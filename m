Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132FC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0E820881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557909205;
	bh=zXSlD5hrmeq3wkcrjzbqDtRVooiSYzziP/zgztF0yKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FBN6tjQFnL6b6zAGqtundsrEcE1/gH/RLmb54g34KLAa+PVZRSf4qPFLo58SThc6C
	 +nOMku8rTO+yxdNcJOvUK0Hf2pxcajUWvqpaDV8d/nkVOT1pi/ee//bsIqRusxtP6W
	 jA+oXOEvtGkxlR+HNv6Y4186UvE7UFxs8ti4JxGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEOIdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:33:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:34892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfEOIdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:33:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92802AFA7;
        Wed, 15 May 2019 08:33:22 +0000 (UTC)
Date:   Wed, 15 May 2019 10:33:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190515083321.GC16651@dhcp22.suse.cz>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
 <20190514145122.GG4683@dhcp22.suse.cz>
 <20190515062523.5ndf7obzfgugilfs@butterfly.localdomain>
 <20190515065311.GB16651@dhcp22.suse.cz>
 <20190515073723.wbr522cpyjfelfav@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515073723.wbr522cpyjfelfav@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-05-19 09:37:23, Oleksandr Natalenko wrote:
[...]
> > This is way too generic. Please provide something more specific. Ideally
> > with numbers. Why those usecases cannot use an existing interfaces.
> > Remember you are trying to add a new user interface which we will have
> > to maintain for ever.
> 
> For my current setup with 2 Firefox instances I get 100 to 200 MiB saved
> for the second instance depending on the amount of tabs.

What does prevent Firefox (an opensource project) to be updated to use
the explicit merging?

[...]

> Answering your question regarding using existing interfaces, since
> there's only one, madvise(2), this requires modifying all the
> applications one wants to de-duplicate. In case of containers with
> arbitrary content or in case of binary-only apps this is pretty hard if
> not impossible to do properly.

OK, this makes more sense. Please note that there are other people who
would like to see certain madvise operations to be done on a remote
process - e.g. to allow external memory management (Android would like
to control memory aging so something like MADV_DONTNEED without loosing
content and more probably) and potentially other madvise operations.
Or maybe we need a completely new interface other than madvise.

In general, having a more generic API that would cover more usecases is
definitely much more preferable than one ad-hoc API that handles a very
specific usecase. So please try to think about a more generic
-- 
Michal Hocko
SUSE Labs
