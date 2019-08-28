Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708F820828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566976131;
	bh=CSJOaiEqxPXeIBy9J+uSal3FQ2K+71AZ3fojn1oDoag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zgrIn8fgg/aDEgQ0FYJAWWRomuzYpaHha8MbBsdS/VLni8ZGDWABSrFYg7Zz38Vf8
	 N5oxMoPztTeqy9/p6gE9IVA5/295gMbWN2NJOFqs1/Moa54b1BMsTbAEue1TiXIwu9
	 aZoylOvHg+qFnijhaCTdThSnjhqhyMlKTClASJ/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfH1HIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:08:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:58404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfH1HIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:08:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A944B06B;
        Wed, 28 Aug 2019 07:08:47 +0000 (UTC)
Date:   Wed, 28 Aug 2019 09:08:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
Message-ID: <20190828070845.GC7386@dhcp22.suse.cz>
References: <20190826193638.6638-1-echron@arista.com>
 <1566909632.5576.14.camel@lca.pw>
 <CAM3twVQEMGWMQEC0dduri0JWt3gH6F2YsSqOmk55VQz+CZDVKg@mail.gmail.com>
 <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw>
 <CAM3twVSdxJaEpmWXu2m_F1MxFMB58C6=LWWCDYNn5yT3Ns+0sQ@mail.gmail.com>
 <2A1D8FFC-9E9E-4D86-9A0E-28F8263CC508@lca.pw>
 <CAM3twVR5TVuuZSLM2qRJYnkCEKVZmA3XDNREaB+wdKH2Ne9vVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM3twVR5TVuuZSLM2qRJYnkCEKVZmA3XDNREaB+wdKH2Ne9vVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 19:47:22, Edward Chron wrote:
> On Tue, Aug 27, 2019 at 6:32 PM Qian Cai <cai@lca.pw> wrote:
> >
> >
> >
> > > On Aug 27, 2019, at 9:13 PM, Edward Chron <echron@arista.com> wrote:
> > >
> > > On Tue, Aug 27, 2019 at 5:50 PM Qian Cai <cai@lca.pw> wrote:
> > >>
> > >>
> > >>
> > >>> On Aug 27, 2019, at 8:23 PM, Edward Chron <echron@arista.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On Tue, Aug 27, 2019 at 5:40 AM Qian Cai <cai@lca.pw> wrote:
> > >>> On Mon, 2019-08-26 at 12:36 -0700, Edward Chron wrote:
> > >>>> This patch series provides code that works as a debug option through
> > >>>> debugfs to provide additional controls to limit how much information
> > >>>> gets printed when an OOM event occurs and or optionally print additional
> > >>>> information about slab usage, vmalloc allocations, user process memory
> > >>>> usage, the number of processes / tasks and some summary information
> > >>>> about these tasks (number runable, i/o wait), system information
> > >>>> (#CPUs, Kernel Version and other useful state of the system),
> > >>>> ARP and ND Cache entry information.
> > >>>>
> > >>>> Linux OOM can optionally provide a lot of information, what's missing?
> > >>>> ----------------------------------------------------------------------
> > >>>> Linux provides a variety of detailed information when an OOM event occurs
> > >>>> but has limited options to control how much output is produced. The
> > >>>> system related information is produced unconditionally and limited per
> > >>>> user process information is produced as a default enabled option. The
> > >>>> per user process information may be disabled.
> > >>>>
> > >>>> Slab usage information was recently added and is output only if slab
> > >>>> usage exceeds user memory usage.
> > >>>>
> > >>>> Many OOM events are due to user application memory usage sometimes in
> > >>>> combination with the use of kernel resource usage that exceeds what is
> > >>>> expected memory usage. Detailed information about how memory was being
> > >>>> used when the event occurred may be required to identify the root cause
> > >>>> of the OOM event.
> > >>>>
> > >>>> However, some environments are very large and printing all of the
> > >>>> information about processes, slabs and or vmalloc allocations may
> > >>>> not be feasible. For other environments printing as much information
> > >>>> about these as possible may be needed to root cause OOM events.
> > >>>>
> > >>>
> > >>> For more in-depth analysis of OOM events, people could use kdump to save a
> > >>> vmcore by setting "panic_on_oom", and then use the crash utility to analysis the
> > >>> vmcore which contains pretty much all the information you need.
> > >>>
> > >>> Certainly, this is the ideal. A full system dump would give you the maximum amount of
> > >>> information.
> > >>>
> > >>> Unfortunately some environments may lack space to store the dump,
> > >>
> > >> Kdump usually also support dumping to a remote target via NFS, SSH etc
> > >>
> > >>> let alone the time to dump the storage contents and restart the system. Some
> > >>
> > >> There is also “makedumpfile” that could compress and filter unwanted memory to reduce
> > >> the vmcore size and speed up the dumping process by utilizing multi-threads.
> > >>
> > >>> systems can take many minutes to fully boot up, to reset and reinitialize all the
> > >>> devices. So unfortunately this is not always an option, and we need an OOM Report.
> > >>
> > >> I am not sure how the system needs some minutes to reboot would be relevant  for the
> > >> discussion here. The idea is to save a vmcore and it can be analyzed offline even on
> > >> another system as long as it having a matching “vmlinux.".
> > >>
> > >>
> > >
> > > If selecting a dump on an OOM event doesn't reboot the system and if
> > > it runs fast enough such
> > > that it doesn't slow processing enough to appreciably effect the
> > > system's responsiveness then
> > > then it would be ideal solution. For some it would be over kill but
> > > since it is an option it is a
> > > choice to consider or not.
> >
> > It sounds like you are looking for more of this,
> 
> If you want to supplement the OOM Report and keep the information
> together than you could use EBPF to do that. If that really is the
> preference it might make sense to put the entire report as an EBPF
> script than you can modify the script however you choose. That would
> be very flexible. You can change your configuration on the fly. As
> long as it has access to everything you need it should work.
> 
> Michal would know what direction OOM is headed and if he thinks that fits with
> where things are headed.

It seems we have landed in the similar thinking here. As mentioned in my
earlier email in this thread I can see the extensibility to be achieved
by eBPF. Essentially we would have a base form of the oom report like
now and scripts would then hook in there to provide whatever a specific
usecase needs. My practical experience with eBPF is close to zero so I
have no idea how that would actually work out though.

[...]
> For production systems installing and updating EBPF scripts may someday
> be very common, but I wonder how data center managers feel about it now?
> Developers are very excited about it and it is a very powerful tool but can I
> get permission to add or replace an existing EBPF on production systems?

I am not sure I understand. There must be somebody trusted to take care
of systems, right?
-- 
Michal Hocko
SUSE Labs
