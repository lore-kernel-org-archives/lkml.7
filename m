Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B1C47409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A4720828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575886042;
	bh=ixusleWnEq735tjJ8lQG3ERZ+bntGGILzSuUvZg7D3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IRgEO5oh5V4Q1ZS5Fsv+jRvYnjaPo3RiaC/3/ZVnM6IB2lJ8hJSxidHQgyuC6Yz9G
	 AOdSSC96eLBAbnkV0vlV4E/5zBsGx8T+rzEWmI+8l9JPJuncEUB4ftYDX9EwpDLxDq
	 LLVmWrUChBhwsejspzqzzf+Ae4bQdV4h1LyZqNfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfLIKHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:07:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53648 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfLIKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:07:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id n9so14261028wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 02:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZK01xO2VHFn+IEu/N2yJTe1AAJ2Ih5XXg9yHN17A9sE=;
        b=D7601d8weQa7Gu1WIKVejDlYat4+gEkYQnsEI/LYzxwxZq4g0yCOC1dKdKqnCAGRic
         T97zYBzJmwxGJNIhxV8W+S8NbZmI8z/rakAODWQEmkMLc6Sx1ZJgqdmozeUj5IIxp9JX
         dXpAFS95j9Hv8kA92KP9p77scWxmA+yGQwbbPPUI9y894fs0zPo7XMuYaPbikgmbtClx
         xwxkjnGoOVpW79gsYQzY3nRD41cJlk1oufp2Ltk2Set4/Mqj2o/Pevk2GjxDvYwp7RAQ
         gkvHIGiGn6T22rwrSe3qQ3+Gsg92L7vAWIEPYwKSU86wKHoz66ktpPNxbfYKD3DpoTJK
         IQmQ==
X-Gm-Message-State: APjAAAXMtlW0aiJsVNcDBhwhtE/P/fFhwHGoJBflKQ6IYsPFPkcVosht
        qLx+DAzpgN3MmJS7v/v2x7T/QIdM
X-Google-Smtp-Source: APXvYqxFkqWC+BhtSyCb9+jQbv4vLo/72RGm6Rz/bOhvzh38nITpvs1G+YEkejn2rSWpaKrxrmyPNg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr23890833wmj.96.1575886039073;
        Mon, 09 Dec 2019 02:07:19 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n12sm13092152wmd.1.2019.12.09.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 02:07:18 -0800 (PST)
Date:   Mon, 9 Dec 2019 11:07:17 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgross@suse.com,
        william.kucharski@oracle.com, mingo@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/hotplug: Only respect mem= parameter during boot stage
Message-ID: <20191209100717.GC6156@dhcp22.suse.cz>
References: <20191206150524.14687-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206150524.14687-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-12-19 23:05:24, Baoquan He wrote:
> In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
> parameter") a global varialbe global max_mem_size is added to store
> the value which is parsed from 'mem= '. This truly stops those
> DIMM from being added into system memory during boot.
> 
> However, it also limits the later memory hotplug functionality. Any
> memory board can't be hot added any more if its region is beyond the
> max_mem_size. System will print error like below:
> 
> [  216.387164] acpi PNP0C80:02: add_memory failed
> [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> [  216.392187] acpi PNP0C80:02: Enumeration failure
> 
> >From document of 'mem =' parameter, it should be a restriction during
> boot, but not impact the system memory adding/removing after booting.
> 
>   mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
> 
> So fix it by also checking if it's during SYSTEM_BOOTING stage when
> restrict memory adding. Otherwise, skip the restriction.

Could you be more specific about why the boot vs. later hotplug makes
any difference? The documentation is explicit about the boot time but
considering this seems to be like that since ever I strongly suspect
that this is just an omission.

Btw. how have you tested the situation fixed by 357b4da50a62?

> Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem= parameter")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55ac23ef11c1..5466a0a00901 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -105,7 +105,7 @@ static struct resource *register_memory_resource(u64 start, u64 size)
>  	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>  	char *resource_name = "System RAM";
>  
> -	if (start + size > max_mem_size)
> +	if (start + size > max_mem_size && system_state == SYSTEM_BOOTING)
>  		return ERR_PTR(-E2BIG);
>  
>  	/*
> -- 
> 2.17.2

-- 
Michal Hocko
SUSE Labs
