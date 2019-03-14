Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7C52184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5/D2H23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCNKED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:04:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38491 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCNKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:04:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id m2so3635763pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/MoDfOhaWXRaehyHKveslvpP5vSpRnPhv+CQKaRgnU=;
        b=q5/D2H239OGDOF2imYzkeRdcuHnM/e1pJ0iLcsoCtczIP/wXM1vwkhsiNfgjnkW3hY
         H66w08UnxW3m3wkI9DWBJy/fKiF4H+0L7W+Y2WTOPGXnlTB6KQODQCtTYhqpaK2zuclu
         WVVKMTQJeRiOtOh7+JBZwZdeDSUxPbSysWDflY2cT9HMnpoVxmskJfte6SeTCF1yn7zS
         3lEtovAzn5HJN2TB8m/7ephqTF+pjfCiEFi+cXzwZwUh00+lE/39Ix2Yvar+Z/J7Xb8Q
         JsOYdKQwe1v8w9jvnBD9WhLg7SLRGbwRVnZ1cy7r9B9ENXYjTAJPMXfdDnxrGpMoT+1A
         +kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/MoDfOhaWXRaehyHKveslvpP5vSpRnPhv+CQKaRgnU=;
        b=lgntQcy3xTa6rQtrPaRMbdI1WFoiNvjCc8B3v6S7HhocH1sqWxMpHZZk1gJbG2zjkA
         tETc34g4KzIUHHhwjA6GmynDI0VNsdCdY6TTFcVYS8d8022fleJYXC0nQN0HZKxFuYD8
         QWkD4I472P0o+Q6HVMWWPSXAZ9p+Ei+XYOK//XChKW2V6zebFpLPsu8Mi5LQiicUXhjp
         kCMJuSk8HHThbQeiWXQ49AkhPisniAul7Ub478XwrU0+fjPoHxylTAM1c0NATQNrqb9V
         Ga8EF9qgpxN/VloVJgir6q6L/sZ7wPqKrvdewNuXRTt4jTbtnHXmvKv4kWgiW2lu7kGT
         samA==
X-Gm-Message-State: APjAAAVkEP7O/yloiHTCFh3AeRzT6C8ur69zJ7qcc5xBK3yorj7ryf7J
        l61doDBqYq48SIrXMOMivQwWww==
X-Google-Smtp-Source: APXvYqw8VfQeMmMJCXpghYwiyq/XHQdnirN6x9JcEceegJ6jRe4xlSFVeB4efUTXY8vDFwAdZ+Wr6g==
X-Received: by 2002:aa7:8c13:: with SMTP id c19mr12115601pfd.247.1552557841697;
        Thu, 14 Mar 2019 03:04:01 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id u18sm32610783pfa.176.2019.03.14.03.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 03:04:00 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:33:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] x86/tsc: Update cpufreq transition notifier to
 handle multiple CPUs
Message-ID: <20190314100358.tpkianohhoxnfsmu@vireshk-i7>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
 <8a27342332bc467242f6ccdb4d4bd4d10f8aa552.1552545525.git.viresh.kumar@linaro.org>
 <CAJZ5v0i=QoToW0WCaL50t0qe5sKSe6J3W+EnFTvYuVCp6MvZDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=QoToW0WCaL50t0qe5sKSe6J3W+EnFTvYuVCp6MvZDA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-19, 10:33, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2019 at 7:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > -               set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
> > +               if (boot_cpu) {
> > +                       boot_cpu_data.loops_per_jiffy = lpj;
> > +               } else {
> > +                       for_each_cpu(cpu, freq->cpus)
> 
> This needs to iterate over policy->cpus or you change the behavior.
> 
> Not that it will matter a lot (x86 in one CPU per policy anyway in the
> vast majority of cases), but it is a change nevertheless.  Moreover,
> I'm not even sure if doing that for offline CPUs makes sense.

Okay.

-- 
viresh
