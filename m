Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D1D2133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383772;
	bh=uF6LpAxsYE0kGQZyHL/8g2CnZUbyHV5+7kIbwDuFRO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RuMvgCbYRm9K7eASBw28b6SFMGXUHV17gbi7Fa20aCjePVzrFBE6UUVNntztOPy4Z
	 7siAJlXtOvW2eap3Rk6kPderM+BxcCjGLjZcQam7YdM5p6Yoxitssn3y9sTkexVogW
	 /pA6QWw2V9jkpOJTEQ78gEH96+WIqv7TProkHVuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfJFRmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728632AbfJFRmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:42:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED2720862;
        Sun,  6 Oct 2019 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383765;
        bh=uF6LpAxsYE0kGQZyHL/8g2CnZUbyHV5+7kIbwDuFRO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbQ0h6meoi3MGsD6KNcOp6nSVwS1zh7+68xA5EODmASjEVpbLZSxmvEqi1aAz7WZE
         nQ+DqvG4FFrQvySD47dKGA32kTlrikWp1hNJfDlY010n1WtZhSCuIKKwAtwZY6MfNh
         8aoHXG+N+M2gweni0krS4BGXDUyNdcr5LYjfGbSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 043/166] powerpc/64s/radix: Fix memory hotplug section page table creation
Date:   Sun,  6 Oct 2019 19:20:09 +0200
Message-Id: <20191006171216.583275848@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 8f51e3929470942e6a8744061254fdeef646cd36 ]

create_physical_mapping expects physical addresses, but creating and
splitting these mappings after boot is supplying virtual (effective)
addresses. This can be irritated by booting with mem= to limit memory
then probing an unused physical memory range:

  echo <addr> > /sys/devices/system/memory/probe

This mostly works by accident, firstly because __va(__va(x)) == __va(x)
so the virtual address does not get corrupted. Secondly because pfn_pte
masks out the upper bits of the pfn beyond the physical address limit,
so a pfn constructed with a 0xc000000000000000 virtual linear address
will be masked back to the correct physical address in the pte.

Fixes: 6cc27341b21a8 ("powerpc/mm: add radix__create_section_mapping()")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190724084638.24982-1-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index b4ca9e95e6781..c5cc16ab1954e 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -902,7 +902,7 @@ int __meminit radix__create_section_mapping(unsigned long start, unsigned long e
 		return -1;
 	}
 
-	return create_physical_mapping(start, end, nid);
+	return create_physical_mapping(__pa(start), __pa(end), nid);
 }
 
 int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
-- 
2.20.1



