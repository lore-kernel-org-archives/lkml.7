Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A34C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF612083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CE2GKuJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCSTWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:22:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38019 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:22:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id v1so9817708pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LsViNz3EuXSVXAyDl+lEov/0/hqmOHSRj7WYM60oPCc=;
        b=CE2GKuJpTbcy2TUHrTiiun8dDGL1rW45+DZMmrEGD4r6ZJgZlAa36cOuBA2NbzQ9L3
         S42b64WR+Z5PF5A0L09qsSTSiTJBHaFINH+sFjo1+mcDWMrNdfF1hJIzEwNyxL+QLbJy
         X5dyz8pIrBH5e72nhnIMr0CJsdm7xf9Qj+XyHH16T2rR3xh0GIkllGo0s8k8zzAk9CmY
         EszVjc8X2HTXOJhUrWDcn3HjZwX1iDftEqOayG7kXVaeLnTCCZ1y1xtU9uc/XWLp495+
         Vu+CzxgpKsSmuRdnzra6ClSuVmRW944auQDAEN4p8Com+YxwrwjmZa014ddbKkiQ6ZOR
         vM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LsViNz3EuXSVXAyDl+lEov/0/hqmOHSRj7WYM60oPCc=;
        b=AzC/jfx3yW4yFgZXYpBE6NQlZCAWZ2mb0W43IfwuIRjDqNRuW9bVi6KhPwMZQjRG4h
         vyUVjpMqfqSnrEONs5thIVKhg0FQBeZxdWsQOrxJLJvNQQ4B/vSCZNmY6dZXakGKBQLn
         NQufYygTnTEJhGlGOujpLdoAdqhb6YV6PASscunbXCfIIkUJ+3lrGINzbbh2l4SqWqS4
         SHVMxMkt3z1EIQ39LqiciRjSfElBcsk4SSxMw8/jGsEN3EnRCw4R2c6c17uiY7+ks88i
         fwX5AhpQyOqbuAe0pQrTftjQOOuxa5kKxFsOW+XaIdc4F8bizKXrUs00dQT9FVlghbmz
         hfTQ==
X-Gm-Message-State: APjAAAW2aosB4YUljUP6SX2GbPkiHcVx5bZSBzkDY65mbTNN0fE1kCaP
        TX9Xk+/Oveb1cOqdO0jLZLvWVQ==
X-Google-Smtp-Source: APXvYqxgyCmovfKD9DGAqfbwODVoI0aQiskbj5d5lqwiTMoYBhWKpgA8ZFbTlU+vA314q8BQ2Iymyw==
X-Received: by 2002:a17:902:8b83:: with SMTP id ay3mr3754394plb.1.1553023354294;
        Tue, 19 Mar 2019 12:22:34 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id m13sm26742042pff.175.2019.03.19.12.22.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 12:22:33 -0700 (PDT)
Date:   Tue, 19 Mar 2019 12:21:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Oscar Salvador <osalvador@suse.de>
cc:     akpm@linux-foundation.org, mhocko@suse.com,
        anshuman.khandual@arm.com, william.kucharski@oracle.com,
        hughd@google.com, jack@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix __dump_page when mapping->host is not set
In-Reply-To: <20190318072931.29094-1-osalvador@suse.de>
Message-ID: <alpine.LSU.2.11.1903191215190.1113@eggly.anvils>
References: <20190318072931.29094-1-osalvador@suse.de>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Oscar Salvador wrote:

> Swap mapping->host is NULL, so let us protect __dump_page() for such cases.

Thanks :)

> 
> Fixes: 1c6fb1d89e73c ("mm: print more information about mapping in __dump_page")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org

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
