Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881ACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C173214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UDy5cy9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbfJ1MmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:42:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36766 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbfJ1MmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:42:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so11196752ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YXz21DLbYChNtLC16qKg/F5siZzPuHpmcF6L0vjR70Q=;
        b=UDy5cy9jp7qw9ea3NmGoBYL5rkK3rD7lP+Y1vSO/MvqCsnHZxGiFpUyWebGJzCFW9E
         O4EN/t7pstqQFEkuseKzS6HdAafHy69l0s5ygYkRkW8TfdZhrlCNwaXt87RY98wEt4RP
         Is7yuQa+XX5HsO0mbecgrOsACK82b0mMHfbbMNG+RwruNptd7tjW6NPWahNTvZ/ZFKST
         2P+zFWeOa9FKappwZ+pztKsRRDT1l00rkjKdMCAIe4JbmppMd9zzBec12Pq0lMHa2GJ7
         Nl6Qdmal2rG3oTZIll/X/BRfpYMawwGMn5q0oMGKiT8/fQssH8XyiL1bv1kzEd1UPD1C
         iwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YXz21DLbYChNtLC16qKg/F5siZzPuHpmcF6L0vjR70Q=;
        b=dC1R1PE+1hpz7ulwlYiAOoJfuV1T+NKmyBNeygDdDOxHmdFuTpJSxy3LTS90VeCD7w
         2Aim1k39UL6lH4Xr/7Lc1s6gxvbAeA7ymk+FA+v7/vNJIU9iCSo7leiaNacmYpZnABpC
         S6wSxE+oUPmtaAJ6D0KGjTla8paCmDen+10Jn0NEuVJ4wwPI1IYE3fNPP9QIY5++fCMJ
         Z0ovsTMoeCn86kZJNUYcZt5TNvSgRzT1y8End42be/g7uk79+cm5MrIvC3JHzo01pUdi
         lDyYW+7ZNJv9Kr+CBGJBd6JgapVFiMhQjBOcx1eHAXaObvjl/W0dr8Jl3FjzPBMgVPNS
         9F+w==
X-Gm-Message-State: APjAAAWcUZJH6mF/Zv/rBds08bxevxtkS3/oFoJ5/fEr+41roQVcJmXE
        UVIRvKQFDdar02YGq9bb0aCqBA==
X-Google-Smtp-Source: APXvYqzeBill5sGQdQXwwRpWKiSVdlLvWFYx2xLqvPT8yXAFAWaeU7gv4dx3rhmelIIJkIMHn+8r0A==
X-Received: by 2002:a2e:547:: with SMTP id 68mr11779036ljf.150.1572266541309;
        Mon, 28 Oct 2019 05:42:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 4sm6328938lfa.95.2019.10.28.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 05:42:20 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 86B96100242; Mon, 28 Oct 2019 15:42:22 +0300 (+03)
Date:   Mon, 28 Oct 2019 15:42:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Steven Whitehouse <swhiteho@redhat.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
Message-ID: <20191028124222.ld6u3dhhujfqcn7w@box>
References: <157225677483.3442.4227193290486305330.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157225677483.3442.4227193290486305330.stgit@buzz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:59:34PM +0300, Konstantin Khlebnikov wrote:
> Page cache could contain pages beyond end of file during write or
> if read races with truncate. But generic_file_buffered_read() always
> allocates unneeded pages beyond eof if somebody reads here and one
> extra page at the end if file size is page-aligned.
> 
> Function generic_file_buffered_read() calls page_cache_sync_readahead()
> if page not found in cache and then do another lookup. Readahead checks
> file size in __do_page_cache_readahead() before allocating pages.
> After that generic_file_buffered_read() falls back to slow path and
> allocates page for ->readpage() without checking file size.
> 
> This patch checks file size before allocating page for ->readpage().
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  mm/filemap.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 85b7d087eb45..92abf5f348a9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2225,6 +2225,10 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		goto out;
>  
>  no_cached_page:
> +		/* Do not allocate cache pages beyond end of file. */
> +		if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
> +			goto out;
> +
>  		/*
>  		 * Ok, it wasn't cached, so we need to create a new
>  		 * page..
> 
> 

CC Steven.

I've tried something of this sort back in 2013:

http://lore.kernel.org/r/1377099441-2224-1-git-send-email-kirill.shutemov@linux.intel.com

and I've got push back.

Apparently, some filesystems may not have valid i_size before >readpage().
Not sure if it's still the case...

Anyway I don't think it's valid reason for this inefficiency. These
filesystems have to have own implementation of >read_iter() to deal with
this.

-- 
 Kirill A. Shutemov
