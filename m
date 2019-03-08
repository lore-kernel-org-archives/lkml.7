Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F031C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D72146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="zrmfr+7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCHQBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:01:55 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41633 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfCHQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:01:54 -0500
Received: by mail-yw1-f68.google.com with SMTP id q128so16639579ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Mrnt0v5aTwQKX4K+a22sLlI7mhOrdlmXcat3QdWb0c=;
        b=zrmfr+7XYf//JgH/JmL+nDOiY0Sn4Cn0/tQ6vGXOCsbi5D0ocV11dHDDQm4Brp4j48
         S9A5J6ijrUgsJdPMKZKFojQr2KUKKskPD7i3+dLAiGc54OcWWxcYLzEbdwletNluQOHL
         o3pAGw2BAogHLKZxBl0vS2CQr9jm/IJ9pw6p/UUN1pqx0Q80oo3qCnSmslx0o+dXFL61
         ENnC3P/EsdxY30F8N1PzTIZRyWNg3ReytprClO2X02QbqbRU3AEZFI3EXsTPxXF0GtuY
         lZQ9qZ2qjexeS1iLkhfHNPx2BMTq8qwcUc3PqDe3l5evwK4WKd8WFyX5xJmnxhTQKMly
         GTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Mrnt0v5aTwQKX4K+a22sLlI7mhOrdlmXcat3QdWb0c=;
        b=ieEv6YXACT6kHTP3MJqoJaOchxkT61Gs/c7seFN/6b1XlUN+ofgUyB1R1itiwidlQX
         aiLXdyTEfOLElnfNa6NHoIF+MQkzKmGGviq39GQKPKJ9DzoEUjRNEqzLny5INLp9To4j
         r2t82mJsVW/s7b/jzn2OLjbCloc0dadmt/LWD3VsNPil5K0VeDUR33whDtJ7daztmcuv
         ywYDTlyz2BRkHzDDYb/pKIrP9BNfr5yUkMDLY0C/+4uamQ8w91aZxMP42t7/pvQd+5Oo
         UEa0j0weMksKpmju7RPYoCEn79JS6QlDXhrxRTixEqQiY3IwoJhVvn/KYhrblI/AzKQY
         EKxQ==
X-Gm-Message-State: APjAAAX6483rXOcYSBW0VJEyEwU/LO2PDRNFizZe3RbkcoHQUGvaj5nx
        gyzGnbtARW2kDWNB/lPC9XMFjw==
X-Google-Smtp-Source: APXvYqzbRZ5z4rBPAYJpioypz0Qfq6hwxf1QV1sbef612TXie7Xx3GmmEU8nebWZS5r6iWB0vXbNmA==
X-Received: by 2002:a0d:e612:: with SMTP id p18mr14576212ywe.445.1552060913522;
        Fri, 08 Mar 2019 08:01:53 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id g82sm3210342ywg.60.2019.03.08.08.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 08:01:52 -0800 (PST)
Date:   Fri, 8 Mar 2019 09:01:51 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 07/15] slub: Add defrag_used_ratio field and sysfs support
Message-ID: <20190308160151.GC373@cisco>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-8-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308041426.16654-8-tobin@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:14:18PM +1100, Tobin C. Harding wrote:
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3642,6 +3642,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  
>  	set_cpu_partial(s);
>  
> +	s->defrag_used_ratio = 30;
>  #ifdef CONFIG_NUMA
>  	s->remote_node_defrag_ratio = 1000;
>  #endif
> @@ -5261,6 +5262,28 @@ static ssize_t destroy_by_rcu_show(struct kmem_cache *s, char *buf)
>  }
>  SLAB_ATTR_RO(destroy_by_rcu);
>  
> +static ssize_t defrag_used_ratio_show(struct kmem_cache *s, char *buf)
> +{
> +	return sprintf(buf, "%d\n", s->defrag_used_ratio);
> +}
> +
> +static ssize_t defrag_used_ratio_store(struct kmem_cache *s,
> +				       const char *buf, size_t length)
> +{
> +	unsigned long ratio;
> +	int err;
> +
> +	err = kstrtoul(buf, 10, &ratio);
> +	if (err)
> +		return err;
> +
> +	if (ratio <= 100)
> +		s->defrag_used_ratio = ratio;
    else
        return -EINVAL;

maybe?

Tycho
