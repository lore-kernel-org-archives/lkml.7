Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7413DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40353217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556186645;
	bh=/+eJmfmKMbVPqJpQ6oWQVgZ/pGm0KLqrR5ywKHCRPdo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JgVSTBzB1Xj1J2th00+Z/aOLsD1pfr//eEju6naVRCMOHSwpOReTTNXWnpqW3WLZF
	 7Oo3wOdXNu9d5a1m/3CyKigc7VMrbaFcp7plGP22pZmhjBTl9sH+Z4fxCT/iDq5NJ3
	 1LglvpO94IUyUN5ZSAEzTaRfqQ4tM53lkCYoFx64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbfDYKEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:04:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45563 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDYKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:04:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so18865093otk.12;
        Thu, 25 Apr 2019 03:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbFce9kqOYMXkwbYbsm3ItH4gOftYJ40LGsY5EDEySQ=;
        b=GpoFqo/8sRA0De9Y0/dmGa2mXcFCQXjMGI3KZAU3REuyrDN2NCc7FcRmUROkotWU7Z
         aifpUg1fraTA+7IHiNrps2eeeAGlVG2k0aKqRDzw/qMPy39gBkq9X0hhVsNJ2CF82cy1
         8WOa8ez93mkUTu31MQ2XJWAw+dCp5umKPXtI5S0s696wA74ApxmULaLIGFWoK8dRmfuB
         UKWCHPspKh9jQBJEtquxCx59mUEqyi3iSr5D7zuT2/QjuZS00jxKK3BYLPHFJPkzuYtW
         A/zQ3Yls3s7BuF9yBa0OFuFN/gOWLocZfD7MXoDwf1i+l5J40bnC6THx/UT/gQ/1pWqG
         C4Xw==
X-Gm-Message-State: APjAAAXHAKxl1xQVkH5mrCjC7bIcad5uY8I6x+NLOw1V45ZIeiAsR47o
        W1KqRDnPtNINlpnk2gf+3Dln0l15bshq/R5JN0g=
X-Google-Smtp-Source: APXvYqye7zlg9qsqJ4qajiP68faXdzWWcSDQZ64WTgv0yfrn0oIfUzFm+fLYRbco3aErHavq7zojj97vw8Ieol5EeSE=
X-Received: by 2002:a9d:6e17:: with SMTP id e23mr23121690otr.65.1556186641899;
 Thu, 25 Apr 2019 03:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Apr 2019 12:03:51 +0200
Message-ID: <CAJZ5v0iwrjonKpA3Skkhkg3g5Pp9Qzx0v2GBYKdv7eM_jL4p8g@mail.gmail.com>
Subject: Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Andy Tang <andy.tang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:48 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.

Well, if I'm expected to apply this, the above is a bit terse.

It looks like the patch makes the qoriq-cpufreq driver handle some new
hardware, but the changelog doesn't say much about that.

I'm guessing that the clockgen support added here makes it possible
for qoriq-cpufreq to handle this chip, is that correct?

> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes for v2:
> - Subject line updated
>
>  drivers/clk/clk-qoriq.c         | 12 ++++++++++++
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 3d51d7c..1a15201 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
>                 .flags = CG_VER3 | CG_LITTLE_ENDIAN,
>         },
>         {
> +               .compat = "fsl,lx2160a-clockgen",
> +               .cmux_groups = {
> +                       &clockgen2_cmux_cga12, &clockgen2_cmux_cgb
> +               },
> +               .cmux_to_group = {
> +                       0, 0, 0, 0, 1, 1, 1, 1, -1
> +               },
> +               .pll_mask = 0x37,
> +               .flags = CG_VER3 | CG_LITTLE_ENDIAN,
> +       },
> +       {
>                 .compat = "fsl,p2041-clockgen",
>                 .guts_compat = "fsl,qoriq-device-config-1.0",
>                 .init_periph = p2041_init_periph,
> @@ -1427,6 +1438,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
> +CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_p2041, "fsl,p2041-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_p3041, "fsl,p3041-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_p4080, "fsl,p4080-clockgen", clockgen_init);
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 4295e54..81f0288 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -284,6 +284,7 @@ static const struct of_device_id node_matches[] __initconst = {
>         { .compatible = "fsl,ls1046a-clockgen", },
>         { .compatible = "fsl,ls1088a-clockgen", },
>         { .compatible = "fsl,ls2080a-clockgen", },
> +       { .compatible = "fsl,lx2160a-clockgen", },
>         { .compatible = "fsl,p4080-clockgen", },
>         { .compatible = "fsl,qoriq-clockgen-1.0", },
>         { .compatible = "fsl,qoriq-clockgen-2.0", },
> --
> 2.7.4
>
