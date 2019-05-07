Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49D3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3389205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTfyAoLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfEGVEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:04:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38994 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfEGVEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:04:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so9284270pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tp9MHM6S82XiPQpC6c6jLekBkf9kgfqCZQyGw89KOqE=;
        b=KTfyAoLB21CgLn4vV+DeWm27Z0NxxbAZXzSaXHMVtSC6cam9l8ioBG5uvVhsSKhamD
         5O8P15XSzgMcT/aYJ6UID2M634g4V0M18eMkOog2O/53+5MJUBFoNjUQ9F7KCvtIlc4F
         B7frY+UwvuCyqkixc99UccY4Q4r/WBFLetyaU1tp/0auaUSzitr5YJbs0NRr/EXsA/jO
         Qyum4xwKpBUibLnDJd56JqbnQhzMKlTw48Fm+bceoOk5CPJFQlg4L/CGlS/yDMrG3cxg
         d0npEcAiUhLIsWEerZF+tsXsVCqSY4NIlXXm2r0szlHmhPy19eJTu1TlNSwo9/sG4/Cs
         +ZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tp9MHM6S82XiPQpC6c6jLekBkf9kgfqCZQyGw89KOqE=;
        b=k2euQ5smjBg3KHZoMAZYCXkcKk8z+j+sM5actdwhzIW1ugsoGMvUTWEa0Ivbl9DtlW
         WAIAqkMR78p3mxGMpfX4cA+nlbUB7uScQI5Zo4da3H/odDaNAgrZ/b1aQYFkH3bMNq5k
         vDzk3n9fZBaf7wUT4Z52QWRCFqsHa6UrZFZbDkjmFpnNTVjFaMbGSI2XxaZnge2GlMw0
         TVe+hjoTLBnJBL5GZNmIrVb2CH8t5FrWz5I3+i8E0QuwUR3y0Tt/LqyTwlA5MUU0AzeO
         0pR3E8HzNBch/lbOwerqo+0FYgrORkw4RfcVIxZFmkSWglFgDqPHWtsR+WdeBvPCHZTT
         4c2A==
X-Gm-Message-State: APjAAAWQMFT1eoWbJw4X0fpzMbazX7KQDjja+0EpSVXH7hnjSBXYISZE
        NM/kTegjY+X51NivGd9JVWdDrWC6
X-Google-Smtp-Source: APXvYqzflAmUTQydzxJ4cjPRW0WIecf2bKx2yQBktISYk/b4xLlIZ0c6pxz/B7pjskqQcN+h0MZuiQ==
X-Received: by 2002:a65:6496:: with SMTP id e22mr42445689pgv.249.1557263086677;
        Tue, 07 May 2019 14:04:46 -0700 (PDT)
Received: from localhost ([2601:640:2:82fb:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id u66sm5867753pfa.36.2019.05.07.14.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 14:04:45 -0700 (PDT)
Date:   Tue, 7 May 2019 14:04:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yury Norov <ynorov@marvell.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: avoid double string traverse in
 kmem_cache_flags()
Message-ID: <20190507210444.GB8935@yury-thinkpad>
References: <20190501053111.7950-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501053111.7950-1-ynorov@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:31:11PM -0700, Yury Norov wrote:
> If ',' is not found, kmem_cache_flags() calls strlen() to find the end
> of line. We can do it in a single pass using strchrnul().

Ping?

> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  mm/slub.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4922a0394757..85f90370a293 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1317,9 +1317,7 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>  		char *end, *glob;
>  		size_t cmplen;
>  
> -		end = strchr(iter, ',');
> -		if (!end)
> -			end = iter + strlen(iter);
> +		end = strchrnul(iter, ',');
>  
>  		glob = strnchr(iter, end - iter, '*');
>  		if (glob)
> -- 
> 2.17.1
