Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A7EECE58B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E5A222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lVmb0L/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfJDSwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:52:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37168 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbfJDSwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:52:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so6760582qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4PNhEWMnxTPqUB+Gwx2nqJhU+kkzlGq5UWgg81CPAOk=;
        b=lVmb0L/iZn4vml+LkXL+dphQdKWHA3ZxZOSIfHW6RdR89T1N8qbenCUryqtggxK3xI
         2YWXUT+RIi3O3IPWLfEjGnZEot6UGfhyytibbPammdDaqqOHY2jSrYeeaz69WCX55zDJ
         ARR8UtRjp1dCiCMwHoD/kq1/FRE5CIDkp0WMatzDRfSMO3mVaWfALlnhYpfMmklovldn
         L+YVm/vC1fIiKHkItpf0CaL62jrrp3Mx4GvlKOg6qtSPOp29gwYIWkBObPyaPf6fFqfI
         cytqC/IKiibTxGr/3qe2UZdiTCHf6hQjg8u7Sm1Ig/duvtrFAuCuFXm/vwfjHnoMzJmz
         640g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PNhEWMnxTPqUB+Gwx2nqJhU+kkzlGq5UWgg81CPAOk=;
        b=D7CwVGZ83RKFdgRuTYRI27tepNDxD74tAQqXzOrf0lJtz5gzdT2m8KnSmfcYyPUpqE
         RLpcxa6jDX+GSRLZk/UOjd+nJ0viLpHiICnwBeeEAk98RW08ssyGb91xAVbMN2PS8jJg
         XAy5yTcM4DL8LeSJO9wv5dxpefEky24C5lZReHpuPKNNY7lXljSdkfVAgjn+5LE6tgAn
         UkjMLT3ESyyP15BYC6mOjto9YUjTXPbholiIjOIN1B15EzwXMI9zOEwAfwG/VFD00cp6
         +XMEjHk0RCGkAxfwgFEdaGcT5HSQC6Go8P2+GM3eDSUKWtvEZXbgcKvwh2ZAzMwZmtP6
         rSww==
X-Gm-Message-State: APjAAAV/Ig7JGPoIc7BZviHrOmchi373iohse3evouOYY8p6ya+oqNQd
        NWK0b7DeqmRYjZ6OTJK2MEnP2w==
X-Google-Smtp-Source: APXvYqzPH2B95+uAdwEjwo4WR65DaJB/4AKIlmg9VM3DvOImvx1M/3g1HZeOciIjj3beg2Lbibemtg==
X-Received: by 2002:a37:9202:: with SMTP id u2mr11825975qkd.8.1570215161651;
        Fri, 04 Oct 2019 11:52:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p77sm4042514qke.6.2019.10.04.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:52:41 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v6 03/17] arm64: hibernate: check pgd table allocation
Date:   Fri,  4 Oct 2019 14:52:20 -0400
Message-Id: <20191004185234.31471-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004185234.31471-1-pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
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
 arch/arm64/kernel/hibernate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index d52f69462c8f..ef46ce66d7e8 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -217,6 +217,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	__flush_icache_range(dst, dst + length);
 
 	trans_pgd = allocator(mask);
+	if (!trans_pgd) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
 		pudp = allocator(mask);
-- 
2.23.0

