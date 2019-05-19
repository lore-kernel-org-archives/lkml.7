Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C01DC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C720449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vCUyKhRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfESSMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:12:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45456 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:12:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id a5so5608139pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0bkKTyKYnhFPDlSX68YGNfeLYH++JQQQW+qUhMyZqg8=;
        b=vCUyKhRfrhRkIsTNCZU7vDPV84pSHhJxo02gsYlUNJlz9lUfP945+vbSGTYFkjmf6O
         jWnqrrnlwj8y//OcQgtxYCg1iJEzt78GTEXALjPB1ZcR1Tn3hu9Dks+YARGRCl9+GrTE
         0eY8eEHfmauSyxMRVxwGmi6KAaZaamP/4Nnc7p0e8Egxvztdtz/3VRuWIOIsBXEZe1t/
         NvbfAjXV3/fw6xFDvFNxuNOVMLWIrjejbyzv2kxJkwq328zLOCPXKYV49SuxiEPSoqFC
         US5DvslcrXyVCFxlcJ6Wh+SV6pHKVUmTQridm1KZLaWWcgvxMMUed3uNOveD6nxtGO2c
         vueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0bkKTyKYnhFPDlSX68YGNfeLYH++JQQQW+qUhMyZqg8=;
        b=pjcw2wrsps0bDD0h6IlRJPs8rRyDQegA6uJ45WLoZatZi5sd/cyCSH7zqCwn3XihfD
         DfJekFjxeb9su8s3mT/tJU5LL3HOrvJylNUUXAjSh3LAK9A008ckVljDKzAEIpJBRdXY
         kqc3d8BAJfiXpcjCdNcEMOlpeh+rDEm62gJqwdxIW4EK6ne+KMljXYNz4R+SkjSUnylS
         eo3SbGF7QIsI2o9M0Kf3Mm+Qxb8u85bTn1jC4owiPZkKeHyHUWwUJsSWkQfW86ayFIM7
         dEjTD4v/wcJlF558Wc8pHfGvyubjUI75RMLse5llBCS2hlGjTuD4EzFy0YufsfZHFjHM
         Sj4g==
X-Gm-Message-State: APjAAAW65iStKaC7M4J7sRtgSFHutFmp717trlJqQ7Xm7NAw+DStGLXz
        FiCv60RQGuTEcx4qJagERYDvHhM/ZMU=
X-Google-Smtp-Source: APXvYqxTaej6US56dxAOlOzySYvZzu1OU1GiK24oDnA8nE3dQqCOUhAUTGzuQJKDp90IaIV1Jc5BpQ==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr68384959pla.271.1558240984723;
        Sat, 18 May 2019 21:43:04 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j10sm14335787pgk.37.2019.05.18.21.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 21:43:03 -0700 (PDT)
Date:   Sat, 18 May 2019 21:43:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Gen Zhang <blackgod016574@gmail.com>
cc:     iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] slub: Fix a missing-check bug in mm/slub.c file of Linux
 5.1.1
In-Reply-To: <20190515064457.GA29939@zhanggen-UX430UQ>
Message-ID: <alpine.DEB.2.21.1905182141280.180590@chino.kir.corp.google.com>
References: <20190515064457.GA29939@zhanggen-UX430UQ>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019, Gen Zhang wrote:

> Pointer s is allocated with kmem_cache_zalloc(). And s is used in the 
> follwoing codes. However, when kmem_cache_zalloc fails, using s will
> cause null pointer dereference and the kernel will go wrong. Thus we 
> check whether the kmem_cache_zalloc fails.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> 

It's ok if we encounter a NULL pointer dereference here, if we are ENOMEM 
then there is no way to initialize the slub allocator to be able to 
perform any future memory allocation.  Returning an error code won't help.

> ---
> --- mm/slub.c
> +++ mm/slub.c
> @@ -4201,6 +4201,8 @@ static struct kmem_cache * __init bootst
>  {
>  	int node;
>  	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
> +	if (!s)
> +		return ERR_PTR(-ENOMEM);
>  	struct kmem_cache_node *n;
>  
>  	memcpy(s, static_cache, kmem_cache->object_size);

It's not legal to mix declarations within the C code here.
