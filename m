Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF3C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE88E20868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCEYP/Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfGOOVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:21:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42221 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390004AbfGOOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so2308776wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP59Gx3m7Jou+yXtjCzXvgdV35CA8Lfqjz/4jKFq3O4=;
        b=pCEYP/PvfZqosCmkP7JoAmOtLKbETj/1CU/2OxY7E/V6SyHtYpTGre2MQHMm7D4dmb
         7cVZllfkUiXxDvsjyyJLbkiH30aJzUdCYTni2ka/NVOm+TH22/U3EbR0cEtT/a5DqnWp
         m076BIqncH37M37LT84LcisvJJYkklw8N2F1Ql2F9MIc9SLe6zgF3DqjXIooeBfQRt2j
         qG7O+Tw7C7gn0in0Ac4pYb+Wrqa7ZmFIRN8QeQHru9ruLEuQcnTC1Bj7+fdf31KUZ774
         855dHOt/2hp4gueVyvNC42RE+SIIVxeRkWFu5/6tWnRchaj1H0VYVGlcDg0pyXMpiNCd
         Edyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wP59Gx3m7Jou+yXtjCzXvgdV35CA8Lfqjz/4jKFq3O4=;
        b=MT0+j9ARdoVFsKLF+5JDBEij6ggUBZmXT+1eh+qxyYdKfzIzCqFvV9+m6Sxnexf3ZL
         cGTWyvNjce370hgPC6Nn/6PX2/Ar8i40Lh/kHJOgNNR7XY6aVxpM9BA4h302Px/5aZbl
         CSeCiXXkcHnSjRdhu7+hNTJcoL/We34DeeSIuk3Wq4UqgULXwgKeN1TwJBrqCXUetkiA
         HLOa0omQgD1aYKtsjCyUJR/I27UDSbUuqpgUtLk3Z1EAkcaP5uXdMAFLxlN8R8xf5uf4
         lD4TpcU1XB7rbTHgoju+CLO8getn815zIdUSLof77YLpMqbwA8AWiJLmzoh8gRX1GD02
         4ngw==
X-Gm-Message-State: APjAAAVFBAUKeBty/lNaqS0CIJK0xnB45VcBEHGHKPfFr/qVrlWU6hPQ
        I6eStn95FIrXNsD2eHI40fQ=
X-Google-Smtp-Source: APXvYqz72sz0aUW74u06qoXBxafELDcjaFP4f7IgKBlvWIkJvCMqUbPEdmj93TOma02OuZWVJHfTbQ==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr5420843wri.314.1563200476039;
        Mon, 15 Jul 2019 07:21:16 -0700 (PDT)
Received: from localhost.localdomain.com (93-103-18-160.static.t-2.net. [93.103.18.160])
        by smtp.gmail.com with ESMTPSA id i18sm19986388wrp.91.2019.07.15.07.21.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 07:21:15 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     tglx@linutronix.de, luto@amacapital.net, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH] x86/cpu/intel: Skip CPA cache flush on CPUs with cache self-snooping
Date:   Mon, 15 Jul 2019 16:21:09 +0200
Message-Id: <20190715142109.3063-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUs which have self-snooping capability can handle conflicting
memory type across CPUs by snooping its own cache. Commit #fd329f276ecaa
("x86/mtrr: Skip cache flushes on CPUs with cache self-snooping")
avoids cache flushes when MTRR registers are programmed. The Page
Attribute Table (PAT) is a companion feature to the MTRRs, and according
to section 11.12.4 of the Intel 64 and IA 32 Architectures Software
Developer's Manual, if the CPU supports cache self-snooping, it is not
necessary to flush caches when remapping a page that was previously
mapped as a different memory type.

Note that commit #1e03bff360010
("x86/cpu/intel: Clear cache self-snoop capability in CPUs with known errata")
cleared cache self-snoop capability for CPUs where conflicting memory types
lead to unpredictable behavior, machine check errors, or hangs.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/mm/pageattr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 6a9a77a403c9..e2704996f9c5 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1725,10 +1725,11 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 		goto out;
 
 	/*
-	 * No need to flush, when we did not set any of the caching
-	 * attributes:
+	 * No need to flush when CPU supports self-snoop or
+	 * when we did not set any of the caching attributes:
 	 */
-	cache = !!pgprot2cachemode(mask_set);
+	cache = !static_cpu_has(X86_FEATURE_SELFSNOOP) &&
+		pgprot2cachemode(mask_set);
 
 	/*
 	 * On error; flush everything to be sure.
-- 
2.21.0

