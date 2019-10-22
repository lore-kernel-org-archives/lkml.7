Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890892084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Spb7gnPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfJVJDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:03:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52346 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbfJVJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:03:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so16281288wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bp2iOqaf9LPVHmd5HtUEKhnME9NictImQqdOY1hvOdI=;
        b=Spb7gnPOh/cAOxG1U92VtTvGpsT5DcIlqrJ9yqPaIBmxv/n9o1y/v19mWsGxjqxcL6
         1TLEywnSmEHxzMXd8+XFgGI0eVMkNfIQlXJrbSWkHTb13ztm3k6mGwC8LilKr2v1+ViV
         lOwFeYc1mC60fsR1rl4syq2Mo/gaZtKYOQ26BMfmKF/qEXTybt/1NQi4cGjDzjtycuLg
         2uGpLeF7gLodwoinb+Jqhv5rAGrwvCUmu7Axc8bH5W0sqdo1pyrIYKT/3ShKMjeF6o0b
         YNA99P9KBjZsCHitc27jelTJpaOoenBJKHHoC6rGxPmjcAgeo7GoRXhiI4TpgB+hsD+6
         Ha9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bp2iOqaf9LPVHmd5HtUEKhnME9NictImQqdOY1hvOdI=;
        b=qviy0h0bEJxqYTjf6zO3Z/b3GvBvcxb+v0NAa6kEi8pevVDDjGCtTwkp1HdGJssHUu
         CVMEsNo+0BNrvEyKNo0UL1fTBABmMzv5kbG2GKHMyBHXmXaXo1z7ioz2fI3ktM8AGW4o
         WiJ+m7xj7NW5REWDnknDZAKrCQzpVRuT1coRWjBPiFOCjgW6hSwGe0IWOO3bBXfhoSkR
         xk+E07JjFqXJNsb7SZkTFBx4vqW8++8Qq9VbOwUKaSseaNPavzEJZtk8e0sQs9jgpzcB
         dINN7F+fF+QADoDWpN0ioWKyRje75Jd1wAJGWG6tkwijCRPkEaGfWpPbz996QPUV5oTq
         +1jA==
X-Gm-Message-State: APjAAAVDAnE8pCGYP8hPPJETq/Rvky51TmoDYD5w373QsoAUJnUDG2pv
        cU7DTRjifSf/wsF1w/esrzgVlg==
X-Google-Smtp-Source: APXvYqyw9GLgafAr7b7jxha9hToYSLa/qh0xyou4SsblzD8qtjz/PBsxdlpjridA1UHb20PNIgDoYQ==
X-Received: by 2002:a05:600c:2387:: with SMTP id m7mr1908871wma.137.1571735018347;
        Tue, 22 Oct 2019 02:03:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id g184sm10890549wma.8.2019.10.22.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:03:37 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:03:34 +0100
From:   Quentin Perret <qperret@google.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        daniel.lezcano@linaro.org, kernel-team@android.com
Subject: Re: [Patch v3 7/7] sched: thermal: Enable tuning of decay period
Message-ID: <20191022090334.GA85349@google.com>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
 <1571014705-19646-8-git-send-email-thara.gopinath@linaro.org>
 <20191015101452.GA237548@google.com>
 <5DAE1D3C.4090008@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DAE1D3C.4090008@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Monday 21 Oct 2019 at 17:03:56 (-0400), Thara Gopinath wrote:
> On 10/15/2019 06:14 AM, Quentin Perret wrote:
> > Hi Thara,
> > 
> > On Sunday 13 Oct 2019 at 20:58:25 (-0400), Thara Gopinath wrote:
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> index 00fcea2..5056c08 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -376,6 +376,13 @@ static struct ctl_table kern_table[] = {
> >>  		.mode		= 0644,
> >>  		.proc_handler	= proc_dointvec,
> >>  	},
> >> +	{
> >> +		.procname	= "sched_thermal_decay_coeff",
> >> +		.data		= &sysctl_sched_thermal_decay_coeff,
> >> +		.maxlen		= sizeof(unsigned int),
> >> +		.mode		= 0644,
> >> +		.proc_handler	= proc_dointvec,
> > 
> > Perhaps change this for 'sched_proc_update_handler' with min and max
> > values ? Otherwise userspace is allowed to write nonsensical values
> > here. And since sysctl_sched_thermal_decay_coeff is used to shift, this
> > can lead to an undefined behaviour.
> Will do
> > 
> > Also, could we take this sysctl out of SCHED_DEBUG ? I expect this to be
> > used/tuned on production devices where SCHED_DEBUG should theoretically
> > be off.
> 
> I will take it out of SCHED_DEBUG. I am wondering if this should be
> a runtime control at all. Because this is a shift this changes the
> accumulating window for the thermal pressure signal. A runtime change
> will not guarantee a clean start of the window. May be I should make
> this a config option.

I'd personally prefer if it wan't a Kconfig option. We'd like to make
Android devices (which are going to use this) work with a Generic Kernel
Image, which means there will be a single config for everyone. But I
expect this knob to be tuned to different values depending on the SoC.

If you really don't want a sysctl, perhaps a cmdline option could work ?

Thanks,
Quentin
