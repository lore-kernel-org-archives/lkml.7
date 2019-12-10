Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8DEC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9485D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NqY1B5Lj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLJUFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:05:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42316 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:05:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so16668201otd.9;
        Tue, 10 Dec 2019 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffu1c8lDFafmMWH7UIK/Jm4IFvQzvK0JEWcwhE/AfdQ=;
        b=NqY1B5LjJU0vM1d4WpeD0ZeoqgIt8hI6csNKV63oMHCy3CIGP/mE+VFXtRsCWysuOH
         cBLhJFhVVWspwhg/0iJ+LYahN59cIYX4PzSNnSoLhTclj18oWAVTNbPbGXKwVUcG1m5b
         vIqO9tIcWm1mHn3TDhenvm/Kb7y5VviWObIh9zOffAVbOM+2BsUKYe/3mp7ItszjjpU7
         4r0dzTo0MHzXV0SdMbgtbegD81UW42uChbRS654dX25anJKmSBszdBRt0XPRpcJGh616
         Zi7BSVuJofr6eR1H3qChHVMLTUpJyFOV8FSWll960WfMQRcJGW+9xU5/6Be4ts7TsrE1
         dVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffu1c8lDFafmMWH7UIK/Jm4IFvQzvK0JEWcwhE/AfdQ=;
        b=WTd3AbWGofBBIl6yvzkncMGPhFjibDOCy5STmhtT3w+33Gze4vLtl159i+lZmpUn8Q
         TZpbUyaP4HyzLC3vkoyzx8z1iudHznYi89OpHFbKUcXM6gBJm37C/OAg6Ldbts3VYLyl
         +QnH51MuFMoqjHZNMPej/Nt20yh2V9VCqZ9g8iUp1xepRqB3tlt2YRgAWaFG0h1IXR21
         yqyzTbYTPIbdMpG+VRJ0k8kNMCb9z97V+FnlzjvroO6YvUr5Gb4V2HaoIQpDEYLLYyJS
         O0KChN2lgEav1NOmdUpFkP/xBl6rAbjC7TbFDqQg+mmNpOocNQFyneDvQKAZplB6ky6L
         CQ7A==
X-Gm-Message-State: APjAAAUA5jJ5r7LmNb57sehwLa1K+SUjJjeNus9fjnmtVCXB0zg2whZR
        2a4v+WBsV//s9L6kUTf+6yejLO2u8PqwoBHBcy0=
X-Google-Smtp-Source: APXvYqyQXxbMb0eeNtonRVid5JNsQL8VWcdzxoDr8Caq2Q5ouK3M+5t6gh12myZjJdQRIwE/4kJ8HDen46CJJDc7XCI=
X-Received: by 2002:a05:6830:1b71:: with SMTP id d17mr19510797ote.42.1576008301566;
 Tue, 10 Dec 2019 12:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20191101143126.2549-1-linux.amoon@gmail.com> <7hfthtrvvv.fsf@baylibre.com>
 <c89791de-0a46-3ce2-b3e2-3640c364cd0f@baylibre.com> <CANAwSgQx3LjQe60TGgKyk6B5BD5y1caS2tA+O+GFES7=qCFeKg@mail.gmail.com>
 <7hfthsqcap.fsf@baylibre.com>
In-Reply-To: <7hfthsqcap.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 10 Dec 2019 21:04:50 +0100
Message-ID: <CAFBinCBfgxXhPKpBLdoq9AimrpaneYFgzgJoDyC-2xhbHmihpA@mail.gmail.com>
Subject: Re: [RFC-next 0/1] Odroid C2: Enable DVFS for cpu
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 7:13 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Hi Neil / Kevin,
> >
> > On Tue, 10 Dec 2019 at 14:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> On 09/12/2019 23:12, Kevin Hilman wrote:
> >> > Anand Moon <linux.amoon@gmail.com> writes:
> >> >
> >> >> Some how this patch got lost, so resend this again.
> >> >>
> >> >> [0] https://patchwork.kernel.org/patch/11136545/
> >> >>
> >> >> This patch enable DVFS on GXBB Odroid C2.
> >> >>
> >> >> DVFS has been tested by running the arm64 cpuburn
> >> >> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> >> >> PM-QA testing
> >> >> [2] https://git.linaro.org/power/pm-qa.git [cpufreq testcase]
> >> >>
> >> >> Tested on latest U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM
> >> >
> >> > Have you tested with the Harkernel u-boot?
> >> >
> >> > Last I remember, enabling CPUfreq will cause system hangs with the
> >> > Hardkernel u-boot because of improperly enabled frequencies, so I'm not
> >> > terribly inclined to merge this patch.
> >
> > HK u-boot have many issue with loading the kernel, with load address
> > *it's really hard to build the kernel for HK u-boot*,
> > to get the configuration correctly.
> >
> > Well I have tested with mainline u-boot with latest ATF .
> > I would prefer mainline u-boot for all the Amlogic SBC, since
> > they sync with latest driver changes.
>
> Yes, we would all prefer mainline u-boot, but the mainline kernel needs
> to support the vendor u-boot that is shipping with the boards.  So
> until Hardkernel (and other vendors) switch to mainline u-boot we do not
> want to have upstream kernel defaults that will not boot with the vendor
> u-boot.
>
> We can always support these features, but they just cannot be enabled
> by default.
(I don't have an Odroid-C2 but I'm curious)
should Anand submit a patch to mainline u-boot instead? the
&scpi_clocks node could be enabled at runtime by mainline u-boot


Martin
