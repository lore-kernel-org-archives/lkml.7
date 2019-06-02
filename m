Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4949FC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230E327975
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEEvyuhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFBP7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:59:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38593 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfFBP7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:59:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id l3so6852492qtj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ylmiKH8/t1QghMcsBHCFEUjqXi7qsuao5u1jutlgYvY=;
        b=CEEvyuhq3QxJncBBiG168BeDtfnt9b8sr8VpRBmklgTHOP7er5tdxuS1k+n4NTGIq/
         MFnkbvZArWhwVPGlHq7EGE9bp/PhFXpGiujmaDCIjofCSdyewB/JGBHdWvIN0h/ohVr5
         oLBaV/TNuqebxdN/Ek9LAC4VyXPcmePYYV885eAoIojRtRVYXcZM7kxxyIB3Z1x2M4gu
         +FB0LdPwKjFqNJqqczUW4A10E5Kk5v0YMfKx4kmRRFthbAkt4cMu6a+lhlMV9v7sWbEu
         WEOEBIbOHmgD9pqiv2o04C44bYiFT31isDAFtFSnSVXGNG/3immxJ0Sui/k0rL9YpcP1
         pEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ylmiKH8/t1QghMcsBHCFEUjqXi7qsuao5u1jutlgYvY=;
        b=i6nbUBhKAH1fMhOfPJc27t37pXi0rtaEA7IFVNhs4fv9+A4iN1BYApOq08GIH43U4Z
         +dpWBS214WdqcBJJX1PGOuwZkWDQcyqu5trFH1m9Z9ky8xLRMLopxb4CsnA7bZRPwcaQ
         8+my951lgN5NYNNrEI3gR3uxwDgDseKqddWEnPViM8EJgEBPfJMUZfPNvNKMwpC2mHc7
         l9SYBl5H+XKjIWAuvkziWDedUPUgXqbGMzvz1OOGSIDXXn22YIahk3abE0Y5NscRPLi4
         0ioE4QkJk9A5o3PoF25TMxoUzq5KkxYFiVKNpOZ8GYiTNTiRnkQamCtgNd2vASBfxQZB
         wCzA==
X-Gm-Message-State: APjAAAXiDDGzDwMDUOyyb7oRIyBTp8jzThztRvtTMJBoa2+b9xLWUUd0
        uBrodspFsy8eGgMnDjN1hv4=
X-Google-Smtp-Source: APXvYqzOjdziuSeICOHI84eSIAmK1EJHxXQe3DVmyCk4u+62EoUPmXZwUfLthTLrwQYnJ5po5/UVfQ==
X-Received: by 2002:a0c:b285:: with SMTP id r5mr18360133qve.206.1559491158432;
        Sun, 02 Jun 2019 08:59:18 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n7sm7378589qkd.53.2019.06.02.08.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 08:59:17 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>, Mao Wenan <maowenan@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Geordan Neukum <gneukum1@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: kpc2000: kpc_spi: remove fifo_depth from kp_spi struct
Date:   Sun,  2 Jun 2019 15:58:35 +0000
Message-Id: <1b43a7f1fbfe03536f9c985b9c4135cd549c53a4.1559488571.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559488571.git.gneukum1@gmail.com>
References: <cover.1559488571.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kp_spi structure contains a member 'fifo_depth'. This member is
never used. Therefore, it should be removed.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 13c4651e1fac..049b1e324031 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -105,7 +105,6 @@ struct kp_spi {
 	u64 __iomem        *base;
 	unsigned long       phys;
 	struct device      *dev;
-	int                 fifo_depth;
 	unsigned int        pin_dir:1;
 };
 
-- 
2.21.0

