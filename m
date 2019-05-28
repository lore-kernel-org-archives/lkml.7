Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ABCC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B144020989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559067615;
	bh=SxoqYfaNaJRTdNgPM5E5ZBuEpYoMTnN6R0PyU0t+Fqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0RnQp77/nR6NGz6gc82ZDhn68JvisKueYw1HoOKr9oXqJ3iHRpzkbu4AI2JURBnh5
	 GuLhrdOr5hnfTZGkLMCGXp4zCgZDEjEZlCpjbxpDOTFbzXBKKTBglmdwCwiwynIkv5
	 ghzs6jHpfo1cHvil65RJuENSL2W50yv4JrPG4F0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfE1SUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:20:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfE1SUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:20:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0B88ACBA;
        Tue, 28 May 2019 18:20:12 +0000 (UTC)
Date:   Tue, 28 May 2019 20:20:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190528182011.GG1658@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
 <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw>
 <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw>
 <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz>
 <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for a late reply]

On Thu 23-05-19 11:58:45, Pingfan Liu wrote:
> On Wed, May 22, 2019 at 7:16 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 22-05-19 15:12:16, Pingfan Liu wrote:
[...]
> > > But in fact, we already have for_each_node_state(nid, N_MEMORY) to
> > > cover this purpose.
> >
> > I do not really think we want to spread N_MEMORY outside of the core MM.
> > It is quite confusing IMHO.
> > .
> But it has already like this. Just git grep N_MEMORY.

I might be wrong but I suspect a closer review would reveal that the use
will be inconsistent or dubious so following the existing users is not
the best approach.

> > > Furthermore, changing the definition of online may
> > > break something in the scheduler, e.g. in task_numa_migrate(), where
> > > it calls for_each_online_node.
> >
> > Could you be more specific please? Why should numa balancing consider
> > nodes without any memory?
> >
> As my understanding, the destination cpu can be on a memory less node.
> BTW, there are several functions in the scheduler facing the same
> scenario, task_numa_migrate() is an example.

Even if the destination node is memoryless then any migration would fail
because there is no memory. Anyway I still do not see how using online
node would break anything.

> > > By keeping the node owning cpu as online, Michal's patch can avoid
> > > such corner case and keep things easy. Furthermore, if needed, the
> > > other patch can use for_each_node_state(nid, N_MEMORY) to replace
> > > for_each_online_node is some space.
> >
> > Ideally no code outside of the core MM should care about what kind of
> > memory does the node really own. The external code should only care
> > whether the node is online and thus usable or offline and of no
> > interest.
>
> Yes, but maybe it will pay great effort on it.

Even if that is the case it would be preferable because the current
situation is just not sustainable wrt maintenance cost. It is just too
simple to break the existing logic as this particular report outlines.
-- 
Michal Hocko
SUSE Labs
