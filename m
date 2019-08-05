Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138B2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 04:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564978492;
	bh=+Y1NuEUjGC3aUIFq2y7e/Xv0wOCDGVTnmXI4vCIVEDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WoGhGVLQYJG0f0Qn8wVBaD/7CLEvCAOjl3/VQx2TJMu+bUW4RqZAxHvBpvRjAMaLB
	 nOAlTxtChuDukU/yhrSYm8DlxRBQTwgXMCNZylGiXWOMzVuEfEuULJ1wM82rZofOqN
	 cc26ZCLETO278d+S5pTuuUOLOX+XIjRofJZ70bA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfHEEOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 00:14:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37414 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfHEEOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 00:14:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so38910976pfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 21:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mva09u+yn1RWE+TO1luNzBDnrlH/Q/3QfIfoFJtdBKs=;
        b=lUaKgKHU3tYV6FVsndghO1nh62VmLyjBz+gnRDFzMtyQSKeK4kyNlKt7pfyVZI5dP0
         lCmU53u7ZoMWT0GjNCzqnOSqZsjasDVwlPCqu3E04EBsomGuC5AAi2qOnGX+T6kdDxni
         dV6o/haUzLnNpKhvlZ15NuuJvVzUEFuORq2wb6M+ExKwYLtMUDhXsmnZ6PSmWyr8PWxE
         V0kct3Svkq8vUoVZOO289g/Yw0Wqon93UAVktJZ1iuJxKV0PoU8euDaXateelJ7JSx9o
         f40OBUyRw88R3NWa2O8csPHoyge5AVZZPF8py8aCAYxVK8+Dltiuo2QpqUbwAnXmRmta
         HM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mva09u+yn1RWE+TO1luNzBDnrlH/Q/3QfIfoFJtdBKs=;
        b=WFh0WRKlDWzimve2a7CqH2ZobNQ8h9xschxkoEBnAk+XcEZr7vT9ESBD0OuWfrB9mM
         9a33gP+GyxBhAEcB4ym6qX98U6+Byvt/DcbRPrWlm0p1ANBl/L9WfB87Dc+4rrkffZqX
         Q3/mUUDotR3Mbm1tU9NMtTJK/4DbWLHuOcBEaozm0lMwnZpoJrGxqE9hE6Vc7aZEebuH
         srJa9SzGfo4U34RDt/MwzFMU5bAYIN5QUSQrONbhU8R9MIuIqmDD6rqPAauMnPIWj4vf
         ddEGi2/pBX2V5GsU2gXk+k3Ox+KYILF9eGx9A3hAZpOb/W7mbEPl6rwmvxAfi6L5GF4f
         X3gg==
X-Gm-Message-State: APjAAAVlSJUW857VtOh9A3UPFBFE7MkHiRa0odNryiped9RMhUeyY2YA
        vX6xm/i/x1G5nhgJy6GqQUg=
X-Google-Smtp-Source: APXvYqxu85q5rU7e/DgfZCTuChdmrDTsIJLsBcmb1yRybucaAu5vmnJlY6V1Pxkezx8ce2esQ0uBSg==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr134680099pgc.346.1564978486557;
        Sun, 04 Aug 2019 21:14:46 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j1sm115888081pgl.12.2019.08.04.21.14.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 21:14:44 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:14:40 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Henry Burns <henryburns@google.com>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: Migration can leave pages in ZS_EMPTY
 indefinitely
Message-ID: <20190805041440.GA178551@google.com>
References: <20190802015332.229322-1-henryburns@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802015332.229322-1-henryburns@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 06:53:31PM -0700, Henry Burns wrote:
> In zs_page_migrate() we call putback_zspage() after we have finished
> migrating all pages in this zspage. However, the return value is ignored.
> If a zs_free() races in between zs_page_isolate() and zs_page_migrate(),
> freeing the last object in the zspage, putback_zspage() will leave the page
> in ZS_EMPTY for potentially an unbounded amount of time.

Nice catch.

> 
> To fix this, we need to do the same thing as zs_page_putback() does:
> schedule free_work to occur.  To avoid duplicated code, move the
> sequence to a new putback_zspage_deferred() function which both
> zs_page_migrate() and zs_page_putback() call.
> 
> Signed-off-by: Henry Burns <henryburns@google.com>
Cc: <stable@vger.kernel.org>    [4.8+]
Acked-by: Minchan Kim <minchan@kernel.org>

Below a just trivial:

> ---
>  mm/zsmalloc.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 1cda3fe0c2d9..efa660a87787 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1901,6 +1901,22 @@ static void dec_zspage_isolation(struct zspage *zspage)
>  	zspage->isolated--;
>  }
>  
> +static void putback_zspage_deferred(struct zs_pool *pool,
> +				    struct size_class *class,
> +				    struct zspage *zspage)
> +{
> +	enum fullness_group fg;
> +
> +	fg = putback_zspage(class, zspage);
> +	/*
> +	 * Due to page_lock, we cannot free zspage immediately
> +	 * so let's defer.
> +	 */

Could you move this comment function's description since it becomes
a function?

Thanks.
