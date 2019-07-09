Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C49EC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6997020861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562704660;
	bh=/9LTzKi2u4iUq755wikCwdwulj3n2J071wkeNeptzIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kg725NH9+/d+jjxRl359xoCVmXavosQXwwCRdKcgwHORgnyRZiP8XwldVc+QRXJZ1
	 /6SUqyxJpHbmvRS5zznQW1MqYxId8k2UpFUFul6UXDsrA3W7g+eZ3bJaiRO+AdgpwG
	 jE2Q79e7wJImSMZL2Bpqzc3QIBSc7YXiGAokUdqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfGIUhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbfGIUhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:37:39 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6CA20861;
        Tue,  9 Jul 2019 20:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562704657;
        bh=/9LTzKi2u4iUq755wikCwdwulj3n2J071wkeNeptzIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J+oSXowCJu1Ojf7ZugvCFOUS/kT5hfSiz48WLrqAbUGjEHMko79VqV+tiTfBPcwzL
         vSSbj06XgQKQbh2t6Z60kkhgAuMmF6IP0GT18Z+jf4x7Zg0QxDmuIr3q5wuCx65KbV
         vfgDL/QRQJKySDVn6SeD2m7kXE4QAqa1KdtZNkMA=
Date:   Tue, 9 Jul 2019 13:37:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kernel-build-reports@lists.linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: next/master build: 230 builds: 3 failed, 227 passed, 391
 warnings (next-20190709)
Message-Id: <20190709133736.31f22a5e4aae49fec83faa99@linux-foundation.org>
In-Reply-To: <20190709151333.GD14859@sirena.co.uk>
References: <5d24a6be.1c69fb81.c03b6.0fc7@mx.google.com>
        <20190709151333.GD14859@sirena.co.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 16:13:33 +0100 Mark Brown <broonie@kernel.org> wrote:

> On Tue, Jul 09, 2019 at 07:37:50AM -0700, kernelci.org bot wrote:
> 
> Today's -next fails to build tinyconfig on arm64 and x86_64:
> 
> > arm64:
> >     tinyconfig: (clang-8) FAIL
> >     tinyconfig: (gcc-8) FAIL
> > 
> > x86_64:
> >     tinyconfig: (gcc-8) FAIL
> 
> due to:
> 
> > tinyconfig (arm64, gcc-8) — FAIL, 0 errors, 0 warnings, 0 section mismatches
> > 
> > Section mismatches:
> >     WARNING: vmlinux.o(.meminit.text+0x430): Section mismatch in reference from the function sparse_buffer_alloc() to the function .init.text:sparse_buffer_free()
> >     FATAL: modpost: Section mismatches detected.
> 
> (same error for all of them, the warning appears non-fatally in
> other configs).  This is caused by f13d13caa6ef2 (mm/sparse.c:
> fix memory leak of sparsemap_buf in aliged memory) which adds a
> reference from the __meminit annotated sparse_buffer_alloc() to
> the newly added __init annotated sparse_buffer_free().

Thanks.  Arnd just fixed this:

From: Arnd Bergmann <arnd@arndb.de>
Subject: mm/sparse.c: mark sparse_buffer_free as __meminit

Calling an __init function from a __meminit function is not allowed:

WARNING: vmlinux.o(.meminit.text+0x30ff): Section mismatch in reference from the function sparse_buffer_alloc() to the function .init.text:sparse_buffer_free()
The function __meminit sparse_buffer_alloc() references
a function __init sparse_buffer_free().
If sparse_buffer_free is only used by sparse_buffer_alloc then
annotate sparse_buffer_free with a matching annotation.

Downgrade the annotation to __meminit for both, as they may be
used in the hotplug case.

Link: http://lkml.kernel.org/r/20190709185528.3251709-1-arnd@arndb.de
Fixes: mmotm ("mm/sparse.c: fix memory leak of sparsemap_buf in aliged memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/sparse.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/sparse.c~mm-sparse-fix-memory-leak-of-sparsemap_buf-in-aliged-memory-fix
+++ a/mm/sparse.c
@@ -428,7 +428,7 @@ struct page __init *sparse_mem_map_popul
 static void *sparsemap_buf __meminitdata;
 static void *sparsemap_buf_end __meminitdata;
 
-static inline void __init sparse_buffer_free(unsigned long size)
+static inline void __meminit sparse_buffer_free(unsigned long size)
 {
 	WARN_ON(!sparsemap_buf || size == 0);
 	memblock_free_early(__pa(sparsemap_buf), size);
_

