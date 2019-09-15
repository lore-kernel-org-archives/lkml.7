Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14295C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91D120873
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1xoMG61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfIOVio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 17:38:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44732 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbfIOVik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:38:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id k1so15878326pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=h/ncaV79w3xY6uDWRhXLpEpTfQJmu4P1Z2vnPyRUpIA=;
        b=F1xoMG61RxtRCLXxjqDWYUm0394z6rD85HVnbn9F4gsb3b6dKZUs9ZjGFrY9c4ImFQ
         1fLIlFzwuuyAwStdYmUlNMDXXLPNk7cpjjtxoTbPqFLI2nzdgsRuplCMLHccqnXBlsRt
         zPPAUujdo989SuLOVZdYzUjtT6YHBiz08XF/+p25bO/kOJ1PO6OPkLXLEap/lRNrmaSe
         DDSXYYdOv51j1IemdzFk2LfKF8FH8E8EitP1K2z/eoYuLkzT8Pitdv6hkjhH+EFmVRWl
         czAe17sRG2HvdbEXLERIcpiBgmBbUKDHXFD1gE/AKmwxXxeArRl9mOObvXfhsXV/FgQB
         kXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=h/ncaV79w3xY6uDWRhXLpEpTfQJmu4P1Z2vnPyRUpIA=;
        b=obxMpWAAZN9V6RFwAv+IcrZ8Bmacz+SP5BwiWxEoKK3/TEG+jgjX8HXGjX0LG8vyO2
         wjStO6QQPdN4ioAkrGI58h8t6P8d2u7DLDcNqGGYOFR3690OkJYRgdeT+IHbNKE0+p9e
         ZFqWD0T6IKYM483YuGmPQ2iznQCa7y87WJ0djmrFHXanFLmAWZOhF7Fs6zxp20Q4bswk
         XDJHdiT1ulFQ/HOK2WuDPIW+vDFXZNLZSYf+igGugnE0+CyOFRj0AJilGaN09vImfbIg
         /N5rP8/nDYXz4Mg9JZTHvYfR4kiK8mrgkyF0+Lcxof0aSb+ouc1MXstHWedtTB8F+FEt
         QaSw==
X-Gm-Message-State: APjAAAV/NYk2MTo5M9YQeJQ2T8Z7DYzFOq5SDTsjJQyDENdS0JKIjePr
        4JQI7mBQETEkD8TXpk++cidP6w==
X-Google-Smtp-Source: APXvYqxg7TWt8JQFo35pgCsPA1Lke131vcZRopO4TAfjZaxIMibIfqzIgqSRmfyUEyRISgME2WKVKw==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr59400191plb.93.1568583519068;
        Sun, 15 Sep 2019 14:38:39 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v44sm21332300pgn.17.2019.09.15.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 14:38:38 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:38:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
Subject: Re: [RESEND v4 6/7] mm, slab_common: Initialize the same size of
 kmalloc_caches[]
In-Reply-To: <20190915170809.10702-7-lpf.vector@gmail.com>
Message-ID: <alpine.DEB.2.21.1909151434140.211705@chino.kir.corp.google.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-7-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Pengfei Li wrote:

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 2aed30deb071..e7903bd28b1f 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1165,12 +1165,9 @@ void __init setup_kmalloc_cache_index_table(void)
>  		size_index[size_index_elem(i)] = 0;
>  }
>  
> -static void __init
> +static __always_inline void __init
>  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  {
> -	if (type == KMALLOC_RECLAIM)
> -		flags |= SLAB_RECLAIM_ACCOUNT;
> -
>  	kmalloc_caches[type][idx] = create_kmalloc_cache(
>  					kmalloc_info[idx].name[type],
>  					kmalloc_info[idx].size, flags, 0,
> @@ -1185,30 +1182,22 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  void __init create_kmalloc_caches(slab_flags_t flags)
>  {
>  	int i;
> -	enum kmalloc_cache_type type;
>  
> -	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
> -		for (i = 0; i < KMALLOC_CACHE_NUM; i++) {
> -			if (!kmalloc_caches[type][i])
> -				new_kmalloc_cache(i, type, flags);
> -		}
> -	}
> +	for (i = 0; i < KMALLOC_CACHE_NUM; i++) {
> +		if (!kmalloc_caches[KMALLOC_NORMAL][i])
> +			new_kmalloc_cache(i, KMALLOC_NORMAL, flags);
>  
> -	/* Kmalloc array is now usable */
> -	slab_state = UP;
> +		new_kmalloc_cache(i, KMALLOC_RECLAIM,
> +					flags | SLAB_RECLAIM_ACCOUNT);

This seems less robust, no?  Previously we verified that the cache doesn't 
exist before creating a new cache over top of it (for NORMAL and RECLAIM).  
Now we presume that the RECLAIM cache never exists.

Can we just move a check to new_kmalloc_cache() to see if 
kmalloc_caches[type][idx] already exists and, if so, just return?  This 
should be more robust and simplify create_kmalloc_caches() slightly more.
