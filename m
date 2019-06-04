Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747F2C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FAD208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690573;
	bh=P8ZHBb0jGGNwqIab+/TIcOlpr+mGM6rn/7/7ddc7+4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2m6J2dQYle1nuJe8HQDyuTqtwvxHrMHxrLHplJFxRvLL33/TMgWTCkS+dUFYsM74K
	 53GZHbMZsyHbG8TCqQCcMxugn/MQ4l0QwQgj9WQAhh2MA6w6o0c4wPa/uhQ90bW+RS
	 XPnuwU1kGlFLr+W6pD9p094hB7Vn4C2GCnhQ8JKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFDXWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfFDXWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:22:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02714208E3;
        Tue,  4 Jun 2019 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690567;
        bh=P8ZHBb0jGGNwqIab+/TIcOlpr+mGM6rn/7/7ddc7+4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAw/mQcaKGiMikpTvAmb2lHrB0QTwxPg8wjJ+nClQQgbGcrhsduDbaH2roV9DLt6s
         35Ld3v0KXhNEjD2qeALCV5c+8mqVa1BJxlvMABL/YQynBNqPaNTS9W0xAZOUXORXti
         RN86GUoBxiRDi8Chxhh591HLAODHD1Hwo882UR+8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 21/60] arm64: Print physical address of page table base in show_pte()
Date:   Tue,  4 Jun 2019 19:21:31 -0400
Message-Id: <20190604232212.6753-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 48caebf7e1313eb9f0a06fe59a07ac05b38a5806 ]

When dumping the page table in response to an unexpected kernel page
fault, we print the virtual (hashed) address of the page table base, but
display physical addresses for everything else.

Make the page table dumping code in show_pte() consistent, by printing
the page table base pointer as a physical address.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9a6099a2c633..f637447e96b0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -171,9 +171,10 @@ void show_pte(unsigned long addr)
 		return;
 	}
 
-	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgdp = %p\n",
+	pr_alert("%s pgtable: %luk pages, %u-bit VAs, pgdp=%016lx\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
-		 mm == &init_mm ? VA_BITS : (int) vabits_user, mm->pgd);
+		 mm == &init_mm ? VA_BITS : (int)vabits_user,
+		 (unsigned long)virt_to_phys(mm->pgd));
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
-- 
2.20.1

