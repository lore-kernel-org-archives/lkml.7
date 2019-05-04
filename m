Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD3C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3152075E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556931022;
	bh=MM3NOmVCz1xRVAPGR+BO0vxpdhPxpsI1uVGkFEMG4jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lYNnGmcvGb28RZ/AftDCMT/6kcfdMQ8wU2piWi/JoydU/npcoda8A48h6mgq8TWYp
	 VWAhqzcJqX6JfPu+7GZklFZ1b6TzdC9HrXytlVNKdJFlNXucapAjlAxmE1yCH53P7d
	 11wAIMgP6R/HxvxISv8372dxr9eP+TcsRpyO3YHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEDAuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 20:50:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35445 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfEDAuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:50:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so8543283wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tGIpyHh66ISLnP9KLegCkli4scoOI6Fnu3GjehQgDl8=;
        b=IE6UhRY1pPuvWnH3xnrZtGNsqcaedvt0I8FQ2FRycRtPXTr0R4/fdfjyhM9p3Ae3le
         O4rqAxjVI46PREipkQ+lCLwAvU6vmeoEGU2wjMF7wEAbJNC1Jbmv3sVOWnQS8tOOubEU
         UVRrLT/Ws2OcQeza8YwnxmSICAB3/Rq+oNINxSUAGistlHIEJIHIwfE7kxYnnl/y0Zoe
         hez4/hyfEHFfEB7RlPFN1JrUc64PQ7L/xrBWVD3pkzgyE3tbCThWBgXjWXrCONev0MGY
         xGsS+o3hluR/a+zcH7CBqfyYr6M8TgWCYqcgldHkcyYeQX6jJWFRnai9VfrTbGKihK4T
         CegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tGIpyHh66ISLnP9KLegCkli4scoOI6Fnu3GjehQgDl8=;
        b=cYwa17VIMBWB2YiOyhRKx+gFKj1q0my/38UPrZVP8C3SdvlcuKyv2DTOViKCu/1qTL
         6UC/klNulYajlFmOYxzCrnA1KzpAVC3vU90JKr5i1LwX9b2eyTWgnsz0ksGrV0AUipri
         /tITJt8QidXcgdmSDV2LHG5MYsVGZ02QLcuKu5xogWvkMpwnNGRX8MrRzh8fuDwa4q8u
         CXHIVX/cFqEQryU9p+3pIvcrwduPGviaAXAV1Mq8c066Z0SIvmyqmYEz0NWgQiwGx32P
         b4HSh6rPuYkKjwv6aq/jcxbkFend2FEH+a27otiuSbsak2caJnj/MoihCyQUhtj4ZgOU
         OGJQ==
X-Gm-Message-State: APjAAAVo3g4imCZyPuVFV6IqAykkHOHf7tCWD3S1YV01kUZOSz+nJSa5
        u75b60EBXgPQ2r6Irp/0il9DReRX
X-Google-Smtp-Source: APXvYqyKFvmF+br5OVCto9o0pgs6tcx1qlgY//9FgKDcY9hx/2CZFXeR/vd78tS0qUPMhiBs2wffFg==
X-Received: by 2002:a1c:e3c4:: with SMTP id a187mr8698370wmh.87.1556931019401;
        Fri, 03 May 2019 17:50:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a17sm3651391wrm.53.2019.05.03.17.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 17:50:18 -0700 (PDT)
Date:   Sat, 4 May 2019 02:50:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
Subject: Re: [tip:sched/core 24/27] kernel/power/suspend.c:431:10: error:
 implicit declaration of function 'suspend_disable_secondary_cpus'
Message-ID: <20190504005016.GA114514@gmail.com>
References: <201905032053.KmG848Ye%lkp@intel.com>
 <20190503160458.GF2606@hirez.programming.kicks-ass.net>
 <1556927451.rwdz1vqk9f.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556927451.rwdz1vqk9f.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicholas Piggin <npiggin@gmail.com> wrote:

> Peter Zijlstra's on May 4, 2019 2:04 am:
> > On Fri, May 03, 2019 at 08:34:57PM +0800, kbuild test robot wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> >> head:   65874bd36e6ae3028539e989bfb5c28ad457368e
> >> commit: c2cb30bfceceba8a2a0d5713230a250dd6140e22 [24/27] power/suspend: Add function to disable secondaries for suspend
> >> config: x86_64-randconfig-l3-05031806 (attached as .config)
> >> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> >> reproduce:
> >>         git checkout c2cb30bfceceba8a2a0d5713230a250dd6140e22
> >>         # save the attached .config to linux build tree
> >>         make ARCH=x86_64 
> >> 
> > 
> > The below appears to fix.
> > 
> > 
> > --- a/include/linux/cpu.h
> > +++ b/include/linux/cpu.h
> > @@ -150,6 +150,8 @@ static inline void suspend_enable_second
> >  #else /* !CONFIG_PM_SLEEP_SMP */
> >  static inline int disable_nonboot_cpus(void) { return 0; }
> >  static inline void enable_nonboot_cpus(void) {}
> > +static inline int suspend_disable_secondary_cpus(void) { return 0; }
> > +static inline void suspend_enable_secondary_cpus(void) { }
> >  #endif /* !CONFIG_PM_SLEEP_SMP */
> >  
> >  void cpu_startup_entry(enum cpuhp_state state);
> > 
> 
> Oops, thanks for that, it looks okay.

I back-merged the fix into tip:sched/core.

For these bits to make it upstream in the merge window which starts in 
two days, Frederic's questions about this patch need to be addressed:

   Re: [tip:sched/core] sched/isolation: Require a present CPU in housekeeping mask

Thanks,

	Ingo
