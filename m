Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED34C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 21:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887C720673
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 21:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPBKUG8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfFVVqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 17:46:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33144 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVVqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 17:46:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id f80so7110444oib.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IQxmn+d/vzJxXJMTpbS06OU2+1PIYH2ZEA34BMxwa+Q=;
        b=tPBKUG8jMZNVyHZC7oXhpXNwk7HJ/pUQe+sGcVz33ooGXgD6vJ74JcnldSdcftvZKZ
         ZeKGN1i46kiJQSZE+wawRulzaOc4pM5bPYUgP95aiK0oZtGye/LMFu8RwdSW8E9ZlTBv
         c4lw5QFlEVvulmyluOemgxrYe+AjuqduiuM7LJrSn1QdV1ER+PzpM2u9M0DTBqPpHTkQ
         knxSGvU/JCs9bRuWQN7JirguWN1boQMcxZFRVBo1fsnBEJF/KC0Xpwcxzvh2ZeERCzur
         was3YkohPrSTvzW+HCpulz41hRMYfPopBILIdb8tRMUa5b/3h/a82eWQIi1V5rOD3A/2
         fwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IQxmn+d/vzJxXJMTpbS06OU2+1PIYH2ZEA34BMxwa+Q=;
        b=nzFEw1usrR63CeFjSoAqbXv4iq3gcl3Xc0dA49FJPudPMdkPSCzhiw5z3Lfh5zLVDg
         Lq2y1YJYCOa2SNHBHRyYkhSWJ6Doc/RxNqGCVuRH8ZimjMOdq/HcVRSMkpYCTXX/QS31
         QvNcE3bROrmVmxU7m5LZetVtyzalo0bBICZMo7ZV4L9S5cS8hfKAqqd4KHipvL0j0M5r
         F5176lTmbqeMQVw15GG7lHPm6df8HOLnVEVCAja+wFcKmeeyqVjREoqSIh8KJVg+6o0V
         fekxpgvZ4P33taOU4z7VaMIP9Bnhf/iJDv6ijQT3FgMZmfgoWYqvqyv6waKi6FWM7Tx1
         KHsg==
X-Gm-Message-State: APjAAAVAMUrPxgE/xWdzp3DxT1gI44AH2M+87pp/OB/NsLOkh+kLG02E
        DoodqHdfz447v0PSRY0a8pCnoaw2d+lgVLOpY5V/Dg==
X-Google-Smtp-Source: APXvYqzkDDd7UskURLH6vHR59mauMZIEIHiF1rywaf7LmTtrrmqMh+fNNf+0CzPkX+9w1zD/J01B+JpoE0Ak5QYDuLI=
X-Received: by 2002:a05:6808:6c7:: with SMTP id m7mr6421578oih.43.1561239979958;
 Sat, 22 Jun 2019 14:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190622003449.33707-4-saravanak@google.com>
 <CAGTfZH1COWzhDBr63S18md44ypKixstHHsX7cm5LnAhXXbfecA@mail.gmail.com>
In-Reply-To: <CAGTfZH1COWzhDBr63S18md44ypKixstHHsX7cm5LnAhXXbfecA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 22 Jun 2019 14:45:44 -0700
Message-ID: <CAGETcx8QcAw937Q5kW7BOKFfB+=obB9pXj25pAuQUAXNMOwkjQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM / devfreq: Add required OPPs support to passive governor
To:     cwchoi00@gmail.com
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 5:01 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Hi,
>
> Absolutely, I agree this approach.

Thanks!

> But, I add some comments on below. please check them.
>
> 2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9:36,=
 Saravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > Look at the required OPPs of the "parent" device to determine the OPP t=
hat
> > is required from the slave device managed by the passive governor. This
> > allows having mappings between a parent device and a slave device even =
when
> > they don't have the same number of OPPs.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/devfreq/governor_passive.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/gover=
nor_passive.c
> > index 3bc29acbd54e..bd4a98bb15b1 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -21,8 +21,9 @@ static int devfreq_passive_get_target_freq(struct dev=
freq *devfreq,
> >         struct devfreq_passive_data *p_data
> >                         =3D (struct devfreq_passive_data *)devfreq->dat=
a;
> >         struct devfreq *parent_devfreq =3D (struct devfreq *)p_data->pa=
rent;
> > +       struct opp_table *opp_table =3D NULL, *c_opp_table =3D NULL;
>
> In this function, the base device is passive devfreq device.
> So, I think that better to define the 'parent_opp_table' instead of 'opp_=
table'
> indicating the OPP table of parent devfreq device. And better to define
> just 'opp_table' instead of 'c_opp_table' indicating the passive devfreq =
device.
> - opp_table -> parent_opp_table
> - c_opp_table -> opp_table

Sounds good. I did it that way at first, but I wanted to keep the diff
simple in my first patch series. So renamed it. I can do the rename
that you suggested. Makes sense to me.

> >         unsigned long child_freq =3D ULONG_MAX;
> > -       struct dev_pm_opp *opp;
> > +       struct dev_pm_opp *opp =3D NULL, *c_opp =3D NULL;
>
> Ditto. I think that better to define the variables as following:
> - opp -> parent_opp
> - c_cpp -> opp

Will do.

>
> >         int i, count, ret =3D 0;
> >
> >         /*
> > @@ -65,7 +66,20 @@ static int devfreq_passive_get_target_freq(struct de=
vfreq *devfreq,
> >                 goto out;
> >         }
> >
> > -       dev_pm_opp_put(opp);
> > +       opp_table =3D dev_pm_opp_get_opp_table(parent_devfreq->dev.pare=
nt);
>
> devfreq_passive_get_target_freq() is called frequently for DVFS support.
> I think that you have to add 'struct opp_table *opp_table' instance to
> 'struct devfreq'
> and then get 'opp_table' instance in the devfreq_add_device().

Sounds good. I had wanted to do that anyway, but didn't think it was
part of this series. But I can add that change to this series.

> devfreq_add_device() already get the OPP information by using
> dev_pm_opp_get_suspend_opp_freq().
> You can add following code nearby dev_pm_opp_get_suspend_opp_freq() in
> devfreq_add_device().
> - devfreq->opp_table =3D dev_pm_opp_get_opp_table(dev);

Will do something like that.

I'll send out an updated patch series on Monday or Tuesday. Hopefully
Viresh would have replied by then to give his opinion on whether this
is okay by him.

Thanks,
Saravana
