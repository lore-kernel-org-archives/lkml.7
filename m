Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC98A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ghEzSY7E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GC+5CKwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfH0DdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:33:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfH0DdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:33:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2867860DAB; Tue, 27 Aug 2019 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566876789;
        bh=BkFt4Q8EaU/5o+mwycNYlDke8uLgBCENPfwlvIHWvLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ghEzSY7ELMWClGflokaZre0oAKHH6zneAlFqwZJLu350ebSJvyMtltU1VjMUhxeZv
         Xeysw0mw0zdFyNvgYDNn5u9ySi5gF5o3XCYNs2UfEyOGskY1LLbU6WvmHik/kR3v2a
         MKN7ymWuVWSYrconO3rTVQjHquXxdNRqy1o/fQck=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DA7F3604D4;
        Tue, 27 Aug 2019 03:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566876787;
        bh=BkFt4Q8EaU/5o+mwycNYlDke8uLgBCENPfwlvIHWvLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GC+5CKwYAPyAlVr9fFeiBLnQ9JiCn1yGEcHgmemnDDGf4uXy6zhEyzAX0+vjbqKhg
         vD0XClCdoGt3am54tsFr6V9RkElCCsc14uUREID7PRUiE4sFv9hteesGinwbLbX9/H
         ALdDAeBg/l1Peyp2uZ4ubkWeI90AwslDRnSl2Mhg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Aug 2019 09:03:07 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] clk: Evict unregistered clks from parent caches
In-Reply-To: <20190826234311.138147-1-sboyd@kernel.org>
References: <20190826234311.138147-1-sboyd@kernel.org>
Message-ID: <8e545af29789231be3a8b2e7b6ee7885@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-27 05:13, Stephen Boyd wrote:
> We leave a dangling pointer in each clk_core::parents array that has an
> unregistered clk as a potential parent when that clk_core pointer is
> freed by clk{_hw}_unregister(). It is impossible for the true parent of
> a clk to be set with clk_set_parent() once the dangling pointer is left
> in the cache because we compare parent pointers in
> clk_fetch_parent_index() instead of checking for a matching clk name or
> clk_hw pointer.
> 
> Before commit ede77858473a ("clk: Remove global clk traversal on fetch
> parent index"), we would check clk_hw pointers, which has a higher
> chance of being the same between registration and unregistration, but 
> it
> can still be allocated and freed by the clk provider. In fact, this has
> been a long standing problem since commit da0f0b2c3ad2 ("clk: Correct
> lookup logic in clk_fetch_parent_index()") where we stopped trying to
> compare clk names and skipped over entries in the cache that weren't
> NULL.
> 
> There are good (performance) reasons to not do the global tree lookup 
> in
> cases where the cache holds dangling pointers to parents that have been
> unregistered. Let's take the performance hit on the uncommon
> registration path instead. Loop through all the clk_core::parents 
> arrays
> when a clk is unregistered and set the entry to NULL when the parent
> cache entry and clk being unregistered are the same pointer. This will
> fix this problem and avoid the overhead for the "normal" case.
> 
> Based on a patch by Bjorn Andersson.
> 
> Fixes: da0f0b2c3ad2 ("clk: Correct lookup logic in 
> clk_fetch_parent_index()")
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..f3982bfa39d6 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3737,6 +3737,34 @@ static const struct clk_ops clk_nodrv_ops = {
>  	.set_parent	= clk_nodrv_set_parent,
>  };
> 
> +static void clk_core_evict_parent_cache_subtree(struct clk_core *root,
> +						struct clk_core *target)
> +{
> +	int i;
> +	struct clk_core *child;
> +
> +	for (i = 0; i < root->num_parents; i++)
> +		if (root->parents[i].core == target)
> +			root->parents[i].core = NULL;
> +
> +	hlist_for_each_entry(child, &root->children, child_node)
> +		clk_core_evict_parent_cache_subtree(child, target);
> +}
> +
> +/* Remove this clk from all parent caches */
> +static void clk_core_evict_parent_cache(struct clk_core *core)
> +{
> +	struct hlist_head **lists;
> +	struct clk_core *root;
> +
> +	lockdep_assert_held(&prepare_lock);
> +
> +	for (lists = all_lists; *lists; lists++)
> +		hlist_for_each_entry(root, *lists, child_node)
> +			clk_core_evict_parent_cache_subtree(root, core);
> +
> +}
> +
>  /**
>   * clk_unregister - unregister a currently registered clock
>   * @clk: clock to unregister
> @@ -3775,6 +3803,8 @@ void clk_unregister(struct clk *clk)
>  			clk_core_set_parent_nolock(child, NULL);
>  	}
> 
> +	clk_core_evict_parent_cache(clk->core);
> +
>  	hlist_del_init(&clk->core->child_node);
> 
>  	if (clk->core->prepare_count)


Thanks Stephen. Tested this on cheza now and the issue is not seen 
anymore.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
