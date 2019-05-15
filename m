Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AC7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2C22084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919993;
	bh=Rw5aZz2Yzs6QVR9aXm4MlXZDJk78bhm1T0dAQyRCfG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSx0z77XQwuwpQKVMhZZOMrfejTPQgzLrUzJdoUpcP/RoSlpaBpyV0BOl8NLoj425
	 HXPeGyTnR+yGiacvuJ+91H9X8+SN6REpiXG61ntKV4VrRviGz+GueCiQsACo3tu3XQ
	 /CDno5YNkXi/ftW5BlDHvuRJXFBDDGZeE0UbbB9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbfEOLdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732808AbfEOLdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C272084F;
        Wed, 15 May 2019 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919984;
        bh=Rw5aZz2Yzs6QVR9aXm4MlXZDJk78bhm1T0dAQyRCfG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beCzEpb3mFsaOIoX+dHM2yf/7tzkGIQ7ibXQIE1tb7+EGQIjeiSygRADM1FP0CGMR
         Cz3x2onHWP1vfaLSynauSbgClzwSnOFmSe6YXjSM7xJ32/OKGtYN0SEFMd97FOht1p
         eCA3DmW04n4fgqHqyW6hriZqpel5mTFeiq7K5qk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pepijn de Vos <pepijndevos@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>
Subject: [PATCH 5.1 03/46] platform/x86: dell-laptop: fix rfkill functionality
Date:   Wed, 15 May 2019 12:56:27 +0200
Message-Id: <20190515090618.617681245@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@dell.com>

commit 6cc13c28da5beee0f706db6450e190709700b34a upstream.

When converting the driver two arguments were transposed leading
to rfkill not working.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201427
Reported-by: Pepijn de Vos <pepijndevos@gmail.com>
Fixes: 549b49 ("platform/x86: dell-smbios: Introduce dispatcher for SMM calls")
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Acked-by: Pali Rohár <pali.rohar@gmail.com>
Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/dell-laptop.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -531,7 +531,7 @@ static void dell_rfkill_query(struct rfk
 		return;
 	}
 
-	dell_fill_request(&buffer, 0, 0x2, 0, 0);
+	dell_fill_request(&buffer, 0x2, 0, 0, 0);
 	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
 	hwswitch = buffer.output[1];
 
@@ -562,7 +562,7 @@ static int dell_debugfs_show(struct seq_
 		return ret;
 	status = buffer.output[1];
 
-	dell_fill_request(&buffer, 0, 0x2, 0, 0);
+	dell_fill_request(&buffer, 0x2, 0, 0, 0);
 	hwswitch_ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
 	if (hwswitch_ret)
 		return hwswitch_ret;
@@ -647,7 +647,7 @@ static void dell_update_rfkill(struct wo
 	if (ret != 0)
 		return;
 
-	dell_fill_request(&buffer, 0, 0x2, 0, 0);
+	dell_fill_request(&buffer, 0x2, 0, 0, 0);
 	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
 
 	if (ret == 0 && (status & BIT(0)))


