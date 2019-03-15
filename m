Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDCC20854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552654058;
	bh=dE012e3hUTtyWbfivgT5C5HILG+bh3QIXeawMLiADUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Loy46kFe1/YhIHlYSxMg/rT+vTSeL1J1fh1sfSWix3Galz85MAQJ6axofBZRXRPD1
	 uaIt68G58iDnC5po83y89rbMFSV0Z/q02rwrF4VJ1+vVw5ectOfMaMA5LWqiQsLWcj
	 xRrapBGuUKwzZPArYFreMwrsVuGaprw6JJllSrXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbfCOMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:47:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:59202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727492AbfCOMrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:47:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9C45AFCC;
        Fri, 15 Mar 2019 12:47:35 +0000 (UTC)
Date:   Fri, 15 Mar 2019 13:47:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        william.kucharski@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: Fix __dump_page when mapping->host is not set
Message-ID: <20190315124733.GE15672@dhcp22.suse.cz>
References: <20190315121826.23609-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315121826.23609-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Jack and Hugh - the full patch is http://lkml.kernel.org/r/20190315121826.23609-1-osalvador@suse.de]

On Fri 15-03-19 13:18:26, Oscar Salvador wrote:
> While debugging something, I added a dump_page() into do_swap_page(),
> and I got the splat from below.
> The issue happens when dereferencing mapping->host in __dump_page():
> 
> ...
> else if (mapping) {
> 	pr_warn("%ps ", mapping->a_ops);
> 	if (mapping->host->i_dentry.first) {
> 		struct dentry *dentry;
> 		dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
> 		pr_warn("name:\"%pd\" ", dentry);
> 	}
> }
> ...
> 
> Swap address space does not contain an inode information, and so mapping->host
> equals NULL.
> 
> Although the dump_page() call was added artificially into do_swap_page(),
> I am not sure if we can hit this from any other path, so it looks worth
> fixing it.

It is certainly worth fixing. We cannot assume anything about the
calling context for __dump_page

> We can easily do that by cheking mapping->host first.
[...]

The splat is still surprising to me because I thought that all file
backed mappings have a host. Swap file/partition certainly has a
mapping but swapcache mapping is special because the underlying swap
storage is hidden in the swap_info_struct. I am wondering whether we
should do that special casing for PageSwapCache in __dump_page rather
than hid the mapping details instead


diff --git a/mm/debug.c b/mm/debug.c
index 1611cf00a137..499c26d5ebe5 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -78,6 +78,9 @@ void __dump_page(struct page *page, const char *reason)
 	else if (PageKsm(page))
 		pr_warn("ksm ");
 	else if (mapping) {
+		if (PageSwapCache(page))
+			mapping = page_swap_info(page)->swap_file->f_mapping;
+
 		pr_warn("%ps ", mapping->a_ops);
 		if (mapping->host->i_dentry.first) {
 			struct dentry *dentry;

But I am not really sure this will work for all swap cases.

Thanks for reporting this Oscar!

> Fixes: 1c6fb1d89e73c ("mm: print more information about mapping in __dump_page")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index c0b31b6c3877..7759f12a8fbb 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -79,7 +79,7 @@ void __dump_page(struct page *page, const char *reason)
>  		pr_warn("ksm ");
>  	else if (mapping) {
>  		pr_warn("%ps ", mapping->a_ops);
> -		if (mapping->host->i_dentry.first) {
> +		if (mapping->host && mapping->host->i_dentry.first) {
>  			struct dentry *dentry;
>  			dentry = container_of(mapping->host->i_dentry.first, struct dentry, d_u.d_alias);
>  			pr_warn("name:\"%pd\" ", dentry);
> -- 
> 2.13.7

-- 
Michal Hocko
SUSE Labs
