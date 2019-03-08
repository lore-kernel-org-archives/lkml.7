Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D92C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5392208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049470;
	bh=83IWXk9HOj2ruGF9jbECjXRqKwYJKaRdI69M1WshEq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RzAV735k/f9ZEpqLvRz075reVCcEJPqmLutzVnVq2WybQ6d72MVuDHvFtnqnHVxQR
	 ONIM/+p7GgZIg5FhXvVkEB52IfjTeTqpIvKEC17x768icO1OUFVu82m/n3NtVmMoZ7
	 uBNADIlHCQDToOn28FmSpdgZ9ExWbz2kVkHiHemc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCHMvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfCHMvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:51:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE7F20684;
        Fri,  8 Mar 2019 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049464;
        bh=83IWXk9HOj2ruGF9jbECjXRqKwYJKaRdI69M1WshEq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IF34PVmPBTBCB3FZZXY25SHKXDbhVLZxUPtsEBignKg+lFvCjMjzkpUAjAY/+LKG/
         3XRcPH7YQJ7ICJBKkQPLwOcFVflSw3nwX1WYeayHce+VXdQKyIibqq4eTJHA49KrJc
         Z2iCv8Hyp8e8i8ahnSZbV/XW0bfap6bqPvdPYjp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5.0 11/46] staging: erofs: fix illegal address access under memory pressure
Date:   Fri,  8 Mar 2019 13:49:44 +0100
Message-Id: <20190308124902.970842520@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 1e5ceeab6929585512c63d05911d6657064abf7b upstream.

Considering a read request with two decompressed file pages,
If a decompression work cannot be started on the previous page
due to memory pressure but in-memory LTP map lookup is done,
builder->work should be still NULL.

Moreover, if the current page also belongs to the same map,
it won't try to start the decompression work again and then
run into trouble.

This patch aims to solve the above issue only with little changes
as much as possible in order to make the fix backport easier.

kernel message is:
<4>[1051408.015930s]SLUB: Unable to allocate memory on node -1, gfp=0x2408040(GFP_NOFS|__GFP_ZERO)
<4>[1051408.015930s]  cache: erofs_compress, object size: 144, buffer size: 144, default order: 0, min order: 0
<4>[1051408.015930s]  node 0: slabs: 98, objs: 2744, free: 0
  * Cannot allocate the decompression work

<3>[1051408.015960s]erofs: z_erofs_vle_normalaccess_readpages, readahead error at page 1008 of nid 5391488
  * Note that the previous page was failed to read

<0>[1051408.015960s]Internal error: Accessing user space memory outside uaccess.h routines: 96000005 [#1] PREEMPT SMP
...
<4>[1051408.015991s]Hardware name: kirin710 (DT)
...
<4>[1051408.016021s]PC is at z_erofs_vle_work_add_page+0xa0/0x17c
<4>[1051408.016021s]LR is at z_erofs_do_read_page+0x12c/0xcf0
...
<4>[1051408.018096s][<ffffff80c6fb0fd4>] z_erofs_vle_work_add_page+0xa0/0x17c
<4>[1051408.018096s][<ffffff80c6fb3814>] z_erofs_vle_normalaccess_readpages+0x1a0/0x37c
<4>[1051408.018096s][<ffffff80c6d670b8>] read_pages+0x70/0x190
<4>[1051408.018127s][<ffffff80c6d6736c>] __do_page_cache_readahead+0x194/0x1a8
<4>[1051408.018127s][<ffffff80c6d59318>] filemap_fault+0x398/0x684
<4>[1051408.018127s][<ffffff80c6d8a9e0>] __do_fault+0x8c/0x138
<4>[1051408.018127s][<ffffff80c6d8f90c>] handle_pte_fault+0x730/0xb7c
<4>[1051408.018127s][<ffffff80c6d8fe04>] __handle_mm_fault+0xac/0xf4
<4>[1051408.018157s][<ffffff80c6d8fec8>] handle_mm_fault+0x7c/0x118
<4>[1051408.018157s][<ffffff80c8c52998>] do_page_fault+0x354/0x474
<4>[1051408.018157s][<ffffff80c8c52af8>] do_translation_fault+0x40/0x48
<4>[1051408.018157s][<ffffff80c6c002f4>] do_mem_abort+0x80/0x100
<4>[1051408.018310s]---[ end trace 9f4009a3283bd78b ]---

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/unzip_vle.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -721,8 +721,12 @@ repeat:
 
 	/* lucky, within the range of the current map_blocks */
 	if (offset + cur >= map->m_la &&
-		offset + cur < map->m_la + map->m_llen)
+		offset + cur < map->m_la + map->m_llen) {
+		/* didn't get a valid unzip work previously (very rare) */
+		if (!builder->work)
+			goto restart_now;
 		goto hitted;
+	}
 
 	/* go ahead the next map_blocks */
 	debugln("%s: [out-of-range] pos %llu", __func__, offset + cur);
@@ -736,6 +740,7 @@ repeat:
 	if (unlikely(err))
 		goto err_out;
 
+restart_now:
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
 		goto hitted;
 


