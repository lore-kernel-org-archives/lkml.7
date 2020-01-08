Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFD5C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FAE2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578476447;
	bh=06ZO+lZZtiA5khyjpH4A1yTTiaxpTEVlw9R/5uyxQHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i8LTLtPVmh3seb+yk5bkkdNR9ahyywwQ+H/V7Lk1/8qFh0RMq11/ZyWUTbCui0Nfb
	 I6VPEto25DRbw+dtSXfO0LtoMJm0qktQDORUVi0iEUCe3bjXKGxPFqIDbC1fbuilLz
	 /JYaCBmcnTFQCEqQRUkNZWjwX2bt1qNaOVLPi4b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAHJkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:40:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54490 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgAHJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:40:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so1716076wmj.4;
        Wed, 08 Jan 2020 01:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=meLHATiTUUwiWD33DPkavEeGj5naCYHS6kL4s3+/juM=;
        b=lzUQyloi4JgMMhaxX6DV2L82rczMp6YQ6c1mb+Qimfiltl0mQnYUiShbIL5EfqB6P3
         UdYpGVii7e+xfv8DlBBJlFmijhBpzARHZYm709byNzu2SozLjDaX0UYxPz4xObzhSWW7
         p6FtsUazhLLI+1XwlDXRtR2VGS+ULTVOcGeYJtxPaUumS5AsMMCXwgEO+zuhrTUzzFqW
         3atBL/TgzTFWrIbtEt4Aw3uvOzyGMPP5wDZT/6G7dnLo0tQRa8xPq/HJ5B7QDkK5KL2u
         DNXLgnRixpEnpNosETszw4nxre/VtPPDrS2rLdrlppo130ujZGdVXRKdyK2dae+wZHyZ
         BrsQ==
X-Gm-Message-State: APjAAAUq5hA9Vj0SgFImqLnwtTbDRugIQ8Ly4gdMm2R259LIXhtJT5uh
        3aRBEbzy3jtZt/PXyGOvxSczwVdv
X-Google-Smtp-Source: APXvYqzGlv3UyrOBEYEndGtbZQxn4HYfskoN+/gXiEDOTsWvFx0jPB8TFCI/W8XsPq4H8mmr5M7KMQ==
X-Received: by 2002:a7b:cf26:: with SMTP id m6mr2553244wmg.17.1578476444398;
        Wed, 08 Jan 2020 01:40:44 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s19sm2998002wmj.33.2020.01.08.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 01:40:43 -0800 (PST)
Date:   Wed, 8 Jan 2020 10:40:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200108094041.GQ32178@dhcp22.suse.cz>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <20200106102345.GE12699@dhcp22.suse.cz>
 <20200107012241.GA15341@richard>
 <20200107083808.GC32178@dhcp22.suse.cz>
 <20200108003543.GA13943@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108003543.GA13943@richard>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-01-20 08:35:43, Wei Yang wrote:
> On Tue, Jan 07, 2020 at 09:38:08AM +0100, Michal Hocko wrote:
> >On Tue 07-01-20 09:22:41, Wei Yang wrote:
> >> On Mon, Jan 06, 2020 at 11:23:45AM +0100, Michal Hocko wrote:
> >> >On Fri 03-01-20 22:34:07, Wei Yang wrote:
> >> >> As all the other places, we grab the lock before manipulate the defer list.
> >> >> Current implementation may face a race condition.
> >> >
> >> >Please always make sure to describe the effect of the change. Why a racy
> >> >list_empty check matters?
> >> >
> >> 
> >> Hmm... access the list without proper lock leads to many bad behaviors.
> >
> >My point is that the changelog should describe that bad behavior.
> >
> >> For example, if we grab the lock after checking list_empty, the page may
> >> already be removed from list in split_huge_page_list. And then list_del_init
> >> would trigger bug.
> >
> >And how does list_empty check under the lock guarantee that the page is
> >on the deferred list?
> 
> Just one confusion, is this kind of description basic concept of concurrent
> programming? How detail level we need to describe the effect?

When I write changelogs for patches like this I usually describe, what
is the potential race - e.g.
	CPU1			CPU2
	path1			path2
	  check			  lock
	  			    operation2
				  unlock
	    lock
	    # check might not hold anymore
	    operation1
	    unlock

and what is the effect of the race - e.g. a crash, data corruption,
pointless attempt for operation1 which fails with user visible effect
etc.
This helps reviewers and everybody reading the code in the future to
understand the locking scheme.

> To me, grab the lock before accessing the critical section is obvious.

It might be obvious but in many cases it is useful to minimize the
locking and do a potentially race check before the lock is taken if the
resulting operation can handle that.

> list_empty and list_del should be the critical section. And the
> lock should protect the whole critical section instead of part of it.

I am not disputing that. What I am trying to say is that the changelog
should described the problem in the first place.

Moreover, look at the code you are trying to fix. Sure extending the
locking seem straightforward but does it result in a correct code
though? See my question in the previous email. How do we know that the
page is actually enqued in a non-empty list?
-- 
Michal Hocko
SUSE Labs
