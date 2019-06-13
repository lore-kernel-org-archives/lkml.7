Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B58FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE882173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443415;
	bh=BNbxu4zfrw+e3UY+/tqBh1L4CBa6pxKcFjnrA7DapY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ixDBVRO68OTTOy/75fIf/SAISNr9ZoXkpj+M8t1YmslQd4iBhV3OR7Rja7J9G11hC
	 L8lL60MyFfSUGjsXaSY8vBtaac9Q7QGaoOIk2hMrGDcnZIFO70jpzyRDMRShriqkFA
	 guzsskXWXdhhzwdb2KKGnKD+910eq2+Kcgd3HUY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392527AbfFMQaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730917AbfFMIfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:35:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE96620B7C;
        Thu, 13 Jun 2019 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560414903;
        bh=BNbxu4zfrw+e3UY+/tqBh1L4CBa6pxKcFjnrA7DapY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+Yj2Kg7n17EuyZyyv+O7Qnlok+lwD6LwyNgAZyyRFGV7AID8Z1x23v0f3jxIA9tS
         6Mvy8I3kYxDJLbBjj0lT18qPAiGwLEdmyDHK2ixWtPLkaqah3p7tutRkWPHCJIxdVm
         xh3zHhO2Vm+t9UmetJnK5t2awPMtEWCxOMiQq6Ho=
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
Subject: [PATCH 4.14 06/81] mm/hmm: select mmu notifier when selecting HMM
Date:   Thu, 13 Jun 2019 10:32:49 +0200
Message-Id: <20190613075649.529301482@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
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
index 59efbd3337e0..cc4d633947bf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -708,12 +708,12 @@ config MIGRATE_VMA_HELPER
 
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



