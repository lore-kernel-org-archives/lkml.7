Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71384C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E60A2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="o+eqW1QW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCYSES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:04:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46689 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYSER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:04:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id c18so8864977otl.13;
        Mon, 25 Mar 2019 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GADRvM0xN4bllnd3qZhEh8xI+loEVurWzVmPK/bUGn4=;
        b=o+eqW1QWWrIKtllLpb/54oAYP5Z3yohEpohdPOmIlzfzeapD+tA+fWE8VGMVfq8tTw
         qR2EMrf8jUH/yg0BmaCsZFMoK2RvqaYP79NeC5B2nLHTICkVtzS6IHzEldtJKKQPa67P
         EqgsXQozYW2GAMPu4FL/h/nqTC8CIY/VB6oAVbzqr7xFoqNi3AN1SSE5ykn+ZpjclzUk
         ukvWQaBdKIrWMtqnZr024z4uQfkhEgXgAEsFbWrwXyYG6dkgiS1o3hldhaGEO8v4GeVQ
         LcYQQ31b1We0O4xW5z4fW+gwIeuY6OzURJUVGCH4VP9R/9GWxEyGSKJwBvx3Ssg/O7tj
         9Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GADRvM0xN4bllnd3qZhEh8xI+loEVurWzVmPK/bUGn4=;
        b=sm+gzwgD6EoirjxTlhLOqg3y3NIoQL5v6eSrbCYoEo11aNVTpXfu1mhje8PVLbfrfW
         rarupx9tbtRKbFOhN30RRzwg5Yl2sjkiI6Ew9VWAdPiBQCAO0tE9DTq/evXFhTIVtvAZ
         iPcW+z9QpAQ/NcGjOoYLL1hUN/HVX8gkjDwVztjV/bRJGFJpew1D4ygMSd8l27NiPCVR
         m4j896/F0KMALE3ec98nsCN74BeqcuVN1jmHgekKQ1qXXH7q8qFOIWLXxQjMxIQzkmgR
         EnRV9WRue1QiE3sjGtIP6YnaYLV1Ya1noYdxB5L3KT4vKT8wlwIY62wDHphMwSBtiZ6z
         oFXQ==
X-Gm-Message-State: APjAAAXEP3s6zwfYfd2+ayy5nayYs6nxnyh+I+OpJ/PyGQThqtfq0rc3
        U8/HYq0MD/MoIlercghao3wPT/TdedJ8OP7cNos=
X-Google-Smtp-Source: APXvYqypZk6IN2goZkQQ3kCsStNCRpPQUw/Nmnmm1imDszeEB0ThMlAUdtaHCGkJ+7p3NxDX6bNG7VtPb2Y1kWCprNA=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr18256071otk.86.1553537056347;
 Mon, 25 Mar 2019 11:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com> <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
In-Reply-To: <47e944da1c3b0a11cf46fc5ad5678ba961b9f9d3.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Mar 2019 19:04:05 +0100
Message-ID: <CAFBinCCPW8wAoiN4hjj9tAYSqQqChpSB6+urAiXU95VYaZZKGg@mail.gmail.com>
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     thierry.reding@gmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Mar 25, 2019 at 10:35 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sun, 2019-03-24 at 23:02 +0100, Martin Blumenstingl wrote:
> > Back in January a "BUG: scheduling while atomic" error showed up during
> > boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
> > The call trace comes down to:
> >   __mutex_lock
> >   clk_prepare_lock
> >   clk_core_get_rate
> >   meson_pwm_apply
> >   ..
> >   dev_pm_opp_set_rate
> >   ..
> >
> > Jerome has also seen the same problem but from pwm-leds (instead of a
> > pwm-regulator). He posted a patch which replaces the spinlock with a
> > mutex. That works. I believe we can optimize this by reducing the time
> > where the lock is held - that also allows to keep the spin-lock.
> >
> > Analyzing this issue helped me understand the pwm-meson driver better.
> > My plan is to send some cleanups (with the goal of re-using more of the
> > goodies from the PWM core in the pwm-meson driver) after this single fix
> > is merged (they can be found here: [1]).
>
> Thanks for fixing this Martin.
you're welcome!

> As for the future enhancement, I'd like to know what you have in mind.
> As I have told you previously, I think the clock bindings of this driver are
> not great.
>
> The global name of the input clocks are hard coded in this driver and it
> sucks. CCF is evolving to rely less on these global names.
I fully agree with you on the clock setup, but I'm not sure if we have
to break the dt-bindings for it.

the datasheet notes: "Each PWM is driven by a programmable divider
driven by a 4:1 clock selector".
In my own words this means that each PWM controller has up to 8 clock inputs:
- up to 4 inputs for the first channel (PWM_A)
- up to 4 inputs for the second channel (PWM_B)

the current pwm-meson driver assumes that both the inputs for both
channels are identical.
the "clock trees" section of the public S912 datasheet (page 65)
clearly documents the clock inputs per PWM channel, not per PWM
controller.

Thus I believe we should name our clock-names (the inputs to the PWM
controller) "pwm-a-clkin0", "pwm-a-clkin1", "pwm-b-clkin0", ...
That way we don't have a conflict with the existing bindings (which
already reserve "clkin0" and "clkin1").

> In addition, the 'clock' binding should be used to refer to the clock
> 'consumed' by the device, not to define a setting (as done now). 'assigned-
> clock' binding can be used for that.
using the assigned-clock* properties requires self-referencing the PWM
controller (which I'm not used to), for example:
  &pwm_ab {
      #clock-cells = <1>;
      assigned-clocks = <&pwm_ab 0>, <&pwm_ab 1>; /* references itself */
      assigned-clock-parents = <&xtal>, <&clkc CLKID_FCLK_DIV5>;
  };

if we want to auto-detect the parent clock (like you suggested below)
we need to consider if we can detect whether a .dts-author assigned a
specific parent.
I know that it's easy to detect this when the clock is passed in the
"clocks" property, but I'm not sure if it's easy to parse it from the
assigned-clocks/assigned-clock-parents properties.

[...]
> Last, instead of specifying the parent to be used, I think we should come up
> with some code to let the driver pick the most appropriate parent for the period/duty requested.
that will make it easier for .dts authors.
I would like to postpone this until we have solved the other topics though.


Regards
Martin


[0] https://dl.khadas.com/Hardware/VIM2/Datasheet/S912_Datasheet_V0.220170314publicversion-Wesion.pdf
