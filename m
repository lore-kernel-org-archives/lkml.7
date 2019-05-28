Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB33C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E949920883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHfXJIyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfE1Mj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:39:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42476 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfE1Mj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:39:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so3634324eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybsMUgY6ounJuaGDtEKhAz+yC4cA28XUN/3YPkPsJiU=;
        b=NHfXJIytPkkYgJ6rar0p4QA9KmqbIkxKsQ0CHv26Br6zjd6780zyDBv19RY/Winab9
         lMf6H5okEJ2jEqcNbR0ApwdBAMFcKg1oOK2kd6e2xaOcE/VJ1qqYmkFA165hAMBNH55b
         wMOdPYxgSh4aQ97AFz73SKI/zi+9OAO7hM46m8Z/kcXS5UrDzaLjzT8RGktH5cOTHGIV
         lXqMWRs+dXQeItJ6SZPReiyJtb9p48f2isx3NR87g1eWDce88MfLS+XnSEyM7J2o7guf
         ytPjeyC9Zk63P/3zCc4kIDmyqf/ujmHbAGdLIPekeNHUnOXwiFvxBDUwktm1lUewEWKE
         gsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybsMUgY6ounJuaGDtEKhAz+yC4cA28XUN/3YPkPsJiU=;
        b=AMiz61C2rqHQSxG/ZnrPqe+FBszx8E2OTTorJq+jIc4IyL1rvo7d/IhE3KHr3kt6i8
         W5TieCYecynP1wwMeVX6SDVVjgzC6xGKisXtDuW90kAzMWuU8OwGvWL9y4yh27c8LoM6
         rksWSDmQ1HuLTM/YwtOba8RHuwhV9/+YIoDOZyZtFOZpdjd5JaqJOxzsdtgxDFSEQ5VM
         84y2jez93Z3nLYpo4mukagBF+b7pQ0nn+fEi2qiA1mAhr5Mn9u3qhQvJmx3iXVDC/+eu
         m+mZLJvDo+2xFn8yr8xFSRRcpwPh0WRMyVz/un7z/U5f/bUiCl4fLu+hsiW2nNkXQTE+
         4Fhw==
X-Gm-Message-State: APjAAAXKeMWoD+fHmYwTV2a+pd3PRegmYsoZTHjVaWvmsMrd6HCg88m3
        t6pbjJhMSY86+tBsSmKuurIpyTNdP8ub0xp/mgA=
X-Google-Smtp-Source: APXvYqyiW3RuSm/Q5M7JS9tflgiot/Qc9jsuaXF8ZguxiXKGN8hQI2qQzZtasetqxOX7iKiUAzBfDfkTceixKP5vhV8=
X-Received: by 2002:a17:906:f194:: with SMTP id gs20mr15974716ejb.177.1559047196254;
 Tue, 28 May 2019 05:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190420154038.14576-1-daniel.baluta@nxp.com> <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
 <20190421080439.GA8784@Asurada> <20190421082627.GB8304@Asurada>
In-Reply-To: <20190421082627.GB8304@Asurada>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 28 May 2019 15:39:44 +0300
Message-ID: <CAEnQRZD6nNH04xZjpSi7ozL=sNJvJdkEAGAYQStJESeu_2R=Eg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 11:26 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Apr 21, 2019 at 01:04:39AM -0700, Nicolin Chen wrote:
> > On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > > > Firstly, according to your commit message, neither imx8qm nor
> > > > imx6sx has an "mclk0" clock in the clock list. Either of them
> > > > starts with "mclk1". So, before you change the driver, I don't
> > > > think it's even a right thing to define an "mclk0" in the DT.
> > >
> > > From what I understand mclk0 means option 00b of MSEL bits which is:
> > > * busclk for i.MX8
> > > * mclk1 for i.MX6/7.
> >
> > MSEL bit is used for an internal clock MUX to select four clock
> > inputs. However,  these four clock inputs aren't exactly 1:1 of
> > SAI's inputs. As fas as I can tell, SAI only has one bus clock
> > and three MCLK[1-3]; the internal clock MUX maps the bus clock
> > or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
> > inputs[1-3]. So it doesn't sound right to me that you define an
> > "MCLK0" in the DT, as it's supposed to describe input clocks of
> > SAI block, other than its internal clock MUX's.
>
> Daniel, I think I's saying this too confident, though I do feel
> so :) But if you can prove me wrong and justify that there is an
> "MCLK0" as an external input of the SAI block, I will agree with
> this change.

Looking inside the RTL for SAI on i.MX8 I found that there
is a MUX with 4 inputs exactly as RM says:
- bus
- master clock 1
- master clock 2
- master clock 3

My point is that the DT is modelling the internal clock MUX
used for SAI to select its clock source.

thanks,
Daniel.
