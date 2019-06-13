Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BBAC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E9C520866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441993;
	bh=2wol2PuCFvjV0G0iPAMvNKKiMoTyf9ad8KlBzdEMfJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uSqBmvELiAWnqopgOJOQP0CQctPDqiWoDrcPa98OsqT/TY7Viz5dzNMikMF7j8qIR
	 yPYDndufXOSFVyflCeC949Xjx8rFggOydiA/ucITI6vmw01MS5bolOt0MTSsPPtLf9
	 JEPa7u9oLJszLIdjhY7mSV+qDW1zO8AuLD5dGPro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391309AbfFMQGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731321AbfFMIqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:46:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E722173C;
        Thu, 13 Jun 2019 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415562;
        bh=2wol2PuCFvjV0G0iPAMvNKKiMoTyf9ad8KlBzdEMfJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPQ7vCUfYIi5ne5OASvYhuWY8/9EIMqlW5lTRmjbSOQ3XieExPiESrHa2wWH5ksjs
         H0mbuNFGsUmHHdt8JlTpGlbPx+glKDiR5LuAEASUXQp0+g8Q42fDk7VIOQJ/WqPZx1
         UjOv3roAM5iaJuLp3AikZQmxwcgfnw1XAiVG8Ccw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 012/155] mm/hmm: select mmu notifier when selecting HMM
Date:   Thu, 13 Jun 2019 10:32:04 +0200
Message-Id: <20190613075653.438871567@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 734fb89968900b5c5f8edd5038bd4cdeab8c61d2 ]

To avoid random config build issue, select mmu notifier when HMM is
selected.  In any cases when HMM get selected it will be by users that
will also wants the mmu notifier.

Link: http://lkml.kernel.org/r/20190403193318.16478-2-jglisse@redhat.com
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb8a7db..2e6d24d783f7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -694,12 +694,12 @@ config DEV_PAGEMAP_OPS
 
 config HMM
 	bool
+	select MMU_NOTIFIER
 	select MIGRATE_VMA_HELPER
 
 config HMM_MIRROR
 	bool "HMM mirror CPU page table into a device page table"
 	depends on ARCH_HAS_HMM
-	select MMU_NOTIFIER
 	select HMM
 	help
 	  Select HMM_MIRROR if you want to mirror range of the CPU page table of a
-- 
2.20.1



