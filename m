Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB22C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26364206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfDDQu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:50:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:40196 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbfDDQu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:50:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 09:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="137615681"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 04 Apr 2019 09:50:58 -0700
Date:   Thu, 4 Apr 2019 09:50:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: fix the wrong comments
Message-ID: <20190404165046.GB1857@iweiny-DESK2.sc.intel.com>
References: <20190404072347.3440-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404072347.3440-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 03:23:47PM +0800, Huang Shijie wrote:
> When CONFIG_HAVE_GENERIC_GUP is defined, the kernel will use its own
> get_user_pages_fast().
> 
> In the following scenario, we will may meet the bug in the DMA case:
> 	    .....................
> 	    get_user_pages_fast(start,,, pages);
> 	        ......
> 	    sg_alloc_table_from_pages(, pages, ...);
> 	    .....................
> 
> The root cause is that sg_alloc_table_from_pages() requires the
> page order to keep the same as it used in the user space, but
> get_user_pages_fast() will mess it up.

I wonder if there is something we can do to change sg_alloc_table_from_pages()
to work?  Reading the comment for it there is no indication of this limitation.
So should we update that comment as well?

> 
> So change the comments, and make it more clear for the driver
> users.
> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
>  mm/gup.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 22acdd0f79ff..b810d15d4db9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1129,10 +1129,6 @@ EXPORT_SYMBOL(get_user_pages_locked);
>   *  with:
>   *
>   *      get_user_pages_unlocked(tsk, mm, ..., pages);
> - *
> - * It is functionally equivalent to get_user_pages_fast so
> - * get_user_pages_fast should be used instead if specific gup_flags
> - * (e.g. FOLL_FORCE) are not required.
>   */
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  			     struct page **pages, unsigned int gup_flags)
> @@ -2147,6 +2143,10 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>   * If not successful, it will fall back to taking the lock and
>   * calling get_user_pages().
>   *
> + * This function is different from the get_user_pages_unlocked():
> + *      The @pages may has different page order with the result
> + *      got by get_user_pages_unlocked().
> + *

I think I would word this a bit more generally.  Say:

<quote>
NOTE: Because get_user_pages_fast() walks the page tables to find the pages,
the order of pages returned may be different from those returned by other
get_user_pages_*() calls.
</quote>

Ira

>   * Returns number of pages pinned. This may be fewer than the number
>   * requested. If nr_pages is 0 or negative, returns 0. If no pages
>   * were pinned, returns -errno.
> -- 
> 2.17.1
> 
