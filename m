Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC16C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5503821841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639020;
	bh=wKOlZSx4CfiKezSLe4RjSocThAM1H9tuHQ8Ho95X1wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eoR8yq8GnbD8YJiKpNdIEDayEXA5ccc4ayV5gbOvMqqjx0diBlDqTSVp7MfYgRrT1
	 iHeaFxdaPE5oGG3laHAaZS/kmqUXbrqxqfr50Gym/aJwPowf6pL5rYv4leknQxsZp9
	 Ith/VV0KyI/HLXjpIf/H9YT61xVpFVvwaaWitTFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbfEWTQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388830AbfEWTQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:16:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FC22184B;
        Thu, 23 May 2019 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639016;
        bh=wKOlZSx4CfiKezSLe4RjSocThAM1H9tuHQ8Ho95X1wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rW8EdZLSyOrkrQY/NCrBrlP05RKfWqbd6oumpRqKzf6ZaBxmy2Ee/1JmD93WBWSWL
         s4aJCyPuiikMPwTi7VJv+ukSKDK1AGS+C3BhE1PUTFPupSxeQUhNnI5tUh7PcKjUHK
         uC1nrZJRDob0RW1cMkzzg2vRF1akPYGWwjF33Vv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.19 065/114] fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA
Date:   Thu, 23 May 2019 21:06:04 +0200
Message-Id: <20190523181737.497528035@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181731.372074275@linuxfoundation.org>
References: <20190523181731.372074275@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Li <tomli@tomli.me>

commit ec1587d5073f29820e358f3a383850d61601d981 upstream.

When the machine is booted in VGA mode, loading sm712fb would cause
a glitch of random pixels shown on the screen. To prevent it from
happening, we first clear the entire framebuffer, and we also need
to stop calling smtcfb_setmode() during initialization, the fbdev
layer will call it for us later when it's ready.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: <stable@vger.kernel.org>  # v4.4+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/sm712fb.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1493,7 +1493,11 @@ static int smtcfb_pci_probe(struct pci_d
 	if (err)
 		goto failed;
 
-	smtcfb_setmode(sfb);
+	/*
+	 * The screen would be temporarily garbled when sm712fb takes over
+	 * vesafb or VGA text mode. Zero the framebuffer.
+	 */
+	memset_io(sfb->lfb, 0, sfb->fb->fix.smem_len);
 
 	err = register_framebuffer(info);
 	if (err < 0)


