Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFE3CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9E5206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkO7kkIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfJUI74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:59:56 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40880 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUI74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:59:56 -0400
Received: by mail-ua1-f67.google.com with SMTP id i13so3568782uaq.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkOKxxpsGK/80WlQWwLBXhyhiD8tMwT8+Cgd/zEVlCY=;
        b=gkO7kkILMDe7OJ4KFmrFBHJ2ZE1ERHJD1rmFfjWKt4iYJxpHRjQFsR5YmbgdNoGqlQ
         RdqhZ7g1SOnR99RsgsurMaDeuGuzGcZGnOM6/vbC+m6YDrcDI/s+R8iHEGq/225QMv8S
         BNZ/5z2RSQfjyt6mFh+ARMFUOGF2p256asXG6RXH0R59A4tV+/MZqC6SY5jO4oihmr9y
         1eHwV9hExJcsM7prdU8uLUGv5oQHJxgUqafgwkM7tTOBW915Z5QczaoSas68EUPMrsrG
         gvYdDZ4+MvCf7GPMJbdM09rRUuZAGetP38SPMjYDuyKgnNF4BEXhkJrMAmoTE6trglqn
         IIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkOKxxpsGK/80WlQWwLBXhyhiD8tMwT8+Cgd/zEVlCY=;
        b=iTo9kuwMZji8aq8kjf06EuB4Sz1iwWE90v+7kPYIc0qcKbvlM9N0elFNlDFncZabwx
         kgVCXmjWrglvHJWkXmkWkZUGBOXfx2TKkpFUtAfdZ4wBbe0XSkhwS0oHi1DtGv4eRHU7
         SJA8tMdzTFY3Fgp3pJ7UNwnUHLN+CUCQ4KvGFBFZ1ZC6FoljZ7GjTQ+suGpyM5+SR/m7
         nApabkuZH8AkT18d5MbPSkqOVf1gd7EKg131hpzgg1nleUkftrzndFKSxC5dyQNgjpF3
         8EzZCMfVMBxz2sXTT1BBQv9YE+zPXgpm3eKx9R+dM6GSsIlTVs8NJQ9Rb7UdoXtSdZhG
         WxSg==
X-Gm-Message-State: APjAAAW5fN4BqQ520vPOmrolaW/ltmkKVyKIQb1yuVUSxGH+7D9Suk5O
        U4yLc2xUtNwViAeVI+qffI73VCTS0FHoiaMnsL/xvw==
X-Google-Smtp-Source: APXvYqy1skCw5iA/y67UrQPP3MAZhJ04h3rF2rtlEMmZQVVO3ryPl7j+34VyGLMMcpvzuCqueqM59hhRx1AvMlcjFdo=
X-Received: by 2002:ab0:2015:: with SMTP id v21mr12191265uak.94.1571648394900;
 Mon, 21 Oct 2019 01:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571387352.git.amit.kucheria@linaro.org>
 <66d8ae593ce7936a5f492d0c6855c1ac225b64ee.1571387352.git.amit.kucheria@linaro.org>
 <20191021080811.GA54219@gmail.com>
In-Reply-To: <20191021080811.GA54219@gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 21 Oct 2019 14:29:43 +0530
Message-ID: <CAHLCerOcdnSTppKRm2vi6V8E7vyVWvwDakaQcnXnnDVqKDXmBA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] cpufreq: Initialize cpufreq-dt driver earlier
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 1:38 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> > This allows HW drivers that depend on cpufreq-dt to initialise earlier.
>
> My obsessive-compulsive in-brain spellchecker noticed that the title says
> 'initialize' (US spelling), while the comment uses 'initialise' (UK
> spelling). Just in case this is not some post-Brexit expression of
> cross-Atlantic friendliness you might want to fix it. :)

Naah, its just my confused brain that grew up learning British
English, then spent enough time in US to pick up some of that too. I
think it is a form of selective spelling blindness :-)

Will fix.
