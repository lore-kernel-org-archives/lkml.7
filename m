Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BE9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24300218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="lSlmxo1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCPWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:39 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPWZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:37 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id c24c834c;
        Sat, 16 Mar 2019 22:25:34 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=a+rMub2vZtwc96/4+FBQHgZRTvW7Soc2ak2NjAW/PSs=; b=lSlmxo1FqbI+njadjF/NB8Tbtd3LWiIE+F8ldjDURTNZyAX/DrXPmCHSJuP438FCAJvQyhJBWbkUWr8okxWghwqs9vHz1AT0lNbovLdSR54IjH5HghofXSL+E4EDTiHueGpqczstxTtSkbgOmQY+ruwZUnPIvfCiTdE/m3PXvb7zlJthzHQaNJhUPWaXWiyDWpaSn1EDNrulFqFOCdSPNxq4A/WG4E3JU+yC4jR/8Gi3ga0fJgaqXe3e/9clB+JWyVslPsLL4+XZFngkLJyo3me6nXTgurZYp7COpddaAyH77GsdxCI8AGpxeYljEW+h5yCNgvioPHJOQP12ydo5Vw==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        stable@vger.kernel.org
Subject: [PATCH 4/8] fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA.
Date:   Sun, 17 Mar 2019 06:25:00 +0800
Message-Id: <20190316222504.27170-5-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
References: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the machine is booted in VGA mode, loading sm712fb would cause
a glitch of random pixels shown on the screen. To prevent it from
happening, we first clear the entire framebuffer, and we also need
to stop calling smtcfb_setmode() during initialization, the fbdev
layer will call it for us later when it's ready.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 1a3d232c2916..e8149f0f47d5 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1493,7 +1493,11 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
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
-- 
2.20.1

