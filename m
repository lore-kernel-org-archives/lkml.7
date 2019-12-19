Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADCBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BAA2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781138;
	bh=35yKDkiE8KL4FQ6IGuKiSvQsrdEoHklWw7BgukhTtfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B7F0xBOiCkb5iBKkrEGKW8la9PiSdXoqvWlXi3Esg1uTqslgvC5BlU1dXFhpDIxoK
	 XAf96jELQB2IoG0Y+mU+5l3u7ww/TSJ2VNLe5mts0Sw1S8ntffKC4sf2NdmRGqxIlx
	 X4JTv3Kbm4g3swQSi9ke1ioau5/vcy51Pf66ek50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfLSSph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbfLSSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:45:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3692B24672;
        Thu, 19 Dec 2019 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781133;
        bh=35yKDkiE8KL4FQ6IGuKiSvQsrdEoHklWw7BgukhTtfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4WxtpYMiktqb/RyVadpcooYZNiqmw7IMYs84Aph7mDUaDG29wvBjw9RkpPgmlwfJ
         p3zKBx5A1M/iL8OW19GRrxOzd+7RpZD2wiF3HP3tDthFB1TNpT+uvZh0ecj0pxv16F
         2Q3rKkWoeVeQcFjgldN17bmALhQkhF1mv73YYEkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.9 097/199] USB: uas: honor flag to avoid CAPACITY16
Date:   Thu, 19 Dec 2019 19:32:59 +0100
Message-Id: <20191219183220.282932558@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit bff000cae1eec750d62e265c4ba2db9af57b17e1 upstream.

Copy the support over from usb-storage to get feature parity

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191114112758.32747-2-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -832,6 +832,10 @@ static int uas_slave_configure(struct sc
 		sdev->wce_default_on = 1;
 	}
 
+	/* Some disks cannot handle READ_CAPACITY_16 */
+	if (devinfo->flags & US_FL_NO_READ_CAPACITY_16)
+		sdev->no_read_capacity_16 = 1;
+
 	/*
 	 * Some disks return the total number of blocks in response
 	 * to READ CAPACITY rather than the highest block number.


