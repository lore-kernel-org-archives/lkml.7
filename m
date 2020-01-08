Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD41C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9F62082E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578493269;
	bh=sBVCTdQ0luWR6m8QbPPQ/7BuDc7qqG+m4zOzFBTC4Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=azx6OiEXseA3VGi7xWd+pW6m8C80P2n/lobudyz3uPlRNPw9uD0hwY9LZUX/iagFs
	 7Oea4KOfe7XAbNhUBGyZS63U1e6SEjTkROFh6NYhLRNTB6oaEwMCyh0LdPtvzbERnL
	 xz2vVajZzMnXkMzBl+WqOrMLKdXpK4FqLoOJmhvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgAHOVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:21:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33217 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgAHOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:21:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so3628065wrq.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzE+F+ToFamNbTv3ApmTi3LLQ+FBp1ImrOvDnsH1Cgo=;
        b=s3RLlzcnEQwafuJN2UGn7h6gpAYcuGRShKjWailcbC5fZYE5j4Tp3JC9yZ9ZPHrHbs
         ZlyOrGc4x60x8A//q2QUFiZedsTcRSYRILoH8/jbz/Eunjt6NayaklxI5+5jtpsyfOhH
         nlGi/xqf6ZhhinHf2JB+LldwUh+0jVsRC6TdyT/bhGP87Q77w4rdgbbv6So0J3ePi4hF
         h+4Q/gk1qYTZ1swgok1plTBrfEN9+fgLav3jmFiOqOx88TSgmhkIhCUEFQQlbeapAnH6
         LYofYgnqLwceaSgpSJ8Zj2CXCeeH0L9Mozjm5Y6b3rVm3iHgyOEWMX/Hu/+5kSVRepef
         ArkQ==
X-Gm-Message-State: APjAAAX/p20lP76nAKYtUfLBkYesbPcDY9S/1m/+zzr9rzjhx4xVnTXT
        8s3iZKeR0xGVy+EE3VvdaNQ=
X-Google-Smtp-Source: APXvYqxNeeqdHzZSBpuJgBcbZK8+AKxsNrUqX1+680WsPSmRNfeTcR4e0SSNGtTDB0os0mKnTZOHvw==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr5015220wrv.120.1578493265708;
        Wed, 08 Jan 2020 06:21:05 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i10sm4660930wru.16.2020.01.08.06.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:21:04 -0800 (PST)
Date:   Wed, 8 Jan 2020 15:21:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] drivers/base/memory.c: cache blocks in radix tree to
 accelerate lookup
Message-ID: <20200108142104.GU32178@dhcp22.suse.cz>
References: <20191121195952.3728-1-cheloha@linux.vnet.ibm.com>
 <20191217193238.3098-1-cheloha@linux.vnet.ibm.com>
 <20200107214801.GN32178@dhcp22.suse.cz>
 <890c1d43-b5c6-e126-c228-cb8c062df654@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890c1d43-b5c6-e126-c228-cb8c062df654@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-01-20 14:36:48, David Hildenbrand wrote:
> On 07.01.20 22:48, Michal Hocko wrote:
> > [Cc Andrew]
> > 
> > On Tue 17-12-19 13:32:38, Scott Cheloha wrote:
> >> Searching for a particular memory block by id is slow because each block
> >> device is kept in an unsorted linked list on the subsystem bus.
> > 
> > Noting that this is O(N^2) would be useful.
> > 
> >> Lookup is much faster if we cache the blocks in a radix tree.
> > 
> > While this is really easy and straightforward, is there any reason why
> > subsys_find_device_by_id has to use such a slow lookup? I suspect nobody
> > simply needed a more optimized data structure for that purpose yet.
> > Would it be too hard to use radix tree for all lookups rather than
> > adding a shadow copy for memblocks?
> 
> As reply to v1/v2 I argued that this is really only needed if there are
> many devices. So far that seems to be applicable to the memory subsystem
> mostly. No need to waste space on all other subsystems IMHO.

How much space are we talking about? Radix tree (resp. xarray) is a
small data structure and even when we have to allocate nodes dynamically
this doesn't sound like a huge overhead (especially with a small id
space). I might be missing something of course because I am not familiar
with this part the driver model and I would be interested what
maintainers think about that.

> As you said, right now it's easy and straightforward, if we find out
> other subsystems need it we can generalize/factor out.

I will not really push for that but it is almost always better to
improve a common infrastructure rather than build up a dedicated
workarouns in some users. Especially when there are no strong arguments
for that.
-- 
Michal Hocko
SUSE Labs
