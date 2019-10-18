Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2222CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873EB21897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZOZIsJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394099AbfJRQEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:04:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38447 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389793AbfJRQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:04:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so6620488wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yc/ESgAECZFZFTl6VRSyrtsk401b5UBT2U4wK4t3Xg8=;
        b=GZOZIsJp6efqo33qitUnH5+hoiujQW5tjyGLqMwZL8Ci8opGSflROmREeaZ/qTwHpz
         IPwlviGDRDESd5aTdKL+H4u9smqnim0zNVsOCR+Tny5Dmk9I8SfwIPsf6r9hMwVcLlv2
         m0GvxJXvU8rZxw9DLJGncGn7euxXas/moBvLPYVm2fyItuJ2nbCboH3O3JItDGRFkiRt
         2qf94qHECOxmvaydzT2/99i7AneXTm1Y6/P4lf+Sjytj9SYUmk3yUAkJRG/95RtbqDsg
         RbckDBLEj+DQx9Q/qvsD0LFOQADTXPesLzMC0p2c3a/S3tWDcY2MGA7TjYwgLNXoA9ul
         gCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yc/ESgAECZFZFTl6VRSyrtsk401b5UBT2U4wK4t3Xg8=;
        b=BLv3194VtS7mYz0xRC34+6TpuN2bqA1NgswFj0nGxuDt6J+GC6KRlDp+/GKU2kVkZZ
         7hFoqpLwCQ56alja+f+6ETv2yOKLU5cU3S8SePVFL16h/1fRqt1uDQOXZXdGTd8hGf8o
         suR2GoJJ28BBpcWginwH3wp8a/2rsD4p9z65QI3JO4B4xiVVDOO6+t2epKdfUb4Txv4X
         boI61cJTlLGXKqCMuWL2coAVNvqEAuP870xmqm9YAv34hMsJrvjq9UhuFBIT7tm9ReF9
         n1q1KF0EvpIuGVb4AfrZodeeHeYw1EAqC7dZXyL4HUZo/ztskw0GQI7cRloDTEYaOTm0
         4TAg==
X-Gm-Message-State: APjAAAUIoApEGLxrrw8cyaB7fv4HZscnVZ90KV7JNpRAqIelEeFw6Hin
        XIf0SUEqXmvtgpWDkRUsX25Lsw==
X-Google-Smtp-Source: APXvYqwtDbGUo784uN0YShVP0F5YD9wvytRqbKRWisGJiiC2UoG4WYTgx/6R+3jhOU45zbrA14u+uw==
X-Received: by 2002:a1c:804d:: with SMTP id b74mr8423828wmd.170.1571414662644;
        Fri, 18 Oct 2019 09:04:22 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r2sm5875238wrm.3.2019.10.18.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:04:21 -0700 (PDT)
Date:   Fri, 18 Oct 2019 17:04:19 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH 1/2] mfd: mfd-core: Allocate reference counting memory
 directly to the platform device
Message-ID: <20191018160419.rm2ogvh3k3jdx3tn@holly.lan>
References: <20191018122647.3849-1-lee.jones@linaro.org>
 <20191018122647.3849-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018122647.3849-2-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 01:26:46PM +0100, Lee Jones wrote:
> MFD provides reference counting (for the 2 consumers who actually use it!)
> via mfd_cell's 'usage_count' member.  However, since MFD cells become
> read-only (const), MFD needs to allocate writable memory and assign it to
> 'usage_count' before first registration.  It currently does this by
> allocating enough memory for all requested child devices (yes, even disabled
> ones - but we'll get to that) and assigning the base pointer plus sub-device
> index to each device in the cell.
> 
> The difficulty comes when trying to free that memory.  During the removal of
> the parent device, MFD unregisters each child device, keeping a tally on the
> lowest memory location pointed to by a child device's 'usage_count'.  Once
> all of the children are unregistered, the lowest memory location must be the
> base address of the previously allocated array, right?
> 
> Well yes, until we try to honour the disabling of devices via Device Tree
> for instance.  If the first child device in the provided batch is disabled,
> simply skipping registration (and consequentially deregistration) will mean
> that the first device's 'usage_count' pointer will not be accounted for when
> attempting to find the base.  In which case, MFD will assume the first non-
> disabled 'usage_count' pointer is the base and subsequently attempt to
> erroneously free it.
> 
> We can avoid all of this hoop jumping by simply allocating memory to each
> single child device before it is considered read-only.  We can then free
> it on a per-device basis during deregistration.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/mfd-core.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 23276a80e3b4..eafdadd58e8b 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -404,7 +398,7 @@ int mfd_clone_cell(const char *cell, const char **clones, size_t n_clones)
>  		cell_entry.name = clones[i];
>  		/* don't give up if a single call fails; just report error */
>  		if (mfd_add_device(pdev->dev.parent, -1, &cell_entry,
> -				   cell_entry.usage_count, NULL, 0, NULL))
> +				   NULL, 0, NULL))

I think this change is broken.

Cloned cells are supposed to share the same reference counter as their
template and this change results in each clone having its own counter.
That means the "the 2 consumers who actually use it" will both end up
calling cs5535_mfd_res_enable() (and whichever loses the race will fail
to probe).

To be honest it might be easier to move the request_region() into
cs5535_mfd_probe() and rip out the entire reference counting mechanism
since at that point it would be unused (the other callers of
mfd_cell_enable() look safe w/o a counter).


Daniel.

>  			dev_err(dev, "failed to create platform device '%s'\n",
>  					clones[i]);
>  	}
> -- 
> 2.17.1
> 
