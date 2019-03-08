Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C5C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCC4208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="C+SYhW/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCHP2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:28:24 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43649 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:28:24 -0500
Received: by mail-yw1-f68.google.com with SMTP id d129so2678242ywe.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=es1/thk3hoUT6a0CwJnVIOFCsRTZM2H+z7e9ODWXPCQ=;
        b=C+SYhW/98DRn7mbeftP5Bq2AbuAX7KuViHXSUAvc1IsYNrJ7tOev7hx50tI6RW1RHo
         kNUEaGRnrhS1RtYE4mWKYQ4Zrs9caruA8gdGq6Sm8l+4MvNZuzY0Ou2AwpopygZg1H6B
         EnS+5OlPRw9FsxEIlo+V9zhlIp/YUENj15jQspsBKLtlrTLxu7ep/OdPMhWufTO6xxEU
         KgYT/kgT3YChzT5J5hCXXPeTDshI5at5Fb+Hn+42S2ww9tGyC1teik/rRjM4Yuob0ljI
         w/50Cw2sSqKG5/hLuMDJYDYTCIIi+nZ7BJM5eKCMCvdjOCUFd3EWKH2mZ83bnlqA6TCR
         bALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=es1/thk3hoUT6a0CwJnVIOFCsRTZM2H+z7e9ODWXPCQ=;
        b=mgq0QWjAWPK71WbFVShnwrBlYUYFXPmlGXZmHOWzqNlnCead3bV7qrE0O86DIr3cAF
         81YQXR3+wAISuZqEYWrJXs88LrqDHiIEbbqemjon0roR/OHFx7Dh/V+GQGLZE+VdLyGN
         EWu0oK/WHRjXFMqTjXPoBngl7TT2gJpMwDX9g3WZRpuBHMjQIPQKRDDWowT7ElwgWFru
         hqMzlt2itrd038yyQ+TVSiZY0inESxBLJbp1RYaaDNZQnelcIyv61s9o1E9QHcVnJD4s
         bOBye9XIID9tVopf4xLeVNCO4bG3qgLahrXG7tWgfgVHyCPus0Tvgc185vhvpEMzToub
         oKvg==
X-Gm-Message-State: APjAAAWPSEv2Xleb7kDfmviUhKkbeV7GVf/peXs4hfE1VAP4SJhG5dls
        Uvps0uHtcHqnjLpQqjhbLJ34GA==
X-Google-Smtp-Source: APXvYqyc0geEIyeysQhQBQA3bHmVi1yYqIl4pBFfAN9RZNmAsvYKpWmEgZ/BboNg9gDxcNVqFB37kg==
X-Received: by 2002:a81:a652:: with SMTP id d79mr15361903ywh.472.1552058903364;
        Fri, 08 Mar 2019 07:28:23 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id d85sm3121148ywd.96.2019.03.08.07.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 07:28:22 -0800 (PST)
Date:   Fri, 8 Mar 2019 08:28:20 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/15] slub: Add isolate() and migrate() methods
Message-ID: <20190308152820.GB373@cisco>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-3-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308041426.16654-3-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:14:13PM +1100, Tobin C. Harding wrote:
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f9d89c1b5977..754acdb292e4 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -298,6 +298,10 @@ int slab_unmergeable(struct kmem_cache *s)
>  	if (!is_root_cache(s))
>  		return 1;
>  
> +	/*
> +	 * s->isolate and s->migrate imply s->ctor so no need to
> +	 * check them explicitly.
> +	 */

Shouldn't this implication go the other way, i.e.
    s->ctor => s->isolate & s->migrate
?

>  	if (s->ctor)
>  		return 1;

Tycho
