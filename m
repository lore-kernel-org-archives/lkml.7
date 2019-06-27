Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052ACC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF47F21738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M7oR9SbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfF0RyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:54:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38532 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfF0RyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:54:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so3278565ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81ufU1Y4KPPaNBIXIxjLeNCQp/WRZPN4IE3DhlmLXmM=;
        b=M7oR9SbNJynybjmKaRKDMS8RIKmKAAbvhNdDceNxtkYguSlv1y/h62U8kdg3QkCh+d
         Gn0Z5Uh/EJm2ESh0TKaL99vJqYIASsMpFFBdUDyI2j/HUpafC47/1u9+pFhzC4Mndelc
         xcn0sXyXdPoYGlDPTBWf+lVufhIQxSYNUrZgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81ufU1Y4KPPaNBIXIxjLeNCQp/WRZPN4IE3DhlmLXmM=;
        b=lPZ30r3SRvvM1DyqQoUc1XvW01k7DJb+miVwhvtK4f+SvQtBc3S06xf9hgQo+TKNYb
         UnQmZl8O86SDp1YLBvOmS6sRq8TDlgZWTpUJNwl+tNmHyYhbvzdcKlMx0RTOGA/hLPRj
         YFuSfZxC7FmRRF+xvHGr7ER42EywEyvek+B0LMwWvSBRiQHW7LLiZGJyUaYT1DvrPAYR
         pFkYJF4xQDB5z2m1vyYsqUG7mmQMOjn5De+ja8qVR7chBxY8pROAbYxGv4zl6M3uZ/yB
         pMCXWCDRt0lR8A2Xq0QY4msXhsrYjBuUaNR2fAyRDw8y8DaBRf6WATdLj1dG/I8OBIjz
         SASA==
X-Gm-Message-State: APjAAAV8tNYeRmLDgE+nWLz9OhhHQxeesCLJCMOifZaXCWsGEAVG70ny
        A+tN1hRFNDcpjtvhtyEsneeLDpAR8lo=
X-Google-Smtp-Source: APXvYqzNB+CvfHxdZGBxB/vcd7K5gGO3fOg9snUwBACVkrSAyRzxdi7wUItVNyOjT2Qg9uowLxxOKA==
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr3005579lja.207.1561658050900;
        Thu, 27 Jun 2019 10:54:10 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 20sm535912ljf.21.2019.06.27.10.54.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:54:09 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y198so2184181lfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:54:09 -0700 (PDT)
X-Received: by 2002:a19:3f16:: with SMTP id m22mr2676505lfa.104.1561658048754;
 Thu, 27 Jun 2019 10:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190617215234.260982-1-evgreen@chromium.org> <20190625130515.GJ21119@dell>
 <e9e6e090-7c9b-ff5c-7389-702f9deb6712@collabora.com> <CAE=gft5TCcWGz_i3AaqexNWx6XvwcxNqTcXqrGn_4bFaMQFtjA@mail.gmail.com>
 <1be4bbbe-783c-ea91-8283-624ee66be00c@collabora.com>
In-Reply-To: <1be4bbbe-783c-ea91-8283-624ee66be00c@collabora.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Jun 2019 10:53:32 -0700
X-Gmail-Original-Message-ID: <CAE=gft5ahY7ji4+zRxyOWwKavjc-ejXJwgbcbC=W39fe+rRAWw@mail.gmail.com>
Message-ID: <CAE=gft5ahY7ji4+zRxyOWwKavjc-ejXJwgbcbC=W39fe+rRAWw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: Expose resume result via debugfs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 9:42 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Evan,
>
> On 27/6/19 18:07, Evan Green wrote:
> > On Wed, Jun 26, 2019 at 1:55 PM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Evan,
> >>
> >> Two few comments and I think I'm fine with it.
> >>
> >> On 25/6/19 15:05, Lee Jones wrote:
> >>> On Mon, 17 Jun 2019, Evan Green wrote:
> >>>
> >>>> For ECs that support it, the EC returns the number of slp_s0
> >>>> transitions and whether or not there was a timeout in the resume
> >>>> response. Expose the last resume result to usermode via debugfs so
> >>>> that usermode can detect and report S0ix timeouts.
> >>>>
> >>>> Signed-off-by: Evan Green <evgreen@chromium.org>
> >>>
> >>> This still needs a platform/chrome Ack.
> >>>
> >>>> ---
> >>>>
> >>>> Changes in v2:
> >>>>  - Moved from sysfs to debugfs (Enric)
> >>>>  - Added documentation (Enric)
> >>>>
> >>>>
> >>>> ---
> >>>>  Documentation/ABI/testing/debugfs-cros-ec | 22 ++++++++++++++++++++++
> >>>>  drivers/mfd/cros_ec.c                     |  6 +++++-
> >>>>  drivers/platform/chrome/cros_ec_debugfs.c |  7 +++++++
> >>>>  include/linux/mfd/cros_ec.h               |  1 +
> >>>>  4 files changed, 35 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> >>>> index 573a82d23c89..008b31422079 100644
> >>>> --- a/Documentation/ABI/testing/debugfs-cros-ec
> >>>> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> >>>> @@ -32,3 +32,25 @@ Description:
> >>>>              is used for synchronizing the AP host time with the EC
> >>>>              log. An error is returned if the command is not supported
> >>>>              by the EC or there is a communication problem.
> >>>> +
> >>>> +What:               /sys/kernel/debug/cros_ec/last_resume_result
> >>
> >> Thinking about it, as other the other interfaces, I'd do
> >>
> >> s/cros_ec/<cros-ec-device>/
> >>
> >> I know that for now only cros_ec supports that, but we don't know what will
> >> happen in the future, specially now that the number of cros devices is incrementing.
> >
> > See my comment below, I suppose the fate of these two comments are
> > tied together.
> >
> >>
> >>>> +Date:               June 2019
> >>>> +KernelVersion:      5.3
> >>>> +Description:
> >>>> +            Some ECs have a feature where they will track transitions to
> >>>> +            the (Intel) processor's SLP_S0 line, in order to detect cases
> >>>> +            where a system failed to go into S0ix. When the system resumes,
> >>>> +            an EC with this feature will return a summary of SLP_S0
> >>>> +            transitions that occurred. The last_resume_result file returns
> >>>> +            the most recent response from the AP's resume message to the EC.
> >>>> +
> >>>> +            The bottom 31 bits contain a count of the number of SLP_S0
> >>>> +            transitions that occurred since the suspend message was
> >>>> +            received. Bit 31 is set if the EC attempted to wake the
> >>>> +            system due to a timeout when watching for SLP_S0 transitions.
> >>>> +            Callers can use this to detect a wake from the EC due to
> >>>> +            S0ix timeouts. The result will be zero if no suspend
> >>>> +            transitions have been attempted, or the EC does not support
> >>>> +            this feature.
> >>>> +
> >>>> +            Output will be in the format: "0x%08x\n".
> >>>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> >>>> index 5d5c41ac3845..2a9ac5213893 100644
> >>>> --- a/drivers/mfd/cros_ec.c
> >>>> +++ b/drivers/mfd/cros_ec.c
> >>>> @@ -102,12 +102,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >>>>
> >>>>      /* For now, report failure to transition to S0ix with a warning. */
> >>>>      if (ret >= 0 && ec_dev->host_sleep_v1 &&
> >>>> -        (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> >>>> +        (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> >>>> +            ec_dev->last_resume_result =
> >>>> +                    buf.u.resp1.resume_response.sleep_transitions;
> >>>> +
> >>>>              WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
> >>>>                        EC_HOST_RESUME_SLEEP_TIMEOUT,
> >>>>                        "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
> >>>>                        buf.u.resp1.resume_response.sleep_transitions &
> >>>>                        EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> >>>> +    }
> >>>>
> >>>>      return ret;
> >>>>  }
> >>>> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> >>>> index cd3fb9c22a44..663bebf699bf 100644
> >>>> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> >>>> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> >>>> @@ -447,6 +447,13 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
> >>>>      debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> >>>>                          &cros_ec_uptime_fops);
> >>>>
> >>>> +    if (!strcmp(ec->class_dev.kobj.name, CROS_EC_DEV_NAME)) {
> >>
> >> For debugfs I don't care having the file exposed even is not supported, anyway
> >> there are some CROS_EC_DEV_NAME that won't support it, so just make this simple
> >> and create the file always.
> >
> > Aw, really? This file is very specific to system suspend/resume. My
> > original patch had it everywhere, but I was finding it very ugly that
> > this was showing up on things like the fingerprint device. I can
> > change it if you think it's better to have it everywhere, but it also
> > seems like an easy change to make in the future if this file is for
> > some reason needed on other EC types.
> >
>
> I'd think different if it was a sysfs property but it's a debugfs.
>
> Right now we have:
>
> #define CROS_EC_DEV_NAME        "cros_ec"
> #define CROS_EC_DEV_FP_NAME     "cros_fp"
> #define CROS_EC_DEV_ISH_NAME    "cros_ish"
> #define CROS_EC_DEV_PD_NAME     "cros_pd"
> #define CROS_EC_DEV_SCP_NAME    "cros_scp"
> #define CROS_EC_DEV_TP_NAME     "cros_tp"
>
> Is really the named cros_ec the only that has this feature? What about cros_scp
> (is not supposed to run the same base code as cros_ec)? And cros_ish ?
>
> And all the named cros_ec devices have this feature? Maybe is supported by
> Nocturne but not Veyron? Wouldn't be exposed also on those cros_ec that doesn't
> support it?
>
> And don't have the answer to all these questions, hence my concerns.
>
> As per your documentation
>
>  +                ...           The result will be zero if no suspend
>  +            transitions have been attempted, or the EC does not support
>  +            this feature.
>
> I can accept if _all_ the CROS_EC_DEV_NAMEs and _only_ the CROS_EC_DEV_NAME
> supports it, is that the case?
>
> But if you are anyway exposing this on CROS_EC_DEV_NAMEs that doesn't support it
> why not just expose to all and skip a future bunch of code to filter, it is
> clear what a 0 means and at the end it's just a debugfs file.

Yes, my patch was attempting to expose it for all "cros_ec" devices,
even if the EC didn't support that feature. I was hoping to avoid
polluting other devices like cros_fp and cros_pd, but I think you may
be correct about cros_scp. That's something that will act as the
system EC but is named differently because it can send IPIs as well?
Weird, but ok.

Ok, I'll add this debugfs file to all EC devices.
-Evan
