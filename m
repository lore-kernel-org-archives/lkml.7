Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE6C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC06207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573918996;
	bh=xSTAfSAwQlR+mw6DZnVx2dvVH4DuAFNoVR9OKpY6MwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1hvL6Gm6VP7mRF9H9eb/0dn8/K2KNwvvhu471VK/jLFwJO7Qhk69dI46nBPe6z11D
	 rS6Yhc5rs9UE86xY6QedfFadmMV2ray79W+DT0MHdeTCm2kuKcXIaCEDOR1OlKpwxO
	 C9+zRxJWObLvmfPpF3aoxPEMYjtHfhgjRTH0FhSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfKPPnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbfKPPnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:10 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254E02072D;
        Sat, 16 Nov 2019 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918989;
        bh=xSTAfSAwQlR+mw6DZnVx2dvVH4DuAFNoVR9OKpY6MwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZHhtcwsaQodyOzZDIbL4eA2D1A7AyfR5dOdQM74sdjWX+OsOXxxRzo4zeyIYUKPd
         LVAnGniTq8AHZ8LOTEeJYJwW9LtGuFCxbKWwzrYW2m4+7ShNobcSKQvx6IfOi/fC29
         suo/kfW5xu1t30Hjx98BfiunKrvVvG/w89ZWY0cI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 094/237] powerpc/mm/radix: Fix small page at boundary when splitting
Date:   Sat, 16 Nov 2019 10:38:49 -0500
Message-Id: <20191116154113.7417-94-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 81d1b54dec95209ab5e5be2cf37182885f998753 ]

When we have CONFIG_STRICT_KERNEL_RWX enabled, we want to split the
linear mapping at the text/data boundary so we can map the kernel
text read only.

Currently we always use a small page at the text/data boundary, even
when that's not necessary:

  Mapped 0x0000000000000000-0x0000000000e00000 with 2.00 MiB pages
  Mapped 0x0000000000e00000-0x0000000001000000 with 64.0 KiB pages
  Mapped 0x0000000001000000-0x0000000040000000 with 2.00 MiB pages

This is because the check that the mapping crosses the __init_begin
boundary is too strict, it also returns true when we map exactly up to
the boundary.

So fix it to check that the mapping would actually map past
__init_begin, and with that we see:

  Mapped 0x0000000000000000-0x0000000040000000 with 2.00 MiB pages
  Mapped 0x0000000040000000-0x0000000100000000 with 1.00 GiB pages

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/pgtable-radix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index b387c7b917b7e..69caeb5bccb21 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -295,14 +295,14 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
 			(addr < __pa_symbol(__init_begin)) &&
-			(addr + mapping_size) >= __pa_symbol(__init_begin)) {
+			(addr + mapping_size) > __pa_symbol(__init_begin)) {
 			max_mapping_size = PMD_SIZE;
 			goto retry;
 		}
 
 		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
 		    (addr < __pa_symbol(__init_begin)) &&
-		    (addr + mapping_size) >= __pa_symbol(__init_begin)) {
+		    (addr + mapping_size) > __pa_symbol(__init_begin)) {
 			mapping_size = PAGE_SIZE;
 			psize = mmu_virtual_psize;
 		}
-- 
2.20.1

