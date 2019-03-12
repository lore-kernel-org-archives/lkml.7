Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C78C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3390B21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ReZ7TFra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfCLSvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:51:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46067 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:51:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so3249727ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mm1QjN0w8dacwGXEVgLh1zGRWMMMxD/FUwmSzd/yuf8=;
        b=ReZ7TFratJ9POYe6uENAlwtgGehDAzQ2wCByC5K5jWadZKihhqNohXxG6TJQKQPbQM
         Z2fBsTi4n9dUsdHgFXbDNVqnCfzUp8UG4J4TXogC9BIeJE7mVvjgjdV2QKQ3EWDZsVcV
         0GWRm/8L5yezYHi9shNQtX5EWu81grR7bJQvyzJrys7kBYxQc3TCEXJvVb9cv3oR7YTA
         jRoAVYCvsLhSmCgM3v71misWrrC8WCrbGHvpbwr0Yw5zMIvqGbFjLKdxO/jWUO/eNMv5
         zkj8CKXLtQ2OxjJPT/o56vzm5sk5BpJ26RbliroOVQqmDBfM/pwErxR90ONVv/lB84ox
         F7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mm1QjN0w8dacwGXEVgLh1zGRWMMMxD/FUwmSzd/yuf8=;
        b=GxX319c6uMcOAehrUGGGTAT0d7SpHDX8mHAlFuHDT8J5MuYSO0OkzCAOss467pqtbG
         Vkrcjk+nPF/k9z2dt6d/pjZQoR9MLctXSQ78B1aOQsJWA27A1K5YMmb1Vdk6STWdz+x4
         Duwg3uIFzFS0HMZyKdiCcD2HR8SCHEa11QC5nb5x0HcXG0+i2JKW0reROF/LyqKLCq4f
         Q4Z+nmwI9jICJYFxEVZQD0TsQxrugKQWfMj4EaPkMTLbO1ZzNL6tXlM0M7udlDr6BRql
         UOzqVAalPxiM86fl4wFYEiLzXxZv7khD6UVEVWn8NoJlSzKe0GGw1WBq2ZtiZpPeidvN
         TJ2Q==
X-Gm-Message-State: APjAAAXAASiVfdVJDv6aUEXaQfp6DMyi2cU8QiTWpEE7OCKyYoT/byyx
        Oo296m9hmQovwAltUghxQqP3Bgv2k8pqswcrjUxSvg==
X-Google-Smtp-Source: APXvYqw042Y405TkkYroyypqXMMWe0ijN5HML/93iYXw+M+g2oYOWyTaRT6QzClpgaL7ftG8FMaffrhutNYfqB9ApDI=
X-Received: by 2002:a2e:b014:: with SMTP id y20mr10013024ljk.116.1552416666852;
 Tue, 12 Mar 2019 11:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain> <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz> <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <20190312174520.GA9276@sultan-box.localdomain> <CAEe=Sx=MxzBB46WxuwHTQcocBkx1UW+fmVOa3VWv_eUferzVYw@mail.gmail.com>
In-Reply-To: <CAEe=Sx=MxzBB46WxuwHTQcocBkx1UW+fmVOa3VWv_eUferzVYw@mail.gmail.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Tue, 12 Mar 2019 19:50:56 +0100
Message-ID: <CAHrFyr7wJsNAQ_NPAsBDA-g7useeetgJ-MBod40SQAmf08sXJw@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Tim Murray <timmurray@google.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-drivers <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 7:43 PM Tim Murray <timmurray@google.com> wrote:
>
> On Tue, Mar 12, 2019 at 10:45 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > On Tue, Mar 12, 2019 at 10:17:43AM -0700, Tim Murray wrote:
> > > Knowing whether a SIGKILL'd process has finished reclaiming is as far
> > > as I know not possible without something like procfds. That's where
> > > the 100ms timeout in lmkd comes in. lowmemorykiller and lmkd both
> > > attempt to wait up to 100ms for reclaim to finish by checking for the
> > > continued existence of the thread that received the SIGKILL, but this
> > > really means that they wait up to 100ms for the _thread_ to finish,
> > > which doesn't tell you anything about the memory used by that process.
> > > If those threads terminate early and lowmemorykiller/lmkd get a signal
> > > to kill again, then there may be two processes competing for CPU time
> > > to reclaim memory. That doesn't reclaim any faster and may be an
> > > unnecessary kill.
> > > ...
> > > - offer a way to wait for process termination so lmkd can tell when
> > > reclaim has finished and know when killing another process is
> > > appropriate
> >
> > Should be pretty easy with something like this:
>
> Yeah, that's in the spirit of what I was suggesting, but there are lot
> of edge cases around how to get that data out efficiently and PID
> reuse (it's a real issue--often the Android apps that are causing
> memory pressure are also constantly creating/destroying threads).
>
> I believe procfds or a similar mechanism will be a good solution to this.

Fwiw, I am working on this and have send a PR for inclusion in 5.1:
https://lore.kernel.org/lkml/20190312135245.27591-1-christian@brauner.io/
There's also a tree to track this work.

Christian
