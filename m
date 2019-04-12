Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E6720643
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oGHyjfwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDLKER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:04:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44110 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfDLKEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:04:16 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190412100414euoutp02a091d3b6d46bd5b6092ed196c7d13a03~UsfkL6oyM0806108061euoutp02V
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 10:04:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190412100414euoutp02a091d3b6d46bd5b6092ed196c7d13a03~UsfkL6oyM0806108061euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555063454;
        bh=+ZEpazSWubH2AEi33K6zXgN4idtxO2jSTdHtcuL+NkU=;
        h=To:Cc:From:Subject:Date:References:From;
        b=oGHyjfwhOiYykWyvAYlTFRl6qNylFSehXbkFDaMLfPaGHi6U8yGruwwa/BwaHZbtC
         g/C1uJ9F8Bngo+UutVt0RBVyR8/rFInec6EA4rKe1dwgQP00YVuNh/W2ulo8i3AJda
         NM9yT8yLfqE6ksBw55s/SUk4Ta/Zs+fwPqjlgO7o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190412100414eucas1p1dc978872cd5efb82cba8a53076b949e7~UsfjzUYVv2942229422eucas1p1N;
        Fri, 12 Apr 2019 10:04:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 67.69.04325.D9260BC5; Fri, 12
        Apr 2019 11:04:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190412100413eucas1p19510296b44a2b81b3de2bae038e94940~UsfjBs_4t1899018990eucas1p1_;
        Fri, 12 Apr 2019 10:04:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412100413eusmtrp20c760d931895776de870fb42b32c8176~UsfizwZhK1874018740eusmtrp28;
        Fri, 12 Apr 2019 10:04:13 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-08-5cb0629d14ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.04.04146.C9260BC5; Fri, 12
        Apr 2019 11:04:12 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190412100412eusmtip2e9a46b25baab79e83f881dcc58e4d57b~UsfikACq71458214582eusmtip2K;
        Fri, 12 Apr 2019 10:04:12 +0000 (GMT)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] mm: remove redundant 'default n' from Kconfig-s
Message-ID: <c3385916-e4d4-37d3-b330-e6b7dff83a52@samsung.com>
Date:   Fri, 12 Apr 2019 12:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7pzkzbEGFyfZWoxZ/0aNovLu+aw
        Wdxb85/Vgdlj06dJ7B4nZvxm8fi8SS6AOYrLJiU1J7MstUjfLoEr4/X+G8wFbSoVX2Y1MDcw
        3pHuYuTkkBAwkbi+7wVjFyMXh5DACkaJWxsvs0M4XxglNj6fCpX5zCjx8ds9dpiWIxMboaqW
        M0q8fTYZynnLKNF35gQbSJWIgK7Eque7mEFsZqCO+60PWUFsNgEriYntq4DGcnAICzhITHmj
        DRLmFbCTmH94HVgJi4CqRPv9a8wgJaICERL9Z9QhSgQlTs58wgIxUV5i+9s5zCBrJQRus0l8
        3PgIbKSEgIvE0611EHcKS7w6vgXqZhmJ/zvnM0HUr2OU+NvxAqp5O6PE8sn/2CCqrCUOH7/I
        CjKIWUBTYv0ufYiwo8SqWyDPg8znk7jxVhDiBj6JSdumM0OEeSU62oQgqtUkNizbwAaztmvn
        SmYI20PidONmFpByIYFYiRmn7CcwKsxC8tgsJI/NQjhhASPzKkbx1NLi3PTUYuO81HK94sTc
        4tK8dL3k/NxNjMBUcfrf8a87GPf9STrEKMDBqMTDu8F5fYwQa2JZcWXuIUYJDmYlEd4QFqAQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRrvL/8wYVn6M
        FNsleGDmVgezg69s3toKVbKtXL/u/F17bnbftzIKayPcvaS143XPHHbbe9XQec3nOqmX2oXc
        Zmt2TrBPPvRsRvsyfbYbLheCk17PMPnl2rDteJ5//LFTvsn6r961Venm6ZZylH+OTQt7wj1l
        jRnr7HjfJ9Yy9af1n695UuMUocRSnJFoqMVcVJwIAMejNfYRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsVy+t/xe7pzkjbEGLy9aWMxZ/0aNovLu+aw
        Wdxb85/Vgdlj06dJ7B4nZvxm8fi8SS6AOUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q
        2DzWyshUSd/OJiU1J7MstUjfLkEv4/X+G8wFbSoVX2Y1MDcw3pHuYuTkkBAwkTgysZG9i5GL
        Q0hgKaPEl6MTgBwOoISMxPH1ZRA1whJ/rnWxQdS8ZpSYOm8zO0hCREBXYtXzXcwgNjPQoPut
        D1lBbDYBK4mJ7asYQeYICzhITHmjDRLmFbCTmH94HVgJi4CqRPv9a2CtogIRErcedrBA1AhK
        nJz5hAVipLrEn3mXoMbLS2x/O4d5AiP/LCRls5CUzUJStoCReRWjSGppcW56brGhXnFibnFp
        Xrpecn7uJkZgUG879nPzDsZLG4MPMQpwMCrx8AZYrY8RYk0sK67MPcQowcGsJMIbwgIU4k1J
        rKxKLcqPLyrNSS0+xGgKdPhEZinR5HxgxOWVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJ
        zU5NLUgtgulj4uCUamAsPspxLuQs39V5m+RFTt64/H+vnpzJq3NSk1K8FpgYfkwxUKifEhKQ
        8c+C2WB3m5W2WF6BwEbLsFccXD8F5t7kmqz8lPv+njdC6285vPmrqH7svMJ127lfmT5+CvFU
        qhW4E/Tk0ZSW5c/uyp6pUnj107DFhN+lybuAreJOmqNY3fpn9Y3yZ5cosRRnJBpqMRcVJwIA
        qPQ09oACAAA=
X-CMS-MailID: 20190412100413eucas1p19510296b44a2b81b3de2bae038e94940
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190412100413eucas1p19510296b44a2b81b3de2bae038e94940
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190412100413eucas1p19510296b44a2b81b3de2bae038e94940
References: <CGME20190412100413eucas1p19510296b44a2b81b3de2bae038e94940@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 mm/Kconfig       |   11 -----------
 mm/Kconfig.debug |    1 -
 2 files changed, 12 deletions(-)

Index: b/mm/Kconfig
===================================================================
--- a/mm/Kconfig	2019-04-12 12:01:55.622124712 +0200
+++ b/mm/Kconfig	2019-04-12 12:01:55.598124711 +0200
@@ -161,7 +161,6 @@ config MEMORY_HOTPLUG_SPARSE
 
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
         bool "Online the newly added memory blocks by default"
-        default n
         depends on MEMORY_HOTPLUG
         help
 	  This option sets the default policy setting for memory hotplug
@@ -439,7 +438,6 @@ config NEED_PER_CPU_KM
 
 config CLEANCACHE
 	bool "Enable cleancache driver to cache clean pages if tmem is present"
-	default n
 	help
 	  Cleancache can be thought of as a page-granularity victim cache
 	  for clean pages that the kernel's pageframe replacement algorithm
@@ -463,7 +461,6 @@ config CLEANCACHE
 config FRONTSWAP
 	bool "Enable frontswap to cache swap pages if tmem is present"
 	depends on SWAP
-	default n
 	help
 	  Frontswap is so named because it can be thought of as the opposite
 	  of a "backing" store for a swap device.  The data is stored into
@@ -535,7 +532,6 @@ config ZSWAP
 	depends on FRONTSWAP && CRYPTO=y
 	select CRYPTO_LZO
 	select ZPOOL
-	default n
 	help
 	  A lightweight compressed cache for swap pages.  It takes
 	  pages that are in the process of being swapped out and attempts to
@@ -552,14 +548,12 @@ config ZSWAP
 
 config ZPOOL
 	tristate "Common API for compressed memory storage"
-	default n
 	help
 	  Compressed memory storage API.  This allows using either zbud or
 	  zsmalloc.
 
 config ZBUD
 	tristate "Low (Up to 2x) density storage for compressed pages"
-	default n
 	help
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to two compressed pages per physical
@@ -570,7 +564,6 @@ config ZBUD
 config Z3FOLD
 	tristate "Up to 3x density storage for compressed pages"
 	depends on ZPOOL
-	default n
 	help
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to three compressed pages per physical
@@ -580,7 +573,6 @@ config Z3FOLD
 config ZSMALLOC
 	tristate "Memory allocator for compressed pages"
 	depends on MMU
-	default n
 	help
 	  zsmalloc is a slab-based memory allocator designed to store
 	  compressed RAM pages.  zsmalloc uses virtual memory mapping
@@ -631,7 +623,6 @@ config MAX_STACK_SIZE_MB
 
 config DEFERRED_STRUCT_PAGE_INIT
 	bool "Defer initialisation of struct pages to kthreads"
-	default n
 	depends on SPARSEMEM
 	depends on !NEED_PER_CPU_KM
 	depends on 64BIT
@@ -743,7 +734,6 @@ config ARCH_HAS_PKEYS
 
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
-	default n
 	help
 	  This feature collects and exposes statistics via debugfs. The
 	  information includes global and per chunk statistics, which can
@@ -751,7 +741,6 @@ config PERCPU_STATS
 
 config GUP_BENCHMARK
 	bool "Enable infrastructure for get_user_pages_fast() benchmarking"
-	default n
 	help
 	  Provides /sys/kernel/debug/gup_benchmark that helps with testing
 	  performance of get_user_pages_fast().
Index: b/mm/Kconfig.debug
===================================================================
--- a/mm/Kconfig.debug	2019-04-01 13:12:35.691272564 +0200
+++ b/mm/Kconfig.debug	2019-04-12 12:02:12.686125141 +0200
@@ -33,7 +33,6 @@ config DEBUG_PAGEALLOC
 
 config DEBUG_PAGEALLOC_ENABLE_DEFAULT
 	bool "Enable debug page memory allocations by default?"
-	default n
 	depends on DEBUG_PAGEALLOC
 	---help---
 	  Enable debug page memory allocations by default? This value
