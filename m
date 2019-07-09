Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04345C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A012166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562704268;
	bh=/tteBi3FwGsHAETT02bIg+e0ZNo7j8DYyhLdl+lJps0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kHgI7G5nycVGb789Is9kyr9ChzJ4NAuTZ+gLSauSy706e5xrEgGfiRum0eWX6+lzA
	 8Z+3Bz5+tWJ1npd2WYXwSOTHs2KX0i3L6Avu4zsVjM2uZb1qyV7SXvi497/vvwviin
	 vgm9JenITV+QunEAintr+ut3vBGv83Ns9Bqup7l0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfGIUbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729179AbfGIUbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:31:07 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C75A216C4;
        Tue,  9 Jul 2019 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562704266;
        bh=/tteBi3FwGsHAETT02bIg+e0ZNo7j8DYyhLdl+lJps0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WK6kvH07mh4thZzT1jrFK286npoFsNqcw7HX+SQcPx7Q4WS9QXAS+BLPRbyFafB22
         2CafceWPg+iRvpXpebTOAzEj3GuQHGScoCPpGYUjb7gXPxe6U0Jql0Kya6+uMTtIob
         bznSqIz5RyvDOp8Hx2XBgK4lt0h1F5Y4IuLO7a1Q=
Received: by mail-qt1-f170.google.com with SMTP id k10so30613qtq.1;
        Tue, 09 Jul 2019 13:31:06 -0700 (PDT)
X-Gm-Message-State: APjAAAVoEltQsI2oKhnVCaKSRJnLDGGGu/GseEVjyrwp7Ln7KiPoqaPh
        ikEND7YESV9gNJQ3WVQDgrxrlym8O/MryTXM0A==
X-Google-Smtp-Source: APXvYqzH8k8Dv1us69V2h3oPdKKrl7k8iPqPdSXKGumU7uUT/sxu6iBZEGR13WtL7FC+49CqCTsHjJ62OGTJqaZLYXE=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr20343076qtb.224.1562704265525;
 Tue, 09 Jul 2019 13:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190701093826.5472-1-Anson.Huang@nxp.com> <20190701093826.5472-2-Anson.Huang@nxp.com>
In-Reply-To: <20190701093826.5472-2-Anson.Huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Jul 2019 14:30:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKeu-b8mbMJBtnNn1vL=RSvUXbo+g40haZnjXTW11CJ6w@mail.gmail.com>
Message-ID: <CAL_JsqKeu-b8mbMJBtnNn1vL=RSvUXbo+g40haZnjXTW11CJ6w@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] clocksource/drivers/sysctr: Add clock-frequency property
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bai Ping <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 3:47 AM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>

'dt-bindings: timer: ...' for the subject.

>
> Systems which use platform driver model for clock driver require the
> clock frequency to be supplied via device tree when system counter
> driver is enabled.

This is a DT binding. What's a platform driver?

>
> This is necessary as in the platform driver model the of_clk operations
> do not work correctly because system counter driver is initialized in
> early phase of system boot up, and clock driver using platform driver
> model is NOT ready at that time, it will cause system counter driver
> initialization failed.
>
> Add clock-frequency property to the device tree bindings of the NXP
> system counter, so the driver can tell timer-of driver to get clock
> frequency from DT directly instead of doing of_clk operations via
> clk APIs.

While you've now given a good explanation why you need this, it all
sounds like linux specific issues and a DT change should not be
necessary.

Presumably, 'clocks' points to a fixed-clock node, right? Just parse
the 'clocks' phandle and fetch the frequency from that node if you
need to get the frequency 'early'.

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  .../devicetree/bindings/timer/nxp,sysctr-timer.txt        | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> index d576599..7088a0e 100644
> --- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> @@ -11,15 +11,18 @@ Required properties:
>  - reg :             Specifies the base physical address and size of the comapre
>                      frame and the counter control, read & compare.
>  - interrupts :      should be the first compare frames' interrupt
> -- clocks :         Specifies the counter clock.
> -- clock-names:             Specifies the clock's name of this module
> +- clocks :          Specifies the counter clock, mutually exclusive with clock-frequency.
> +- clock-names :     Specifies the clock's name of this module, mutually exclusive with
> +                   clock-frequency.
> +- clock-frequency : Specifies system counter clock frequency, mutually exclusive with
> +                   clocks/clock-names.

It doesn't really work to say one or the other is needed unless you
make the OS support both cases.

Rob
