Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4DCC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0C21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARZFb59f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfEUQLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:11:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38087 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbfEUQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so3488746wmh.3;
        Tue, 21 May 2019 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
        b=ARZFb59f/TEGR4dKn2zPIsVrlQpgAN3MkGdMyYoenwZrYx//1w/GS1vxb/zR0DiMu4
         kFpEmoMA86LR7oMglGgowJVUCRWcB4uFwzjEjBzB/TClFDnUCsAYsZGfse3m9d3Elf0X
         LZXgLoTvu2klwbc97GLhdfLn9ItpsQuHfWTsjUtfW9vQRNNk+uobllA6qAZTnTm99Ugm
         n1r7iW/h9mU0lcFEX1q+b4LjCRuTE9urqhkK56b9ItVJIMrgMcJ4E0gF0t7oqfqCy6WU
         IMfY/wZLsXkxMjbx6rkgIiucVgB9E+aq2VD6BVtbZIJW4Dj9fkmrj2Upj/QMFHowPrYh
         TkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
        b=nt1bGZN8tclvvd7QfhnKztowjBBbuLWMbtolJcP0ZArZFpA+Q0HhN32Jl4NQaoFOFw
         boNVRNU40WIVrHtcRsp1JbnjRk2lfUh7VzDBxpnjHscGmCv3Ws206rmvvZxj8D2JXFka
         jBGWtdZSvZxNBoBii6ABfiMPou/GsdxlnHBCMREAbREx8AHnV+PTiyAxYjkWtXx2OpPp
         CDHzZ1t7VM8EX55dm7e9p9WszPaIk755xJHTU5itfJPuBoApy8m/1vJR5MOtRZ8ZXWXz
         yJ9kadMn0RAWx2Yq+YdBe+ruQUEkQ70abgW6NifgkzN6zW/gDf+GQK6NwN8txYBTTz3P
         2IYQ==
X-Gm-Message-State: APjAAAXUN83GTtEViKW35NrfFmEvHc6X/vGQaP2zp0GVuNR0zST3VEZS
        QbzWi2GT8fXFMFAGXvZquog=
X-Google-Smtp-Source: APXvYqxfxJ6RsSMMKEQ8Whf7wf2BBbNOZyqWjeSvLocsSoko9vuDWmS1j0CXAq8lGvRTLD6FP4Blfw==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr4212516wmk.78.1558455070526;
        Tue, 21 May 2019 09:11:10 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id n63sm3891094wmn.38.2019.05.21.09.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:11:09 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 2/6] iommu: io-pgtable: fix sanity check for non 48-bit mali iommu
Date:   Tue, 21 May 2019 18:10:58 +0200
Message-Id: <20190521161102.29620-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521161102.29620-1-peron.clem@gmail.com>
References: <20190521161102.29620-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has a Mali T720MP2 with a 33-bit iommu which
trig the sanity check during the alloc of the pgtable.

Change the sanity check to allow non 48-bit configuration.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4e21efbc4459..74f2ce802e6f 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1016,7 +1016,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 {
 	struct io_pgtable *iop;
 
-	if (cfg->ias != 48 || cfg->oas > 40)
+	if (cfg->ias > 48 || cfg->oas > 40)
 		return NULL;
 
 	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
-- 
2.17.1

