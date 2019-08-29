Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DA5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FEA2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567079772;
	bh=lva1E11bF7gIIdvbDX4uRFl1/6Rg3Q/AFbBiaubMCVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I6G12nJczYkgeKveUJCtKRCx6r9sm4CohTPK/7AusOUEf/EvSqZPShiHWQIAnYRqE
	 Id6ttzR1RxMj5f7wkZSh+OAdPQ0PyS1GahCMYEsGBgaWR4a/0pKNwM18Yu2fvZG+JE
	 xqvEzR3WzGSvb3+axM8u25XBgUBPtFOx3PMtdL4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfH2L4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:56:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48806 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbfH2L4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:56:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2026AB680;
        Thu, 29 Aug 2019 11:56:09 +0000 (UTC)
Date:   Thu, 29 Aug 2019 13:56:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Edward Chron <echron@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
Message-ID: <20190829115608.GD28313@dhcp22.suse.cz>
References: <20190826193638.6638-1-echron@arista.com>
 <20190827071523.GR7538@dhcp22.suse.cz>
 <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
 <20190828065955.GB7386@dhcp22.suse.cz>
 <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
 <20190829071105.GQ28313@dhcp22.suse.cz>
 <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29-08-19 19:14:46, Tetsuo Handa wrote:
> On 2019/08/29 16:11, Michal Hocko wrote:
> > On Wed 28-08-19 12:46:20, Edward Chron wrote:
> >> Our belief is if you really think eBPF is the preferred mechanism
> >> then move OOM reporting to an eBPF.
> > 
> > I've said that all this additional information has to be dynamically
> > extensible rather than a part of the core kernel. Whether eBPF is the
> > suitable tool, I do not know. I haven't explored that. There are other
> > ways to inject code to the kernel. systemtap/kprobes, kernel modules and
> > probably others.
> 
> As for SystemTap, guru mode (an expert mode which disables protection provided
> by SystemTap; allowing kernel to crash when something went wrong) could be used
> for holding spinlock. However, as far as I know, holding mutex (or doing any
> operation that might sleep) from such dynamic hooks is not allowed. Also we will
> need to export various symbols in order to allow access from such dynamic hooks.

This is the oom path and it should better not use any sleeping locks in
the first place.

> I'm not familiar with eBPF, but I guess that eBPF is similar.
> 
> But please be aware that, I REPEAT AGAIN, I don't think neither eBPF nor
> SystemTap will be suitable for dumping OOM information. OOM situation means
> that even single page fault event cannot complete, and temporary memory
> allocation for reading from kernel or writing to files cannot complete.

And I repeat that no such reporting is going to write to files. This is
an OOM path afterall.

> Therefore, we will need to hold all information in kernel memory (without
> allocating any memory when OOM event happened). Dynamic hooks could hold
> a few lines of output, but not all lines we want. The only possible buffer
> which is preallocated and large enough would be printk()'s buffer. Thus,
> I believe that we will have to use printk() in order to dump OOM information.
> At that point,

Yes, this is what I've had in mind.

> 
>   static bool (*oom_handler)(struct oom_control *oc) = default_oom_killer;
> 
>   bool out_of_memory(struct oom_control *oc)
>   {
>           return oom_handler(oc);
>   }
> 
> and let in-tree kernel modules override current OOM killer would be
> the only practical choice (if we refuse adding many knobs).

Or simply provide a hook with the oom_control to be called to report
without replacing the whole oom killer behavior. That is not necessary.
-- 
Michal Hocko
SUSE Labs
