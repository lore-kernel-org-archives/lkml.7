Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B39C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F12217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738559;
	bh=4e7K11PfMIhXOu7QlSmT0dlreo4YuwrOLP/AMEUugM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VBnFpnR7rm/bdF5pa2iCCJ2n5EUWeGOKlWU8IlG4wgYv7Sz/GRSKEl9GrILy6s30l
	 0tK2ahhvjR5o4zTbdwBXvAHoUMUtLCCNlPHYSsPSEwnQ/XY6+5XP/H+oz4eYqbJJBU
	 fCDdDg3xfGOb8fKy4DuzuswhR4gqIvxHuXb/tkJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404792AbfHBJf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404041AbfHBJfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:35:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E67B217D4;
        Fri,  2 Aug 2019 09:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738553;
        bh=4e7K11PfMIhXOu7QlSmT0dlreo4YuwrOLP/AMEUugM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoit9m0mXCo9DBxljWwBqKHWX+xsg0fkw7DE/Hcsjys/QyHnlzWUT14r3ovU/WQ5V
         6VIPxLV4kdZupRWVRWmisQb65Gt2aCo27LExMdW/5o/f2fhZu+3YpXZ12pu3JKFNa1
         YmArtb7MroRcu4aFBd+Y69vsI0tmzpQzAoozNh/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Oliver OHalloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 132/158] powerpc/eeh: Handle hugepages in ioremap space
Date:   Fri,  2 Aug 2019 11:29:13 +0200
Message-Id: <20190802092230.213182896@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 33439620680be5225c1b8806579a291e0d761ca0 ]

In commit 4a7b06c157a2 ("powerpc/eeh: Handle hugepages in ioremap
space") support for using hugepages in the vmalloc and ioremap areas was
enabled for radix. Unfortunately this broke EEH MMIO error checking.

Detection works by inserting a hook which checks the results of the
ioreadXX() set of functions.  When a read returns a 0xFFs response we
need to check for an error which we do by mapping the (virtual) MMIO
address back to a physical address, then mapping physical address to a
PCI device via an interval tree.

When translating virt -> phys we currently assume the ioremap space is
only populated by PAGE_SIZE mappings. If a hugepage mapping is found we
emit a WARN_ON(), but otherwise handles the check as though a normal
page was found. In pathalogical cases such as copying a buffer
containing a lot of 0xFFs from BAR memory this can result in the system
not booting because it's too busy printing WARN_ON()s.

There's no real reason to assume huge pages can't be present and we're
prefectly capable of handling them, so do that.

Fixes: 4a7b06c157a2 ("powerpc/eeh: Handle hugepages in ioremap space")
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190710150517.27114-1-oohall@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/eeh.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6696c1986844..16193d7b0635 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -363,10 +363,19 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 					   NULL, &hugepage_shift);
 	if (!ptep)
 		return token;
-	WARN_ON(hugepage_shift);
-	pa = pte_pfn(*ptep) << PAGE_SHIFT;
 
-	return pa | (token & (PAGE_SIZE-1));
+	pa = pte_pfn(*ptep);
+
+	/* On radix we can do hugepage mappings for io, so handle that */
+	if (hugepage_shift) {
+		pa <<= hugepage_shift;
+		pa |= token & ((1ul << hugepage_shift) - 1);
+	} else {
+		pa <<= PAGE_SHIFT;
+		pa |= token & (PAGE_SIZE - 1);
+	}
+
+	return pa;
 }
 
 /*
-- 
2.20.1



