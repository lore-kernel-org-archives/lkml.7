Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AA62087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="t0XBQDiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbfCZUQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:16:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33472 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfCZUQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:16:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id j10so6275939otq.0;
        Tue, 26 Mar 2019 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HKRbNAGxx3E6fIrG/wCmcOilFwv8otZbG2o+Zy7k34=;
        b=t0XBQDiXF1YzhJLaHCB1hdaghABB5qoyW3LBhNuf7k69Kc6+eotVPT2dz8fJhsAxr3
         UsyaZiLiW/ZDXZT1l8kfyxgSNeJlx7LxYJbCsokYSeZTv5BnEMZ2SlAgvtNO0WWHow1u
         GaHmGPpwWZe5rnIMrdO8Y98/YGQIOkwnb/j3CKm/C5sFug+4ktSFbhNVdx6Taz7gMFIs
         Z/kk8gZnuZZbaYagDrJ4WuSz7mVTD2N5qM5XirsNYTdlVDcB3r0WI5HF96YiVDWnGXHz
         tfeDc+PQHvGc5NG+SYwsch3dtY96cGgBR++tRojRjA5u2lFWz6/GnR8IaHT6/Q9xP2UK
         +Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HKRbNAGxx3E6fIrG/wCmcOilFwv8otZbG2o+Zy7k34=;
        b=OrMTSBMOU9nrpFM49YJqXKJBdZZOw56igXo4O02pttet1fqUJubQYQ7kt6PHkA6CTL
         NPrSk2XmS/DwfUpo5g6yxHYSaHlUW3AfzxueD+dCJ9/lCqr9ovi2fdv03xj7ThE/Oc9c
         6ilNlEGFaSH4iTFvtTQHohN76ePc9uRTJ2qV6NHPt1LqZgu11d+ku2Zomvh9lLMkDVk8
         Z+U7Lb/cGb1nqYhk2C9GtGIi6NZNArZTx/E6790GhsXRVQyIKT8qCEKUEZrtFCsighIy
         tXyHEmFE6nY6UuG35QUxLSu9fIDu0Gj6qW+/ey6oqXSupYnf/aeTemS7nvwpVrUDhOz0
         sSKg==
X-Gm-Message-State: APjAAAU4UGiA93/KuANTwPhtfnHKOWNOWh1PASRr1IjC/v0OLyS6+Ou4
        lICqmUrDaAEeAOtlBWpTLcEIhrALrcIzsFS5Kzw=
X-Google-Smtp-Source: APXvYqwghaC3KVyDgc0duAPHhQRrn85x3jjzL88OYmbujjlskbSjbKGNd7aIjJF/S8fhIrg1e4PnAzaQQ6Nr/Rmw/cQ=
X-Received: by 2002:a9d:5614:: with SMTP id e20mr23059038oti.348.1553631415625;
 Tue, 26 Mar 2019 13:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
 <CAFBinCCPW8wAoiN4hjj9tAYSqQqChpSB6+urAiXU95VYaZZKGg@mail.gmail.com> <88a731b0f1c2ce18d2cf7aff6e2ffc24a395a067.camel@baylibre.com>
In-Reply-To: <88a731b0f1c2ce18d2cf7aff6e2ffc24a395a067.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 26 Mar 2019 21:16:44 +0100
Message-ID: <CAFBinCCs0XkxbbnMTqccVopVTv3Ok8_sGKbFX1XM-mbGE_zKmA@mail.gmail.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, thierry.reding@gmail.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianxin.pan@amlogic.com, bichao.zheng@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Mar 26, 2019 at 9:37 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Mon, 2019-03-25 at 19:04 +0100, Martin Blumenstingl wrote:
> > > Thanks for fixing this Martin.
> > you're welcome!
> >
> > > As for the future enhancement, I'd like to know what you have in mind.
> > > As I have told you previously, I think the clock bindings of this driver are
> > > not great.
> > >
> > > The global name of the input clocks are hard coded in this driver and it
> > > sucks. CCF is evolving to rely less on these global names.
> > I fully agree with you on the clock setup, but I'm not sure if we have
> > to break the dt-bindings for it.
> >
> > the datasheet notes: "Each PWM is driven by a programmable divider
> > driven by a 4:1 clock selector".
> > In my own words this means that each PWM controller has up to 8 clock inputs:
> > - up to 4 inputs for the first channel (PWM_A)
> > - up to 4 inputs for the second channel (PWM_B)
>
> Not from the pwm device POV. there is one device (PWM_AB) with 4 (max) input
> clocks. Those are consumed by two internal muxes. There would be 8 if the
> input was different between path A and B.
>
> >
> > the current pwm-meson driver assumes that both the inputs for both
> > channels are identical.
> > the "clock trees" section of the public S912 datasheet (page 65)
> > clearly documents the clock inputs per PWM channel, not per PWM
> > controller.
> >
> > Thus I believe we should name our clock-names (the inputs to the PWM
> > controller) "pwm-a-clkin0", "pwm-a-clkin1", "pwm-b-clkin0", ...
> > That way we don't have a conflict with the existing bindings (which
> > already reserve "clkin0" and "clkin1").
>
> I think this is overkill an inaccurate. The experience of all the soc we have
> seen so far (meson8, gxbb, gxl, gxm, axg and g12) confirms the sources the are
> the same input clock for both path.
>
> The documentation just shows the clock src of each pwm. That just how the the
> table is presented. That does not change the fact the pwms are organized in
> modules (pairs) and the that the clock source are the same for each pwm of the
> module. IOW, there is only 4 lines of clocks getting to the IP, not 8. Feel
> free to ask amlogic if you want to make sure.
interesting, the way you describe it also seems valid.

I don't want to implement either way and find out that we have to
change the bindings again later on.

Bichao, Jianxin, can you answer the question whether each PWM controller has:
- up to four clock inputs. clock parents for channels PWM_A and PWM_B
are always the same
- up to eight clock inputs. four parents for channel PWM_A and four
more parents for PWM_B, where the parents of PWM_A and PWM_B could be
different
(for all known SoCs the parents of the channels PWM_A and PWM_B are
identical, so we don't know how the hardware is modelled)

> The name clash is not really my point. The purpose of the clock binding would
> be different (from stating a setting to describing hw connection)
OK, so your main concern is that we're breaking the DT bindings - so
instead of coming up with a "quick fix" we might as well take the long
but proper route?

> >
> > > In addition, the 'clock' binding should be used to refer to the clock
> > > 'consumed' by the device, not to define a setting (as done now). 'assigned-
> > > clock' binding can be used for that.
> > using the assigned-clock* properties requires self-referencing the PWM
> > controller (which I'm not used to), for example:
> >   &pwm_ab {
> >       #clock-cells = <1>;
> >       assigned-clocks = <&pwm_ab 0>, <&pwm_ab 1>; /* references itself */
> >       assigned-clock-parents = <&xtal>, <&clkc CLKID_FCLK_DIV5>;
> >   };
> >
> > if we want to auto-detect the parent clock (like you suggested below)
> > we need to consider if we can detect whether a .dts-author assigned a
> > specific parent.
>
> I (personally) don't want to keep supporting the manual assignment of the
> parent. If the driver can guarantee than it will pick the most appropriate
> parent, there is no reason to have that.
>
> > I know that it's easy to detect this when the clock is passed in the
> > "clocks" property, but I'm not sure if it's easy to parse it from the
> > assigned-clocks/assigned-clock-parents properties.
>
> Assigned parent is the poor man solution and not necessarily easier to
> implement (the pwm device would have to export its own clocks) ... I have just
> mentioned it to make  the point that current method is not ideal
>
> >
> > [...]
> > > Last, instead of specifying the parent to be used, I think we should come up
> > > with some code to let the driver pick the most appropriate parent for the period/duty requested.
> > that will make it easier for .dts authors.
> > I would like to postpone this until we have solved the other topics though.
>
> I much prefer this last solution. Since the algorithm and the bindings would
> change, I think it would be easier (in DT) to just make v2 driver with a new
> compatible, progressively transition dts to it and finally remove the old
> driver.
Neil has already raised the question whether clock jitter may be relevant.

what also came to my mind is the "system suspend" use-case:
I'm not sure if the fixed_pll (and it's post-dividers) are enabled
during system suspend.
in that case we probably need clock the PWM channel off the main XTAL.
(I don't know if this use-case really exists, I want to bring it up so
we can discuss it)


Regards
Martin
