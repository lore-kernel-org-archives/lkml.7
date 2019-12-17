Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A26C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403AD2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUvgKgYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfLQGRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:17:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35541 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfLQGRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:17:13 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so8740130iol.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRrxKYHoyrhokgZk6UbADBR6VEatST48aL6QNC1ne/Y=;
        b=bUvgKgYGVfv3qd0rlI5Ge5R5d5nFza0ODCBxUaUY2OGxSLgDegydew6Ux1HVIc602b
         GCK0usSXDhbFoSUhUq+MqXCqFR5A+tVjparSIz9KndO7m2dPFwYN4fFZsJaTZandjXq6
         AGVH5SX2yhX6asplP3klDY1lELh5SrOWMUIYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRrxKYHoyrhokgZk6UbADBR6VEatST48aL6QNC1ne/Y=;
        b=Tn2vzyn8lWjFe3HYwSNylkiy0hkF2G3QyTW18z5L33RNpiIz16eJlYwsLUp4z3Drwr
         JbtaSELLsQKWKYNYwFg1taoHUSfMSGYl6KNR7TTq6bPfmpYtW8p3xmYI9ThRK9Z0cqjA
         Iku+ZaYCSeiYkszzx/Oql49BhwFK8oeVlomvs8Cj5EfUYnWi2/WrhJDnonuMcxJVqRGY
         gb+YUGRP22VEcToiJlI0Qg4U7HuEWfdcrdArAj5GwQWmYC78s1PJRxWH8FWvvZBCqtyJ
         9dXWrY1rtheo+h2NvmNPVhvTt33PD4x7Xo3qaNRRgOMB2Iy51ezvAbxOxbWhP9asehMD
         /hMQ==
X-Gm-Message-State: APjAAAUiGLEOGwIeJPXbAcmM5ZWEyh5LSjRzI+mT27HKaiZWEi/FN/5B
        9pyIIQjIdJLTb9DBRXAodC3lJOVpTh8=
X-Google-Smtp-Source: APXvYqwJDZZPd3rSCdDEqEHtNTqkW3gSoF6b1Vkx07Dmh5O7hgnUGapVLjJQgWnKkzVPyv861HbHbg==
X-Received: by 2002:a02:cd9c:: with SMTP id l28mr15417974jap.46.1576563431965;
        Mon, 16 Dec 2019 22:17:11 -0800 (PST)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id w16sm6517726ilq.5.2019.12.16.22.17.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2019 22:17:09 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id v69so6293883ili.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:17:09 -0800 (PST)
X-Received: by 2002:a92:ca90:: with SMTP id t16mr1730292ilo.218.1576563428823;
 Mon, 16 Dec 2019 22:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20191216220512.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
In-Reply-To: <20191216220512.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Dec 2019 22:16:56 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wb6MtqdBZgNWdTH97RZamYfPZ0a9_1CELE_kJHXtKuYQ@mail.gmail.com>
Message-ID: <CAD=FV=Wb6MtqdBZgNWdTH97RZamYfPZ0a9_1CELE_kJHXtKuYQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: Use non-empty ranges in example
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 16, 2019 at 10:06 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> On many arm64 qcom device trees, running `make dtbs_check` yells:
>
>   timer@17c20000: #size-cells:0:0: 1 was expected
>
> It appears that someone was trying to assert the fact that sub-nodes
> describing frames would never have a size that's more than 32-bits
> big.  That does indeed appear to be true for all cases I could find.
>
> Currently many arm64 qcom device tree files have a #address-cells and
> about in commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase
> address and size cells for soc").  That means the only way we can
> shrink them down is to use a non-empty ranges.
>
> Since forever it has said in "writing-bindings.txt" to "DO use
> non-empty 'ranges' to limit the size of child buses/devices".  I guess
> we should start listening to it.
>
> I believe (but am not certain) that this also means that we should use
> "ranges" to simplify the "reg" of our sub devices by specifying an
> offset.  Let's update the example in the bindings to make this
> obvious.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> See:
>   https://lore.kernel.org/r/20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid
>
> ...for the patch that sparked this change.
>
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> index b3f0fe96ff0d..d927b42ddeb8 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> @@ -99,22 +99,22 @@ examples:
>        compatible = "arm,armv7-timer-mem";
>        #address-cells = <1>;
>        #size-cells = <1>;
> -      ranges;
> +      ranges = <0 0xf0000000 0x1000>;

I checked this over a few times and yet I still screwed it up.  :(
This should be:

ranges = <0 0xf0001000 0x1000>;

...which makes the first "frame" below actually start at 0.  I'll wait
before sending out a v2, though, in case this patch is totally wrong
or something.


>        reg = <0xf0000000 0x1000>;
>        clock-frequency = <50000000>;
>
> -      frame@f0001000 {
> +      frame@0 {
>          frame-number = <0>;
>          interrupts = <0 13 0x8>,
>                 <0 14 0x8>;
> -        reg = <0xf0001000 0x1000>,
> -              <0xf0002000 0x1000>;
> +        reg = <0x0000 0x1000>,
> +              <0x1000 0x1000>;
>        };
>
>        frame@f0003000 {
>          frame-number = <1>;
>          interrupts = <0 15 0x8>;
> -        reg = <0xf0003000 0x1000>;
> +        reg = <0x2000 0x1000>;
>        };
>      };
