Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D033AC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAD121902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcMGrPnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfCWMBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:01:06 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41878 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWMBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:01:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id l15so3357597ywe.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OxtWF8GmikN+/3mXH6py7vzZ6KycdJnIWvcyc/DIb6A=;
        b=dcMGrPnSUtoqjxhfLJs7nY564bSfH1rTmJgryZZZc5bjCCq5Zx1v5aT+6No6OV8i0M
         vJVJuveL26qPkVohNXJqTMoht3s4LOryV7lNBKJ2okYblwCXl0BvAQzNh0D3GCeDhsB8
         4bEysLJ36jp8Eh6WMmnPWsjeiowp7KdOrcpgvF8kYMniZbqgdfdnYcuNDmy10kudcNPU
         AWJ3mjaM2hwh070PzYGPhhQKKbjoV49DjAD9BhfK+572drdGJuB+yfuXzMM+O2KGe62Y
         pXxp30PxGobEn2Y+kFZBJyVlkO10iiFmTvX5hEKFS5vXiiHddlb8qEdB29I2FkHVY74I
         HKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OxtWF8GmikN+/3mXH6py7vzZ6KycdJnIWvcyc/DIb6A=;
        b=PvDRt5foW9gefupWZ0nKD2vQfObRK8Lfgz0IDczdCVdvPu2iF1CndxgRF2EEISKy47
         tMgYW9Xj7k+omjQltstMR8mMsyVBnAKJIXzGoolAYG7HeHjv9V5VR1NepFSr1FyOPwPn
         AH8wem3pi7/3SKGJ/1KxmlBqIkzEqcbTQbIEvGbyh3r4wKL1SPddqVmMGAi2Sl02vfPN
         t+HcsSTX9djyL7Y8/5eYYAHR5bz2ka0+oo4hJJ1LS44cNUR334za2v4wt9dZc+kEoDu2
         +sbWV+zg3U3v2dPWr8Mju25EtVEZ/anGC6yBiM4jBgD4ykokMYBCFQu3PcxRAriTK4wK
         FEgg==
X-Gm-Message-State: APjAAAWRMuFG94r9C6mcc1WuK1B6yLnqBr5mrBfsQ2eoNZoJo2Eio+Fr
        hqGZJ4aD+o2cQpRWof855xE=
X-Google-Smtp-Source: APXvYqzn4FMMWily8FQT5LLExBeX86jm+dO3qtpoZvBNUPGdF+z0kvtC/HCmBZOQNLFdDbKu2182AA==
X-Received: by 2002:a0d:c9c2:: with SMTP id l185mr12972134ywd.227.1553342465644;
        Sat, 23 Mar 2019 05:01:05 -0700 (PDT)
Received: from centos-dev.localdomain (pool-173-66-89-81.washdc.fios.verizon.net. [173.66.89.81])
        by smtp.gmail.com with ESMTPSA id g1sm3613882ywf.0.2019.03.23.05.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 05:01:05 -0700 (PDT)
Date:   Sat, 23 Mar 2019 08:00:52 -0400
From:   Ryan Thibodeaux <thibodux@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190323120052.GB11100@centos-dev.localdomain>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
 <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 06:10:16PM -0400, Boris Ostrovsky wrote:
> On 3/22/19 2:29 PM, thibodux@gmail.com wrote:
> > From: Ryan Thibodeaux <ryan.thibodeaux@starlab.io>
> >
> > Add a new command-line option "xen_timer_slop=<INT>" that sets the
> > minimum delta of virtual Xen timers. This commit does not change the
> > default timer slop value for virtual Xen timers.
> >
> > Lowering the timer slop value should improve the accuracy of virtual
> > timers (e.g., better process dispatch latency), but it will likely
> > increase the number of virtual timer interrupts (relative to the
> > original slop setting).
> >
> > The original timer slop value has not changed since the introduction
> > of the Xen-aware Linux kernel code. This commit provides users an
> > opportunity to tune timer performance given the refinements to
> > hardware and the Xen event channel processing. It also mirrors
> > a feature in the Xen hypervisor - the "timer_slop" Xen command line
> > option.
> 
> Is there any data that shows effects of using this new parameter?
> 
> -boris
> 

For our own testing using "cyclictest" from the rt-tests project,
lowering the timer slop helped produce the best test runs, especially
in terms of maximum process dispatch latency (PDL).

Here is the output from one such test that ran overnight. The Xen
timer slop in this case was 10000 or 10 microseconds.

...
[root@slop1 ~]# cset shield -c 3
[root@slop1 ~]# echo ; date ; echo ; \
./rt-tests-1.3/cyclictest -p95 -a3 -t1 -m; echo ; date

Thu Mar 14 19:45:36 UTC 2019

# /dev/cpu_dma_latency set to 0us
policy: fifo: loadavg: 0.00 0.02 0.00 1/91 4260
T: 0 ( 3212) P:95 I:1000 C:57077313 Min: 27 Act: 44 Avg: 43 Max: 145
^C
Fri Mar 15 11:36:53 UTC 2019
...

This test system was configured to use a TSC clocksource, disabled
C states, and lowered the timer slop. I am not claiming the timer
slop change was solely responsible for the best results. In other
testing with the default timer slop setting of 100000 (100
microseconds), the average PDL would run slightly higher, but the
spikes were much higher and more in number, often near the 1000s
and happening multiple times per 10 minutes of testing.

- Ryan
