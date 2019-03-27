Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC8DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCA62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553692510;
	bh=KjSD+aCYL/x5+QmPOrYaXOA/aVMJFLfLjNZCXLXNOAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wnr+o1x8QN7nY9GpD/GqpU0Ul1O6cJQ0jBDw6Kd/4OC6uxfqI7yGA87Fm75NJYRIc
	 aVN1k7xzdxBRfMB2K3PLrsKqBr/fXgZcJFE7tBjmEqftfu26b8kmr5G/bqao6GH55T
	 fxuk+dsHnk3JF69MJJk6SDlknueoYtxDn/je62S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfC0NPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:15:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728101AbfC0NPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:15:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D0A9AFD1;
        Wed, 27 Mar 2019 13:15:07 +0000 (UTC)
Date:   Wed, 27 Mar 2019 14:15:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, david@redhat.com, vbabka@suse.cz,
        willy@infradead.org, akpm@linux-foundation.org,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm/page-flags: Check enforce parameter in PF_ONLY_HEAD()
Message-ID: <20190327131506.GI11927@dhcp22.suse.cz>
References: <1553689672-28343-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553689672-28343-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Nick]

On Wed 27-03-19 17:57:52, Anshuman Khandual wrote:
> Just check for enforce parameter in PF_ONLY_HEAD() wrapper before calling
> VM_BUG_ON_PGFLAGS() for tail pages.

Why is this an actual fix? Only TESTPAGEFLAG doesn't enforce the check
but I suspect that Nick just wanted the check to be _always_ performed
as the name suggests. What kind of problem are you trying to solve?

> Fixes: 62906027091f ("mm: add PageWaiters indicating tasks are waiting for a page bit")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/page-flags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 9f8712a4b1a5..82539e287bc6 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -229,7 +229,7 @@ static inline void page_init_poison(struct page *page, size_t size)
>  #define PF_ANY(page, enforce)	PF_POISONED_CHECK(page)
>  #define PF_HEAD(page, enforce)	PF_POISONED_CHECK(compound_head(page))
>  #define PF_ONLY_HEAD(page, enforce) ({					\
> -		VM_BUG_ON_PGFLAGS(PageTail(page), page);		\
> +		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
>  		PF_POISONED_CHECK(page); })
>  #define PF_NO_TAIL(page, enforce) ({					\
>  		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
