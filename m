Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95347C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D1620659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mMSGLXrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfF0QHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 12:07:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35260 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF0QHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:07:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so2964728ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7gTNVn5WCRldcDUWtwi1/4b1MRMrZ6Z1SWmnd3KDtoo=;
        b=mMSGLXrRvMZGZ14LwUf/WZBcQ21CdDDWbtHgzqqBkGpt9ngbgWupQBTb5vwwIw6yW4
         GahqbUABhriM2yXqUnGjZkwg0LPGCGJNO+ZXqwLGyQrNVAY7s8T/ktfrpesN3OIR3iH7
         TyoVBc7MOhQWS+sE+q9qT7LeV+q30GZrpaVHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7gTNVn5WCRldcDUWtwi1/4b1MRMrZ6Z1SWmnd3KDtoo=;
        b=c3kQQkTNOOP9zrtBtYhfJG3ZJ39nEYSzERmpEVvaZTE5P3ebCGbLAeVzqQFcBN0iJz
         7ucHwwDB2HejgHvakDRzNT35e1KPiylyGoBsQ7RPLC3c1F4vkSsxdZnI2bfu4qORM1da
         Ux4597OLvh09HNekIRyPiYcbqogx7DmHfKO0n/fRsleejilrnzJ66OWmnWjMnzi+/CTb
         zwuXWoioa9BpzO2xoVqlMkOxFRBAWvK8XuLgZg1w1ptFaHs614I8sSQxkxczihcO55kq
         QvMdF+Uc3Os+AxMzoc3Uy1iQtEJ0R91ssONNPyiwl9MAIzm0MpHza2su+lY+VgUscUG1
         B3RA==
X-Gm-Message-State: APjAAAXBI2cuh2jPFAJOmYgDbiLcZ+y52CKLYSx6tXFYU+IJPeQ5EddU
        vcuOA+rfdNDM62AabrJqnCmW4caN1EI=
X-Google-Smtp-Source: APXvYqwvdYI8N+dOE3fM39c7E9OBE+KOV4mycaBiJ2m6fxLLorWObJEuVb91ETDWFk4/6Y9KQOdyQw==
X-Received: by 2002:a2e:7c15:: with SMTP id x21mr3145402ljc.55.1561651662755;
        Thu, 27 Jun 2019 09:07:42 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a17sm490759lfk.0.2019.06.27.09.07.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 09:07:41 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r9so2951515ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 09:07:41 -0700 (PDT)
X-Received: by 2002:a2e:898b:: with SMTP id c11mr3200920lji.241.1561651660581;
 Thu, 27 Jun 2019 09:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190617215234.260982-1-evgreen@chromium.org> <20190625130515.GJ21119@dell>
 <e9e6e090-7c9b-ff5c-7389-702f9deb6712@collabora.com>
In-Reply-To: <e9e6e090-7c9b-ff5c-7389-702f9deb6712@collabora.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Jun 2019 09:07:04 -0700
X-Gmail-Original-Message-ID: <CAE=gft5TCcWGz_i3AaqexNWx6XvwcxNqTcXqrGn_4bFaMQFtjA@mail.gmail.com>
Message-ID: <CAE=gft5TCcWGz_i3AaqexNWx6XvwcxNqTcXqrGn_4bFaMQFtjA@mail.gmail.com>
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

On Wed, Jun 26, 2019 at 1:55 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Evan,
>
> Two few comments and I think I'm fine with it.
>
> On 25/6/19 15:05, Lee Jones wrote:
> > On Mon, 17 Jun 2019, Evan Green wrote:
> >
> >> For ECs that support it, the EC returns the number of slp_s0
> >> transitions and whether or not there was a timeout in the resume
> >> response. Expose the last resume result to usermode via debugfs so
> >> that usermode can detect and report S0ix timeouts.
> >>
> >> Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > This still needs a platform/chrome Ack.
> >
> >> ---
> >>
> >> Changes in v2:
> >>  - Moved from sysfs to debugfs (Enric)
> >>  - Added documentation (Enric)
> >>
> >>
> >> ---
> >>  Documentation/ABI/testing/debugfs-cros-ec | 22 ++++++++++++++++++++++
> >>  drivers/mfd/cros_ec.c                     |  6 +++++-
> >>  drivers/platform/chrome/cros_ec_debugfs.c |  7 +++++++
> >>  include/linux/mfd/cros_ec.h               |  1 +
> >>  4 files changed, 35 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> >> index 573a82d23c89..008b31422079 100644
> >> --- a/Documentation/ABI/testing/debugfs-cros-ec
> >> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> >> @@ -32,3 +32,25 @@ Description:
> >>              is used for synchronizing the AP host time with the EC
> >>              log. An error is returned if the command is not supported
> >>              by the EC or there is a communication problem.
> >> +
> >> +What:               /sys/kernel/debug/cros_ec/last_resume_result
>
> Thinking about it, as other the other interfaces, I'd do
>
> s/cros_ec/<cros-ec-device>/
>
> I know that for now only cros_ec supports that, but we don't know what will
> happen in the future, specially now that the number of cros devices is incrementing.

See my comment below, I suppose the fate of these two comments are
tied together.

>
> >> +Date:               June 2019
> >> +KernelVersion:      5.3
> >> +Description:
> >> +            Some ECs have a feature where they will track transitions to
> >> +            the (Intel) processor's SLP_S0 line, in order to detect cases
> >> +            where a system failed to go into S0ix. When the system resumes,
> >> +            an EC with this feature will return a summary of SLP_S0
> >> +            transitions that occurred. The last_resume_result file returns
> >> +            the most recent response from the AP's resume message to the EC.
> >> +
> >> +            The bottom 31 bits contain a count of the number of SLP_S0
> >> +            transitions that occurred since the suspend message was
> >> +            received. Bit 31 is set if the EC attempted to wake the
> >> +            system due to a timeout when watching for SLP_S0 transitions.
> >> +            Callers can use this to detect a wake from the EC due to
> >> +            S0ix timeouts. The result will be zero if no suspend
> >> +            transitions have been attempted, or the EC does not support
> >> +            this feature.
> >> +
> >> +            Output will be in the format: "0x%08x\n".
> >> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> >> index 5d5c41ac3845..2a9ac5213893 100644
> >> --- a/drivers/mfd/cros_ec.c
> >> +++ b/drivers/mfd/cros_ec.c
> >> @@ -102,12 +102,16 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >>
> >>      /* For now, report failure to transition to S0ix with a warning. */
> >>      if (ret >= 0 && ec_dev->host_sleep_v1 &&
> >> -        (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> >> +        (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> >> +            ec_dev->last_resume_result =
> >> +                    buf.u.resp1.resume_response.sleep_transitions;
> >> +
> >>              WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
> >>                        EC_HOST_RESUME_SLEEP_TIMEOUT,
> >>                        "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
> >>                        buf.u.resp1.resume_response.sleep_transitions &
> >>                        EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> >> +    }
> >>
> >>      return ret;
> >>  }
> >> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> >> index cd3fb9c22a44..663bebf699bf 100644
> >> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> >> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> >> @@ -447,6 +447,13 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
> >>      debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
> >>                          &cros_ec_uptime_fops);
> >>
> >> +    if (!strcmp(ec->class_dev.kobj.name, CROS_EC_DEV_NAME)) {
>
> For debugfs I don't care having the file exposed even is not supported, anyway
> there are some CROS_EC_DEV_NAME that won't support it, so just make this simple
> and create the file always.

Aw, really? This file is very specific to system suspend/resume. My
original patch had it everywhere, but I was finding it very ugly that
this was showing up on things like the fingerprint device. I can
change it if you think it's better to have it everywhere, but it also
seems like an easy change to make in the future if this file is for
some reason needed on other EC types.

-Evan
