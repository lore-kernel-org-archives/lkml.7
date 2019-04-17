Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1434C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD092173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555525779;
	bh=D3wLtJO4BReF9RI7gJO/1Q+VPisxYCVIWO4OWEkFdlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=THuswgtggWPKD77SMVSu7o2PRdY9RiIDkp0PGIRiLW7bmI2usGkhs+e25GoPes6NA
	 FZDcnXrM4jLHirSv7XABeXxc2171ptVuZxMzXGHqJ8QOft/eSW6mJICl2W7yCCeS6/
	 H+MuHviF2/WmR/GFRqspW0w5nL92tkRBZ8gdrPN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfDQS3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:29:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44678 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbfDQS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:29:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so3105632wrv.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwVBL4kWuFln1ORwazUUMUmKQZg4gxsY+OMTK6S6/ig=;
        b=iBIyPB0PimRV7hc9ZuvpCiTman37YmffyWA7FxV10EjPEGmM4livSxPsCzw1w6LUhL
         20TrRKvWCI0P6nONQX3nC/G2sWnOC8c9LE8G8rLBlCqp3xnpC0GVtPvRbLV80Mwm9vOS
         O0i7tV7DD/HEJ47O0ra0Tq/YgBAk++RFtqga9aHi9ElweQsXRH0jOP8+erfL3P7BAfmH
         55SpxpgqVvtWhPBswdCEVfO13LX/rQxQSKdj3xQf9LNoFWk2kMjcfYIudcszy2FQDgiI
         IIHN+Fa7kmPcIM6Jb+3N837qPG0IkxTGAr9cUMBmSCtggHlHE0ZPWqgcu6N5Nb6YpU65
         AFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwVBL4kWuFln1ORwazUUMUmKQZg4gxsY+OMTK6S6/ig=;
        b=Co9ZTBy/zXhD5YRN3hEHyBny8IOqDL+MFltwG/AWEvf9IHAWB6DVcbPTQTfTLBFc1X
         YzP7aNPznngo3E2UeaH5uy4VbEWklnpjQ/aeGi1gMHH8oQcXN6G1Kn3HQ+FpFGl7y54a
         o8BguIYZD9+OYhuuNDpdPOCRqX638/NDuGZtWbA1vEsOOSrueOifPqQY3ZDf2Tj3P6d9
         UTEc5QRG7iEf6eK3YwqOFjnxqnhfOMci2KROInkrb3ESDBTxPJfYdHaPcIjBnQQc4AgO
         KDhPGD+yYz8aki2LVrUXTMJmxGVjVDQEqT12qaHgfm8t/n5aG9qQWpSm7mmp4dUL1OiL
         /xKw==
X-Gm-Message-State: APjAAAUHDwP5rGjQHXVbX7pmOmy/Nv1S6s7A7ZbLMmKIbAwmht0/ZIGK
        1rmuyFB6aV9sNcVicafpUrSvAqBU
X-Google-Smtp-Source: APXvYqyGQCfuKhiHlrrcJ+CCkS1JMcF4jna5843rMSkTTeuvm5KCL7XXWYsgYBcjDiVcHGDwjhEVXw==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr857857wrm.325.1555525776250;
        Wed, 17 Apr 2019 11:29:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w10sm39466529wrv.8.2019.04.17.11.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 11:29:35 -0700 (PDT)
Date:   Wed, 17 Apr 2019 20:29:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
Message-ID: <20190417182932.GB5140@gmail.com>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <20190417053626.GA47282@gmail.com>
 <5CB75FD9.3070207@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CB75FD9.3070207@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thara Gopinath <thara.gopinath@linaro.org> wrote:

> 
> On 04/17/2019 01:36 AM, Ingo Molnar wrote:
> > 
> > * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> > 
> >> The test results below shows 3-5% improvement in performance when
> >> using the third solution compared to the default system today where
> >> scheduler is unware of cpu capacity limitations due to thermal events.
> > 
> > The numbers look very promising!
> 
> Hello Ingo,
> Thank you for the review.
> > 
> > I've rearranged the results to make the performance properties of the 
> > various approaches and parameters easier to see:
> > 
> >                                          (seconds, lower is better)
> > 
> > 			                 Hackbench   Aobench   Dhrystone
> >                                          =========   =======   =========
> > Vanilla kernel (No Thermal Pressure)         10.21    141.58        1.14
> > Instantaneous thermal pressure               10.16    141.63        1.15
> > Thermal Pressure Averaging:
> >       - PELT fmwk                             9.88    134.48        1.19
> >       - non-PELT Algo. Decay : 500 ms         9.94    133.62        1.09
> >       - non-PELT Algo. Decay : 250 ms         7.52    137.22        1.012
> >       - non-PELT Algo. Decay : 125 ms         9.87    137.55        1.12
> > 
> > 
> > Firstly, a couple of questions about the numbers:
> > 
> >    1)
> > 
> >       Is the 1.012 result for "non-PELT 250 msecs Dhrystone" really 1.012?
> >       You reported it as:
> > 
> >              non-PELT Algo. Decay : 250 ms   1.012                   7.02%
> 
> It is indeed 1.012. So, I ran the "non-PELT Algo 250 ms" benchmarks
> multiple time because of the anomalies noticed.  1.012 is a formatting
> error on my part when I copy pasted the results into a google sheet I am
> maintaining to capture the test results. Sorry about the confusion.

That's actually pretty good, because it suggests a 35% and 15% 
improvement over the vanilla kernel - which is very good for such 
CPU-bound workloads.

Not that 5% is bad in itself - but 15% is better ;-)

> Regarding the decay period, I agree that more testing can be done. I 
> like your suggestions below and I am going to try implementing them 
> sometime next week. Once I have some solid results, I will send them 
> out.

Thanks!

> My concern regarding getting hung up too much on decay period is that I 
> think it could vary from SoC to SoC depending on the type and number of 
> cores and thermal characteristics. So I was thinking eventually the 
> decay period should be configurable via a config option or by any other 
> means. Testing on different systems will definitely help and maybe I am 
> wrong and there is no much variation between systems.

Absolutely, so I'd not be against keeping it a SCHED_DEBUG tunable or so, 
until there's a better understanding of how the physical properties of 
the SoC map to an ideal decay period.

Assuming PeterZ & Rafael & Quentin doesn't hate the whole thermal load 
tracking approach. I suppose there's some connection of this to Energy 
Aware Scheduling? Or not ...

Thanks,

	Ingo
