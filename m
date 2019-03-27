Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F4BC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D82217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709830;
	bh=MGfIoXnzyNJ/KAFrw5ZJrFi7P/sOO+b797C3j3DpCrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2HWu7CXcVBAV74oSnGcBrpG+EXH1OM6a2AA1AOh8T5VPS/BAXK/NzVJSU7NagYvpM
	 95P/EnH2rpIGz4MWbsUiPMOZ3SYtR05cnr8Gda1FqsknNBRnFdxyTmgsnf4B4Xpnst
	 yQrT4V4hEWSLhRFBNBlKyjyBfjDlxdvcziUuOISw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbfC0SDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732685AbfC0SDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9AB42087C;
        Wed, 27 Mar 2019 18:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709827;
        bh=MGfIoXnzyNJ/KAFrw5ZJrFi7P/sOO+b797C3j3DpCrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKJDa9lqPCT5FrQKRqlbe33Y1Ye8nJS7oPjbXYzBZXdORbP2sT2Gk9qQ/a+zaOe+r
         56eY7JaZIzN0iAPiS8P7be/uC6PxgIAFcyBrhSvdPoWSPmaep2ZwWuIFnw4qKCwHN4
         ZhUQpFgGkEsWbo2bsOhgFsFweXmOBPHTka2uJitQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jerome Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Keith Busch <keith.busch@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 061/262] mm/resource: Return real error codes from walk failures
Date:   Wed, 27 Mar 2019 13:58:36 -0400
Message-Id: <20190327180158.10245-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

[ Upstream commit 5cd401ace914dc68556c6d2fcae0c349444d5f86 ]

walk_system_ram_range() can return an error code either becuase
*it* failed, or because the 'func' that it calls returned an
error.  The memory hotplug does the following:

	ret = walk_system_ram_range(..., func);
        if (ret)
		return ret;

and 'ret' makes it out to userspace, eventually.  The problem
s, walk_system_ram_range() failues that result from *it* failing
(as opposed to 'func') return -1.  That leads to a very odd
-EPERM (-1) return code out to userspace.

Make walk_system_ram_range() return -EINVAL for internal
failures to keep userspace less confused.

This return code is compatible with all the callers that I
audited.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ross Zwisler <zwisler@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Huang Ying <ying.huang@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 915c02e8e5dd..ca7ed5158cff 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -382,7 +382,7 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
 				 int (*func)(struct resource *, void *))
 {
 	struct resource res;
-	int ret = -1;
+	int ret = -EINVAL;
 
 	while (start < end &&
 	       !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
@@ -462,7 +462,7 @@ int walk_system_ram_range(unsigned long start_pfn, unsigned long nr_pages,
 	unsigned long flags;
 	struct resource res;
 	unsigned long pfn, end_pfn;
-	int ret = -1;
+	int ret = -EINVAL;
 
 	start = (u64) start_pfn << PAGE_SHIFT;
 	end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
-- 
2.19.1

