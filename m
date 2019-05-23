Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD4C282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 04:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48E217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 04:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfr53ssr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfEWEA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 00:00:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53543 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfEWEA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 00:00:58 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so7383412ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 21:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fg4kLqlGmQOQHyxdEvFZw9hI0MF57JuinNfYOlZxse8=;
        b=gfr53ssrCpePDd3o/wOwS15A94lu541xXTe7gLxo4+6lrHONgoP+naUChfz3ms0GaJ
         /J1AODe36vt0rV9YVaPkLeSlW1O3E5lzz1oqVaBZrAibST1H6LtBoxX/d0zNnY681a8B
         sUsZi7JXLRxkvd7Hy1mrRT+09QXS6LTwPG0Rm2wTCro5DsIiRLYyYBvVdefcI9TCMGUv
         RA+//daunEjTIUMei4thpisJVFtHEnu1Nd69wb04U/iTB6uHW3W1/6PzgwGOQcYYNEdF
         L6/eNgB1zOJjC13wwtSIEYM2vcVRuM4S1PfIQXQ0rocVfpkP7al2mpDcuWTwoP3+hqYC
         MVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fg4kLqlGmQOQHyxdEvFZw9hI0MF57JuinNfYOlZxse8=;
        b=LqwlxGRp6zqCxtO+o5ys49esmurckZ6sF1jjJE1jFZaP3NIMlH4dx4nlI2P04xsQnt
         AV7lLi1g0rLG3jNpHNHsu1RglAmIIP6HEtxKqQV5otBq2k1jbAa5L+EyIdfkw2vtOQkE
         xHKv4vwbnnxUGRD7//UAAgcWLdjZneXnzX+qPQ8pEVKZEsle3V2UztS199xgiYw8y/b+
         zNb/rxtFnFL4kXH5s1BhhcS7oYMpGYhtrLl+cF3v6eGEIaEMPqEg0Pe5fpA8XfZn2G1w
         2Y/x8QuD+TxDTnhRpAUnLn4RhrLtbCtypKGdeNakHXjdvWDxkOr61VCzexDJsm8h5bC7
         p6+w==
X-Gm-Message-State: APjAAAXiAbZrv+7UxzeTUXQ0iPtWr1/+59umRzpAHkUZogkGMZoxetcO
        Bwn/QbdjwdDUx7SiLPBL432OSPwE0bbKug4NmA==
X-Google-Smtp-Source: APXvYqzf8Aj+YNXtaUpB++OtPPM8aUwvi8nQbv9VFNqU6+qkAwF3cOnghIf2wCuZKJk5A2bx4wRDx3xHHzxKl98iYPs=
X-Received: by 2002:a24:5095:: with SMTP id m143mr11383477itb.68.1558584057383;
 Wed, 22 May 2019 21:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190512054829.11899-1-cai@lca.pw> <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw> <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw> <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
 <20190522111655.GA4374@dhcp22.suse.cz> <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
In-Reply-To: <CAFgQCTuKVif9gPTsbNdAqLGQyQpQ+gC2D1BQT99d0yDYHj4_mA@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 23 May 2019 12:00:46 +0800
Message-ID: <CAFgQCTvKZU1B0e4Bg3hQedMJ4Oq2uiOshnsBQCjKinmrGdKcYg@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA boot
To:     Michal Hocko <mhocko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:58 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Wed, May 22, 2019 at 7:16 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 22-05-19 15:12:16, Pingfan Liu wrote:
> > > On Mon, May 13, 2019 at 11:31 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Mon 13-05-19 11:20:46, Qian Cai wrote:
> > > > > On Mon, 2019-05-13 at 16:04 +0200, Michal Hocko wrote:
> > > > > > On Mon 13-05-19 09:43:59, Qian Cai wrote:
> > > > > > > On Mon, 2019-05-13 at 14:41 +0200, Michal Hocko wrote:
> > > > > > > > On Sun 12-05-19 01:48:29, Qian Cai wrote:
> > > > > > > > > The linux-next commit ("x86, numa: always initialize all possible
> > > > > > > > > nodes") introduced a crash below during boot for systems with a
> > > > > > > > > memory-less node. This is due to CPUs that get onlined during SMP boot,
> > > > > > > > > but that onlining triggers a page fault in bus_add_device() during
> > > > > > > > > device registration:
> > > > > > > > >
> > > > > > > > >       error = sysfs_create_link(&bus->p->devices_kset->kobj,
> > > > > > > > >
> > > > > > > > > bus->p is NULL. That "p" is the subsys_private struct, and it should
> > > > > > > > > have been set in,
> > > > > > > > >
> > > > > > > > >       postcore_initcall(register_node_type);
> > > > > > > > >
> > > > > > > > > but that happens in do_basic_setup() after smp_init().
> > > > > > > > >
> > > > > > > > > The old code had set this node online via alloc_node_data(), so when it
> > > > > > > > > came time to do_cpu_up() -> try_online_node(), the node was already up
> > > > > > > > > and nothing happened.
> > > > > > > > >
> > > > > > > > > Now, it attempts to online the node, which registers the node with
> > > > > > > > > sysfs, but that can't happen before the 'node' subsystem is registered.
> > > > > > > > >
> > > > > > > > > Since kernel_init() is running by a kernel thread that is in
> > > > > > > > > SYSTEM_SCHEDULING state, fixed this by skipping registering with sysfs
> > > > > > > > > during the early boot in __try_online_node().
> > > > > > > >
> > > > > > > > Relying on SYSTEM_SCHEDULING looks really hackish. Why cannot we simply
> > > > > > > > drop try_online_node from do_cpu_up? Your v2 remark below suggests that
> > > > > > > > we need to call node_set_online because something later on depends on
> > > > > > > > that. Btw. why do we even allocate a pgdat from this path? This looks
> > > > > > > > really messy.
> > > > > > >
> > > > > > > See the commit cf23422b9d76 ("cpu/mem hotplug: enable CPUs online before
> > > > > > > local
> > > > > > > memory online")
> > > > > > >
> > > > > > > It looks like try_online_node() in do_cpu_up() is needed for memory hotplug
> > > > > > > which is to put its node online if offlined and then hotadd_new_pgdat()
> > > > > > > calls
> > > > > > > build_all_zonelists() to initialize the zone list.
> > > > > >
> > > > > > Well, do we still have to followthe logic that the above (unreviewed)
> > > > > > commit has established? The hotplug code in general made a lot of ad-hoc
> > > > > > design decisions which had to be revisited over time. If we are not
> > > > > > allocating pgdats for newly added memory then we should really make sure
> > > > > > to do so at a proper time and hook. I am not sure about CPU vs. memory
> > > > > > init ordering but even then I would really prefer if we could make the
> > > > > > init less obscure and _documented_.
> > > > >
> > > > > I don't know, but I think it is a good idea to keep the existing logic rather
> > > > > than do a big surgery
> > > >
> > > > Adding more hacks just doesn't make the situation any better.
> > > >
> > > > > unless someone is able to confirm it is not breaking NUMA
> > > > > node physical hotplug.
> > > >
> > > > I have a machine to test whole node offline. I am just busy to prepare a
> > > > patch myself. I can have it tested though.
> > > >
> > > I think the definition of "node online" is worth of rethinking. Before
> > > patch "x86, numa: always initialize all possible nodes", online means
> > > either cpu or memory present. After this patch, only node owing memory
> > > as present.
> > >
> > > In the commit log, I think the change's motivation should be "Not to
> > > mention that it doesn't really make much sense to consider an empty
> > > node as online because we just consider this node whenever we want to
> > > iterate nodes to use and empty node is obviously not the best
> > > candidate."
> > >
> > > But in fact, we already have for_each_node_state(nid, N_MEMORY) to
> > > cover this purpose.
> >
> > I do not really think we want to spread N_MEMORY outside of the core MM.
> > It is quite confusing IMHO.
> > .
> But it has already like this. Just git grep N_MEMORY.
>
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
>
> > > By keeping the node owning cpu as online, Michal's patch can avoid
> > > such corner case and keep things easy. Furthermore, if needed, the
> > > other patch can use for_each_node_state(nid, N_MEMORY) to replace
> > > for_each_online_node is some space.
> >
> > Ideally no code outside of the core MM should care about what kind of
> > memory does the node really own. The external code should only care
> > whether the node is online and thus usable or offline and of no
> > interest.
> Yes, but maybe it will pay great effort on it.
>
And as a first step, we can find a way to fix the bug reported by me
and the one reported by Barret

> Regards,
> Pingfan
> > --
> > Michal Hocko
> > SUSE Labs
