Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA22C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7218B20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsNojTry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfITUDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:03:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36200 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfITUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:03:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so8558353qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwa4EAZC1poPppej+zNVzAUxvGIzsTLI+17C+mtmgsk=;
        b=YsNojTry/Nt93tlKFnCheF3yiEmyKEjG2+8LifXCmZJPK4E4QsUjCh6XnOJW9de5AW
         GytnyL9No6uzzc6oYCYdKCR1fG1x52S2/cjszyRqNwLteYDsCaB1iaEVxl0TM0sYy56F
         jkBQwOBhRZG0tB5VwcByEkqhenKyDlPx3xSfOWJNcIuS2YTxCEFAggWkeS47CB8ys7eO
         f3vocqpxxwh17D86th2AdSOdm8dgBdoDp9wyBx1MM0Y/x/m4Z5GtiCfWx3+BD8Izx27d
         lI5SvDWiL3kaMtLRk3NCZW9yqUChIPag64R1/tJJcCC+JaxQD5TLsafnTUZuz9tuvX7E
         9mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwa4EAZC1poPppej+zNVzAUxvGIzsTLI+17C+mtmgsk=;
        b=uUfpXlO4Jxmc+O6+cX5Dw0JzpnwfdMXJg6vtjNwq0R2Ow1iePEQvBqftBjBxHkNaxa
         D94l2aI8XDOdHaD26yHNsKDQ9vc+2EZre366W1LbUF1UWW+MYwQmg9BtW+HyCiyghWx3
         kjr+fuGACj3MrNpHgR2+pKhX+SKq64k3TMI5tIjbX02x3e6TuEmS8Zae17hCncbCzuoJ
         s9Kt97jGNcGSpi6JHn0sqOAb0IwLOpSFDXqQZKqo4o5YxOD2YFtWYYGWQrsEqxIJGgfb
         uFPJWA5nBaavH/oX+9tdXfUEy0Wm2KaEYoofEhg43AlQy1/Qx16z76H8V1u1zkABNrjm
         kalA==
X-Gm-Message-State: APjAAAVrNNDVLdON0AWrebYiDUIcMOFTB52OHFxKBS0NiXSIi71A4Ooa
        sAmHH+C8Zpf4LVJzbUHZR3pzksKwdW5r5D2SqBT5nA==
X-Google-Smtp-Source: APXvYqwzQEWk2WXsSzH0cM+f21LhG2/T3g+JPI6SID+TAjvudvGxccjtSqDO+6NeLBY2Pbv22xx/3k6DAZtMQ/4Xqjc=
X-Received: by 2002:a37:6d2:: with SMTP id 201mr5583270qkg.106.1569009829829;
 Fri, 20 Sep 2019 13:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
 <20190917093412.GA24757@bogus> <58e60ca4-9615-bbdf-5fe7-2a0e1d7f48d8@linaro.org>
 <20190917132035.GB30016@bogus>
In-Reply-To: <20190917132035.GB30016@bogus>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 20 Sep 2019 13:03:38 -0700
Message-ID: <CAP245DWSKGgJWkbGhXMazqjsEy7PBumN_r0Do6nhbQRv58R_zw@mail.gmail.com>
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Sep 17, 2019 at 6:20 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Sep 17, 2019 at 02:47:22PM +0200, Daniel Lezcano wrote:
> >
> > Hi Sudeep,
> >
> > On 17/09/2019 11:34, Sudeep Holla wrote:
> > > On Thu, Sep 12, 2019 at 04:02:34AM +0530, Amit Kucheria wrote:
> > >> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> > >> subsystems are initialised in core_initcall so we get earlier access to
> > >> thermal mitigation.
> > >>
> > >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > >> ---
> > >>  drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > >> index 4b0b50403901..04676cc82ba6 100644
> > >> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > >> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > >> @@ -327,7 +327,7 @@ static int __init qcom_cpufreq_hw_init(void)
> > >>  {
> > >>    return platform_driver_register(&qcom_cpufreq_hw_driver);
> > >>  }
> > >> -device_initcall(qcom_cpufreq_hw_init);
> > >> +postcore_initcall(qcom_cpufreq_hw_init);
> > >
> > > I am fine with core framework initcall pushed to earlier initcall levels
> > > if required, but for individual/platform specific drivers I am not so
> > > happy to see that.
> > >
> > > This goes against the grand plan of single common kernel strategy by
> > > Android moving all drivers as modules. We might decide to make this
> > > a module.
> >
> > module = mounted file system = very late initialization
> >
> > Is that the plan? Force every driver to load too late?
> >
>
> Yes. Something similar to what we have on desktops/servers.
>
> > There are core drivers which must be loaded as soon as possible. If the
> > qcom driver is one of them, then what is the problem?
> >
>
> I am fine with that if it's really issue but it shouldn't become the
> defacto trend.

I didn't convert other HW drivers on purpose since it's really up to
the platform to decide. I have tested with all drivers converted to
core_initcall and didn't find any boot issues on kernelci.

> > "The grand plan" will have to solve this first before doing the module
> > move.
> >
>
> Sure, I just expressed my view as it looks to be going in different
> direction for me.
>
> > > Also there are few cpufreq drivers that are modules. Will
> > > they have issues ? If not, why do we need this change at all.
> >
> > Because some boards don't have thermal issues with the cpufreq drivers
> > as module, other boards have.
> >
>
> OK, so this platform boots with default high OPP and needs thermal
> mitigation that early ? If so, that's fine.

That is indeed the case - 30-40 degree rise in under 50ms can be seen
on some of these platforms.

> > > Needing
> > > thermal mitigation during boot this earlier is still too much of
> > > expectation, I would rather boot slowly than relying on this feature.
> >
> > And what if we want to boot faster? The boot time is one of a key point
> > of benchmark.
> >
>
> I understand the requirement, though for me it's really sounds stupid.

Is it stupid if the SoC was being used in automotive with a 2s (or
less) startup requirement? :-)

> As Quentin pointed out, it would be good to get all those benchmark
> details, and preferably in the commit log so that we can look back
> whenever someone else take the same approach later.

I'm traveling for Connect this week but will try to post some logs
with initcall_debug turned on where changing these initcalls shaves
off several seconds. Just to reassure everyone that GKI isn't
forgotten, the next set of patches will actually add module support
for the tsens driver so AOSP can make them modules and things will
still work.

Regards,
Amit
