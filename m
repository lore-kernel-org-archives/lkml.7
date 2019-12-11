Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB31C2D0C7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EE92173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j64x/3Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfLKT2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:28:12 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40146 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfLKT2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:11 -0500
Received: by mail-qt1-f202.google.com with SMTP id e37so5099644qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Eog5Opk+TxZa3uVk6okHcHGhLRzwOGiRhHGWRzBGg10=;
        b=j64x/3CexPc0bd2HJLhsbO9Andd2Z16PIf/duinmMu3i6cvIhVXxO9HrJ2c076G+jM
         dTp1zL5tjkvom1UQk0D9eNOmd0i41jGamL0+rcfFWjjESCraQkA7/BNeKicHHVD78ggl
         osxTl9apihDEtuRQFt2ntrLocWfAhjWvfUSssad8SmjvIjzDIzN2l2s/Y2l5XCvckH07
         hYBi/Val0U00ZCY+G052IyQxtVM9B0Xwd2Azl9s8x2U/EXFaL1kkDg/YSi8TRSZJhfn1
         FI0Bqv1VFahlGX8fbCVfNfeIgMBqdGcT6NZVkW7bifZ527ERCmHBU6iqjKrAYH+2tv/D
         DRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Eog5Opk+TxZa3uVk6okHcHGhLRzwOGiRhHGWRzBGg10=;
        b=X3mc5EHHB//ky1y2BJtzolKoQPL0kASqG/CrE0zzTImot+CbJT/XVUYrc/vcX/DdJc
         cKlPOepecv/F+qsNE2e/CvIFAQW1pPdxFSiXFP8QNHzcRjg4XRd6U2peylYseBtx8pn/
         xuK33OAlWF3R13wfITMCIznf1SqVlRZ4w4GO1i17hkun+SQn+qkcVe/o2oOr6pgZqrSh
         FBSThVdiXo/kAI+hfYJWmLppfdca8ZFYIyhwylOvFWBuIGkonQJDfd3M7JQ/CJUq9Yhj
         +HJ0damteYV0OlRDzbK93wQ2slUn3LjzjyVUk/1D+llpGa3mLheSB5k4bK6lrJQ8Lf6z
         SOuw==
X-Gm-Message-State: APjAAAXbIbgs8hJzMpxpD1aA5DZaLdYyMhcpw67nrRhQCPNWvaWeqmHg
        SstHp6Be5FvIhRHhOmCd0RvLfb626s9y8TEO9iz/YA==
X-Google-Smtp-Source: APXvYqztxSHmafU+N9DsXnQIDJGGZpjOfQWlL3wdRjbnip1gtquXg8S5FeJcoQm8xtxSX8bgGJi3wnFoepSd4JVdzJUusA==
X-Received: by 2002:a0c:cd8e:: with SMTP id v14mr4708063qvm.182.1576092490192;
 Wed, 11 Dec 2019 11:28:10 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:27:37 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Piotr Sroka <piotrs@cadence.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 74fb91adeb469..a80a46bb5b8bc 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -452,7 +452,7 @@ config MTD_NAND_PLATFORM
 
 config MTD_NAND_CADENCE
 	tristate "Support Cadence NAND (HPNFC) controller"
-	depends on OF || COMPILE_TEST
+	depends on (OF || COMPILE_TEST) && HAS_IOMEM
 	help
 	  Enable the driver for NAND flash on platforms using a Cadence NAND
 	  controller.
-- 
2.24.0.525.g8f36a354ae-goog

