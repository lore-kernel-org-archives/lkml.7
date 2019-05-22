Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9C6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045202173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558549998;
	bh=/z7Nk3RKquTaLh7LGUcYRr+01LS+V0BVfOEfOJekipI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g2wLzVMmNeKDJRm76xo8HZ5LjovoU3GbeoR+cItssbst4ihccGLD5gwHtor2+8fdr
	 o6O7POJ55sl69QWikyqKc4wheAu2ca1XlIx/VnfMdnxHLTQd5nGg+WGGM54ZnXFumC
	 8eGRM+u1SBW0DqDOUeyhGFvc+Ct8xIsUPyechVXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfEVSdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbfEVSdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:33:17 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DACD221473;
        Wed, 22 May 2019 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558549996;
        bh=/z7Nk3RKquTaLh7LGUcYRr+01LS+V0BVfOEfOJekipI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qc6ooJJqMW/TOTEEJs0mgLGcq/MVsfm/8GvlWWs9LT4wUO4b6UKknAx2oboANj7+q
         6voZxPnNM595lMZPazAL9Ajnf53Oan1CXvtxHbpHSMnjiJ0sZ5bM/iZ8YyNuMp3jfr
         q17Z5wbd05wBVP8yO2kqntJwVR+63yQtjvjNtGIo=
Date:   Wed, 22 May 2019 11:33:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-kernel@vger.kernel.org, George Spelvin <lkml@sdf.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Abramov <st5pub@yandex.ru>, kernel@collabora.com
Subject: Re: [PATCH] lib/sort: Add the sort_r() variant
Message-Id: <20190522113315.08484a3942ec07793b7d6112@linux-foundation.org>
In-Reply-To: <20190522112550.31814-1-boris.brezillon@collabora.com>
References: <20190522112550.31814-1-boris.brezillon@collabora.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 13:25:50 +0200 Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Some users might need extra context to compare 2 elements. This patch
> adds the sort_r() which is similar to the qsort_r() variant of qsort().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Hello,
> 
> A few more details about this patch.
> 
> Even though I post it as a standalone patch, I do intend to use it in
> a real driver (v4l2 driver), just didn't want to have it burried in a
> huge patch series.
> 
> Note that sort() and sort_r() are now implemented as wrappers around
> do_sort() so that most of the code can be shared. I initially went for
> a solution that implemented sort() as a wrapper around sort_r() (which
> basically contained the do_sort() logic without the cmp_func arg)
> but realized this was adding one extra indirect call (the compare func
> wrapper), which I know are being chased.

Please move the above text into the changelog.  It's probably useful
and we can afford the disk space ;)

> There's another option, but I'm pretty sure other people already
> considered it and thought it was not a good idea as it would make
> the code size grow: move the code to sort.h as inline funcs/macros so
> that the compiler can optimize things out and replace the indirect
> cmp_func() calls by direct ones. I just tried it, and it makes my .o
> file grow by 576 bytes, given that we currently have 122 users of
> this function, that makes the kernel code grow by ~70k (that's kind
> of a max estimate since not all users will be compiled in).

eep, let's not do that.

> --- a/include/linux/sort.h
> +++ b/include/linux/sort.h

Patch otherwise looks OK.  Please include it with the patch series
which uses it.  Feel free to add

Acked-by: Andrew Morton <akpm@linux-foundation.org>
