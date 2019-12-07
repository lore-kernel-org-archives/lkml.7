Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20880C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A7924670
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwLvU8VP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLGO5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 09:57:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38279 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLGO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 09:57:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so4901759pfc.5;
        Sat, 07 Dec 2019 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25F5bzK4/aEW3vuFYsWwqmq55HIQLk7YGMrza+DtJYk=;
        b=lwLvU8VPqXvIS3o6aTpmddGf9VoYEWhoYbURlQG4nISMDWSK0buPuAjMny9Jex5cOf
         Z9Qpu/qKOKc319O7WsdXJ2ONLBk5iz7mKfJmGHF85QPnmdwyTOSIv1FtbCIm7uAi+13y
         mVPzBXPbLVLEB5JVuPMDU0mk0YGO1DMrzh0JyUTKnR5kVnQcKOzoXO0Bxylb+X9IsePM
         r/p+NHMwCE1Ye/cgZEuftaDnKQhs6/bb7OmSzZiGYoZncKlnRRFLSstTZAHb53HXo3Eh
         b03zZwpaXjHfvbZDu/nF1UU8u7l4rFmxAyYJNaUx5+DVxkWo0ReDoh+cUzBwTcThLlDK
         MCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25F5bzK4/aEW3vuFYsWwqmq55HIQLk7YGMrza+DtJYk=;
        b=f/6Ti5POmH+VazM5N0jTS7lDD3hX/OrgSJSR8vWmyHyinEUxBaHD8Sa1WOrdYHgLK7
         ybdZYgNPS4BEukJrBIddQERNQ7ic9Hes/mv0wEDNRbqow7iBpP6rYPpbwn1vpCqRT/SG
         tgiP865g/LAV2kRyBI8fz9DUfntTxkY7sx76/Zze85JT2tLfPva+nkIv7euO4JF5J7cz
         blnbtmO58ZCxB4p4/RFGpen1oCjuqOAttA3Ri+ZwHN4m28E7E2ZIkddMLx9QLZmiA/sk
         VpblHWwh+wo5LsBU4i4C+neCufJ3KeGKIQSbj/va534qsfk4Kl8X9F2K9HzfrV7HxtoW
         ko5g==
X-Gm-Message-State: APjAAAXH+awb4YhEi21VqBBMFjkj3KG/5V1ValqWMOV7dMYySkJt2lQV
        cCFp+DnUKl/U8+ug6stQEHeYtVZlD4alKPE9YWw=
X-Google-Smtp-Source: APXvYqyjIGKc8ylr/kEoXJSnBuvclbVGkcG7LR9ZsRoSGTIspPyzHE2q8WlURq5AfG/tML9lgeMLytVZBhxNR6/ABo8=
X-Received: by 2002:a62:7590:: with SMTP id q138mr19721922pfc.241.1575730674313;
 Sat, 07 Dec 2019 06:57:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1566975410.git.rahul.tanwar@linux.intel.com>
 <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190828150951.GS2680@smile.fi.intel.com> <e4a1fd0a-b179-92dd-fb81-22d9d7465a33@linux.intel.com>
 <20190902122030.GE2680@smile.fi.intel.com> <20190902122454.GF2680@smile.fi.intel.com>
 <db9b8978-b9ae-d1bf-2477-78a99b82367a@linux.intel.com>
In-Reply-To: <db9b8978-b9ae-d1bf-2477-78a99b82367a@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Dec 2019 16:57:43 +0200
Message-ID: <CAHp75VdtsXjW5kaWVspi-5u6ya5512Yk7VN4HJ4Tn34PWci5Og@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        robhkernel.org@smile.fi.intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        qi-ming.wu@intel.com, yixin.zhu@linux.intel.com,
        cheol.yong.kim@intel.com, rahul.tanwar@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 7:06 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:
> On 2/9/2019 8:24 PM, Andy Shevchenko wrote:
> > On Mon, Sep 02, 2019 at 03:20:30PM +0300, Andy Shevchenko wrote:
> >> On Mon, Sep 02, 2019 at 03:43:13PM +0800, Tanwar, Rahul wrote:
> >>> On 28/8/2019 11:09 PM, Andy Shevchenko wrote:
> >>>> On Wed, Aug 28, 2019 at 03:00:17PM +0800, Rahul Tanwar wrote:

> >>>>> + { .val = 0, .div = 1 },
> >>>>> + { .val = 1, .div = 2 },
> >>>>> + { .val = 2, .div = 3 },
> >> 1
> >>
> >>>>> + { .val = 3, .div = 4 },
> >>>>> + { .val = 4, .div = 5 },
> >>>>> + { .val = 5, .div = 6 },
> >> 1
> >>
> >>>>> + { .val = 6, .div = 8 },
> >>>>> + { .val = 7, .div = 10 },
> >>>>> + { .val = 8, .div = 12 },
> >> 2
> >>
> >>>>> + { .val = 9, .div = 16 },
> >>>>> + { .val = 10, .div = 20 },
> >>>>> + { .val = 11, .div = 24 },
> >> 4
> >>
> >>>>> + { .val = 12, .div = 32 },
> >>>>> + { .val = 13, .div = 40 },
> >>>>> + { .val = 14, .div = 48 },
> >> 8
> >>
> >>>>> + { .val = 15, .div = 64 },
> >> 16
> >>
> >>
> >> So, now we see the pattern:
> >>
> >>      div = val < 3 ? (val + 1) : (1 << ((val - 3) / 3));
> > It's not complete, but I think you got the idea.
> >
> >> So, can we eliminate table?
>
> In the desperation to eliminate table, below is what i can come up with:
>
>         struct clk_div_table div_table[16];

But this is not an elimination, it's just a replacement from static to
dynamically calculated one.

>         int i, j;
>
>         for (i = 0; i < 16; i++)
>                 div_table[i].val = i;
>
>         for (i = 0, j=0; i < 16; i+=3, j++) {
>                 div_table[i].div = (i == 0) ? (1 << j) : (1 << (j + 1));
>                 if (i == 15)
>                         break;
>
>                 div_table[i + 1].div = (i == 0) ? ((1 << j) + 1) :
>                                         (1 << (j + 1)) + (1 << (j - 1));
>                 div_table[i + 2].div = (3 << j);
>         }
>
> To me, table still looks a better approach. Also, table is more extendable &
> consistent w.r.t. clk framework & other referenced clk drivers.
>
> Whats your opinion ?

Whatever CCF maintainers is fine with.

--
With Best Regards,
Andy Shevchenko
