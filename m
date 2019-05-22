Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D56C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A518217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQC+LDvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfEVMOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:14:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40199 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfEVMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:14:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id q197so1272759qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIEcDIHKJwEp18hnndikeLlhOBy2trJmJWiZcL9j2Ok=;
        b=QQC+LDvAy47svZpaqkuyugiJWSDGnq43An/Ip1DjODVIW8zkSpkO3FJMV2k5BJJf1n
         YH55KanIfLbCqk/hYL8HHVvCBL+4y90l2/jrmcxlE8GBG2usvs2o01d9hy0deYkU4FAd
         2DW93OwwjHJyEe4bicIPqgptRbyExNOFw9NQUVghCq0NzUObLVGIc2ZdBCSj1nRzfSng
         VwB4zOglsxG2qLIplCBelDgEIqTI79cpKEQ4WeRrqd75D16perlLF/ogA/YGOUSZ1zZk
         WWSYszgvt950AW8VrnScABqUAbuWZsB8AftUFpd9ldq9VJicDzn/GZ47RdJA1SqrY2YX
         h/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIEcDIHKJwEp18hnndikeLlhOBy2trJmJWiZcL9j2Ok=;
        b=RET1XDShCjegsyicEZgxx2UQEWPdgFqIvoxLRg0UKQ8+NRtApmXevBRwQRXdFt7oUz
         RYtNaKvkAFadOv8PACA99Ym6o3MyQFTgeE1/FSLA8RYcCGxErdLW2qEqJ7q+w/5Ytwlr
         612jiv7W4QFqHuvnFe4j1DTVKKXxy9qDe+i1GN5NQRXecNtCF+hb3LiscsZjAzwH6Hxv
         cid7qAMDijwASWlcQpVwUQQ5uzVP8486/j7wcBXfwppxJ/IMPndflPmvVlK98kvOE7Fe
         daB6i1zHpHrpP0Juv9ClgKvYzVZGi78B6DowTB6EfoO6in8NLWlvSxRZAzFR8MxiCZ+5
         mFsQ==
X-Gm-Message-State: APjAAAUuCZyX2GYKA00ZxmVFetEhaomtgWUGt8gCjkamVcuPnWzvjzUW
        iuMzYMwNHqLNztgWRZufh54=
X-Google-Smtp-Source: APXvYqzwUtiwb0sA4Xlb6GlJ9h7DMqTouWxXSModJlyjwShrd8E056iRalp7cwCAEohL0HTrNf1lwQ==
X-Received: by 2002:a37:b287:: with SMTP id b129mr60006366qkf.20.1558527292935;
        Wed, 22 May 2019 05:14:52 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id w2sm8742070qto.19.2019.05.22.05.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:14:51 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Matt Sickler <Matt.Sickler@daktronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 4/6] staging: kpc2000: kpc_i2c: use <linux/io.h> instead of <asm/io.h>
Date:   Wed, 22 May 2019 12:14:00 +0000
Message-Id: <5631017d1920d4bdcfdff252ba2fcda80b6f2d7b.1558526487.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558526487.git.gneukum1@gmail.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than include asm/io.h, include linux/io.h. Issue reported
by the script checkpatch.pl.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index a1ebc2386d70..5d98ed54c05c 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -19,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/types.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/export.h>
 #include <linux/slab.h>
-- 
2.21.0

