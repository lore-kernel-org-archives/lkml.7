Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEF420843
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfENMWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:22:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33838 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:22:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so1143910wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 05:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qayVS96zY1J0R6Jc99pitHz7f8TygGhnMtrO6wAoCLY=;
        b=JY0bpwwj6cr70czYL3CuB8AqfXtyBhzhJagm5NtT+MNqtQq6plyri1wM7ustj0dpmf
         QMlrXkjiTlRrhQJ+XdgYtsxrlaaETi02TqQ4eFbFdccWlbGRwDuR/Z51MGhGmu7ecXC/
         4yVZB5d4RzX6+yylcr1IZpxqbNr/UdKe8xX604+MF9HumE2bWVT7NGwD257ja9l7/8jc
         9cr3VeZ8Dxb24xCCioFWZr12P7GTS9VDEc/wGgjA4a8gh8Z2XO3QhbWUDwoxGVRmyNFS
         y7pyaqS07rJ6Hv7cTVBBzZUPOthnkZ5+SB96WEjpGHObnvsQvdqztkGc8ukdBYQK9+43
         5blA==
X-Gm-Message-State: APjAAAVmmx5HsLbtppBFR/8ixlLmxt9kKHXASXdMYKMLFdGECJXY4mZt
        tT4M+cVr9wqjGGh38M5hXhh1
X-Google-Smtp-Source: APXvYqzsCEp7VbrRb6Vl8WtA7IteENteanfdFIhbcZA5iRmul1ICxBd3alvROKgMfbRA3KyhviSxLA==
X-Received: by 2002:adf:9bd8:: with SMTP id e24mr16595634wrc.1.1557836525782;
        Tue, 14 May 2019 05:22:05 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id a128sm2874817wma.23.2019.05.14.05.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 05:22:04 -0700 (PDT)
Date:   Tue, 14 May 2019 13:22:03 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@marvell.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: avoid double string traverse in
 kmem_cache_flags()
Message-ID: <20190514122203.xvgxi4poajcs5lgx@atomlin.usersys.com>
References: <20190501053111.7950-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501053111.7950-1-ynorov@marvell.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180716-1637-ee8449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-04-30 22:31 -0700, Yury Norov wrote:
> If ',' is not found, kmem_cache_flags() calls strlen() to find the end
> of line. We can do it in a single pass using strchrnul().
> 
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

Fair enough.

Acked-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin
