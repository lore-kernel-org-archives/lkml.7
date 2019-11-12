Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0717C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94FA204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573548722;
	bh=+BY0VvfyuJYLVwmPsjPPcn+olp9DxZPqEefJHUc9gH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0cr+KG/N1KjmmJUSlhXx7MxEn34TUWqS58EQ3spIp3v8mTzlU6cfcs8s/13ancwz+
	 IcBVkSl1Ke0zga68PW2B/P6U3iB1QXSJFIZMk1hw7SpxYBHwJkdPxxqRq3EobTKAKm
	 VTcGC792PahzjP98uvjuOdNct8ZhYq29cKU+kOwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKLIwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:52:01 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45534 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfKLIwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:52:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id r24so13614731otk.12;
        Tue, 12 Nov 2019 00:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwgmVrxEXIpt/g4J0RDmvVyEpXSTtk8AjSu3XM3en0U=;
        b=XfVy4mayQX01DgYYHYcusrVZXXI+HmJrK5jvzRsA4yJg1FZntm5eSgFJJesWkKEGNG
         ewWoitOmReqJLNfDkzvwFYMIzz1+qH5ra/M3WtKLaktPCdLSMqAdbRGt7+juDeZczZpp
         /gI/5y4v7IxfdaNNO0G2Q+Drrhe1HF2wELuwjhyOHq8MDT5JpLgWRmSYFnLLSNFykEWl
         /gvG6Y6GWAWqpugbLFiNWRUciRz98+GpoHfz2IH0qAY3W4eEiEb3qPsLG5x0aIvcw+QV
         53YzF//rmGStLnX53Ttvbc34xIXjnIl2sVt9ux/9p98NOQXqPSUulyr1r/VxWaJspe6G
         b/HA==
X-Gm-Message-State: APjAAAXcH1uzrZJ1LlUMTOFk9njIyKQRq24SBfGAHS1o60D1vmBc2OHo
        eByEvfbGYjYXm4yIV4nJgaBupcl9lXxABrZFvkM=
X-Google-Smtp-Source: APXvYqxNMBiLvKOlrjxbDhWAQLFStbGhVVWY323VqOO2Kh71JkU3OhJV6xgerTPwBs3hdLdyclaEG/Ze79QGxVmdYc0=
X-Received: by 2002:a9d:5a0f:: with SMTP id v15mr25429657oth.266.1573548717882;
 Tue, 12 Nov 2019 00:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20191030022105.223213-1-ikjn@chromium.org> <2576101.gjqMWB6DaV@kreacher>
 <CAATdQgCH+WBU-caZ-kUFZxsYAQqMXNgCOtTosK5H70KodzkTaw@mail.gmail.com>
In-Reply-To: <CAATdQgCH+WBU-caZ-kUFZxsYAQqMXNgCOtTosK5H70KodzkTaw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Nov 2019 09:51:46 +0100
Message-ID: <CAJZ5v0hJsw1Bkfh_fBYsH2diNmBSWcrYvhTRiO=NR+EwnpcGqg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] cpuidle: undelaying cpuidle in dpm_{suspend|resume}()
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pavel Machek )" <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 6:10 AM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> On Fri, Nov 8, 2019 at 7:22 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, October 30, 2019 3:21:05 AM CET Ikjoon Jang wrote:
> > > cpuidle is paused only during dpm_suspend_noirq() ~ dpm_resume_noirq().
> > > But some device drivers need random sized IOs in dpm_{suspend|resume}()
> > > stage (e.g. re-downloading firmware in resume).
> > > And with such a device, cpuidle's latencies could be critical to
> > > response time of system suspend/resume.
> > >
> > > To minimize those latencies, we could apply pm_qos to such device drivers,
> > > but simply undelaying cpuidle from dpm_suspend_noirq() to dpm suspend()
> > > seems no harm.
> >
> > While the patch is generally acceptable, the changelog is not.
> >
> > First, what does "undelying" mean?
>
> You're right, that should be fixed,
> actually I used 'undelaying' from commit: 8651f97bd951d
> (PM / cpuidle: System resume hang fix with cpuidle),
> when the first time cpuidle_{pause|resume} is introduced:
>
> "Since we are dealing with drivers it seems best to call this function
> during dpm_suspend(). Delaying the call till dpm_suspend_noirq() does
> no harm, as long as it is before cpu_hotplug_begin() to avoid race
> conditions with cpu hotpulg operations."
>
> Delaying does no harm, but I think that there had been no specific
> reason of this
> delay from the beginning. Undelaying does no harm too.

I see.

It would be good to mention commit 8651f97bd951d in the changelog.
And while "delaying" is a proper word in English, "undelaying" isn't
AFAICS, so maybe say "avoid delaying" or something to that effect
instead.

> >
> > Second, you seem to be talking about the cases in which exit latencies of
> > idle states are not small relative to the system suspend/resume time, so
> > without any specific examples this is not really convincing.
> >
> > Also, potentially, there is another reason to make this change, which is
> > that on some systems i2c (or similar) controllers may be requisite for
> > idle state entry and exit, so it may make sense in general to prevent
> > cpuidle from being used over the entire suspend and resume of the
> > system.  However, without any example of a system in which that matters
> > it still is not convincing enough IMO.
> >
>
> Currently I've got only one specific device for examples.
> Maybe this patch needs more generalized examples for applying to all
> other machines.

One example would be enough, but please provide it in the changelog of
the patch.
