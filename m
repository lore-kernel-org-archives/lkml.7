Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C926C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199F320644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bWqiVcnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfD2Rha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:37:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39678 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2Rh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:37:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id f125so6451409qke.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvnWUGFqH95OBjKoRYHHb96ddSAj8nCyrjhcWgd3CDw=;
        b=bWqiVcnRj/Vd97tx4zyzrejGtpdVMQ0UFD0o2qJcWQuAZWnEdAnWyaipWP7zob7o7A
         Ra51WcsiMK0BC++h98ACNGCqNIarwvYtJ3lra2c1TvmHnCpdbTI9DbavgqP02S8hREFq
         LCxSytLcGt4FNW0WQwaKw8MgwCHevGQdNX7rBwHLxXLy3gl2QM7p4s1nZfSUXOnkZmoQ
         Lbkbn5qnpvsavdq7H6Pl5mNpf5BoMl7fgZH8dvuMMOnkI7LityhmwMH9qoQEdsyiW4HO
         U7nUa71zuLcBnM19Hz5IxvBgN4C7x1yA3bC63zEGy4YKBuCdNPvOl/l+ODb/t6l1Bdqa
         +hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvnWUGFqH95OBjKoRYHHb96ddSAj8nCyrjhcWgd3CDw=;
        b=UUzfItdSN0SdeUCLB3twxcB8vMN5vy9Wagrr8PWm1KLdVeCJh4QiV72tCbsDgdMH5X
         HIBhs2DqEawq4c8fy9SeHjdikuUfcjh6TE4PMHtTQWasX2DkLEjiLrgKn2aVYkjB34Vj
         LBjjEQQvx2pZr+NTxi/F8UIFXtsdQKf+sPPywuaioFAkZ1SqfTqB8jXm9rxgpL5EX/NG
         4EGsOjFt4+26s+vQJ7UeX2YF1jMDHfH9ZDNtJVeZr+W880lKF8xdDi7eYKZGKD8d6g7n
         dWx4BMNjePGBrYAa4PXNzor+N+44k9L8/DJdHwmc1QKuPD8rlavlA2LHqwzlVfVZzkbR
         DFsQ==
X-Gm-Message-State: APjAAAWO8ZFJxiD3sqYTNaRjv7Ut9a6M6U8sWALCt5VrbpJjO5E5Cq6r
        /h8xQ9dzeom5zIRBjC+THcJBkw==
X-Google-Smtp-Source: APXvYqyDR1sXcSEAZU/tvwIMNEhwty8wwd269Y2/rO40JCaUuY3rcPAbpIdrHEQc/6u+v7vtffq0yA==
X-Received: by 2002:a37:a514:: with SMTP id o20mr15647617qke.41.1556559441746;
        Mon, 29 Apr 2019 10:37:21 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 74sm4710182qta.15.2019.04.29.10.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 10:37:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH 2/2] arm64: remove pte_unmap_nested()
Date:   Mon, 29 Apr 2019 13:37:02 -0400
Message-Id: <20190429173702.31389-2-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190429173702.31389-1-cai@lca.pw>
References: <20190429173702.31389-1-cai@lca.pw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the commit ece0e2b6406a ("mm: remove pte_*map_nested()"),
pte_unmap_nested() is not used anymore.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 74ebe9693714..7543e345e078 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -488,7 +488,6 @@ static inline void pte_unmap(pte_t *pte) { }
 
 #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
 #define pte_offset_map_nested(dir,addr)	pte_offset_kernel((dir), (addr))
-#define pte_unmap_nested(pte)		do { } while (0)
 
 #define pte_set_fixmap(addr)		((pte_t *)set_fixmap_offset(FIX_PTE, addr))
 #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
-- 
2.20.1 (Apple Git-117)

