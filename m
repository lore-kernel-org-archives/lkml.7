Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F07C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB53E217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mog5DRJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfDEJyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:54:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35026 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbfDEJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:54:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so6662447qte.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 02:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1D/0M9h9S3sCpW1UVMdtL+Iw0wVieOgXITMxUjOQunM=;
        b=mog5DRJ+qj0+fCq7bja9IDDTWuDs/9aZvnOeBWUrrKbFXaSwCoKklIqpIjyZC+Z/Lr
         FnR+yUS7AfWtbsRqU1Ek+eKEKMet6Yn+8WfaQ1ZC3Tqs1BTKmE2LUtpn8NCgsFeHhMgX
         Yiz+s4EwMfv8V/SvWIQBx2bVlszIOvU6pxqkaOClgBnjEzcTpdTT0dYf0xpEKWkp/bJA
         ISsf46So3Q3WSWFxpb+OhyR/kZKzYj5pazLobtxwZIABD5REiFjwSsgWk+HmsrNh+6AP
         66cSsBvpTeEbk3SCJx/OlPFtT6yRHNRJf8dN3fPlS9t5oQBZfgsQQ0UpIzeG5p25yGjj
         Olug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1D/0M9h9S3sCpW1UVMdtL+Iw0wVieOgXITMxUjOQunM=;
        b=l+gy2vm6G6+laIgfRCQXNv9n9otdOxnybcFr334uv4jf1U0TyfVA2YkdiL87y46R3B
         MxAgypbd+owdXjN82BBtTrWZV1qzSUCZxVs0jVnQld+DQ7MRVSz400sELEwfY5gSEevx
         RtSMke8WnOCd1y/PF7QvG6nGv/9rCNWHEl2fhLcfx29xI1crFhwXM8w/RElrt3UUTvkl
         yZ8PO91q8dhawFJe3T+CsRxo0khfhKrhNUpo0SF9bpzACxNSaz60DcHnvD5qcKu1qbEW
         80WD9nVJM0Zo0y3CikssW9d+OdYWC+dWqz2dW2c2f1RjnNznNqKS+BIPdwGXChaQTi4m
         DWMQ==
X-Gm-Message-State: APjAAAVt0YiOzUT8YoI/BW62u48OkOBs7RRqMc6574y13JYMRKOz/dy9
        NsFHvWgz7Lz6NjZbNaif9zxgWj3TBRl67baz7Ho=
X-Google-Smtp-Source: APXvYqyLrYctk91YTsqvvfgbBMH+72W/XlHeppbjcIf58eDb4Ejw+BXgygj9CZP8pTp8QvNfN47Ek0m1w1NEgpHFcQ4=
X-Received: by 2002:a0c:b523:: with SMTP id d35mr9348389qve.104.1554458054913;
 Fri, 05 Apr 2019 02:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190403213428.89920-1-evgreen@chromium.org> <20190403213428.89920-2-evgreen@chromium.org>
 <CACK8Z6FMA+9+t4bs4AxwAHi02fSO8Q-1rmxuiXdeh491X-1erg@mail.gmail.com>
In-Reply-To: <CACK8Z6FMA+9+t4bs4AxwAHi02fSO8Q-1rmxuiXdeh491X-1erg@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 5 Apr 2019 11:54:03 +0200
Message-ID: <CAFqH_53G+dc5nGTNZV=5ec=uRaahObLopus3GVY58ktQfRYNKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mfd: cros_ec: Add host_sleep_event_v1 command
To:     Rajat Jain <rajatja@google.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missatge de Rajat Jain <rajatja@google.com> del dia dj., 4 d=E2=80=99abr. 2=
019
a les 20:40:
>
> On Wed, Apr 3, 2019 at 2:34 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > Introduce the command and response structures for the second revision
> > of the host sleep event. These structures are part of a new EC change
> > that enables detection of failure to enter S0ix. The EC waits a
> > kernel-specified timeout (or a default amount of time) for the S0_SLP
> > pin to change, and wakes the system if that change does not occur in
> > time.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Rajat Jain <rajatja@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>
> >
> > ---
> >
> > Changes in v3: None
> > Changes in v2:
> > - Made unions anonymous
> > - Replaced reserved union members with a comment
> >
> >  include/linux/mfd/cros_ec_commands.h | 57 ++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/c=
ros_ec_commands.h
> > index fc91082d4c35..1cdb07c0ece1 100644
> > --- a/include/linux/mfd/cros_ec_commands.h
> > +++ b/include/linux/mfd/cros_ec_commands.h
> > @@ -2729,6 +2729,63 @@ struct ec_params_host_sleep_event {
> >         uint8_t sleep_event;
> >  } __packed;
> >
> > +/*
> > + * Use a default timeout value (CONFIG_SLEEP_TIMEOUT_MS) for detecting=
 sleep
> > + * transition failures
> > + */
> > +#define EC_HOST_SLEEP_TIMEOUT_DEFAULT 0
> > +
> > +/* Disable timeout detection for this sleep transition */
> > +#define EC_HOST_SLEEP_TIMEOUT_INFINITE 0xFFFF
> > +
> > +struct ec_params_host_sleep_event_v1 {
> > +       /* The type of sleep being entered or exited. */
> > +       uint8_t sleep_event;
> > +
> > +       /* Padding */
> > +       uint8_t reserved;
> > +       union {
> > +               /* Parameters that apply for suspend messages. */
> > +               struct {
> > +                       /*
> > +                        * The timeout in milliseconds between when thi=
s message
> > +                        * is received and when the EC will declare sle=
ep
> > +                        * transition failure if the sleep signal is no=
t
> > +                        * asserted.
> > +                        */
> > +                       uint16_t sleep_timeout_ms;
> > +               } suspend_params;
> > +
> > +               /* No parameters for non-suspend messages. */
> > +       };
> > +} __packed;
> > +
> > +/* A timeout occurred when this bit is set */
> > +#define EC_HOST_RESUME_SLEEP_TIMEOUT 0x80000000
> > +
> > +/*
> > + * The mask defining which bits correspond to the number of sleep tran=
sitions,
> > + * as well as the maximum number of suspend line transitions that will=
 be
> > + * reported back to the host.
> > + */
> > +#define EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK 0x7FFFFFFF
> > +
> > +struct ec_response_host_sleep_event_v1 {
> > +       union {
> > +               /* Response fields that apply for resume messages. */
> > +               struct {
> > +                       /*
> > +                        * The number of sleep power signal transitions=
 that
> > +                        * occurred since the suspend message. The high=
 bit
> > +                        * indicates a timeout occurred.
> > +                        */
> > +                       uint32_t sleep_transitions;
> > +               } resume_response;
> > +
> > +               /* No response fields for non-resume messages. */
> > +       };
> > +} __packed;
> > +
> >  /*********************************************************************=
********/
> >  /* Smart battery pass-through */
> >
> > --
> > 2.20.1
> >
