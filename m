Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D633C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5778521871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gjo1O64T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfCOQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:18:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46854 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfCOQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:18:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id a132so5846501lfa.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUGJ75OmBZQm5OTwyXIACWB5EDYwvdGF1+g28FmmE5U=;
        b=gjo1O64TSZq7jpmOv0+3khF3F/O+txIJMfgDOrKmzAQ8AGAuuUj9FSSRPWcwZjsqZF
         tFe2cmnqP7lx66qYP+gWKMmtfH6s0fIyCeMqx9i/S9xIDUzQDUphmUcvzDCgvLR1pEuF
         gN/HWl5PVZ0FBTIBpkNB2mZ5ClfnZ2gJoSA6MYERqJ7zgcFpJ2/YDoAGrndTtHmtWyWo
         91RxajFnncP9vzPZb20kfxx3bsykFuQRfsFqQOXxm9/fL+b9yZYcvhyEPlmOppNaHEcW
         fjCTEQOV02e0my0QS2E9nR1scryCJ7XesL4NlHhW1G9GHGhjZFp5XJqFX1TPCDaDQ2XO
         VEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUGJ75OmBZQm5OTwyXIACWB5EDYwvdGF1+g28FmmE5U=;
        b=t/hywLiU1jh7XoXqELxOS899oWCBBf3d5upJsj6n49TXQCEREF0BrkJrnp2YSZAe+D
         d+WLN2uN3gZuIFrpK6wbKUMFlwsIPUgRun5+PoxmGrP6nMG/8n1plEBffq+7cym+XeCV
         eRfD7MOEplO0/3151Si1B/BjNq/Flx5eEapESpgJMAczkxjWAGpV2Zw98VoFJhCrr7u0
         +6UmQc3zRCbpIfuOWIe+YccZNIekNIhBeCvx+0LVDljfpCAbn9EuEgyFxbdW1elffEVh
         AsNgA6gtXl17fik4g9e0OM/t0sxB2IjEVxhSARjpKV4xI67uEiono4m/1vPdEYrt9p3c
         Py1w==
X-Gm-Message-State: APjAAAV5Bac4ZCJtrzT+xrx/7HDFf91pgfdpwki36hWIfFEUJksA5N+P
        Z1MWZchWnTAi0erUzsl3AAv5gr4wSM1yMuXNhhOuSA==
X-Google-Smtp-Source: APXvYqzWrvfzXxvSk6MFsdhGfH49ejWnLJrAop9BtvBYPmxheAo2q0BDq4l6tQzNnPIcJVWT4cexcfY5emtS38zGo4g=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr2390773lfl.129.1552666691178;
 Fri, 15 Mar 2019 09:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190313193408.23740-1-abailon@baylibre.com>
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
From:   Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 15 Mar 2019 09:17:44 -0700
Message-ID: <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Stephen Boyd <sboyd@codeaurora.org>, Emilio Lopez
        <emilio@elopez.com.ar>, Hans de Goede <hdegoede@redhat.com>, linux-clk
        <linux-clk@vger.kernel.org>, linux-arm-kernel" 
        <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Some nitpick review comments below.

On Wed, Mar 13, 2019 at 12:33 PM Alexandre Bailon <abailon@baylibre.com> wrote:
>
> This series implements busfreq, a framework used in MXP's

s/MXP/NXP/

> tree to scale the interconnect and dram frequencies.
> In the vendor tree, device's driver request for a
> performance level, which is used to scale the frequencies.
> This series implements it using the interconnect framework.
> Devices' driver request for bandwidth which is use by busfreq
> to determine a performance level, and then scale the frequency.
>
> Busfreq is quite generic. It could be used for any i.MX SoC.
> A busfreq platform driver just have to define a list of
> interconnect nodes, and some OPPs.
>
> This series is sent as RFC mostly because the current support
> of i.MX SoC won't benefit of busfreq framework, because the
> clocks' driver don't support interconnect / dram frequency
> scaling.

In your v2 cover letter could you post a link to a git branch that has
everything integrated that is needed to test the series? I guess this
is similar to what Aisheng asked for already.

> As exemple, this series implements busfreq for i.MX8MM whose
> upstreaming is in progress. Because this relies on ATF to
> do the frequency scaling, it won't be hard make it work.

It's not clear to me whether this series actual scales the dram
frequency based on what you said above. Is it just theoretical or do
you have it working with a pile of out-of-tree patches? Would be good
to include that pile of patches in your integration branch that I
suggested above.

Thanks,
Mike

>
> As exemple, this series implements busfreq for
> Alexandre Bailon (3):
>   drivers: interconnect: Add a driver for i.MX SoC
>   drivers: interconnect: imx: Add support of i.MX8MM
>   dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
>
>  .../bindings/interconnect/imx8mm.txt          |  24 +
>  drivers/interconnect/Kconfig                  |   1 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/imx/Kconfig              |  17 +
>  drivers/interconnect/imx/Makefile             |   2 +
>  drivers/interconnect/imx/busfreq-imx8mm.c     | 132 ++++
>  drivers/interconnect/imx/busfreq.c            | 570 ++++++++++++++++++
>  drivers/interconnect/imx/busfreq.h            | 123 ++++
>  include/dt-bindings/interconnect/imx8mm.h     |  37 ++
>  9 files changed, 907 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/imx8mm.txt
>  create mode 100644 drivers/interconnect/imx/Kconfig
>  create mode 100644 drivers/interconnect/imx/Makefile
>  create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
>  create mode 100644 drivers/interconnect/imx/busfreq.c
>  create mode 100644 drivers/interconnect/imx/busfreq.h
>  create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>
> --
> 2.19.2



-- 
Michael Turquette
CEO
BayLibre - At the Heart of Embedded Linux
http://baylibre.com/
Schedule a meeting: https://calendly.com/mturquette
