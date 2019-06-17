Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852052089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806456;
	bh=Ojkf9KrupfHqD1L5U9ZrcGnvaPUSV5u9FdB8ETpsauM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KjojyKrHMLWYYwW6lMA+M/upHIFoZ6i0Gqbn8r/zjZBMREpxK6kExmpPRkDbGxYf
	 +UQiumvGlugEldKNygF4mQBOxLKJ1446dS1SJPBMsio5uvQ/Kr3s9Q9ewHaevlUg1V
	 x3z4WRAyhs4qt0xIYEhyfR1rdJf5rmNflilmkTcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfFQVUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfFQVUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:20:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E9F2089E;
        Mon, 17 Jun 2019 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806453;
        bh=Ojkf9KrupfHqD1L5U9ZrcGnvaPUSV5u9FdB8ETpsauM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KiqiwYq9sxU2m4OJBCYRXE0uxMjBWIZAK3aziWbcfDUhsK0Awkz9DRH0lNcgzOjF+
         HzpHuAfFL3I3wq8DfJn4Rs7RaaiZg/hlH6tKb18aC+o9conJq9kOjZ3UKYvCXfFPqN
         VmIXKaOPy+sfNZQcgSROLiBOvkXPRAg8m9FBO2gE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 058/115] arm64: Print physical address of page table base in show_pte()
Date:   Mon, 17 Jun 2019 23:09:18 +0200
Message-Id: <20190617210803.278755245@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



