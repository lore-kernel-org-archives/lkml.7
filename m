Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56578C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A1A2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 02:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564022201;
	bh=D1/XAZeml+GaFLf+eOsik3qb0TT1TCoXAkWbdZi4Uk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bpa910gvrdlb/0AROTvFXN1kgaGMr+MZQcdikMNXaU3b8Ze8nC7wSzvfXlqrbMH/M
	 4JKc8QM7pSq2HVA3UNvjraA8wnJ1MKlOwA8S8ottZT/KzPlq/tKgUsNCSO8uq48yg/
	 HrgXSiJ3g3a7/IE9+cmsKB+T20A81WJXox4u3NvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbfGYCgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387562AbfGYCgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:36:39 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA0B21852;
        Thu, 25 Jul 2019 02:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564022198;
        bh=D1/XAZeml+GaFLf+eOsik3qb0TT1TCoXAkWbdZi4Uk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i0fC83ypNVUKB9EVai4LXo+v9ARw5Eyade7UDcE4YL+6sCTYavtEvzFa0Tykazaz+
         SsLvMemZaTAs++xQk83lBYn2Grm5YGG3xvnbO7/nLnU1R+78CB5s67GOwvl1L5kqIO
         uj/fRVIsKke3L1aYxS/VQVMNN28hRjeKuFm2wTWM=
Date:   Wed, 24 Jul 2019 19:36:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     willy@infradead.org, urezki@gmail.com, rpenyaev@suse.de,
        peterz@infradead.org, guro@fb.com, rick.p.edgecombe@intel.com,
        rppt@linux.ibm.com, aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmalloc: do not keep unpurged areas in the
 busy tree
Message-Id: <20190724193637.44ced3b82dd76649df28ecf5@linux-foundation.org>
In-Reply-To: <20190716152656.12255-2-lpf.vector@gmail.com>
References: <20190716152656.12255-1-lpf.vector@gmail.com>
        <20190716152656.12255-2-lpf.vector@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 23:26:55 +0800 Pengfei Li <lpf.vector@gmail.com> wrote:

> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> The busy tree can be quite big, even though the area is freed
> or unmapped it still stays there until "purge" logic removes
> it.
> 
> 1) Optimize and reduce the size of "busy" tree by removing a
> node from it right away as soon as user triggers free paths.
> It is possible to do so, because the allocation is done using
> another augmented tree.
> 
> The vmalloc test driver shows the difference, for example the
> "fix_size_alloc_test" is ~11% better comparing with default
> configuration:
> 
> sudo ./test_vmalloc.sh performance
> 
> <default>
> Summary: fix_size_alloc_test loops: 1000000 avg: 993985 usec
> Summary: full_fit_alloc_test loops: 1000000 avg: 973554 usec
> Summary: long_busy_list_alloc_test loops: 1000000 avg: 12617652 usec
> <default>
> 
> <this patch>
> Summary: fix_size_alloc_test loops: 1000000 avg: 882263 usec
> Summary: full_fit_alloc_test loops: 1000000 avg: 973407 usec
> Summary: long_busy_list_alloc_test loops: 1000000 avg: 12593929 usec
> <this patch>
> 
> 2) Since the busy tree now contains allocated areas only and does
> not interfere with lazily free nodes, introduce the new function
> show_purge_info() that dumps "unpurged" areas that is propagated
> through "/proc/vmallocinfo".
> 
> 3) Eliminate VM_LAZY_FREE flag.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

This should have included your signed-off-by, since you were on the
patch delivery path.  (Documentation/process/submitting-patches.rst,
section 11).

Please send along your signed-off-by?
