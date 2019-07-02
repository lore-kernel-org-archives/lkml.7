Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA73C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804120673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562113988;
	bh=rVBWY9NKk3peUyI1EC9GF70mJHGF/edO4QPbzMYTAPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dBr05UIDjN9dSvtsYMZoNjgD42nTMDyiP3T0yzXO7vrlEvjUHK36smz/YLq52WZD5
	 YxfdmZtLJtG4AfTQnWHrkRAo2SZlN17K+pFDEh/BYTEe1SicZuKjBNLCzHq/VXBYob
	 m+QkPrTvwn7xd3I4Sbiglzb35K2irQ8waYvC898I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfGCAdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfGCAdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:33:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3344D20673;
        Tue,  2 Jul 2019 20:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562100859;
        bh=rVBWY9NKk3peUyI1EC9GF70mJHGF/edO4QPbzMYTAPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJc3a/aiBmbIeNeNSP0XS9Oba/camnFTOL9hqC8zm7j1dF2QBonphwxy7DsLeJtYF
         taFkYBHmMv1mufJj2/5bJblCqD5zSvM01FR3QX6HWCg5fFJ3YTOzltXbwqPlS9VVVr
         MZDir0n73svKaPTv20CmYRaLCPorogn8uUu9W1GY=
Date:   Tue, 2 Jul 2019 13:54:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH -next] mm: Mark undo_dev_pagemap as __maybe_unused
Message-Id: <20190702135418.ce51c988e88ca0d9546a2a11@linux-foundation.org>
In-Reply-To: <1562072523-22311-1-git-send-email-linux@roeck-us.net>
References: <1562072523-22311-1-git-send-email-linux@roeck-us.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Jul 2019 06:02:03 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> Several mips builds generate the following build warning.
> 
> mm/gup.c:1788:13: warning: 'undo_dev_pagemap' defined but not used
> 
> The function is declared unconditionally but only called from behind
> various ifdefs. Mark it __maybe_unused.
> 
> ...
>
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1785,7 +1785,8 @@ static inline pte_t gup_get_pte(pte_t *ptep)
>  }
>  #endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
>  
> -static void undo_dev_pagemap(int *nr, int nr_start, struct page **pages)
> +static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
> +					    struct page **pages)
>  {
>  	while ((*nr) - nr_start) {
>  		struct page *page = pages[--(*nr)];

It's not our preferred way of doing it but yes, it would be a bit of a
mess and a bit of a maintenance burden to get the ifdefs correct.

And really, __maybe_unused isn't a bad way at all - it ensures that the
function always gets build-tested and the compiler will remove it so we
don't have to play the chase-the-ifdefs game.
