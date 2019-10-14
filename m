Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C7BC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2374320873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="apn9r32F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbfJNOs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:48:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42283 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:48:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so16098805qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbF4z6Po+L7uELtvdMJOGe3JlbdY9qB4rUYqWGj1Jjo=;
        b=apn9r32Fkdb3gKR0IDz6l0B6b5jFruaQ2x60IIBI0cQZGzTpLbDfFHfuKgL1o7ISE+
         9+kiU11Ir/MaJLMRI2nGXGNB06/xK/rVMoyKR3GBpkOl/oWCF5py7YGV7C6rVCkNiekq
         Om8BY5kGZRUGGL2KbCZi4qznGAoTxdccQzG7K1XVZuDx7S7qOGjsOVEij7vfRMrXZVpp
         owCvJsrg4XBKRBiVJl2WJo7USRaojC8T5yEREMLQ/bWiDouDNqP0LXddoTYhtHAYQbeM
         3G+STd63oOBvztiAZV4llOLahw/ncibKbdMzdfpuFhx8i3rfFJjLNDAHvWh+TzL0h1oP
         710A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbF4z6Po+L7uELtvdMJOGe3JlbdY9qB4rUYqWGj1Jjo=;
        b=t1B1Sk+/A7Rkm+qpzCjmrtIMl4Q9PTnoICGyy5j1l+vSNCemc31Puw+wmt/Z21BCbv
         QgbpRDgh+BMMl8F7kxBVB1/tMFATcWPKZNPJssj+nKg1R6qmTUatuNvPxWA6CdkF/hBJ
         vyT5Flei8YRR5K8NZNa7yqxSf3YdK5tJ8lWZWOoorWeB1X+ZRQm9MqnExDR/kr5JOL7T
         AHLl+6rsZuE1t6fjn1shwtHwGYUdBCHIjYBIPSVNl5PkpK4Q5BlopYvUXKhAeJEf8Wgm
         QCZQLz7YK9psLOKRpy4LxaH8V6kk8xF03KLSVlf+gF9ElMO6fMirOTorrffiVOSSentW
         HvVg==
X-Gm-Message-State: APjAAAVkROMhpJVcWvoN2VDhKXfCNE1ND6oE4sopQfogIxMcpcnhFAfP
        8FdAatjy9qMWBBoq8GkNwmEuRA==
X-Google-Smtp-Source: APXvYqy2fGQKFYZ7/E+TOArAVSi2bDSBKCavlDZJ5/ZyDDWiVT4LH6C1CIF02J7b7Y3Nzqe0Zo08hQ==
X-Received: by 2002:a37:67cb:: with SMTP id b194mr29937925qkc.238.1571064507496;
        Mon, 14 Oct 2019 07:48:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id h29sm10517230qtb.46.2019.10.14.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:48:26 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: [PATCH] arm64: hibernate: check pgd table allocation
Date:   Mon, 14 Oct 2019 10:48:24 -0400
Message-Id: <20191014144824.159061-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in create_safe_exec_page(), when page table is allocated
it is not checked that table is allocated successfully:

But it is dereferenced in: pgd_none(READ_ONCE(*pgdp)).  Check that
allocation was successful.

Fixes: 82869ac57b5d ("arm64: kernel: Add support for hibernate/suspend-to-disk")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index e0a7fce0e01c..a96b2921d22c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -201,6 +201,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 gfp_t mask)
 {
 	int rc = 0;
+	pgd_t *trans_pgd;
 	pgd_t *pgdp;
 	pud_t *pudp;
 	pmd_t *pmdp;
@@ -215,7 +216,13 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
-	pgdp = pgd_offset_raw(allocator(mask), dst_addr);
+	trans_pgd = allocator(mask);
+	if (!trans_pgd) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = allocator(mask);
 		if (!pudp) {
-- 
2.23.0

