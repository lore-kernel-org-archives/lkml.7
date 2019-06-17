Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DAFC31E58
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B802084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ais7vmnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfFQOM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:12:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45374 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:12:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so9420791lje.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UR02dBMpLO2IwgmJl+zzqfvWxW4b3uNT3A/fq8b3Xl8=;
        b=ais7vmnlp64PLs4/yXLarwLc3vWBtVrRpvk2YVRLCu5vOynXF/ETKfQV3kRZdWVNd4
         AHp8ZVFVSXxWboDrThV6ewKEIoHbd9p0HhILdPz/MdACLBMShrwayFTu7p68fLujVUpA
         7QgSAMEcPGG8pk5jzEBlYJaUZxq5mjlgKzrocXpZfIuC+o7svmRuMipiT8lk1mPzseBJ
         3B6aL30SNmWb5x3EbValwnSyXeV0QGAIs5ZXgxIw1CAP1Ewia2ASPyhh1EyVWVPkLgBW
         iZUdOfLWIzgYGZgHNgxHtDyaqaplfikrHJgT3afxiLgYycfJpZk/SyQVnLvwV2i0xldT
         dNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UR02dBMpLO2IwgmJl+zzqfvWxW4b3uNT3A/fq8b3Xl8=;
        b=scRRewJJXhViLN0mawYNza5JR8VcS7DjloTZSKSzlfZ+XrnIUFCeU7Irb89Rb/8Cgz
         cCGiyaKQdLcNwwOTjjm/5NrkknrMmldTt4wNZeSF9DU5ShPg4cLBQFIPO2zKe0yRm2GO
         0T2UO+HMsqA62FQI4pmGbqydF5IyRwmR3FAGcncAq5st0Uh7RQBZrY7X1GGdtwsmRVv2
         Jeyf/3j9Z3YQeOGuvCYcpczjpMowgkMnO3+L41AuCloKsiSK+0SJ5srvO0Nz9KmC1SE/
         6F/ozifqSNeHnwcIv6ZWfWy72U9z23Irni4auOkH5yIrUh9ZHkBb1fEyWgc//ZFosADJ
         4gmA==
X-Gm-Message-State: APjAAAUkDS0EyBEhqAV2sA/qh+Bb/Rh7JUaRGzAskCORzylWIjHZCJDa
        qaQBbrmgYacCxkZMy44lb5s=
X-Google-Smtp-Source: APXvYqz67dES8orYwdSlSUe3JHIspV1NctOeVCA4RYfKHZHj2HcSoZQBqbf24JEc9RSK1DCSvpM3ZA==
X-Received: by 2002:a2e:988b:: with SMTP id b11mr17763540ljj.110.1560780773866;
        Mon, 17 Jun 2019 07:12:53 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id n3sm1784184lfh.3.2019.06.17.07.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 07:12:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 17 Jun 2019 16:12:44 +0200
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Penyaev <rpenyaev@suse.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG]: mm/vmalloc: uninitialized variable access in
 pcpu_get_vm_areas
Message-ID: <20190617141244.5x22nrylw7hodafp@pc636>
References: <20190617121427.77565-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617121427.77565-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:14:11PM +0200, Arnd Bergmann wrote:
> gcc points out some obviously broken code in linux-next
> 
> mm/vmalloc.c: In function 'pcpu_get_vm_areas':
> mm/vmalloc.c:991:4: error: 'lva' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     insert_vmap_area_augment(lva, &va->rb_node,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      &free_vmap_area_root, &free_vmap_area_list);
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/vmalloc.c:916:20: note: 'lva' was declared here
>   struct vmap_area *lva;
>                     ^~~
> 
> Remove the obviously broken code. This is almost certainly
> not the correct solution, but it's what I have applied locally
> to get a clean build again.
> 
> Please fix this properly.
> 
> Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/vmalloc.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a9213fc3802d..bfcf0124a773 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -984,14 +984,9 @@ adjust_va_to_fit_type(struct vmap_area *va,
>  		return -1;
>  	}
>  
> -	if (type != FL_FIT_TYPE) {
> +	if (type == FL_FIT_TYPE)
>  		augment_tree_propagate_from(va);
>  
> -		if (type == NE_FIT_TYPE)
> -			insert_vmap_area_augment(lva, &va->rb_node,
> -				&free_vmap_area_root, &free_vmap_area_list);
> -	}
> -
>  	return 0;
>  }
>  
> -- 
> 2.20.0
> 
Please do not apply this. It will just break everything. As Roman
pointed we can just set lva = NULL; in the beginning to make GCC happy. 
For some reason GCC decides that it can be used uninitialized, but that
is not true.

--
Vlad Rezki
