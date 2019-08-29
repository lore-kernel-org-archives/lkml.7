Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C90C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3322173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="StpqtEW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfH2PtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:49:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43868 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfH2PtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:49:12 -0400
Received: by mail-io1-f65.google.com with SMTP id u185so4048335iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyGoJL/dRu795TDEcF7qp/dcanjpzr2qNIk3nhp4pBA=;
        b=StpqtEW508X1BAwN4TV2B06Gk399USwcufzfm6cs9+YDIuN7iPLyOlccmxmNFc/yCh
         ZEPUF1HcAZMN0/cwMSjtAjdXeWAfysvaNO14b6mDvHuM4HBTcrIgwUHkEVd8mXufZRre
         IPv+OJxVArIAvk60HYTsBaOsmdwTSD3XLDL1rhXEkbQFih2sbJev70mo2jIBgaSP0+Yw
         0yO03gN4FSKrzqktA0SkiwrCvGk9eWwKapxu2cp0suc61Vrl9GXvreNjZdTqGywFPWTw
         w6D+lJLUVjugy7NX0A0xoa19EPP0IdrhUOmMQdfM8F0I69nWJEe5gKew5LRSnNrHtXHC
         9Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyGoJL/dRu795TDEcF7qp/dcanjpzr2qNIk3nhp4pBA=;
        b=eh9QCoyHEJDeDU/gKt+znC3npRTAgYZpwSeozqGq+0hzM3ZrtvFR7AuyE4xDJOfwjH
         305Q0Cn8ZG8ochIFGPKWpoFG4LB8za2x+3pC+Re2XmcLHGroZmBzJJS3Z70cHhpAy+w4
         zUlLnB/PMhnwZewsHqmC3dXo0jK8mJRnSBo9M3iIohynjlD72nEPg4MAT0VTaZ9X2hv+
         tD4jSb51utU7cIwAH9mHUnFg92D9MpwKZ1se5EvC2smFXqT7JtsEW8IGnMI1hIQQcjgh
         TUSimeMFLJ8FNpXjawcJaZXHdT/HUvlvDtXZU9638MPUUc876ceBkzH7F3PjPHsGoj7Z
         2umA==
X-Gm-Message-State: APjAAAXOFq1w7ujV8VlQDWwxJ5i8CGQ76FkGUcrPmDnuCL9pbP7Rl49t
        MUcYBAMYnOj5Ri9xX4JX+X1NNMvPoTZIYo0U+qxtVA==
X-Google-Smtp-Source: APXvYqyoe4GeHyy6g7dazTKEG1XkpjWSwVk+OLbTlVX8ayxSPwqBIL0bYI9KsIbZHteZekrObzW9+ZgdQuOdF2uGJn0=
X-Received: by 2002:a02:94e5:: with SMTP id x92mr203774jah.11.1567093751491;
 Thu, 29 Aug 2019 08:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190826193638.6638-1-echron@arista.com> <20190827071523.GR7538@dhcp22.suse.cz>
 <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
 <20190828065955.GB7386@dhcp22.suse.cz> <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
 <20190829071105.GQ28313@dhcp22.suse.cz> <297cf049-d92e-f13a-1386-403553d86401@i-love.sakura.ne.jp>
 <20190829115608.GD28313@dhcp22.suse.cz> <a8979b50-b8db-55c1-996b-6d86736513f5@i-love.sakura.ne.jp>
In-Reply-To: <a8979b50-b8db-55c1-996b-6d86736513f5@i-love.sakura.ne.jp>
From:   Edward Chron <echron@arista.com>
Date:   Thu, 29 Aug 2019 08:48:59 -0700
Message-ID: <CAM3twVR_9CgQvqpjVn6TZ0Xq3==eR_KkfMsBO1gLWarbYNtfmQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional information
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
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

On Thu, Aug 29, 2019 at 7:09 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/08/29 20:56, Michal Hocko wrote:
> >> But please be aware that, I REPEAT AGAIN, I don't think neither eBPF nor
> >> SystemTap will be suitable for dumping OOM information. OOM situation means
> >> that even single page fault event cannot complete, and temporary memory
> >> allocation for reading from kernel or writing to files cannot complete.
> >
> > And I repeat that no such reporting is going to write to files. This is
> > an OOM path afterall.
>
> The process who fetches from e.g. eBPF event cannot involve page fault.
> The front-end for iovisor/bcc is a python userspace process. But I think
> that such process can't run under OOM situation.
>
> >
> >> Therefore, we will need to hold all information in kernel memory (without
> >> allocating any memory when OOM event happened). Dynamic hooks could hold
> >> a few lines of output, but not all lines we want. The only possible buffer
> >> which is preallocated and large enough would be printk()'s buffer. Thus,
> >> I believe that we will have to use printk() in order to dump OOM information.
> >> At that point,
> >
> > Yes, this is what I've had in mind.
>
> Probably I incorrectly shortcut.
>
> Dynamic hooks could hold a few lines of output, but dynamic hooks can not hold
> all lines when dump_tasks() reports 32000+ processes. We have to buffer all output
> in kernel memory because we can't complete even a page fault event triggered by
> the python process monitoring eBPF event (and writing the result to some log file
> or something) while out_of_memory() is in flight.
>
> And "set /proc/sys/vm/oom_dump_tasks to 0" is not the right reaction. What I'm
> saying is "we won't be able to hold output from dump_tasks() if output from
> dump_tasks() goes to buffer preallocated for dynamic hooks". We have to find
> a way that can handle the worst case.

With the patch series we sent the addition of vmalloc entries print
required us to
add a small piece of code to vmalloc.c but we thought this should be core
OOM Reporting function. However you want to limit which vmalloc entries you
print, probably only very large memory users. For us this generates just a few
entries and has proven useful.

The changes to limit how many processes get printed so you don't have the all
or nothing would be nice to have. It would be easiest if there was a standard
mechanism to specify which entries to print, probably by a minimum size which
is what we did. We used debugfs to set the controls but sysctl or some other
mechanism could be used.

The rest of what we did might be implemented with hooks as they only output
a line or two and I've already got rid of information we had that was
redundant.
