Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A941C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFD82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZF66mpLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfHNHwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:52:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33868 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfHNHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:52:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so7687712otp.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A3FwTQnzXQxQ1tn9puJCL/AccobFRlvOfxXdkmMzNAc=;
        b=ZF66mpLco25PsHUC0Z45Wlas+FiEdMC3mkgmrVy7hzyZGD5YPGjRWRW1CYEAkiei3o
         46MauRHGSRVvFr9uDrdyzuKzaFAtK1YqNdWoJdiF3XHZ+1Rta3dPk3igQlqu+duPJs7n
         pT80bDQF5HDD8IX56+4VUF/v8Pg6dMuY7ZPET0yDJMT3YfA0BVCa7nSlfVRHP5JtFCvC
         71KJPTmobIYH+qGf7HtfsXqHWq3CCGo7joebkNOymI+b3mCibWaoTa3dX4t8ntJR6FiC
         Alqfy5mLpEQmKRBdzxyOMjLhVRupV+nTad5JKv5YELt2yEsfraOg4wsExz6ZM0nd9jj6
         BkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A3FwTQnzXQxQ1tn9puJCL/AccobFRlvOfxXdkmMzNAc=;
        b=UTP87vmIdH7krhrC+yVHM5LTLk9klSUnScDmdQ90o/Bbkwu8OxUi+E/Ip293E+R2yi
         Q+rbgFrFbN9J6ROQKbtcBi1dLzWe7cpsbuQ51eNg2SkeFwUz0/qY4Wc708Zo3kU4jn4j
         qL2i8lFTzW5QnZSWoAQjnrh8DxTGEuEanMeEEFNitHMvrTb9d87jI2hHlrfD0aV4AS4b
         8iYXOvklgwcrvhWvdLs5n1sq3CCPZMObtQf2nSghbGYVr/Y2t2obeeJgpnvb3IRfqz7O
         t+5JwoC4iTUn89CDsd0Iw4RMBTrVphtsizHVtGE+qMRSR2TQm4AFW/QPjv9SVsu6xDea
         YD2w==
X-Gm-Message-State: APjAAAXV6N7o0BC8rHF3vpqsP/lEep1CS4Q3vsfJk6mQnGgA22L+nUkD
        XSBQxvD6gWi6jEOytKPUtVaHN6JxbRHxVcDJNyAA4w==
X-Google-Smtp-Source: APXvYqwrX6eHcXHI70cXxsMFdQLH7Cii35FC5m0TSKZOvb6P4BNQxKbxI0LV5NtKmv0hV1QJkvyKm0Ux1HO9+tNcy3g=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr22188129otr.247.1565769128779;
 Wed, 14 Aug 2019 00:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6a:0:0:0:0:0 with HTTP; Wed, 14 Aug 2019 00:52:08 -0700 (PDT)
In-Reply-To: <20190814073939.ubgzysmkmmel5h4y@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de> <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
 <20190814070121.o53tj2mtky4hcy3n@pengutronix.de> <CAMz4ku+55O6ORVM9xDv4R954QG4PXV8EkcGypSTB5wKni+Dq+Q@mail.gmail.com>
 <20190814073939.ubgzysmkmmel5h4y@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 14 Aug 2019 15:52:08 +0800
Message-ID: <CAMz4ku+Q7CV+0dP1P0hAPJR7KiG0HOkZbT_LPXY4Q03hMuvS8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 14/08/2019, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote=
:
> On Wed, Aug 14, 2019 at 03:25:53PM +0800, Baolin Wang wrote:
>> Hi Uwe,
>>
>> On Wed, 14 Aug 2019 at 15:01, Uwe Kleine-K=C3=B6nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> >
>> > Hello Baolin,
>> >
>> > On Wed, Aug 14, 2019 at 09:51:34AM +0800, Baolin Wang wrote:
>> > > On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-K=C3=B6nig
>> > > <u.kleine-koenig@pengutronix.de> wrote:
>> > > > On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
>> > > > > +- assigned-clock-parents: The phandle of the parent clock of PW=
M
>> > > > > clock.
>> > > >
>> > > > I'm not sure you need to point out assigned-clocks and
>> > > > assigned-clock-parents as this is general clk stuff. Also I wonder
>> > > > if
>> > > > these should be "required properties".
>> > >
>> > > I think I should describe any properties used by PWM node, like
>> > > 'clocks' and 'clock-names' properties, though they are common clock
>> > > properties.
>> >
>> > Then you might want to describe also "status", "assigned-clock-rates",
>> > "pinctrl-$n", "pinctrl-names", "power-domains", "power-domain-names"
>> > and
>> > probably another dozen I'm not aware of.
>>
>> We usually do not describe 'status', but if your device node used
>> "pinctrl-$n", "pinctrl-names" ... common properties, yes, you should
>> describe them to let users know what is the purpose of these
>> properties. That's also asked by DT maintainer Rob.
>
> Does this convince you that you should also describe "pinctrl-$n" and
> the others? If not, why not? We also usually don't describe

Our PWM device node did not use "pinctrl-$n" things, why I should
describe "pinctrl-$n"?
If some devices use pinctrl, yes, they should describe what is the
purpose of pinctrl, see:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Do=
cumentation/devicetree/bindings/mmc/sdhci-sprd.txt

> assigned-clock-parents. For me these are all in the same catagory:

Lots of dt bindings describe 'assigned-clock-parents',:
./Documentation/devicetree/bindings/display/msm/dsi.txt
./Documentation/devicetree/bindings/display/msm/dsi.txt
./Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt
./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
./Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
./Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
./Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
......

> Common properties supported for each devicetree node that represents a
> device. The only difference is that on your board you make use of some
> but not some others.

Fine, let's decide this by PWM maintainer or DT maintainer Rob.

>
>> > > Yes, they are required. Thanks for your comments.
>> >
>> > required in which sense? Why can a Spreadtrum PWM not work when the
>> > clock parents are unspecified?
>>
>> On some Spreadtrum platforms, the default source clock of PWM may not
>> be enabled, so we should force users to select one available source
>> clock for PWM output clock.
>
> Sounds like a bug in the clk tree of your SoC that shouldn't affect how
> the PWM is described in the device tree. After all a parent of a clock
> is supposed to become enabled when the clock gets enabled.

That's not a bug, that's like a MUX, the default source clock of PWM
can be disabled, since we usually do not use the default source clock.
Then we can select a available source clock by the MUX.

--=20
Baolin Wang
Best Regards
