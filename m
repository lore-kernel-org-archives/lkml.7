Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC3C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDBD217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkxfK51C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfI0SDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:03:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41902 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfI0SDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:03:01 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so18554499ioh.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yHxRf8iSSBJVbY2jjeb4CIMSwJyJyDAiK8DXSZBel1Y=;
        b=xkxfK51Ci8GL1Sha/Z1ZHn31hXasiiDuDy0vbFozf9TSlb0sp5S7Gq69mDmi+AHdAz
         ZU3oLzGYbj4xxWqwmPdsK8GOJJfmoyASDVgG0VR3osjMBhAS9b5OWFyO3TowNkEMgqKE
         iWVl0PYTyu9IphYCGnYDCP3aH/DT67m7bD5f7g43TbWmruk7PlYmQ1TUKzTn1h/7RxWC
         lrkWy0cDF1hLusZ+tsiBZkn/RxxbD8xFN1JCwtzXpkwJECDwTTdFAWY8JoBPXmtIw3Ex
         a9q84bit+MY27AyVJSAWE5becNKV1HSaCcz1C+d8loB4KWl/yE+gnIRBLLF8YcQ0jLo7
         H1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yHxRf8iSSBJVbY2jjeb4CIMSwJyJyDAiK8DXSZBel1Y=;
        b=QYSiB4/6vLrMaCUkA17gnnFnYDYL6F6XKIg6yxL9KycWT4B3wlqpZcTMVkTEMZ8sUQ
         LRMLIRdHCBGmjm8skJiL370OPQFOQVT1HX48oqOCtIh/i0yW7pvv0xhnDysb9fDP7x1s
         kNMKJmCLJ8VyZAEYBHvh0WVO3iVzK1YYbnOAiXoTtMsRf9hCloXifhBIclq07k67v8TT
         dNlOKQ20yvkyiczGDWChMI4j70ux+14XzS9eTOqqE8knD3zlniHIBtD367fUoLYD3XXK
         vc+LuruAdWu2vm4avcd1DhxyOhXJQx5SVT+jPX+Y1EVqm9my9f3GqpVeNSduC1XuHKzT
         AuKg==
X-Gm-Message-State: APjAAAWMAFwWsi8fRuLNC66psDVv3iJw5tplAf6jkQGh3VqICFvLsYLZ
        6zcfZdPezgHRUdRr/yLMnFYH0M/RTrQTiHar8ezREw==
X-Google-Smtp-Source: APXvYqz+GgYI57ih3KBFENT6isulIJiUTyNks/5H4o2vkl1buRVE0KbLYSWpnU4tr4IeUdcHKjQJ095WkkX2A0QRJ64=
X-Received: by 2002:a05:6e02:683:: with SMTP id o3mr5918830ils.58.1569607380559;
 Fri, 27 Sep 2019 11:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
 <20190909145015.26317-3-daniel.lezcano@linaro.org> <20190918193554.GC24433@xps15>
 <f90bcd0c-e937-54f7-0dae-0e9d9ed45a41@linaro.org>
In-Reply-To: <f90bcd0c-e937-54f7-0dae-0e9d9ed45a41@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 27 Sep 2019 12:02:49 -0600
Message-ID: <CANLsYkxK3RzE1V_GwBarocrFHUSNOFmW_AfQn+JraXg3-gXVuw@mail.gmail.com>
Subject: Re: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state
 to inject
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2019 at 07:02, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
>
> Hi Mathieu,
>
> On 18/09/2019 21:35, Mathieu Poirier wrote:
> > On Mon, Sep 09, 2019 at 04:50:15PM +0200, Daniel Lezcano wrote:
> >> Currently the idle injection framework only allows to inject the
> >> deepest idle state available on the system.
> >>
> >> Give the opportunity to specify which idle state we want to inject by
> >> adding a new function helper to set the state and use it when calling
> >> play_idle().
> >>
> >> There is no functional changes, the cpuidle state is the deepest one.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
>
> [ ... ]
>
> >> +/**
> >> + * idle_inject_set_state - set the idle state to inject
> >> + * @state: an integer for the idle state to inject
> >> + */
> >> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int sta=
te)
> >> +{
> >> +    if (state >=3D CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
> >> +            WRITE_ONCE(ii_dev->state, state);
> >> +}
> >> +
> >>  /**
> >>   * idle_inject_start - start idle injections
> >>   * @ii_dev: idle injection control device structure
> >> @@ -298,6 +310,7 @@ struct idle_inject_device *idle_inject_register(st=
ruct cpumask *cpumask)
> >>      cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
> >>      hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> >>      ii_dev->timer.function =3D idle_inject_timer_fn;
> >> +    ii_dev->state =3D cpuidle_find_deepest_state();
> >>
> >>      for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
> >>
> >> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> >> index a445cd1a36c5..e2b26b9ccd34 100644
> >> --- a/include/linux/idle_inject.h
> >> +++ b/include/linux/idle_inject.h
> >> @@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_dev=
ice *ii_dev,
> >>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
> >>                               unsigned int *run_duration_us,
> >>                               unsigned int *idle_duration_us);
> >> +
> >> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int sta=
te);
> >> +
> >
> > The above function is not used in this patch and as such should be intr=
oduce as
> > part of future work.  Otherwise I agree that this patch does not carry =
any
> > functional changes.
> >
> > Without function idle_inject_set_state():
>
> I was about to remove the function but actually it may not make sense as
> the idle_inject is a framework providing the different API to do the
> idle injection and the function is an helper to set the state value. It
> comes with the addition of the state number in the structure.

I agree with you but there is still no current user of the API.

>
> Next patch is the idle cooling device and makes use of it.

Then why not simply introduce it then?

>
> Can I still consider your acked-by valid?

Whether the API is introduced here or in the next patchset has no
effect on the validity of the code and as such my approbation is still
valid.

Thanks,
Mathieu

>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
