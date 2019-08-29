Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F732C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404DD2073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dHNY39JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfH2QKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:10:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42677 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2QKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:10:02 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so6031982iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwrlLrsYCg5BNMxf+0gmxWY4/BokA4zfyVbGCkQeI20=;
        b=dHNY39JIAv4t/hard4v9AztwnWA3PiH3lqadNodm7DwVtoWszKezFxaD2nfGVJkrtV
         ruGnUOV1UOaaC5KZiqrXBTkN1HryCoM0N29dRyt45u3G6BDLTXcxCybflzpryFWWR6A+
         KT2XZp3NdjE2AUA92YZgPVL1hCSU44LfYHW+GaK+Qwgmvfxoxl5GvKbJ/iyMiJ+T9C5Q
         WZCOWe8lV/XNs3mUbOqZpMEEbiLsTfm4yQrSjjxGX3rK8R1Be7eYy4JBChBFjJHUJSsC
         IcwNM4J6F3QHT6UwunNI3po7rDoDYGEK84vxmIxvQIi7/IvHqqLDq6BAItM7/61DWdGx
         yvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwrlLrsYCg5BNMxf+0gmxWY4/BokA4zfyVbGCkQeI20=;
        b=Ncg+tic5gfahHLsHcBKobeeBiyisMpqs2YW1MFGYVGrNYenaZffEIYD1gXnZsd6Aje
         2xKMY+D9y8rYBRVEcj9YbU2sT8nKeRdKtl2cpm+a/tOnYCL4Wjc3nifuBozVY6I45aZ+
         zzJQci93cnhsGY+ww60G9R21uUFQiOpxSXm9+p93g8YWhIbIYybhh4HuG/tTOB+yzSFO
         kDxefECQCE0I0EHO1J57DyI+HqVeX2TZ33cT9XOOBvRE/wxqz4kA0LG+GpGwcg2ZjRqq
         X3iF6DeMyuCUjKjAhEAu09OaG37PW3ykO1ARxXZarVyeVStZFbqq9AXLN0wFjS6DODS6
         dafw==
X-Gm-Message-State: APjAAAWvCFCEaGIiGaWoXrOsNmqPns5EkGBfSI2IH2bkFzyYv5u5gc/A
        Mwe23QZihiw6FB2JtGXgInIuPG+l45eXboubWLRZcQ==
X-Google-Smtp-Source: APXvYqw00zONXIoxTSPo0/DqsFMla6+7PabAPhEpJ4wBv2ftkft7d/nh+nLCW+OpTT/94bfFeK/FfpY/t1jMNiP52So=
X-Received: by 2002:a5d:8591:: with SMTP id f17mr1593524ioj.5.1567095000975;
 Thu, 29 Aug 2019 09:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190826193638.6638-1-echron@arista.com> <20190827071523.GR7538@dhcp22.suse.cz>
 <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
 <20190828065955.GB7386@dhcp22.suse.cz> <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
 <20190829071105.GQ28313@dhcp22.suse.cz> <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
 <20190829115608.GD28313@dhcp22.suse.cz> <CAM3twVSZm69U8Sg+VxQ67DeycHUMC5C3_f2EpND4_LC4UHx7BA@mail.gmail.com>
 <1567093344.5576.23.camel@lca.pw>
In-Reply-To: <1567093344.5576.23.camel@lca.pw>
From:   Edward Chron <echron@arista.com>
Date:   Thu, 29 Aug 2019 09:09:48 -0700
Message-ID: <CAM3twVSgJdFKbzkg1V+7voFMi-SYQTCz6jCBobLBQ72Cg8k5VQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional information
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 8:42 AM Qian Cai <cai@lca.pw> wrote:
>
> On Thu, 2019-08-29 at 08:03 -0700, Edward Chron wrote:
> > On Thu, Aug 29, 2019 at 4:56 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 29-08-19 19:14:46, Tetsuo Handa wrote:
> > > > On 2019/08/29 16:11, Michal Hocko wrote:
> > > > > On Wed 28-08-19 12:46:20, Edward Chron wrote:
> > > > > > Our belief is if you really think eBPF is the preferred mechanism
> > > > > > then move OOM reporting to an eBPF.
> > > > >
> > > > > I've said that all this additional information has to be dynamically
> > > > > extensible rather than a part of the core kernel. Whether eBPF is the
> > > > > suitable tool, I do not know. I haven't explored that. There are other
> > > > > ways to inject code to the kernel. systemtap/kprobes, kernel modules and
> > > > > probably others.
> > > >
> > > > As for SystemTap, guru mode (an expert mode which disables protection
> > > > provided
> > > > by SystemTap; allowing kernel to crash when something went wrong) could be
> > > > used
> > > > for holding spinlock. However, as far as I know, holding mutex (or doing
> > > > any
> > > > operation that might sleep) from such dynamic hooks is not allowed. Also
> > > > we will
> > > > need to export various symbols in order to allow access from such dynamic
> > > > hooks.
> > >
> > > This is the oom path and it should better not use any sleeping locks in
> > > the first place.
> > >
> > > > I'm not familiar with eBPF, but I guess that eBPF is similar.
> > > >
> > > > But please be aware that, I REPEAT AGAIN, I don't think neither eBPF nor
> > > > SystemTap will be suitable for dumping OOM information. OOM situation
> > > > means
> > > > that even single page fault event cannot complete, and temporary memory
> > > > allocation for reading from kernel or writing to files cannot complete.
> > >
> > > And I repeat that no such reporting is going to write to files. This is
> > > an OOM path afterall.
> > >
> > > > Therefore, we will need to hold all information in kernel memory (without
> > > > allocating any memory when OOM event happened). Dynamic hooks could hold
> > > > a few lines of output, but not all lines we want. The only possible buffer
> > > > which is preallocated and large enough would be printk()'s buffer. Thus,
> > > > I believe that we will have to use printk() in order to dump OOM
> > > > information.
> > > > At that point,
> > >
> > > Yes, this is what I've had in mind.
> > >
> >
> > +1: It makes sense to keep the report going to the dmesg to persist.
> > That is where it has always gone and there is no reason to change.
> > You can have several OOMs back to back and you'd like to retain the output.
> > All the information should be kept together in the OOM report.
> >
> > > >
> > > >   static bool (*oom_handler)(struct oom_control *oc) = default_oom_killer;
> > > >
> > > >   bool out_of_memory(struct oom_control *oc)
> > > >   {
> > > >           return oom_handler(oc);
> > > >   }
> > > >
> > > > and let in-tree kernel modules override current OOM killer would be
> > > > the only practical choice (if we refuse adding many knobs).
> > >
> > > Or simply provide a hook with the oom_control to be called to report
> > > without replacing the whole oom killer behavior. That is not necessary.
> >
> > For very simple addition, to add a line of output this works.
> > It would still be nice to address the fact the existing OOM Report prints
> > all of the user processes or none. It would be nice to add some control
> > for that. That's what we did.
>
> Feel like you are going in circles to "sell" without any new information. If you
> need to deal with OOM that often, it might also worth working with FB on oomd.
>
> https://github.com/facebookincubator/oomd
>
> It is well-known that kernel OOM could be slow and painful to deal with, so I
> don't buy-in the argument that kernel OOM recover is better/faster than a kdump
> reboot.
>
> It is not unusual that when the system is triggering a kernel OOM, it is almost
> trashed/dead. Although developers are working hard to improve the recovery after
> OOM, there are still many error-paths that are not going to survive which would
> leak memories, introduce undefined behaviors, corrupt memory etc.

But as you have pointed out many people are happy with current OOM processing
which is the report and recovery so for those people a kdump reboot is overkill.
Making the OOM report at least optionally a bit more informative has value. Also
making sure it doesn't produce excessive output is desirable.

I do agree for developers having to have all the system state a kdump
provides that
and as long as you can reproduce the OOM event that works well. But
that is not the
common case as has already been discussed.

Also, OOM events that are due to kernel bugs could leak memory and over time
and cause a crash, true. But that is not what we typically see. In
fact we've had
customers come back and report issues on systems that have been in continuous
operation for years. No point in crashing their system. Linux if
properly maintained
is thankfully quite stable. But OOMs do happen and root causing them to prevent
future occurrences is desired.
