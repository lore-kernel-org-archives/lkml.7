Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9F4C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FF72166E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919310;
	bh=UmMYLfISrXlZixYjykw0EVKAEAFriWONhw33thiL0oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0nl+rb8WJsPm/LoWQCE4U6MJHgpu7liEukCc5wcHZQV6x4FY4GwMWHY440wz0QZYJ
	 Li6Ua9zl5K15Dk9S+iMJNWWFl6Hq5QGKspxi6Uy9D9BSAAFk4qx2AmT2s5pResly+p
	 M/iUh2OeVZ86mkKwrMlxsztIPRSuf8RL1MPCQoIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbfEOLVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731334AbfEOLVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:21:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C3C20818;
        Wed, 15 May 2019 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919304;
        bh=UmMYLfISrXlZixYjykw0EVKAEAFriWONhw33thiL0oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Q0E/pYulkTKFRYKUEE4WZElqaBJ2yLRRF5O744d8BnO6GrI3pK+cjHQlxqgHdGRy
         r/xXXKgkULxNiaArVRur+FTLgyQZ1Fs+QAN6CjAHwJeno07B75z2tNzyGaD9Z1yVuU
         dv4Zcht5RfV25nxj9qMES4Cmi2l7NNsNaGqDX4c8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liang ZhiCheng <liangzhicheng@baidu.com>,
        Li RongQing <lirongqing@baidu.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/113] libnvdimm/pmem: fix a possible OOB access when read and write pmem
Date:   Wed, 15 May 2019 12:55:15 +0200
Message-Id: <20190515090655.323788736@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9dc6488e84b0f64df17672271664752488cd6a25 ]

If offset is not zero and length is bigger than PAGE_SIZE,
this will cause to out of boundary access to a page memory

Fixes: 98cc093cba1e ("block, THP: make block_device_operations.rw_page support THP")
Co-developed-by: Liang ZhiCheng <liangzhicheng@baidu.com>
Signed-off-by: Liang ZhiCheng <liangzhicheng@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/pmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 1d432c5ed2753..cff027fc26761 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -113,13 +113,13 @@ static void write_pmem(void *pmem_addr, struct page *page,
 
 	while (len) {
 		mem = kmap_atomic(page);
-		chunk = min_t(unsigned int, len, PAGE_SIZE);
+		chunk = min_t(unsigned int, len, PAGE_SIZE - off);
 		memcpy_flushcache(pmem_addr, mem + off, chunk);
 		kunmap_atomic(mem);
 		len -= chunk;
 		off = 0;
 		page++;
-		pmem_addr += PAGE_SIZE;
+		pmem_addr += chunk;
 	}
 }
 
@@ -132,7 +132,7 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 
 	while (len) {
 		mem = kmap_atomic(page);
-		chunk = min_t(unsigned int, len, PAGE_SIZE);
+		chunk = min_t(unsigned int, len, PAGE_SIZE - off);
 		rem = memcpy_mcsafe(mem + off, pmem_addr, chunk);
 		kunmap_atomic(mem);
 		if (rem)
@@ -140,7 +140,7 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
 		len -= chunk;
 		off = 0;
 		page++;
-		pmem_addr += PAGE_SIZE;
+		pmem_addr += chunk;
 	}
 	return BLK_STS_OK;
 }
-- 
2.20.1



