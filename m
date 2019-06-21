Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A84EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78D72084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="naw7755f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfFUBTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:19:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42568 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:19:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so2121786plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eJKYybw5a1SWYpHwymEpjHSIfv7GuhVzn0pIpamG/wM=;
        b=naw7755fmAIXafE+Jl7dV8RVkpTo05kib/8CyuURh0MhrDFRQHF3jVyKVS6EeiB8N9
         BoFpd2iPgtOquKwlZ5rum1uAPcDMOfYH2zVtsc/BNjku12A7gon9LDPgQ+5iJ4Ko7J14
         5OMRX+XjMMr1O4lr8I4IGUtO/vyhyJrLisAS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eJKYybw5a1SWYpHwymEpjHSIfv7GuhVzn0pIpamG/wM=;
        b=Bl5eIxPZK8Z6E+cZjJnXTiMHNf2fFT7G25m6FzFX3ufdtl60+eJrylh1aMmqNbI/Ba
         aDyR6eu43nhZ8RDLj+YwvdGuRNfenRPTdTdyo/yeDXiDwONMxScJBG8jvuKOV1yZwisz
         Qyzv9DjkNz211qD9Rt3lBrajDBYST4ebhB60E9yWIqijAYfO9JFOhi6MeJHE3iWbmakH
         xBSKTTrXt92JLZQV/+gcRwTywgGMbPzp2O5FL0TqVCVkTGBMK74nfk4UH1VWNdAZJR5K
         Rq6iIfNsLisaFVn9KqrYEf3LTxND9HS3OJNDUn7+TtlTIi4yN+OgjHk7cd08aM1Zc/HP
         QJcQ==
X-Gm-Message-State: APjAAAWkB5rLFUfln+u4rLKXzOb8GSMMQEMt3+tm4Y9/O7yAc/i1w6qy
        DLzOYVNpAcCDoW1+lSjJSF1gJg==
X-Google-Smtp-Source: APXvYqzDCGsl/sfw+DruyeiWlGEv/UbXrhWxZujE3VvkgVVndHlvNmAR1JKU/5PFrVACJM85q79/Uw==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr34357353plp.59.1561079969560;
        Thu, 20 Jun 2019 18:19:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b26sm680142pfo.129.2019.06.20.18.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 18:19:28 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, glider@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] slub: play init_on_free=1 well with SLAB_RED_ZONE
Message-ID: <201906201818.6C90BC875@keescook>
References: <1561058881-9814-1-git-send-email-cai@lca.pw>
 <201906201812.8B49A36@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906201812.8B49A36@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 06:14:33PM -0700, Kees Cook wrote:
> On Thu, Jun 20, 2019 at 03:28:01PM -0400, Qian Cai wrote:
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a384228ff6d3..787971d4fa36 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1437,7 +1437,7 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
> >  		do {
> >  			object = next;
> >  			next = get_freepointer(s, object);
> > -			memset(object, 0, s->size);
> > +			memset(object, 0, s->object_size);
> 
> I think this should be more dynamic -- we _do_ want to wipe all
> of object_size in the case where it's just alignment and padding
> adjustments. If redzones are enabled, let's remove that portion only.

(Sorry, I meant: all of object's "size", not object_size.)

-- 
Kees Cook
