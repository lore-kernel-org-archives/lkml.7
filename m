Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6731420C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 04:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kL9lyAAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfHFEKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 00:10:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32919 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfHFEKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 00:10:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so37209091plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 21:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7f2EvO5gb/gF1pHUEiS10k+vqob3KzvKRDpJw7YgyDc=;
        b=kL9lyAApHjKrFWMjvVQgGntfAqj0l3ygD1PGr+eFgyPTwM7LqYSHklBRMk7LrYvQg7
         IxsJY8dERYCkTtqdFsQUeKWmxVE/N/6oYdZx0WsUSObDb228rpNFd1RNpJPfA6h+Yew+
         FHQ6nPQvkX2DcHxn4jErfSEAvZKLFpmLECvOoKAzrhmgx8TjF3dUjIqitmUXcKztOsbx
         6hslncKxYmN+9GQbaAMZcBaxxsaxYOk7mJPZeReuAJJuJ301uSx/av3H+MiD9OUL+Mwt
         HbEmy0ukS5IvRHguPdIfPF6ORQPS0k6RGVTZEgZrbsRhqiEHl86F/+Tva54B5Ldk+QyO
         FIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7f2EvO5gb/gF1pHUEiS10k+vqob3KzvKRDpJw7YgyDc=;
        b=mIBfjbFjWjgAkZA32RZVUj8jj4FPJXaonq2YCCIR6+bfBMRcITkz21RW0H9aEpQQYA
         MSHmJ3/pb+fx1p/VRToS2A1pthVq/viQlh8xIzkgsKUSFLMyQfel0DXxrtO4MwQCcyCn
         wImHCh2N/cY7r3u6P5q3ZtOO9S3wRRCo75zZKFDehF0iARXSL4iBXb+hyRKN+nypmWHA
         xn2QnfKw93mNRhPyLlpMpP4FJPloaTBuYtcUKtjVuh/xkDYObpvtxqxWnr/wX3iTEj/Q
         3I8WyrixnJxQ8foA6h+qRNx9QvVc6pP7/Pq1EeSubd8dNWtPDbSaZAy0+8OBPaAQFDGk
         9aPg==
X-Gm-Message-State: APjAAAXWJ1o6ADzKGqPmVfd4H9cYbnCrEsnCumX5uRPlhyVsGVxpszC5
        m7/+IWg2dUY4k4A1QK0J6ER/BQ==
X-Google-Smtp-Source: APXvYqwEZh6EPRtHwi5fjKhv6XjpkhMidWikuyLXVKSpwNu/hIGcVTqdrS1glwhtaKHn7A4MVlLH+A==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr1152698plo.42.1565064651684;
        Mon, 05 Aug 2019 21:10:51 -0700 (PDT)
Received: from localhost ([122.172.146.3])
        by smtp.gmail.com with ESMTPSA id g4sm100629374pfo.93.2019.08.05.21.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 21:10:50 -0700 (PDT)
Date:   Tue, 6 Aug 2019 09:40:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "v4 . 18+" <stable@vger.kernel.org>,
        Doug Smythies <doug.smythies@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/2] cpufreq: intel_pstate: Implement ->resolve_freq()
Message-ID: <20190806041048.ksqs3l5bzsakaael@vireshk-i7>
References: <7dedb6bd157b8183c693bb578e25e313cf4f451d.1564724511.git.viresh.kumar@linaro.org>
 <23e3dee8688f5a9767635b686bb7a9c0e09a4438.1564724511.git.viresh.kumar@linaro.org>
 <CAJZ5v0iqztRWyxf1cgiAN1dK4qTGwy9raaGOx5u3tfBTGUKOng@mail.gmail.com>
 <2676200.jfxhmTd764@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2676200.jfxhmTd764@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-19, 11:28, Rafael J. Wysocki wrote:
> On Friday, August 2, 2019 11:17:55 AM CEST Rafael J. Wysocki wrote:
> > On Fri, Aug 2, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Intel pstate driver exposes min_perf_pct and max_perf_pct sysfs files,
> > > which can be used to force a limit on the min/max P state of the driver.
> > > Though these files eventually control the min/max frequencies that the
> > > CPUs will run at, they don't make a change to policy->min/max values.
> > 
> > That's correct.
> > 
> > > When the values of these files are changed (in passive mode of the
> > > driver), it leads to calling ->limits() callback of the cpufreq
> > > governors, like schedutil. On a call to it the governors shall
> > > forcefully update the frequency to come within the limits.
> > 
> > OK, so the problem is that it is a bug to invoke the governor's ->limits()
> > callback without updating policy->min/max, because that's what
> > "limits" mean to the governors.
> > 
> > Fair enough.
> 
> AFAICS this can be addressed by adding PM QoS freq limits requests of each CPU to
> intel_pstate in the passive mode such that changing min_perf_pct or max_perf_pct
> will cause these requests to be updated.

Right, that sounds like a good plan.

But that will never make it to the stable kernels as there will be a
long dependency of otherwise unrelated patches to get that done. My
initial thought was to get this patch merged as it is and then later
migrate to QoS, but since this patch doesn't fix ondemand and
conservative, this patch isn't good enough as well.

Maybe we should add the regular notifier based solution first, mark it
for stable kernels, and then add the QoS specific solution ?

-- 
viresh
