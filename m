Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FADCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahjtDDP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfJ2Myi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:54:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39964 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2Myi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:54:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id f4so4438035lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyC7yE5Zia5wjA+b3r/7nOVhr/nMlkQqP2NCwFPVhd4=;
        b=ahjtDDP93botL/npzK6iP0iXdCdOLn32mOXHEjBGFtbQMGKtcWtlE+IS5ZWtLJ7pT0
         F2aFfEq8Gn6S/gyR2+9YNq2+0CC3tm6JwKAP2+j+p2x1yjWBTFJWKBc3vza418nnG9GT
         1bBO0Pujh56xJjkUUTHxc09oCwvo7zEO1iiFC8GhLGzA7W/Eof9Pd+mJZPLk5m18wn5Z
         UGqe4hwR3G5+DEmOv9D9WtzNNCuZ4JJadOxc8xRl+xUEVOE1Kr7Y0AjY4z6vK5j5PqTE
         khnaiC3qgdWxevSCZbI9fmzVKh1VI83sOWDkwsOUTvnU247+DRd2J6rYZLIVAUaCdLjr
         TF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyC7yE5Zia5wjA+b3r/7nOVhr/nMlkQqP2NCwFPVhd4=;
        b=jihVynE4i44ng8E3gSl35+/79lRo3X9bGBgpcQPA2pFGsM/fbs7NsFkwOe/65Yy84A
         RSY4cqv27+vM+YbSe1sbAcdWF59MId5g5WDT9qqGxndlFqIYmYpEjWkqIiAUy+fo6qQ9
         ScOBTuvbp0D9pujihdZXsnWlurKVfcNSTQR+dzMEor89kzg4oUOhOvrwI0OmntXqzOO3
         NSWhnjxDRamhXRYZOtjMCPSSWGGF/bNXyWb24TlLtWZdzBUxbgpRsc21okaZh+zPNAiQ
         4TBvc74GUh2armxbV+Mp9KPerrwihiW4yITWCxtnCTsysGd9l40mgkesufyIMRfSo1y4
         zGpQ==
X-Gm-Message-State: APjAAAWYm+iGlaoG8QjQ0coeqzca7uvLIPRMrI1At6JhzzIqRPdotpUk
        xXXCUw1TM6+VOjACwzDK6XE8thQwtMfUAyM0ZLQBRoXN
X-Google-Smtp-Source: APXvYqzHz20RYYdTRga9BX249milFT+G7+sMud/tELdQ6UA7FiUzeNgB2BpFWr+IlVyOihjK4WcRi1i6ZxTK6Sk4hSA=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr2333981lfg.133.1572353675805;
 Tue, 29 Oct 2019 05:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191009104611.15363-1-qais.yousef@arm.com> <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
 <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
 <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com> <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
In-Reply-To: <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Oct 2019 13:54:24 +0100
Message-ID: <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 13:46, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 10/29/19 13:20, Vincent Guittot wrote:
> > > > Making big cores the default CPUs for all RT tasks is not a minor
> > > > change and IMO locality should stay the default behavior when there is
> > > > no uclamp constraint
> > >
> > > How this is affecting locality? The task will always go to the big core, so it
> > > should be local.
> >
> > local with the waker
> > You will force rt task to run on big cluster although waker, data and
> > interrupts can be on little one.
> > So making big core as default is far from always being the best choice
>
> This is loaded with assumptions IMO. AFAICT we don't know what's the best
> choice.
>
> First, the value of uclamp.min is outside of the scope of this patch. Unless
> what you're saying is that when uclamp.min is 1024 then we should NOT choose a
> big cpu then there's no disagreement about what this patch do. If that's what
> you're objecting to please be more specific about how do you see this working
> instead.

My point is that this patch makes the big cores the default CPUs for
RT tasks which is far from being a minor change and far from being an
obvious default good choice

>
> If your objection is purely based on the choice of uclamp.min then while
> I agree that on modern systems the little cores are good enough for the
> majority of RT tasks in average Android systems. But I don't feel confident to
> reach this conclusion on low end systems where the little core doesn't have
> enough grunt in many cases. So I see the current default is adequate and the
> responsibility of further tweaking lies within the hands of the system admin.
>
> --
> Qais Yousef
