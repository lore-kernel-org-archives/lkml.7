Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC0C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847062088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PgBQCkgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfDYPnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:43:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41095 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfDYPnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:43:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id v23so254614oif.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuBi+pyE+MOOcRNjrNHKnCL59LtxHiwnpVdboRz7mt4=;
        b=PgBQCkgfUCim04cuwnDmnemk3z/ZFT/C2b6DYjYzFkGTLFkcRrTDmHsXRJwnZHl64b
         CPaXmduTcgjyVzlZ1ixVUis/CefjAKGilmfm8E/mR+d8REyVvnMB/+CIF43KARwsOA2W
         1qvHm5R6LrwuLqq8sLktOwb79BjFRMcphHhTwzyTESoJKzE9bZE7lGGtWDF6PCGiRYTX
         txMvPPtEcbNjOIkSGLJQjut2VzK/uVNcenvDdoOI6g9O44AM6tKHt838/NnBJYhnihBr
         rc4UpJf2Mdve5s2OAAUPqpL6v1KKgLDOTHzxSUnn9foNkP8HZ+CUTL2p8SEJheb3Jb4z
         AHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuBi+pyE+MOOcRNjrNHKnCL59LtxHiwnpVdboRz7mt4=;
        b=KFJO8I0F4HhWgZepIJrz2ioFSA76c4KOwueuzhOyNcL9mzUJEbw8dgFCjPqvLOgd8g
         LNRAh6EnrCzdpGrZXdo1PoGsvngDE6xBh4j4/60sKYe3dbq4SWhsfqoLmy16Oo7b/7QL
         jsNBo1gztAqj9j972pfTMtQDWzLMNjs94eduVmm5l07Sa8fOI/q184C+T54D7HFm/VNK
         kPaFwSJH1gJzjklGlLv3wOmkrKeLW2c3gGkhBg5dnKnf3MvlAETEUeh3u/WNyblErPNU
         TCUkrJgMiyQQDtb9VJJEQOVSVHRXA/3rxm9sbD9pEnN3asgujRgrGLi+hjO3hDVDmLfM
         GAsQ==
X-Gm-Message-State: APjAAAW6MmvS017Po6OBjQpclTfRQz+dUxKZtapLr/+K3yMnm2XE/mPI
        NcdtwYQpwSyaW7QqLRVlvUu5wJvtPnBqLi7ZRqbUKw==
X-Google-Smtp-Source: APXvYqwh3PqfR5/vPjV4UUBzcmSSGH7mhUnUhfc/+cpUrRl0aKmdC7Xo6E468HAZnrkNTvvruta71ETSn2xWCclxVpk=
X-Received: by 2002:aca:de57:: with SMTP id v84mr3927177oig.149.1556206999786;
 Thu, 25 Apr 2019 08:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <20190425063727.GJ12751@dhcp22.suse.cz> <5A90DA2E42F8AE43BC4A093BF067884825785EE8@SHSMSX104.ccr.corp.intel.com>
 <20190425075353.GO12751@dhcp22.suse.cz> <5A90DA2E42F8AE43BC4A093BF067884825785F6E@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <5A90DA2E42F8AE43BC4A093BF067884825785F6E@SHSMSX104.ccr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Apr 2019 08:43:08 -0700
Message-ID: <CAPcyv4jpiPg+dbFg0BrNSqGjxKA6CQdBiLp5L=nrLWzN7mD8Kw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous memory system
To:     "Du, Fan" <fan.du@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 1:05 AM Du, Fan <fan.du@intel.com> wrote:
>
>
>
> >-----Original Message-----
> >From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> >Behalf Of Michal Hocko
> >Sent: Thursday, April 25, 2019 3:54 PM
> >To: Du, Fan <fan.du@intel.com>
> >Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
> >Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
> ><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
> ><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
> >Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous
> >memory system
> >
> >On Thu 25-04-19 07:41:40, Du, Fan wrote:
> >>
> >>
> >> >-----Original Message-----
> >> >From: Michal Hocko [mailto:mhocko@kernel.org]
> >> >Sent: Thursday, April 25, 2019 2:37 PM
> >> >To: Du, Fan <fan.du@intel.com>
> >> >Cc: akpm@linux-foundation.org; Wu, Fengguang
> ><fengguang.wu@intel.com>;
> >> >Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
> >> ><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
> >> ><ying.huang@intel.com>; linux-mm@kvack.org;
> >linux-kernel@vger.kernel.org
> >> >Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous
> >> >memory system
> >> >
> >> >On Thu 25-04-19 09:21:30, Fan Du wrote:
> >> >[...]
> >> >> However PMEM has different characteristics from DRAM,
> >> >> the more reasonable or desirable fallback style would be:
> >> >> DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3.
> >> >> When DRAM is exhausted, try PMEM then.
> >> >
> >> >Why and who does care? NUMA is fundamentally about memory nodes
> >with
> >> >different access characteristics so why is PMEM any special?
> >>
> >> Michal, thanks for your comments!
> >>
> >> The "different" lies in the local or remote access, usually the underlying
> >> memory is the same type, i.e. DRAM.
> >>
> >> By "special", PMEM is usually in gigantic capacity than DRAM per dimm,
> >> while with different read/write access latency than DRAM.
> >
> >You are describing a NUMA in general here. Yes access to different NUMA
> >nodes has a different read/write latency. But that doesn't make PMEM
> >really special from a regular DRAM.
>
> Not the numa distance b/w cpu and PMEM node make PMEM different than
> DRAM. The difference lies in the physical layer. The access latency characteristics
> comes from media level.

No, there is no such thing as a "PMEM node". I've pushed back on this
broken concept in the past [1] [2]. Consider that PMEM could be as
fast as DRAM for technologies like NVDIMM-N or in emulation
environments. These attempts to look at persistence as an attribute of
performance are entirely missing the point that the system can have
multiple varied memory types and the platform firmware needs to
enumerate these performance properties in the HMAT on ACPI platforms.
Any scheme that only considers a binary DRAM and not-DRAM property is
immediately invalidated the moment the OS needs to consider a 3rd or
4th memory type, or a more varied connection topology.

[1]: https://lore.kernel.org/lkml/CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com/

[2]: https://lore.kernel.org/lkml/CAPcyv4it1w7SdDVBV24cRCVHtLb3s1pVB5+SDM02Uw4RbahKiA@mail.gmail.com/
