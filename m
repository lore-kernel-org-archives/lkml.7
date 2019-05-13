Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B26C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF59620879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6DFoLZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfEMNoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:44:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40390 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfEMNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:44:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so6518627plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GkpT1sXmb+12L7PMhae4FFhag91+1a6A+uc2b01x+KM=;
        b=s6DFoLZtUqlkOd20JLTwW9RKM8oNEOVZginRLmfTyKaaghR7dksNdQNikyz1R1l0YD
         jsf5QkoplKHoCItfE9QhoyEJCiacsDS8DEj6P270utiM2xzLcH2IiO+1EoZw8CFOT65Z
         NkeElX31tgycWRgonfSZnqoW+d5RLoT7MmquECNfg1hXG6QUG3gL7wfrA7S6uUL4933s
         gXVqIWwKgRnigCsmCB3kP5n/KPXgMFP679XeNyTlNJjN0NTU6v2ewVw6EZl/fsSwJURf
         ujOZc2Z07AYGOQkkDPne9DDHhpq8jpjZYp9i9mZAMEFQWH8W9OBvrxeFQP4r3xwLUCZH
         H0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GkpT1sXmb+12L7PMhae4FFhag91+1a6A+uc2b01x+KM=;
        b=ogM+jJoyZznaenEoIKzvuGg73bVl5acCey+WAYvQB/Y22iezsSCOtsIPuvMNw7EVCS
         g/p9RZUa6NalF06GAXkt/VSDwZeRSuqwpnyEvdOFIPrHq3P9P71/RqZv0u2NEOSlgHln
         nxiBo8IbNxfwRFkPlLAPFL3lidwC6TLyJjTH7dbOW591H3GrMAtFoNLfvqQlqTNFdNNB
         fxo6nNBCydjXFHHjTftfDUCIBxLs36nAL/oraVJoIsIdFiP7bXOdKfPvwVDx3otElc/b
         csNLRsUS1Elrj1EWtYOwluMJ8iexDPOStBaMlW7vrQqLOKIgtOTd+Ytf/0lJqLzVZgmu
         rcKg==
X-Gm-Message-State: APjAAAUTkCU24p1txksl5L0bbhN8GGE0hJkUuTfd3/QHvVDXyR9hMFnc
        ylkqs9fxJj/znFlKnoR4qJg=
X-Google-Smtp-Source: APXvYqy90EXkl2Z8jAnWXZnG28TxgNjucm+D1eIdecwlVWFMf5c1cr9bRd+bih8bzsm810BosTMyIQ==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr14646747ply.234.1557755041266;
        Mon, 13 May 2019 06:44:01 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.248.72.152])
        by smtp.gmail.com with ESMTPSA id e10sm10874261pfm.137.2019.05.13.06.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 06:44:00 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v4 4/8] Staging: kpc2000: kpc_dma: Resolve code indent and trailing statements on next line errors reported by checkpatch.
Date:   Mon, 13 May 2019 19:13:23 +0530
Message-Id: <20190513134327.26320-4-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513134327.26320-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513134327.26320-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes code indentaion error reported by checkpath
ERROR: switch and case should be at the same indent
ERROR: trailing statements should be on next line

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
v2 - split changes to multiple patches
v3 - edit commit message, subject line
v4 - edit commit message

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

