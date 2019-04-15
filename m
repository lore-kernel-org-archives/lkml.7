Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E6DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBAE2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555328916;
	bh=SpeobVWB2QsYqn/FmtnInJKobU60wZglh1sCEizkgRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xdgX7lN/51znW9osHdp19k4INQgpiM9K8xBbKa40w8Y2QLDdNERVamI3HoZkdl5dD
	 seAG3TSPnBzDYrMLVH07aGFnVfGO57vzEDP0liecxZ2baKJgnrEcz+GEYwBSPwLA7H
	 PLJmAfk5fcHjnLi10Xu/NF0yyYXqi4DD5RDiQBiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfDOLse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:48:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfDOLse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:48:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37C77AE8B;
        Mon, 15 Apr 2019 11:48:33 +0000 (UTC)
Date:   Mon, 15 Apr 2019 13:48:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        mgorman@techsingularity.net, Vlastimil Babka <vbabka@suse.cz>,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20190415114832.GK3366@dhcp22.suse.cz>
References: <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <20181205204034.GB11899@redhat.com>
 <CAHk-=whi8Ju-cTDL4cYtwuLA7BYgGJYyy6HVMoknZaLHnRc83g@mail.gmail.com>
 <20181205233632.GE11899@redhat.com>
 <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com>
 <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com>
 <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-12-18 15:43:26, David Rientjes wrote:
> On Wed, 5 Dec 2018, Linus Torvalds wrote:
> 
> > > Ok, I've applied David's latest patch.
> > >
> > > I'm not at all objecting to tweaking this further, I just didn't want
> > > to have this regression stand.
> > 
> > Hmm. Can somebody (David?) also perhaps try to state what the
> > different latency impacts end up being? I suspect it's been mentioned
> > several times during the argument, but it would be nice to have a
> > "going forward, this is what I care about" kind of setup for good
> > default behavior.
> > 
> 
> I'm in the process of writing a more complete test case for this but I 
> benchmarked a few platforms based solely on remote hugepages vs local 
> small pages vs remote hugepages.  My previous numbers were based on data 
> from actual workloads.

Has this materialized into anything we can use? We plan to discuss this
particular topic at the LSFMM this year and it would be great to have
something to play with.

I am quite nervious that we have left quite a common case with a
bad performance based on a complain that we cannot really reproduce
so it is really hard to move on.
-- 
Michal Hocko
SUSE Labs
