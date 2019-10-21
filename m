Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477CFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EBB2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8sEDm9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfJUUva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:51:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfJUUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:51:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so7218904plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S5KlEma+Te0JRIP8bw41KAfW+1DzZQZbAgKyidpuY/k=;
        b=n8sEDm9Ud2OM3iG03bSHy7mXXfIJCx5q1ExBCF2mgcCNUJRxPywDCLiidpw2NTr5j4
         IHh9+x5r/rQe3jT8e/NaJkc1ZgN8OThUm7oiBkeEjbP1Tv1jPpgNF7lwP7w3bCXrqpHF
         c7yfxLE+jer8Ss9LLPLLfqc4asJTqeB/QgkME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S5KlEma+Te0JRIP8bw41KAfW+1DzZQZbAgKyidpuY/k=;
        b=D6t/ia1rnu8qGtW1e5SNxm20wXeZzAo0FdKQAWwZ9tdfRweVkEN0BS+UsChP7wuhuE
         IS2wYD2LQZAQ4nrMRR9/1yACxaG0H2Zkwg5jR61ViVTzLndDAC6H1NT9/EXf0rfmJGgz
         Wu2FEqjhT9CB9Nye+YPuzCS3r8H+83rOwIiihVAQgqMznTIjWndceEjxBfGzJ9isjrOf
         0i+lrWTWeCFrPLwHjp5fl6QgzLimysxtJnt6TPTfHzBuFh2KFBArg1gA1m+ywLqA5PnH
         UIZun6AC4OFQ3H5dKAIpTyBoAaiqiJBJK+6P/3WY9PqY1IoGzdc0TfRo7wU6tEcQ/b82
         sKeg==
X-Gm-Message-State: APjAAAVyrGRfMBoUFyFtmznLfGPwNU3TS2WBsczL9cWSdZg8g6cj4v63
        kQ4/LJZzpiWlDGXUwPvmNeTdFw==
X-Google-Smtp-Source: APXvYqwfmG6hfHfwTv2A6q1gev8HkkkIp06vHVx91/hxmM2GEz9z3Imng3gRp2v6Hlm26ZuPv2Ubgw==
X-Received: by 2002:a17:902:6b05:: with SMTP id o5mr26537601plk.33.1571691088730;
        Mon, 21 Oct 2019 13:51:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 22sm16628246pfo.131.2019.10.21.13.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:51:28 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:51:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8998: Fixup uart3 gpio config
 for bluetooth
Message-ID: <20191021205127.GH20212@google.com>
References: <20191021161921.31825-1-jeffrey.l.hugo@gmail.com>
 <20191021195851.GG20212@google.com>
 <CAOCk7NpkStP7MNAPtEPZwe=otZAKFa7YAc-A=+_ad4yy6O_RVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOCk7NpkStP7MNAPtEPZwe=otZAKFa7YAc-A=+_ad4yy6O_RVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 02:28:46PM -0600, Jeffrey Hugo wrote:
> On Mon, Oct 21, 2019 at 1:58 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On Mon, Oct 21, 2019 at 09:19:21AM -0700, Jeffrey Hugo wrote:
> > > It turns out that the wcn3990 can float the gpio lines during bootup, etc
> > > which will result in the uart core thinking there is incoming data.  This
> > > results in the bluetooth stack getting garbage.  By applying a bias to
> > > match what wcn3990 would drive, the issue is corrected.
> > >
> > > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > > ---
> > >
> > > v2:
> > > -split out pinctrl config by pin
> > >
> > >  .../boot/dts/qcom/msm8998-clamshell.dtsi      | 22 ++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi     | 22 ++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/msm8998-pins.dtsi    | 25 ++++++++++++++++---
> > >  3 files changed, 65 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> > > index 38a1c2ba5e83..8c9a3e0f3843 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
> > > @@ -37,6 +37,28 @@
> > >       };
> > >  };
> > >
> > > +&blsp1_uart3_on {
> > > +     rx {
> > > +             /delete-property/ bias-disable;
> > > +             /*
> > > +              * Configure a pull-up on 45 (RX). This is needed to
> > > +              * avoid garbage data when the TX pin of the Bluetooth
> > > +              * module is in tri-state (module powered off or not
> > > +              * driving the signal yet).
> > > +              */
> > > +             bias-pull-up;
> > > +     };
> > > +
> > > +     cts {
> > > +             /delete-property/ bias-disable;
> > > +             /*
> > > +              * Configure a pull-down on 47 (CTS) to match the pull
> > > +              * of the Bluetooth module.
> > > +              */
> > > +             bias-pull-down;
> > > +     };
> > > +};
> > > +
> > >  &qusb2phy {
> > >       status = "okay";
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> > > index 8adb4969baec..74c14f50b0f6 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> > > @@ -37,6 +37,28 @@
> > >       };
> > >  };
> > >
> > > +&blsp1_uart3_on {
> > > +     rx {
> > > +             /delete-property/ bias-disable;
> > > +             /*
> > > +              * Configure a pull-up on 45 (RX). This is needed to
> > > +              * avoid garbage data when the TX pin of the Bluetooth
> > > +              * module is in tri-state (module powered off or not
> > > +              * driving the signal yet).
> > > +              */
> > > +             bias-pull-up;
> > > +     };
> > > +
> > > +     cts {
> > > +             /delete-property/ bias-disable;
> > > +             /*
> > > +              * Configure a pull-down on 47 (CTS) to match the pull
> > > +              * of the Bluetooth module.
> > > +              */
> > > +             bias-pull-down;
> > > +     };
> > > +};
> > > +
> > >  &blsp2_uart1 {
> > >       status = "okay";
> > >  };
> > > diff --git a/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
> > > index e32d3ab395ea..7c222cbf19d9 100644
> > > --- a/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
> > > @@ -77,13 +77,30 @@
> > >       };
> > >
> > >       blsp1_uart3_on: blsp1_uart3_on {
> > > -             mux {
> > > -                     pins = "gpio45", "gpio46", "gpio47", "gpio48";
> > > +             tx {
> > > +                     pins = "gpio45";
> > >                       function = "blsp_uart3_a";
> > > +                     drive-strength = <2>;
> >
> > Should the drive-strength really be configured in the .dtsi
> > of the SoC? I think of it as a board specific property, since it
> > depends on what is on the other end of the UART.
> 
> I'm mostly waiting to see what Bjorn would like, but I see some value
> in providing decent, sane defaults to work with to start.  The
> documentation I see indicates that the uart function isn't expected to
> exceed a 2mA sink/source drive.

Ok, if it's a requirement of the UART function it seems reasonable to
configure it as default.

> >
> > > +                     bias-disable;
> >
> > This seems reasonable since the SoC drives the TX pin.
> >
> > >               };
> > >
> > > -             config {
> > > -                     pins = "gpio45", "gpio46", "gpio47", "gpio48";
> > > +             rx {
> > > +                     pins = "gpio46";
> > > +                     function = "blsp_uart3_a";
> > > +                     drive-strength = <2>;
> >
> > 'drive-strength' shouldn't be needed for an input pin
> 
> The hardware always configures a drive strength, its also indicates
> how much the SoC is willing to sink.

Thanks, I wasn't aware that the drive-strength also applies to the sink.
