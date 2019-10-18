Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D757CA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7D21D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571386755;
	bh=L5utEMECNMvAQoZHT2kbry1GljD+caEkAQpbkAXbPCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dJCnK0xwS2KsDQUF5fLBmTg2F3p9f7NY4CFT0Gufda2QyDTI3cvjzoFnFD9QSsImR
	 C1OjdVfe83vo0XNLB7MO8QNAyhZvaKiy7Zea1feitB+GFV7vpv9E5DhBeorxj6yheP
	 r3hchGU3kuLI7eEaHuBw/zb00tDC7NCarvLX+q6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504964AbfJRITO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:19:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33825 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403773AbfJRITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:19:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id m19so4290967otp.1;
        Fri, 18 Oct 2019 01:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gd2dptEFemqCnbDDjztiv+eSsIblD2kjol/65t8ZD44=;
        b=Hp0dNwnklYwXZxzB/9CHCCqdAEG6Zh8TLfS+9yWSpLZs/Rb1mpcgZxLOoYsPIXIKNo
         +Zf71Fhbr/3ATts8yD3TztGs4I9OHN5xN5uc6iipBrNs0Ksp5ERhv0oG/KJ1Flfo4Sk6
         xaTyHnDZjsanS8bxHkDpwwfaLXJW93KBtrVIWnWXssJDqunDZJFFZvBFKcAr9PAmHyn0
         buO62gmUphUu3oYo2R1MZx+TjggA8tpSFvH9kVQZyLAah8DtOQl1KvRnWOhnOy7gTnvA
         qckPAPk4DPuoTUR9Id5abHLEiQhonJe7HfHVkt/IBo/VDMYWfYNdmq6jAPqxEWGXftBD
         nxvw==
X-Gm-Message-State: APjAAAXhxPC/WzaOZoc8eksQwoLylX8cPYdPU/cr7/cUCfuv7bLw7aox
        ogT9hpK2CY9+nVXHtN/Uo6bHMcGaTrEOSKx4SRA=
X-Google-Smtp-Source: APXvYqwOmS6SenmecXmKvPSWcHZNqDqMqs5Wu19+7WCGhEAtAwUtQhEM7LXZj2EafxGDBUnp42OWKpIhCzXxHuUA8Fc=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr6785780oth.266.1571386752111;
 Fri, 18 Oct 2019 01:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191017163503.30791-1-sudeep.holla@arm.com> <CAJZ5v0gTpK0cJhsWGVvs-=Sbgcia0jz2j5QNYRL+1wOz=2xkJQ@mail.gmail.com>
 <CAJZ5v0h0ioEZqLuaW1jz_8jRuGYZLQS3fbpv9ctyV9ucXb1WiA@mail.gmail.com>
 <20191018055533.GC31836@e107533-lin.cambridge.arm.com> <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <CAJZ5v0h0vY9OBYg-_pR-hu_TJkE0odf5Nnd8qnJc17+8NQo=7w@mail.gmail.com> <20191018080338.vbgnrt3i6epkrx3u@vireshk-i7>
In-Reply-To: <20191018080338.vbgnrt3i6epkrx3u@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 10:19:00 +0200
Message-ID: <CAJZ5v0gctj2QuEgq1Q3hoVbv=krw3ub4wcMt4vZ6=DxdDpVYcQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:03 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-10-19, 09:32, Rafael J. Wysocki wrote:
> > Well, the policy is going away, so the governor has been stopped for
> > it already.  Even if the limit is updated, it will not be used anyway,
> > so why bother with updating it?
>
> The hardware will be programmed to run on that frequency before the
> policy exits,

How exactly?

The policy is inactive, so refresh_frequency_limits() won't even run
cpufreq_set_policy() for it.

> so I will say it will be used and the constraint will be
> satisfied. And so I had that view.
