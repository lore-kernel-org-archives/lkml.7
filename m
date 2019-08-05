Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52757C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FEE216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011729;
	bh=dW5DkAzkHpksuzWKswpNCfk3LhCBfQVWwPOA114BGVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BMajqMEe//qtABLpRL2z9OyiKp8Ic+EfFQwNvIzh3TUsVdOnysJb8PcBWg47S8hJs
	 JnPTJwc59Ib/oGdhG52zeEVNAzQYRp5kqMe1Q0tFMqmRTAkUmn0H8HCKieSRnx/O2q
	 k20kUPZzq5wCxGSjUYwNCBvRpJP1XLkATRzmPWcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfHENWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbfHENWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:22:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CC520657;
        Mon,  5 Aug 2019 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011339;
        bh=dW5DkAzkHpksuzWKswpNCfk3LhCBfQVWwPOA114BGVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyCx/XMIK2qCNwvQk7NAwL44hHunYP5bOE9E5vjHh7ocPNfnjClw6UymvZcX6Jwyd
         olqA/QHdgDGSFb3rXVswj59FR71eRqMhhuciqjnstBYhiD8ALOELyMqAxlFdfs1mFa
         o7SdG/YY47qyrbqPjUATA4S3ZwDnSJ1/IFE75k7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Will Deacon <will.deacon@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 056/131] mm/ioremap: check virtual address alignment while creating huge mappings
Date:   Mon,  5 Aug 2019 15:02:23 +0200
Message-Id: <20190805124955.183073760@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6b95ab4218bfa59bc315105127ffe03aef3b5742 ]

Virtual address alignment is essential in ensuring correct clearing for
all intermediate level pgtable entries and freeing associated pgtable
pages.  An unaligned address can end up randomly freeing pgtable page
that potentially still contains valid mappings.  Hence also check it's
alignment along with existing phys_addr check.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/ioremap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index 063213685563c..a95161d9c883c 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -86,6 +86,9 @@ static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
 	if ((end - addr) != PMD_SIZE)
 		return 0;
 
+	if (!IS_ALIGNED(addr, PMD_SIZE))
+		return 0;
+
 	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
 		return 0;
 
@@ -126,6 +129,9 @@ static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
 	if ((end - addr) != PUD_SIZE)
 		return 0;
 
+	if (!IS_ALIGNED(addr, PUD_SIZE))
+		return 0;
+
 	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
 		return 0;
 
@@ -166,6 +172,9 @@ static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 	if ((end - addr) != P4D_SIZE)
 		return 0;
 
+	if (!IS_ALIGNED(addr, P4D_SIZE))
+		return 0;
+
 	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
 		return 0;
 
-- 
2.20.1



