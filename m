Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C70BC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4632084E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxtC1VIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfELXkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 19:40:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35859 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELXke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 19:40:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so5507472plr.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1XuFHs5BD3zek30ZsKmB3kY9fOaFYfw0ATiW+8PMgh4=;
        b=BxtC1VIXurHSmDD9u6qpDK2wu/dki2mpVkrLIcXAub3mJgfQ22Hxh+v0znk8eaE+4K
         ffVxKCO+yDVCPU0BRTkWi1M37XxATMix97+6AaUJ/+CGCDNWqQ4G8znaAaMGbWTJKH7k
         /oUpIq/frMeBpBB5qE0p4o5O0xozCUBjHjC/bCjAyaxWQzeniTpVPgCcc4J8dStJPQIi
         KGTbh/rYIcuJ3HvRUQpMTrQ3dj9O8qMurflPf9nyvO+/ZJWMggwpuD0NWOO6sqNQ6mOI
         aLX/jqaI2sFIlScrMTz8bRmHEM94LF1g+sEZNywbz5ojTScQ8eEQ3fEXNDjjkcEyjCND
         vC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1XuFHs5BD3zek30ZsKmB3kY9fOaFYfw0ATiW+8PMgh4=;
        b=GP1rpjhImYh3UX6p+/vK8fZLIBa6zplFfURSNehl3yn+zzOYPaKl1vCEbtNXDnTjLx
         QOORz8OpEBjQyR72PkvnoaASBHj1JW0/ouYFukp+WE6efyJQ+aH/uNr8tum8Ul/K2Ri3
         qMNHj7mLWjt8/utp0Urmkt/CV4Hl3Z738WSJzd5vQaqsGN3LCf6ag03hUmNlql+CGbkl
         DJ5VLWVpECYDX/Lt3VcQcwkLNUqdQHh/rdyPnw1kDhKOz/I0nph2DxKFo+Hl9/2WmqSV
         5qe7EjvMg5Pzj/tAHlv6EhqjLcmM5F+zYvkhkr+m6i0n0o5mMMnzO+ndIYhOzwGImcvY
         FtBA==
X-Gm-Message-State: APjAAAUOyjxcWgDL1YNyeFb15Q1khS2f/b8MpaugEm40YB+p2CyTT3cx
        AlFGqhdbUlA6Z58jvWHyo/A=
X-Google-Smtp-Source: APXvYqwPhUQc9xhOVh8BRtwgI8hWIRTecRLzVAao9f/VMrSsfLgjjTeqdedAzbLOCJ6fglOoGywS7g==
X-Received: by 2002:a17:902:9343:: with SMTP id g3mr27061916plp.260.1557704433661;
        Sun, 12 May 2019 16:40:33 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.202.125])
        by smtp.gmail.com with ESMTPSA id e29sm13528376pgb.37.2019.05.12.16.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 16:40:33 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v2 4/8] Staging: kpc2000: kpc_dma: Resolve code indent error reported by checkpatch
Date:   Mon, 13 May 2019 05:09:56 +0530
Message-Id: <20190512234000.16555-4-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512234000.16555-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190512234000.16555-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes code indentaion error reported by checkpath
ERROR: switch and case should be at the same indent
ERROR: trailing statements should be on next line

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 8dd948ef455f..c09147aaa4ef 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -395,10 +395,14 @@ long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioc
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_ioctl(filp = [%p], ioctl_num = 0x%x, ioctl_param = 0x%lx) priv = [%p], ldev = [%p]\n", filp, ioctl_num, ioctl_param, priv, priv->ldev);
 
 	switch (ioctl_num) {
-		case KND_IOCTL_SET_CARD_ADDR:           priv->card_addr  = ioctl_param; return priv->card_addr;
-		case KND_IOCTL_SET_USER_CTL:            priv->user_ctl   = ioctl_param; return priv->user_ctl;
-		case KND_IOCTL_SET_USER_CTL_LAST:       priv->user_ctl_last = ioctl_param; return priv->user_ctl_last;
-		case KND_IOCTL_GET_USER_STS:            return priv->user_sts;
+	case KND_IOCTL_SET_CARD_ADDR:
+		priv->card_addr  = ioctl_param; return priv->card_addr;
+	case KND_IOCTL_SET_USER_CTL:
+		priv->user_ctl   = ioctl_param; return priv->user_ctl;
+	case KND_IOCTL_SET_USER_CTL_LAST:
+		priv->user_ctl_last = ioctl_param; return priv->user_ctl_last;
+	case KND_IOCTL_GET_USER_STS:
+		return priv->user_sts;
 	}
 
 	return -ENOTTY;
-- 
2.17.1

