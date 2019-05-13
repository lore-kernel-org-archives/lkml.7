Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F4EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D5B208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA6FmjkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfEMK1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:27:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43597 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfEMK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:27:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so6255135plp.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ARQrJZnpLUZOwS0c7g3B+LWtnsG1cuhJUzNdiZrrFyw=;
        b=MA6FmjkS5gCuz+B2eZ3FX6z9bHPZYnMcXmMNq84bxfv6udH7+VR+VX4WY22R8BLUO/
         Jjaj2A2LwxmEaGJUov4L6LTPORfd2Y6kZ/iZrrGEvem0lISOHF/RRHhYC86Z9uQFjTQi
         3Fx7GrM6HDkwTX0+7HD80kkSvCbd6685x8sCliLmRqqOpqE19zBNku5Ce9exm9pkA7IN
         pbssxTOVJR3CTemI3/7aSpGZ3/kXCdUBXls5sO7OoSRJOdB37OZR/kPv5COk+xFg4ZR7
         i2WK9Hj/2509dsNoPiLclOBEqhiczI35OnCB9DKS3BS9fdZSoMK5pxWEmGv94yOR58/6
         Gl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ARQrJZnpLUZOwS0c7g3B+LWtnsG1cuhJUzNdiZrrFyw=;
        b=OkH7fCiMherawT/Ve83/YONrBJoZ+3ukNB1bptSkt1k4VC09u9WxaFdRDxzSuKpbM5
         72cH1dDNfZAHMmE+nbSUHNS7/SiCM10B7BlZD9KvEkitbHVXjgoRV/pk38GpQQOXueJ+
         9Rz8nFckt9Pgi2566aejpMfDpSp+ngckzKhIMacnQ7iEBPqn6GNDftTvUs/qW4tcSZRM
         FCx7VbQ/ZejV5lGSvia0b8PySaWLDhKtF9mir5NMCYYSNhYHUXFdElzueZj3TvuEWw1Y
         aqjL8OrYGUmf3csRqmRwHy0/jf9LmANbSItROXpMXXCOxg4hyD9Yvnb5nmQ8c0OJ82wp
         1NzQ==
X-Gm-Message-State: APjAAAWM7NCkCY5jxAQfvmurGENZOqjHGiROrgRsi1qspCv8fgNAr9OI
        1iCDwGhqRvquqHgiqU1E2Owwn8+xCAU=
X-Google-Smtp-Source: APXvYqxCaVvAAx0jpATH7EPHP/u699rPxGRlb6MuYXihZaDfJkRVf8pXW5pLR9Gjx+tvDE/MVJDxdA==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr29464138plm.134.1557743231437;
        Mon, 13 May 2019 03:27:11 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id r124sm11773487pgr.91.2019.05.13.03.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:27:10 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v3 4/8] Staging: kpc2000: kpc_dma: Resolve code indent and trailing statements on next line errors reported by checkpatch.
Date:   Mon, 13 May 2019 15:56:18 +0530
Message-Id: <20190513102622.22398-4-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102622.22398-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513102622.22398-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes code indentaion error reported by checkpath
ERROR: switch and case should be at the same indent
ERROR: trailing statements should be on next line
---
v2 - split changes to multiple patches
v3 - edit commit message
---

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

