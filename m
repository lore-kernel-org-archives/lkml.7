Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B529C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F46217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 21:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sbLfgdAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbfKFV2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 16:28:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39755 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfKFV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:28:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so16720629pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 13:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=krzOUvpi1e5/wmoRaiU4lZEs6DtCOLGJs0yJ4n3NiT4=;
        b=sbLfgdAS6EOV//l2R1R1T6k78DSCdQF5xOe10EZQffA6kEO8JX0b9A6OzeFmsYBnoC
         23KagORrktTZpPVwwaCyV1orBrqH+flbaUSwFmG/Na4NbuUuK8d8E1yPR3ke00MkQpDm
         vFsu6+fRKoUkbD3ObCzkSvrz6TmMUisT8ALkgNTBj/csrl0GuHqKje8O63ZnL1wSi8y9
         v27nd3z2u4OiwuIrfffOp5Tg0s2umO4xYWoioIeKCoupHnWl2h8psosdgZI2drwsz39Z
         us48CeWvOT/4/BvzO++HlV6lrdgm2x91NM9tq03NQkAef3CskGnb9I1sp3ww3M74m+9U
         T14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=krzOUvpi1e5/wmoRaiU4lZEs6DtCOLGJs0yJ4n3NiT4=;
        b=DFFu11d5FGFzXbQ59p3lSlkWDWOcbQuouqbUuzcF+ZqFksF97gQt1H2VCSnHaCRaJg
         UBgaImYTdgrXyR/uw8i7BWo0A5wnMArOPMlsONnHMZFgLJjypD97pwlDl/WVv8/lH1NT
         AdKxQH7tg+dKVhAeVSlQPBZAwmXcXZ//X7ZFzkfxrXUSt8Fnlj7g5i8/VPXZBZw0gQIm
         0JEBS9t8qqEFEBrPF9of7WERnx/C5kfw5AzOUauHsN9YZ2Yu9bYl25YQNRD5solAwWua
         8Zvtx0Kep9XPw34X3NQgaz+ErXJHpnm3IPkDw9ufeT9dqJg7DFZ1yl8s43VzYcKJ3GUp
         cmuQ==
X-Gm-Message-State: APjAAAXtyNisspLkZJTTJThh43wsn0eeL8Mk38aRXLDHcg/CfANI5ylj
        oJpDuZjMW/63t4Wrquh8QmHYIA==
X-Google-Smtp-Source: APXvYqz+40bL+/jMKwtbZTq0yAFSPXCohqQNWq9mFOR9X2C86UIGFQu+gwoKF6HXipUBEL6uRjY0yw==
X-Received: by 2002:a62:180a:: with SMTP id 10mr6155357pfy.40.1573075693388;
        Wed, 06 Nov 2019 13:28:13 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y138sm26034618pfb.174.2019.11.06.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 13:28:12 -0800 (PST)
Date:   Wed, 6 Nov 2019 13:28:11 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yunfeng Ye <yeyunfeng@huawei.com>
cc:     akpm@linux-foundation.org, jgg@ziepe.ca, mhocko@suse.com,
        jglisse@redhat.com, minchan@kernel.org, peterz@infradead.org,
        jack@suse.cz, rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] mm/madvise: replace with page_size() in
 madvise_inject_error()
In-Reply-To: <29dce60c-38d6-0220-f292-e298f0c78c4d@huawei.com>
Message-ID: <alpine.DEB.2.21.1911061327550.155572@chino.kir.corp.google.com>
References: <29dce60c-38d6-0220-f292-e298f0c78c4d@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019, Yunfeng Ye wrote:

> The function page_size() is supported after the commit a50b854e073c
> ("mm: introduce page_size()").
> 
> Replace with page_size() in madvise_inject_error() for readability.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  mm/madvise.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 2be9f3fdb05e..38c4e7fcf850 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -856,13 +856,13 @@ static int madvise_inject_error(int behavior,
>  {
>  	struct page *page;
>  	struct zone *zone;
> -	unsigned int order;
> +	unsigned int size;

Should be unsinged long.

> 
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> 
> 
> -	for (; start < end; start += PAGE_SIZE << order) {
> +	for (; start < end; start += size) {
>  		unsigned long pfn;
>  		int ret;
> 
> @@ -874,9 +874,9 @@ static int madvise_inject_error(int behavior,
>  		/*
>  		 * When soft offlining hugepages, after migrating the page
>  		 * we dissolve it, therefore in the second loop "page" will
> -		 * no longer be a compound page, and order will be 0.
> +		 * no longer be a compound page.
>  		 */
> -		order = compound_order(compound_head(page));
> +		size = page_size(compound_head(page));
> 
>  		if (PageHWPoison(page)) {
>  			put_page(page);
