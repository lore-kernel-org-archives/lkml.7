Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11A4C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857ED208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561362104;
	bh=L6gUqCG8drdlw0JNPTw4WV1Q9+mlMVk9+r+rpW2w7AE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bgrUHxMBj3ErNb58lUyi5qd/wbl51voRDioMI68DysudxYlNzsUDykrcr+IQPzvO3
	 Aehexkd/ijm7EV4cmQ6QsUQm5BGE8thS392oeshVhI8qxRK6NtTsK/T0vdZOiY74mW
	 K12OAriGjhxlu1H+kzICe2nosH4Za0GXL53Ac0TA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfFXHlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFXHlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:41:42 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCDB8208CA;
        Mon, 24 Jun 2019 07:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561362101;
        bh=L6gUqCG8drdlw0JNPTw4WV1Q9+mlMVk9+r+rpW2w7AE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2qjE1E6++y+RdD7bONTE2cclIYxf/d21bmpIOBDi5ItxCTulU6+cCP4QmSQYO6Q99
         YIp4tfIVt/RGRZdcKgp4rTNKKLxQx8VeMV8NJBA7JpbJSx9t0sPtfTX5tbxN5YUqPf
         EWglztaz5Ph5WxfmAmG0DeQeohJ89YkYuATaiUtk=
Received: by mail-lj1-f177.google.com with SMTP id p17so11612660ljg.1;
        Mon, 24 Jun 2019 00:41:40 -0700 (PDT)
X-Gm-Message-State: APjAAAWy02DJO3EKyZyRNz48xUG3DS+Bka/xPuEooUDBY9j3omCL+DBo
        OzH02R35294DViDwAZGcejAixRiQ4RZ9ylKB5+0=
X-Google-Smtp-Source: APXvYqyRaeX7TDpnwHIcIB85B+1Xs+snbFiN+OxL0vV5dvoDI7HDxPRSomSVeOWM1E7yFBBSG3qrtNjtyuH0wVO/59s=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr28115717ljg.80.1561362099155;
 Mon, 24 Jun 2019 00:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190621155845.7079-1-krzk@kernel.org> <20190621155845.7079-3-krzk@kernel.org>
 <CGME20190623160226epcas2p3449814deb1faf7bf939481e6d4da2b86@epcas2p3.samsung.com>
 <CANAwSgTFQo8wL5s-djwPXFFOLtTHvRQif6234kFC=23PwMhuEQ@mail.gmail.com> <d94a2f99-fb99-c238-7011-9bbb4c0cd90f@samsung.com>
In-Reply-To: <d94a2f99-fb99-c238-7011-9bbb4c0cd90f@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 24 Jun 2019 09:41:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeXELUjsuW9eyGuRj56067qnL-J2Lt4U42mYiyx=X+F_Q@mail.gmail.com>
Message-ID: <CAJKOXPeXELUjsuW9eyGuRj56067qnL-J2Lt4U42mYiyx=X+F_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: exynos: Add regulator suspend
 configuration to Odroid XU3/XU4/HC1 family
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Anand Moon <linux.amoon@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019 at 09:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Anand,
>
> On 2019-06-23 18:02, Anand Moon wrote:
> > Thanks for this patch. Please add my
> >
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
> >
> > [snip]
> >
> > Could you integrate below small changes into this patch.
> > with these below changes suspend and resume work correctly at my end.
> >
> > [1] XU4_suspendresume.patch
> >
> > As per S2MPS11B PMIC 1.2.1 Regulator (Features)
> > Fix the min max value for *Buck7* and *Buck8*
> >
> > -- Buck7 (VDD_1.0V_LDO) 1.5 A (1.2 V to 1.5 V, 12.5 mV step, default on 1.35 V)
> > -- Buck8 (VDD_1.8V_LDO) 2.5 A (1.8 V to 2.1 V, 12.5 mV step, default on 2.0 V)
>
> Could you elaborate why such change for Buck7 and Buck8 is needed?

Anand has here valid point - the constraints in DTS do not match
hardware manual. This leads to question whether voltage table in
driver is proper... Another point is the voltage itself. The
schematics describes them as at specific voltage (1.35 V and 2.0 V)
but after boot they are 1.2 V and 1.85 V. Maybe this shift comes from
the problem above.

>
> > Also add suspend-off for *Buck9*
> > Buck9 internally controls the power of USB hub.
> > Adding suspend the this node help proper reset of USB hub on Odroid
> > XU4 / HC1/ XU3
> > during suspend and resume. Below it the logs from my testing.
>
> Disabling Buck9 in suspend indeed reduces the power consumed by the
> board during suspend-to-ram from about 80mA to as little as 7-10mA, what
> matches the results of OdroidXU3. Thanks for the hint!

Although I did not get what is the difference in the logs (Anand
pasted two logs but they look the same) but the power consumption is
reason is good enough. I would be happy to put in the changelog entire
consumption  difference. I can measure it on XU3-Lite but can you give
me the XU4 (before and after)?

Best regards,
Krzysztof
