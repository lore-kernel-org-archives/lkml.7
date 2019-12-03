Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6242C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F32D21582
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413634;
	bh=/PKAD3AkTjyL9c8QHOk65inIyuVXFHetGmXfEQaBdZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+H2GZJ8SbHIjH0Upt5jXr0Z6o0LmLoktEiuSPkO/WpHyqKg3OOVUS5Wx1GlsHTaU
	 E0hcbK71MMH53d5glCNKqNVViHfNQcS/V3g+tw+Wwrr6OH6PsaCBkzeGp7t0929SfJ
	 lvPGxc5rPBKPK88IsywTpd868az98oxIRHBgRrrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfLCWxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbfLCWxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:53:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E068F21582;
        Tue,  3 Dec 2019 22:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413629;
        bh=/PKAD3AkTjyL9c8QHOk65inIyuVXFHetGmXfEQaBdZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSVioDquWM4OwjfbWIkcAhBZ47chunpLCNhuPEC1xbnKo1LMBQLp3Smx+uu1A9EHr
         fmSmzJK+54jIYgilOVyN1bPBrNWAMnl5I108xJXdMLx7nbgN/JeIuUyQPh684gL7eK
         PKg+c+eoSCBM/kwreGkIRJ7Fpwx6XKVNPa4qBgLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wentao Wang <witallwang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 200/321] mm/page_alloc.c: deduplicate __memblock_free_early() and memblock_free()
Date:   Tue,  3 Dec 2019 23:34:26 +0100
Message-Id: <20191203223437.527630884@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wentao Wang <witallwang@gmail.com>

[ Upstream commit d31cfe7bff9109476da92c245b56083e9b48d60a ]

Link: http://lkml.kernel.org/r/C8ECE1B7A767434691FEEFA3A01765D72AFB8E78@MX203CL03.corp.emc.com
Signed-off-by: Wentao Wang <witallwang@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memblock.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 237944479d25a..bb4e32c6b19e9 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1537,12 +1537,7 @@ void * __init memblock_virt_alloc_try_nid(
  */
 void __init __memblock_free_early(phys_addr_t base, phys_addr_t size)
 {
-	phys_addr_t end = base + size - 1;
-
-	memblock_dbg("%s: [%pa-%pa] %pF\n",
-		     __func__, &base, &end, (void *)_RET_IP_);
-	kmemleak_free_part_phys(base, size);
-	memblock_remove_range(&memblock.reserved, base, size);
+	memblock_free(base, size);
 }
 
 /**
-- 
2.20.1



