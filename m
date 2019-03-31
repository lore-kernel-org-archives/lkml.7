Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 00:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC62184D
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 00:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FOUfsm5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbfCaAHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 20:07:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43359 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbfCaAHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 20:07:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so6585745qtc.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bk9PKS0LUF/VXYjndR8WWxMJuOaeyMXD3n2lNQIHcU=;
        b=FOUfsm5Igumwg0YHx9wwFUl07awKVRnklSgyGdQRIN1bGq7peNIBiIfekx7ph77iwJ
         NHv0hSqC0siJdjXYovPodLpqHV8SwwE8q/Hoini8SAzoaJ8Jnjz2/pUSpp5rGag+8avy
         Yc1yBPYnUUhki1ucZEZ3Z0VpYy8ICnXF5NSVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bk9PKS0LUF/VXYjndR8WWxMJuOaeyMXD3n2lNQIHcU=;
        b=M5wmhGAav9XeCBk/b2vJv4jVYmCcb6sV+kLo87rrkqdDEGyWFP3XF7TXzPA6DdBekI
         lp8QJRHJEgGWc6dfmzdxG7kA2jg7UIToB8S6W7uqu+YYp7cf0gv1O3JYPkIJMesx2yOB
         vG16LILZ2flSD4ZxfqocmFgC/8XSV/WmDdTzqWpddXTte7nTx2F9clW58igo0J+D3RdM
         2CqUYBJCWX+x8nhmJzP7ajNWi0EZ9q+sF08+9xf8axkn5s3gWMUM+yJkBQuJE0WUrNL1
         vRxYdFWEGXaXonbc3dUNZTSNjSpY91Ti3ICMv9vR9yGEn/zsC0PbG3N7KBqyjWdVmqmm
         +PAw==
X-Gm-Message-State: APjAAAVB3Ts09waKZOfWoovltX2AYzid4ERaKw+YB/WurCR8GQ60yIvm
        fgHG0pqcV4HxOEWicZ1L1lawxt0FYWErWgKlMubszA==
X-Google-Smtp-Source: APXvYqz6Z/DGEGsEyaa9qGn+2yYqelpKYUGdH1lxYhnbq3lvI7+b9MoUcvdxPgfBnolddNg3F1SCS2bCZU7/iYJ6Ti8=
X-Received: by 2002:aed:35f7:: with SMTP id d52mr47105986qte.335.1553990831296;
 Sat, 30 Mar 2019 17:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com> <1553841972-19737-2-git-send-email-andrew-sh.cheng@mediatek.com>
In-Reply-To: <1553841972-19737-2-git-send-email-andrew-sh.cheng@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 30 Mar 2019 17:06:58 -0700
Message-ID: <CANMq1KBX1NTfv1OYV3aq4B8hfrOnSEJRX1g6JOYzMws1ZNQgjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] cpufreq: mediatek: add mt8183 cpufreq support
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 11:46 PM Andrew-sh.Cheng
<andrew-sh.cheng@mediatek.com> wrote:
>
> For new mediatek chip mt8183,
> cci and little cluster share the same buck,
> so need to modify the attribute of regulator from exclusive to optional
>
> Intermediate clock is not always enabled by ccf in different projects,
> so cpufreq should always enable it by itself.

One comment, otherwise the changes look good. However, I feel that
this patch should be split in 3:
 1. Change to regulator_get_optional
 2. Enable inter_clk
 3. Add support for 8183

> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 47729a2..53ea52b 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -117,6 +117,7 @@
>         { .compatible = "mediatek,mt817x", },
>         { .compatible = "mediatek,mt8173", },
>         { .compatible = "mediatek,mt8176", },
> +       { .compatible = "mediatek,mt8183", },
>
>         { .compatible = "nvidia,tegra124", },
>         { .compatible = "nvidia,tegra210", },
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 48e9829..7cd01d3 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -346,7 +346,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>                 goto out_free_resources;
>         }
>
> -       proc_reg = regulator_get_exclusive(cpu_dev, "proc");
> +       proc_reg = regulator_get_optional(cpu_dev, "proc");
>         if (IS_ERR(proc_reg)) {
>                 if (PTR_ERR(proc_reg) == -EPROBE_DEFER)
>                         pr_warn("proc regulator for cpu%d not ready, retry.\n",
> @@ -376,13 +376,17 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>                 goto out_free_resources;
>         }
>
> +       ret = clk_prepare_enable(inter_clk);

Should you disable the clock in mtk_cpu_dvfs_info_release?

> +       if (ret)
> +               goto out_free_opp_table;
> +
>         /* Search a safe voltage for intermediate frequency. */
>         rate = clk_get_rate(inter_clk);
>         opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>         if (IS_ERR(opp)) {
>                 pr_err("failed to get intermediate opp for cpu%d\n", cpu);
>                 ret = PTR_ERR(opp);
> -               goto out_free_opp_table;
> +               goto out_disable_clock;
>         }
>         info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>         dev_pm_opp_put(opp);
> @@ -401,6 +405,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>
>         return 0;
>
> +out_disable_clock:
> +       clk_disable_unprepare(inter_clk);
> +
>  out_free_opp_table:
>         dev_pm_opp_of_cpumask_remove_table(&info->cpus);
>
> @@ -543,6 +550,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>         { .compatible = "mediatek,mt817x", },
>         { .compatible = "mediatek,mt8173", },
>         { .compatible = "mediatek,mt8176", },
> +       { .compatible = "mediatek,mt8183", },
>
>         { }
>  };
> --
> 1.8.1.1.dirty
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
