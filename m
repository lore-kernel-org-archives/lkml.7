Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA2CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C8921D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ig5SOSgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436922AbfJYIvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:51:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39237 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfJYIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:51:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so1106994pgn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8o6EjIfqN25bChdB576+plHQp91qpYydoxPIwoMERx4=;
        b=ig5SOSgvEB3siL/ERQz6j33KrwwKzxL1zUp3xfMb5RU0dPThOC8RlTm44Jrra5oBDo
         gDoq8FmENLk3bGlty1/AZbNnVJk/bCmcoQ+JPZo4FL8oyFbwtQNXi4NAi+iwFUi8MHuY
         cKIfHTDHCl24b+kKXy6K+SFElDlXTwmHj4lEopxpWCVs8DgwS2sKQ7S7lh17HQNz2Nze
         +QP0vWaEekwMRoTJpo2pRA6NbArcLoSNKtFr0ivdXHsSpXZC317WSzljDyRh4SbTshdL
         ywU9VRy42nEuM273qR+BmINlEjy43G7v1mQiMxQHZF/mM0F+r32CLl6tJEbH0VVWRKLH
         ckTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8o6EjIfqN25bChdB576+plHQp91qpYydoxPIwoMERx4=;
        b=bff9U3UcKFNQW+6J/BWduQEn5rnC7pfk3XP0VJsLpGqE0SCGYXbAl1VnM8pFM5p8Ua
         PfyyYWeW0sKfzVgWm8u1xO8I8KC3akpXlhP10hJ9Zy7RryUb7eiSlINH/B9tOqOgIANt
         q0CFa1NT10pV0WKa0SV4hq7hNC3S6FMJ6gIBwzQJ7o9ICziyoAWF5LboP0RKGqyvxkl+
         QaJ9n3IjH+I7iGsjUgusn2VMl4N2uSNWMn2ZBX98ce5rbbBmZc8ABlCCzC1TXV5aOcPy
         vGrhmsIuB4f5DA+sS0s+OzQ5Xm5GcNanFNsZwSaliP3YHHIozFJUD8sUxt1hf/gL3Y0r
         B1yQ==
X-Gm-Message-State: APjAAAWpzegWhlmoqfFAwK5AP7h4sCiaBlphCvHeMJV8gHAWC0xLi/qj
        i444T8UQ1cUP65+oJaKg1+W3Ow==
X-Google-Smtp-Source: APXvYqyeYikLu3j/t2D6AwdxoxPXvX51u7+dkh7OgZVYL/qG+aBDEDqw3nTis5fGL/9ccbruKTJ12g==
X-Received: by 2002:a65:5503:: with SMTP id f3mr2973662pgr.351.1571993495124;
        Fri, 25 Oct 2019 01:51:35 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id f8sm1454698pfn.147.2019.10.25.01.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:51:34 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:21:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: processor: Add QoS requests for all CPUs
Message-ID: <20191025085132.qk6iynyavgvp7wlm@vireshk-i7>
References: <2435090.1mJ0fSsrDY@kreacher>
 <20191025025343.tyihliza45os3e4r@vireshk-i7>
 <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hyAX6zpr+2EzURg7ACmaXhbTAc7mBnr9ep11LkF1EBOg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-19, 10:17, Rafael J. Wysocki wrote:
> On Fri, Oct 25, 2019 at 4:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-10-19, 02:41, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The _PPC change notifications from the platform firmware are per-CPU,
> > > so acpi_processor_ppc_init() needs to add a frequency QoS request
> > > for each CPU covered by a cpufreq policy to take all of them into
> > > account.
> > >
> > > Even though ACPI thermal control of CPUs sets frequency limits
> > > per processor package, it also needs a frequency QoS request for each
> > > CPU in a cpufreq policy in case some of them are taken offline and
> > > the frequency limit needs to be set through the remaining online
> > > ones (this is slightly excessive, because all CPUs covered by one
> > > cpufreq policy will set the same frequency limit through their QoS
> > > requests, but it is not incorrect).
> > >
> > > Modify the code in accordance with the above observations.
> >
> > I am not sure if I understood everything you just said, but I don't
> > see how things can break with the current code we have.
> >
> > Both acpi_thermal_cpufreq_init() and acpi_processor_ppc_init() are
> > called from acpi_processor_notifier() which is registered as a policy
> > notifier and is called when a policy is created or removed. Even if
> > some CPUs of a policy go offline, it won't matter as the request for
> > the policy stays and it will be dropped only when all the CPUs of a
> > policy go offline.
> >
> > What am I missing ?
> 
> The way the request is used.

Yes, I missed the point :)

-- 
viresh
