Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A1C43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F197206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iKQy7pcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404039AbfIEUrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:47:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34167 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfIEUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:47:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so3664722otp.1;
        Thu, 05 Sep 2019 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hpe67X407tYeVqfqBtx1jH+uTg6tH8jR8FjjDadQp48=;
        b=iKQy7pcK0+Aeu3voToJo4z1xhtUcKL/cjAGPDL1dk5XMxb+QXiVvcJoGUZtgExUzeI
         0hKt0/2ycoBwf5Z5px0oYNSi7eDdWCwY1ozNcT6q2VFHCaOwxI3WE9BvckNlXDy/i9hJ
         V+2OFzq+TS1o62Qa8oTi0Gi5XnvMDgkhQ9d3EJkUCkce02hswivWIozI2vLA3iLBcfOT
         EKuLOV494WmLcFsmKFRHBw7xtch424iX/B3Rc0WDxErtSkb5t/zMcVjpVArtPZwcXPTv
         343poVAErivgK65+70F89MRATt/aK8bBqAkttohiPgY+X5jaAjAxw1azr+yv0RasNH07
         SpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hpe67X407tYeVqfqBtx1jH+uTg6tH8jR8FjjDadQp48=;
        b=K4P+HdWUL0H+u3UvA1wLCvqLQSycYyncCE5cLlBoDAt84fkdBJBU1QpiWNjc0ITPbW
         oc/f49eIzfWSqAZ7a3HrDT5MNRsHfF40dXfaffmY9MbgsZ0VWCpsFxH2l/iZ/KunurLm
         Y4p850vsdpseeCC9noyT8LdC3XbK3v6WlKYJghDbVNZ9iQEXUo2hQ2lhdTyyFyXqGChl
         OKcAe+9OpfFnWAPHTl23Z4m/BhRW7szrF1pgdGw8enkRq7OUmOIc5G3BCE4veJbmNV7Z
         NLh1Xee1ua8tcLFLzAv/7y0SniIhVVmWCZUA2xCEUFQ11Q/bKjOIfXkG5PWJy6a08SDQ
         z1kQ==
X-Gm-Message-State: APjAAAVEhcjrkzo3Eez7GqLG1GEbAcd5Jn1I3DQl6fhgxZvho+Qwcdtq
        039NlITugVA+wIoQhblW46dsK5mDAfNUenTvdXc=
X-Google-Smtp-Source: APXvYqxBMSHXDs1QQOhrT5ERhwwBvzG1utnZHIaaBimzhgUetRGpQI2B9o8vZcXvI+RHZcyVr430j2kSYmOU1uYY5Ps=
X-Received: by 2002:a9d:12e7:: with SMTP id g94mr3041613otg.6.1567716454237;
 Thu, 05 Sep 2019 13:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
 <d9e96dab-96be-0c14-b7af-e1f2dc07ebd2@linux.intel.com> <CAFBinCARQJ7q9q3r6c6Yr2SD0Oo_Drah-kxss3Obs-g=B1M28A@mail.gmail.com>
 <b7920723-1df2-62df-61c7-98c3a1665aa1@linux.intel.com>
In-Reply-To: <b7920723-1df2-62df-61c7-98c3a1665aa1@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 5 Sep 2019 22:47:23 +0200
Message-ID: <CAFBinCA+J-HnXfRnquqviXvX0Jo84hoLC9=_uHbyWKZycwyAFw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robh@kernel.org, sboyd@kernel.org, yixin.zhu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On Wed, Sep 4, 2019 at 10:04 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:
>
>
> Hi Martin,
>
> On 4/9/2019 2:53 AM, Martin Blumenstingl wrote:
> >> My understanding is that if we do not use syscon, then there is no
> >> point in using regmap because this driver uses simple 32 bit register
> >> access. Can directly read/write registers using readl() & writel().
> >>
> >> Would you agree ?
> > if there was only the LGM SoC then I would say: drop regmap
> >
> > however, last year a driver for the GRX350/GRX550 SoCs was proposed: [0]
> > this was never updated but it seems to use the same "framework" as the
> > LGM driver
> > with this in mind I am for keeping regmap support because.
> > I think it will be easier to add support for old SoCs like
> > GRX350/GRX550 (but also VRX200), because the PLL sub-driver (I am
> > assuming that it is similar on all SoCs) or some other helpers can be
> > re-used across various SoCs instead of "duplicating" code (where one
> > variant would use regmap and the other readl/writel).
>
>
> Earlier, we had discussed about it in our team.  There are no plans to
> upstream mips based platform code, past up-streaming efforts for mips
> platforms were also dropped. GRX350/GRX550/VRX200 are all mips
> based platforms. Plan is to upstream only x86 based platforms. In-fact,
> i had removed GRX & other older SoCs support from this driver before
> sending for review. So we can consider only x86 based LGM family of
> SoCs for this driver & all of them will be reusing same IP.
this is very sad news
as far as I can tell many IP cores are similar/identical on
GRX350/GRX550, LGM and even VRX200

I already know that VRX200 is a legacy product and you won't be supporting it
once LGM support lands upstream you could add support for
GRX350/GRX550 with small to medium effort
that is a big win (in my opinion) because it means happier end-users
(see XWAY and VRX200 support in OpenWrt for example: while support
from Intel/Lantiq has died long ago these devices can still run a
recent LTS kernel and get security updates. without OpenWrt these
devices would probably end up as electronic waste)

maybe implementing a re-usable regmap clock driver (for mux, gate and
divider) means less effort (compared to converting everything to
standard clock ops) for you.
(we did the switch from standard clock ops to regmap for the Amlogic
Meson clock drivers when we discovered that there were some non-clock
registers that belong to other IP blocks in it and it was a lot of
effort)
this will allow you to add support for GRX350/GRX550 in the future if
demand for upstream drivers rises.


Martin
