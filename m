Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726F8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4339621775
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888481;
	bh=FsvQRTDHzkmyfaLsTy8u40CfgdoIRfi8ccBGcX4mt+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=unyRZKou9uV1tcNVN4IPwunf7aYZkVk5F1d0Hg76XgY8vhm9httPUuPMwXf3t6YUS
	 Z/xp6bw15qqrZ3tntADePm+IaeuKNonKkT9Z4725zgwcqVHfUf9zceq1gERfnXIGKj
	 t5H1beua6li8v8CnbHIPQvMHh3Kssvru4o336Z3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfK0VBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731688AbfK0VBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:01:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB70F21555;
        Wed, 27 Nov 2019 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888476;
        bh=FsvQRTDHzkmyfaLsTy8u40CfgdoIRfi8ccBGcX4mt+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvxmAiJ0EXgQS8ci0x4zeJ0IS+CnfdQTyIO+ppEUnIvLeKcz0Lrh8GjiRVFlgR33k
         jqgud1wnimBwIzR4TWbwMzKwPZLctUbekoduqMllcYszaQeV1GP+DYz44y1SsEa1HV
         YYNonP5IoUAnJeAorGbAOR5SGnGEA/+YJ9g1bnJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/306] USB: misc: appledisplay: fix backlight update_status return code
Date:   Wed, 27 Nov 2019 21:29:06 +0100
Message-Id: <20191127203121.908875694@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mattias Jacobsson <2pi@mok.nu>

[ Upstream commit 090158555ff8d194a98616034100b16697dd80d0 ]

Upon success the update_status handler returns a positive number
corresponding to the number of bytes transferred by usb_control_msg.
However the return code of the update_status handler should indicate if
an error occurred(negative) or how many bytes of the user's input to sysfs
that was consumed. Return code zero indicates all bytes were consumed.

The bug can for example result in the update_status handler being called
twice, the second time with only the "unconsumed" part of the user's input
to sysfs. Effectively setting an incorrect brightness.

Change the update_status handler to return zero for all successful
transactions and forward usb_control_msg's error code upon failure.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/appledisplay.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index 1c6da8d6cccf8..39ca31b4de466 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -148,8 +148,11 @@ static int appledisplay_bl_update_status(struct backlight_device *bd)
 		pdata->msgdata, 2,
 		ACD_USB_TIMEOUT);
 	mutex_unlock(&pdata->sysfslock);
-	
-	return retval;
+
+	if (retval < 0)
+		return retval;
+	else
+		return 0;
 }
 
 static int appledisplay_bl_get_brightness(struct backlight_device *bd)
-- 
2.20.1



