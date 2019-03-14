Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4ACC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C982184D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552544834;
	bh=BFUqoyQ17Oaka9VN+b1h0MhqZJP+oUsAGb777KhvFDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lnnij4K9t9wpTo8bD9NTMXi+rQh90Wei+w1Z1mXd2P1vkvZVJwfnWZAAsRk5kT88n
	 bVeAjMwwcbjEwVZnQP0cQ9Xq+zbyao9wu8tOPQINozI0LBBeFbUwsVJhCSccn9nkqp
	 OcTgKN4nr8cY/O/pT08GhOWmAazkQpK+VxkZHfmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfCNG1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:27:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbfCNG1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:27:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31485ACC6;
        Thu, 14 Mar 2019 06:27:11 +0000 (UTC)
Date:   Thu, 14 Mar 2019 07:27:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix a wrong flag in set_migratetype_isolate()
Message-ID: <20190314062710.GA7473@dhcp22.suse.cz>
References: <20190313212507.49852-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313212507.49852-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-03-19 17:25:07, Qian Cai wrote:
> Due to has_unmovable_pages() takes an incorrect irqsave flag instead of
> the isolation flag in set_migratetype_isolate(), it causes issues with
> HWPOSION and error reporting where dump_page() is not called when there
> is an unmoveable page.
> 
> Fixes: d381c54760dc ("mm: only report isolation failures when offlining memory")

Cc: stable # 5.0
> Signed-off-by: Qian Cai <cai@lca.pw>

Very well spotted!

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_isolation.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index bf67b63227ca..0f5c92fdc7f1 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -59,7 +59,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
>  	 * We just check MOVABLE pages.
>  	 */
> -	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype, flags))
> +	if (!has_unmovable_pages(zone, page, arg.pages_found, migratetype,
> +				 isol_flags))
>  		ret = 0;
>  
>  	/*
> -- 
> 2.17.2 (Apple Git-113)

-- 
Michal Hocko
SUSE Labs
