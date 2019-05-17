Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8239CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537782173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYa1xSeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfEQSrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:47:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38470 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:47:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so6312098wmh.3;
        Fri, 17 May 2019 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
        b=sYa1xSeqBijyACT713JrcPfeJ6i1pId1XJ8eV7bYFwQOvCKVI9hU6X6rsi5VoYuOYt
         0D2cTJcpZWhDRkgW3lFeqzAiU5xxh8pXYkjduO+E3yB4kURp14tlb4FYguNJ6mVXxr/o
         7sNEuSmlziet3wBZ3p1LC4/4XDskX8RjgeFVzrsZZncbZNeV30kdefMoGz1GhCiM5MVN
         77LwiSFwRps5gRv+r0TY4n6TYH1qIYzplYaT0WGD17Sd2DddZ0Ra8tJkdfzHukxZ9Emq
         OxPUS2T4geuoPK9oiBP1tfS0VhtC7+6ZAjb7E2YjmdJZy2Hapy3h2XjQMFiCW1W0RPGZ
         OXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8viNroRA5goE0iPj/ap53EgAXBGfEQtlqx5YkjMMp0=;
        b=b3VQMkVILVH478Y3jEMPd9uVARFRTodwseLJIWxE3pLPPlU3tiIBeuP66yGImnDhhw
         yAXky4QotkG5Wnl02gNogqcpQUfMlgBBr2tstitzjb+slplIh7NDsONXhi5EaM2KfPBG
         J/lx+rq1Hh7iQYScqi+AtmV55ucUsYCmPV7SvL2msB+Kt1It/4i3U0jVL6TGIcDQXFmZ
         KgafqDVEJKdEGHSdT3FUYBNa7jmJHNla4p3Q6mZNEoewtNP7GEBFszG91ANuqjPY7/e4
         B1FYzGWV/JCEcnwWf3fnEmvK41hr3PLGwcb9CDroYPRK8peJWIjJXWQxvJnCm4RW+qM2
         yn4A==
X-Gm-Message-State: APjAAAX0BMgXejHQzpKoi2zSd8lIW/DNEYoi2w5EUdvaIbaGcVHM5KJy
        q9zizFJS9d1tonOJypG6mBw=
X-Google-Smtp-Source: APXvYqx5WYQ+/UFX3j4mg5Ayc/w6LeLH6Wy8mGmkZ59Hw5REOLqHmfti245ovfZ/JrzJoGg3/ubYNA==
X-Received: by 2002:a1c:7c0d:: with SMTP id x13mr3111380wmc.89.1558118828555;
        Fri, 17 May 2019 11:47:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id v20sm5801112wmj.10.2019.05.17.11.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:47:07 -0700 (PDT)
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
Subject: [PATCH v5 2/6] iommu: io-pgtable: fix sanity check for non 48-bit mali iommu
Date:   Fri, 17 May 2019 20:46:55 +0200
Message-Id: <20190517184659.18828-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
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

