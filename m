Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E497DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A737A2192C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138651;
	bh=RBKjI2e9mB0gL351BDQXEksrvxoiTHvA98RqtlJKikQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LPulgN5ExeQ/s6gNXYDaoiod+YUlSm2rWWD+vOhr3KVsBa6IuCkXC5CFQ/gE6UviD
	 dQcHQ2BM3AS/AXk1Qz3aPsLo73ocxzrjyAJzYStNhfFWcGUXQpmSFsAeH9qmWuFTtp
	 T/Bo7qqONRzYK7odoM74EawkCWRyjZNrQGoXKIE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfDARKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfDARKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312A021924;
        Mon,  1 Apr 2019 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138643;
        bh=RBKjI2e9mB0gL351BDQXEksrvxoiTHvA98RqtlJKikQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uQPjPUxWh0+a92YYgDkAMZ1XUhKyKizedERVrMbj8U8m0Qt48L6BCWib8MzE5vYQZ
         WTODh1ZwAImfWCw3YJc2SEfDWddpbctBF8UAOm88Bxftdb7PV7W6eFg8d/CerTci+I
         6+egILiNHXSuwPJomhful1NyKDMZvHYJPVKW2WP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5.0 087/146] staging: erofs: fix to handle error path of erofs_vmap()
Date:   Mon,  1 Apr 2019 19:01:39 +0200
Message-Id: <20190401170056.177888153@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

commit 8bce6dcede65139a087ff240127e3f3c01363eed upstream.

erofs_vmap() wrapped vmap() and vm_map_ram() to return virtual
continuous memory, but both of them can failed due to a lot of
reason, previously, erofs_vmap()'s callers didn't handle them,
which can potentially cause NULL pointer access, fix it.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Fixes: 0d40d6e399c1 ("staging: erofs: add a generic z_erofs VLE decompressor")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/unzip_vle.c     |    4 ++++
 drivers/staging/erofs/unzip_vle_lz4.c |    7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1034,6 +1034,10 @@ repeat:
 
 skip_allocpage:
 	vout = erofs_vmap(pages, nr_pages);
+	if (!vout) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	err = z_erofs_vle_unzip_vmap(compressed_pages,
 		clusterpages, vout, llen, work->pageofs, overlapped);
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -136,10 +136,13 @@ int z_erofs_vle_unzip_fast_percpu(struct
 
 	nr_pages = DIV_ROUND_UP(outlen + pageofs, PAGE_SIZE);
 
-	if (clusterpages == 1)
+	if (clusterpages == 1) {
 		vin = kmap_atomic(compressed_pages[0]);
-	else
+	} else {
 		vin = erofs_vmap(compressed_pages, clusterpages);
+		if (!vin)
+			return -ENOMEM;
+	}
 
 	preempt_disable();
 	vout = erofs_pcpubuf[smp_processor_id()].data;


