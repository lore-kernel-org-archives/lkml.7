Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60D7C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850D82073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752770;
	bh=/JALBUq6mELn3JOlka64G0qvRiO7KXFGKOtkKMWNpsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dKB+6HYbB8HBfzks6cOzVXqDvjg2m0pkc+yDgb26M3rvk+07vovVrUhKSjDP0ceFq
	 7fx5DO8M07dMo/8RTDTyiV4Pg7ih0X98IeYhYXLhnwJA3vHFSYQF2huOkQao2Beqnp
	 xKvyMK42nsaBQQfrHkCwc+ekbDGenNT5bjjPuip8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394059AbfHBNXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387943AbfHBNXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:23:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3792D2186A;
        Fri,  2 Aug 2019 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752221;
        bh=/JALBUq6mELn3JOlka64G0qvRiO7KXFGKOtkKMWNpsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/RKM1ilLBc5xNrllfoDKDhaOS1tjisTVEr28GvwYL356lXYQowcLFfkKR2IYO5ge
         vh4MKqE5tlo+ks5no6j5bSPxubpZBCf9aCrex7cahvBNWbvdAJcSk+180sKOm9V1FA
         Zxapnaa6HCkHi1VcnhDaBNPfJutJgJ6daM1Y9tjU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 17/42] x86/mm: Check for pfn instead of page in vmalloc_sync_one()
Date:   Fri,  2 Aug 2019 09:22:37 -0400
Message-Id: <20190802132302.13537-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 51b75b5b563a2637f9d8dc5bd02a31b2ff9e5ea0 ]

Do not require a struct page for the mapped memory location because it
might not exist. This can happen when an ioremapped region is mapped with
2MB pages.

Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20190719184652.11391-2-joro@8bytes.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9d9765e4d1ef1..4d12176a470ee 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -267,7 +267,7 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	if (!pmd_present(*pmd))
 		set_pmd(pmd, *pmd_k);
 	else
-		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
 
 	return pmd_k;
 }
-- 
2.20.1

