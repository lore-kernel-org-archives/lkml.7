Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E928FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8B8206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BbZVYyg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfDCEcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:32:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39645 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbfDCEcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:32:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so18010562qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S57beQPqnsWH7c2yhxwG0r7rfdOqzi6B+T57wk8rq/M=;
        b=BbZVYyg8g6syDUQKFjBvTT9cLUZZE7a6OoGz+AIY0bEwIXN9dYTEbQaMsqnN4pxqOI
         2r0+OQ+53kGWyP2J80MdrjT1505TRde0MzZ6us98yNcBZuc6C7WbyPZUduN1fogM437b
         G1cTOHaQO47gppSFUJUHRq0GoKVkpZiZM1PaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S57beQPqnsWH7c2yhxwG0r7rfdOqzi6B+T57wk8rq/M=;
        b=YnpT2/DxQ4WVFML+Wh04QznX7h5ZAyqy9wT85P7TOLPbmO1LB5r/LuCLW1rW4cAnGY
         i0Y0WuBJVMZGMLmXmI3fIcm0sG+Gy6rn3/Xe+x16okh9ppTfdLRA1S5gvmKatvgQQFQy
         cixrCmcaACsGzDrPJkKJUXJdPR6XQ378FIVJ7JDKCbPFpe3lvfXFWJTAeyFbV5cDPaE3
         9wO+sglzNOFA18eUiGzsmhhGYxgLOx9G2Sjs1eI2Vj6dzEoas/cdcDYK9v0pfvrfPVmU
         Jaf8L3jSxWFX04mt1rDbbzlIODDpDvARODNibF/sr+/F767qRzZmhj35qbORL7fzhD3A
         fADA==
X-Gm-Message-State: APjAAAWJLX9z6Uh24JtcYRKLiwkooRiwHZEvanGartN+ZwYvinqdjuCW
        SypVDpRiI2cHSegV5smbt7lcSl1TGSPSLnKXm0RQiA==
X-Google-Smtp-Source: APXvYqwCMzL/Q6XymiDfrIN3Qb+qE6BeNX7uPJe7jrtKFSR5gRQ8ao3MXoV+ChtaAA8YTutR2Ju+mySkTo3kVL2gS+w=
X-Received: by 2002:ac8:2ed7:: with SMTP id i23mr61752841qta.326.1554265936440;
 Tue, 02 Apr 2019 21:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553841972-19737-1-git-send-email-andrew-sh.cheng@mediatek.com> <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
In-Reply-To: <1553841972-19737-3-git-send-email-andrew-sh.cheng@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 3 Apr 2019 12:32:05 +0800
Message-ID: <CANMq1KB6x77F9Vo_wXK-M1Qt0Mo9VP3MfgKBAON18cHMts_kwg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] opp: add API which get max freq by voltage
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

On Fri, Mar 29, 2019 at 2:46 PM Andrew-sh.Cheng
<andrew-sh.cheng@mediatek.com> wrote:
>
> This API will get voltage as input parameter.
> Search all opp items for the item which with max frequency,
> and the voltae is smaller than provided voltage.
>
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/opp/core.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0420f7e..7323cd9 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -526,6 +526,61 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
>
> +/**
> + * dev_pm_opp_find_max_freq_by_volt() - Search for a opp with max freq
> + * under provided voltage
> + * @dev:       device for which we do this operation
> + * @u_volt:    provided voltage
> + *
> + * Search for the matching available OPP which provide voltage can support.
> + *
> + * Return: matching *opp, else returns ERR_PTR in case of error
> + * and should be handled using IS_ERR.
> + * Error return values can be:
> + * EINVAL:     for bad pointer
> + * ERANGE:     no match found for search
> + * ENODEV:     if device not found in list of registered devices
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.
> + */
> +struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
> +                                             unsigned long u_volt)
> +{
> +       struct opp_table *opp_table;
> +       struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
> +
> +       if (!dev || !u_volt) {
> +               dev_err(dev, "%s: Invalid argument volt=%d\n", __func__,
> +                       u_volt);

u_volt is an unsigned long, so you should use %lu.

drivers/opp/core.c:582:3: error: format '%d' expects argument of type
'int', but argument 4 has type 'long unsigned int' [-Werror=format=]
  chromeos-kernel-4_19-4.19.32-r271:    dev_err(dev, "%s: Invalid
argument volt=%d\n", __func__,
  chromeos-kernel-4_19-4.19.32-r271:    ^

> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       opp_table = _find_opp_table(dev);
> +       if (IS_ERR(opp_table))
> +               return ERR_CAST(opp_table);
> +
> +       mutex_lock(&opp_table->lock);
> +
> +       list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
> +               if (temp_opp->available) {
> +                       /* go to the next node, before choosing prev */
> +                       if (temp_opp->supplies[0].u_volt > u_volt)
> +                               break;
> +                       opp = temp_opp;
> +               }
> +       }
> +
> +       /* Increment the reference count of OPP */
> +       if (!IS_ERR(opp))
> +               dev_pm_opp_get(opp);
> +       mutex_unlock(&opp_table->lock);
> +       dev_pm_opp_put_opp_table(opp_table);
> +
> +       return opp;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_max_freq_by_volt);
> +
>  static int _set_opp_voltage(struct device *dev, struct regulator *reg,
>                             struct dev_pm_opp_supply *supply)
>  {
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 24c757a..57deef9 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -102,6 +102,8 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>
>  struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>                                               unsigned long *freq);
> +struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
> +                                             unsigned long u_volt);
>
>  struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
>                                              unsigned long *freq);
> @@ -207,6 +209,12 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>         return ERR_PTR(-ENOTSUPP);
>  }
>
> +static inline struct dev_pm_opp *dev_pm_opp_find_max_freq_by_volt(struct device *dev,
> +                                             unsigned long u_volt)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
> +
>  static inline struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
>                                         unsigned long *freq)
>  {
> --
> 1.8.1.1.dirty
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
