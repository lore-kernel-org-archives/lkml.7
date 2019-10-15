Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE79BECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBA32067B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmLRv8ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbfJOWoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:44:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44483 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbfJOWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:44:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id 21so18423156otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/bXnmbscWZtJykXXrw37z4L1ZflXNjKDo4nbAwnlNE=;
        b=jmLRv8ZYIlwkdYjVwllTQoVsbUaOuj+oaLFYbE2i5bRi9rzefOEnGOTDHTuJZMFKgA
         SDL1WMgNCIi+JpecQbfQ71lV/611WLaJcfrOaIlM58Hb4XdIZdGl8m7h5P66pxWjavX/
         Dd+zHZVDyoEP7Jceh3g5FSYJJhn2SOQTLDLIR/hxLQWt7Bltz2rC0ZV3pl7TxBeFlBSZ
         zvsz6WhXtss1/aGEjTZuD3M/jtlSQjgcIdRi1PCkVduSSO40B13zAN7HzKvK2Geg3UoH
         Qh83yyvN5rhtyPprAiH6ouS9LIVC/RmtliVdXLaiKG/crDHn+VCMYjeoU+qJjhm10kXc
         V0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/bXnmbscWZtJykXXrw37z4L1ZflXNjKDo4nbAwnlNE=;
        b=DrqRhgskJWEOAE5PWvO09JBJMVp9JnPF57ORD9sshyM1tA7H/8otP4z8NqBzia6XX1
         Qo5Kv/KN+i+SN+dAGZxj4ftPzjL8hJRibQBp29IIHzd0A2YsL3TivFLyvhMoocYYQWFt
         74JbQka2cPrm/nRziUGa7iNXmVzYMl+jWuFCz/KOmvur6TAAt18qlkaRGDcr/EEEr/mi
         Esa9iYJyHvA9egRPV3iWyBcDoyel47ZkaotEjmHlKekwR7aHMR11FlL2mnSexHc+QHhs
         1OYPZs0Sz4sGhqneXTzy6b5iuQUswCo9OsfJm9SzOC3QistgeIX85++bvhZ55m0LtCmK
         MlyA==
X-Gm-Message-State: APjAAAW8Z+jwYQATGHvHBepC9oI38J3q8c713d0dc93t8WZw8kldmNig
        5rvpaRRxP3Y66auohEqb3fE=
X-Google-Smtp-Source: APXvYqy1VFCcZsmFugM7TV359XTS5pkgqTSwfqZaUQSf+0IKEGMqZ/T16yth90qKkpB03mkIe7J1Vw==
X-Received: by 2002:a9d:624e:: with SMTP id i14mr13890468otk.335.1571179441340;
        Tue, 15 Oct 2019 15:44:01 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id u130sm6843008oib.56.2019.10.15.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:44:00 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next] arm64: mm: Fix unused variable warning in zone_sizes_init
Date:   Tue, 15 Oct 2019 15:43:04 -0700
Message-Id: <20191015224304.20963-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
get disabled so there is a warning about max_dma being unused.

../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
[-Wunused-variable]
        unsigned long max_dma = min;
                      ^
1 warning generated.

Add an ifdef around the variable to fix this.

Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 44f07fdf7a59..c3d6657b9942 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -212,7 +212,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	struct memblock_region *reg;
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
 	unsigned long max_dma32 = min;
+#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA)
 	unsigned long max_dma = min;
+#endif
 
 	memset(zone_size, 0, sizeof(zone_size));
 
-- 
2.23.0

