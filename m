Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C8C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AC5217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639424;
	bh=wKOlZSx4CfiKezSLe4RjSocThAM1H9tuHQ8Ho95X1wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OjNP06ExRHw+aaFR83Zm7+M/+3IacBYJneyhtOg5u/1mhLR/oz1qsbUqUtGXvcuRF
	 E2AGXTr6DZj3DNeWNz+Hr2qRK/+nc46tGPHefpV8EDhHylHZgQCBeGli+i7dHTou0y
	 /0ENMbQsXJEWk2W4GQuCBfn3WopRVcuGsG+Qw5rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390748AbfEWTXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390106AbfEWTXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:23:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD162054F;
        Thu, 23 May 2019 19:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639414;
        bh=wKOlZSx4CfiKezSLe4RjSocThAM1H9tuHQ8Ho95X1wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTlPWhquBLMR51Zb4dnI74oMwxRZ0e+5rE5rInra8T/vZkvivPblQPOn/N+BnKG1B
         JLqcJfvUXYZXnJPvmxLnMR8LhFc+whFxDJ8YMIuMlawg8UWoMGw5WmRf3WFINGO37M
         Yslc051ULpS9Mn8j9Wo2kEXQmqwZXx5HG+27uybk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5.0 080/139] fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA
Date:   Thu, 23 May 2019 21:06:08 +0200
Message-Id: <20190523181731.278156118@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
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


