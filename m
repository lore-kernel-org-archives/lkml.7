Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74D5C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC69321555
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888386;
	bh=JBQjh57E1Ndhk4dCtXRsycP+umjDUfzghAGmYQhFalo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BExiHVeFK+0WAGJSGIpUr0jh5KiRqAI5DCHDu51MjRadOFnuhQjmh4xqp9jkL7hd1
	 dybb834BEV/Fdz+wVbGR1BaYvhmzjDvz3ShmB9Zzvv+6i5PqV6bNoNLmsm86P6rnwn
	 UjxjEUGKyXQ4PNVEDaFXZ4astflLViQu6EYCzV2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfK0U7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbfK0U7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:59:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7B820678;
        Wed, 27 Nov 2019 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888378;
        bh=JBQjh57E1Ndhk4dCtXRsycP+umjDUfzghAGmYQhFalo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTY0RZUBmfOxmdbt1aBasIvKFk42gskcKCN27Gpc4cXLso8RXc94hE4KUmwMmDbdZ
         U2+e/gjgNFF29NW3zRHTQQP6AQSB0/yWbPEJdIcZq4yrvr/LarqAY0++JWEmhFNN4/
         kMRJBjd+u12Q+aA4Xny2oagL/0qirqMxTVdjLixU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 112/306] powerpc/mm/radix: Fix overuse of small pages in splitting logic
Date:   Wed, 27 Nov 2019 21:29:22 +0100
Message-Id: <20191127203123.406072189@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 3b5657ed5b4e27ccf593a41ff3c5aa27dae8df18 ]

When we have CONFIG_STRICT_KERNEL_RWX enabled, we want to split the
linear mapping at the text/data boundary so we can map the kernel text
read only.

But the current logic uses small pages for the entire text section,
regardless of whether a larger page size would fit. eg. with the
boundary at 16M we could use 2M pages, but instead we use 64K pages up
to the 16M boundary:

  Mapped 0x0000000000000000-0x0000000001000000 with 64.0 KiB pages
  Mapped 0x0000000001000000-0x0000000040000000 with 2.00 MiB pages
  Mapped 0x0000000040000000-0x0000000100000000 with 1.00 GiB pages

This is because the test is checking if addr is < __init_begin
and addr + mapping_size is >= _stext. But that is true for all pages
between _stext and __init_begin.

Instead what we want to check is if we are crossing the text/data
boundary, which is at __init_begin. With that fixed we see:

  Mapped 0x0000000000000000-0x0000000000e00000 with 2.00 MiB pages
  Mapped 0x0000000000e00000-0x0000000001000000 with 64.0 KiB pages
  Mapped 0x0000000001000000-0x0000000040000000 with 2.00 MiB pages
  Mapped 0x0000000040000000-0x0000000100000000 with 1.00 GiB pages

ie. we're correctly using 2MB pages below __init_begin, but we still
drop down to 64K pages unnecessarily at the boundary.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/pgtable-radix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 24a2eadc8c21a..b387c7b917b7e 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -295,14 +295,14 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
 			(addr < __pa_symbol(__init_begin)) &&
-			(addr + mapping_size) >= __pa_symbol(_stext)) {
+			(addr + mapping_size) >= __pa_symbol(__init_begin)) {
 			max_mapping_size = PMD_SIZE;
 			goto retry;
 		}
 
 		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
 		    (addr < __pa_symbol(__init_begin)) &&
-		    (addr + mapping_size) >= __pa_symbol(_stext)) {
+		    (addr + mapping_size) >= __pa_symbol(__init_begin)) {
 			mapping_size = PAGE_SIZE;
 			psize = mmu_virtual_psize;
 		}
-- 
2.20.1



