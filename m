Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AFDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A37C218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TY8hhFfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfCORVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:21:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46731 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfCORVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:21:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id c18so8989579otl.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rV3K8PnVom4USqT3Gzf7IMcpT4mAIhVLDbNscsln/e4=;
        b=TY8hhFfbk1i53/4fH5sKe15+nweaFTVhdIk/aMuUgTg4aQH7BGOHw+1HsUL2bsFSd5
         hzY8zV9j1VpZRMMRTKvrvrnHCIeRKvCCLFqgNwxqjLn/iwjDyeNN6RI0+WWrz5hxfyR7
         2HM6lEptgtV2XiRqodQwftKrNu4QmLZMyG9S7Aq2/vO7bu69jJOzsmvuCVSYZZ1wv5cO
         3nCPMKLHFC+owGZrkZ9ewd1SR0arWxz363VTHWPBRqFY/u0YcKGje59fLxjfcnj+TcfC
         M9/FR8fIve0cLLvbyZBcM4mklV782/7M7BK80Mfr7cAvoesGYIYTcFYun8NVeAAPz4Wd
         IbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rV3K8PnVom4USqT3Gzf7IMcpT4mAIhVLDbNscsln/e4=;
        b=SNrOGxK91r+EjXvl6ufFirDGQcEPpcQhTo+9i3rVTI1rgiB3Ttg7R0wWMHnpwbQiZF
         YVl8LBXuygnAUjjBhP4gpCVJnGmJvXfauVNZJfOiIksFfxsgQvNxSEbMEfDtew0W4jSN
         v02zUWc9ebydwJcroBnELVTiuSVNyu26kMMe/RsjkT+YEE7WyQoF+nKH6ix4ZGl7MIH2
         bVbhIpzI0CKH2QSgtOshPPAxeQNi952y91kAsyf7r9z9z4aJBgqgwWsECD6AgaKRtvi1
         h9lFpbReKP5UCHYJa0XwcoAJ7WwT0mEMXNOfkFYoLJlUZK/bzByT3n7rZoZ7VGmISE2/
         5uqg==
X-Gm-Message-State: APjAAAUk/ZxSmJA30OrjsBXzR+gJGrSJonMtFWQXnxd7JmNBRsf9J0RJ
        CH0OkbkHA6uJ9+kjjeLVaqJUfA==
X-Google-Smtp-Source: APXvYqxIGDlSFub6D2MZgeFN+mM5z0qNWtolTi4QKIyeLDX/QxxKp8cHd7JLtlWzrg2flcUszC6KvQ==
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr2769706otn.300.1552670508834;
        Fri, 15 Mar 2019 10:21:48 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h138sm1230701oic.8.2019.03.15.10.21.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 10:21:47 -0700 (PDT)
Date:   Fri, 15 Mar 2019 10:21:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Oscar Salvador <osalvador@suse.de>
cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, william.kucharski@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: Fix __dump_page when mapping->host is not set
In-Reply-To: <20190315143304.pkuvj4qwtlzgm7iq@d104.suse.de>
Message-ID: <alpine.LSU.2.11.1903150952270.2934@eggly.anvils>
References: <20190315121826.23609-1-osalvador@suse.de> <20190315124733.GE15672@dhcp22.suse.cz> <20190315143304.pkuvj4qwtlzgm7iq@d104.suse.de>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019, Oscar Salvador wrote:
> On Fri, Mar 15, 2019 at 01:47:33PM +0100, Michal Hocko wrote:
> > diff --git a/mm/debug.c b/mm/debug.c
> > index 1611cf00a137..499c26d5ebe5 100644
> > --- a/mm/debug.c
> > +++ b/mm/debug.c
> > @@ -78,6 +78,9 @@ void __dump_page(struct page *page, const char *reason)
> >  	else if (PageKsm(page))
> >  		pr_warn("ksm ");
> >  	else if (mapping) {
> > +		if (PageSwapCache(page))
> > +			mapping = page_swap_info(page)->swap_file->f_mapping;
> > +
> >  		pr_warn("%ps ", mapping->a_ops);
> >  		if (mapping->host->i_dentry.first) {
> >  			struct dentry *dentry;
> 
> This looks like a much nicer fix, indeed.
> I gave it a spin and it works.
> 
> Since the mapping is set during the swapon, I would assume that this should
> always work for swap.
> Although I am not sure if once you start playing with e.g zswap the picture can
> change.
> 
> Let us wait for Hugh and Jan.
> 
> Thanks Michal

Sorry, I don't agree that Michal's more sophisticated patch is nicer:
the appropriate patch was your original, just checking for NULL.

Though, would I be too snarky to suggest that your patch description
would be better at 2 lines than 90?  Swap mapping->host is NULL,
so of course __dump_page() needs to be careful about that.

I was a little disturbed to see __dump_page() now getting into dentries,
but admit that it can sometimes be very helpful to see the name of the
file involved; so if that is not in danger of breaking anything, okay.

It is very often useful to see if a page is PageSwapCache (typically
because that should account for 1 of its refcount); I cannot think of
a time when it's been useful to know the name of the underlying swap
device (if that's indeed what f_mapping leads to: it's new to me).
And if you need swp_type and swp_offset, they're in the raw output.

The cleverer __dump_page() tries to get, the more likely that it will
itself crash just when you need it most. Please just keep it simple.

Thanks,
Hugh
