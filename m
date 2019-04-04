Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B83DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE49204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCOSIzX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDDEsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:48:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36372 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfDDEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 00:48:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id k130so876081qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 21:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQexCQ0NMxW/2IrPofG3L6xLJ8n9knIm3twcfu3uFuc=;
        b=UCOSIzX0Dx+OzL5ao4KWMTBxw26jfmj7laNwnKnYne0pzx882xrFt4T5Bo3AS74Gmh
         3f7ctC2Sc7CrNVT59YNB9wlJAIevjL7LVlwhB/ulEUcjG4TNx1fQv41t7goUofIc+RzZ
         o7KsVLDKWEQYE2CuYn5ToiYP3BuUhW+jcbQUK6hG+4d+LOUSJONiZ2QUaRdgRrcInlC0
         neBK6YGUSiWcfJqaKYeFMlSUkcCpHai4IDvpJI/+r+WqPMnaJB1HRRZsD2vyatCYtK51
         /n3L42Y56qAB/9076GOkeOyeRBbRJ/glv6LcmpOWWAS3h6EfrTVHAi1x/bHGOwdSQFdu
         OMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQexCQ0NMxW/2IrPofG3L6xLJ8n9knIm3twcfu3uFuc=;
        b=KYr43qIjScaQjT5qgZoBkVwRIgnU/yWV7RvTXypgRTzHkWMwGRXMYZvEo8CgMNiPDC
         HP3s48eR528oule9f9DihbDbVfS9DuBO7XIDAgLF8u2A5XkCak0ssa4XxRE4O/uycTr8
         jQR5sF8aFxdKmjmillIv4d9tM60mq7Q7KjFAPesAsJmBs/fFZYWfy+gnNssFncGhOUJR
         jvUFZIR700Nsg8QOl7OLngY3/1xH4K9n2jDUIHvHE5o6wANd/fpkk/lBIWYEc+MnIJmL
         IZkyk6BZKXhk3ZLc/LdayXp4qr5Oz8PHz9/L12frxtw7jrBe3BwckSFM/pvQWLoR1Ci3
         6UVw==
X-Gm-Message-State: APjAAAVRSMarlWCF2jcHkm5Nea9AeYT1kBoDp6CDouyC72bprKx/l+md
        Tq17w7JhyKg8IkKP0qNcof4gz510PNun1TR4o5TYRig0
X-Google-Smtp-Source: APXvYqwct8MDayZbZCSX381WIs7AB3bUVH57p//IqtWYThB7gr4IDqLuVWxFn5bwctM6Qp5egibL5QSE0qEztvWrBh8=
X-Received: by 2002:a37:784:: with SMTP id 126mr3264553qkh.10.1554353293115;
 Wed, 03 Apr 2019 21:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190404033541.14072-1-mathieu.poirier@linaro.org> <20190404033541.14072-5-mathieu.poirier@linaro.org>
In-Reply-To: <20190404033541.14072-5-mathieu.poirier@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 4 Apr 2019 05:47:53 +0100
Message-ID: <CAJ9a7Vg1SOQ6r-FRFBg20wRpZ5mdhEcuavXdMPfdrVC=CcR0iw@mail.gmail.com>
Subject: Re: [PATCH v3 04/20] coresight: etm4x: Configure tracers to emit timestamps
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Leach <mike.leach@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 4 Apr 2019 at 04:36, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> Configure timestamps to be emitted at regular intervals in the trace
> stream to temporally correlate instructions executed on different CPUs.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 101 +++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index d64192c29860..46d337fd8442 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -204,6 +204,90 @@ static void etm4_enable_hw_smp_call(void *info)
>         arg->rc = etm4_enable_hw(arg->drvdata);
>  }
>
> +/*
> + * The goal of function etm4_config_timestamp_event() is to configure a
> + * counter that will tell the tracer to emit a timestamp packet when it
> + * reaches zero.  This is done in order to get a more fine grained idea
> + * of when instructions are executed so that they can be correlated
> + * with execution on other CPUs.
> + *
> + * To do this the counter itself is configured to self reload and
> + * TRCRSCTLR1 (always true) used to get the counter to decrement.  From
> + * there a resource selector is configured with the counter and the
> + * timestamp control register to use the resource selector to trigger the
> + * event that will insert a timestamp packet in the stream.
> + */
> +static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
> +{
> +       int ctridx, ret = -EINVAL;
> +       int counter, rselector;
> +       u32 val = 0;
> +       struct etmv4_config *config = &drvdata->config;
> +
> +       /* No point in trying if we don't have at least one counter */
> +       if (!drvdata->nr_cntr)
> +               goto out;
> +
> +       /* Find a counter that hasn't been initialised */
> +       for (ctridx = 0; ctridx < drvdata->nr_cntr; ctridx++)
> +               if (config->cntr_val[ctridx] == 0)
> +                       break;
> +
> +       /* All the counters have been configured already, bail out */
> +       if (ctridx == drvdata->nr_cntr) {
> +               pr_debug("%s: no available counter found\n", __func__);
> +               ret = -ENOSPC;
> +               goto out;
> +       }
> +
> +       /*
> +        * Searching for an available resource selector to use, starting at
> +        * '2' since every implementation has at least 2 resource selector.
> +        * ETMIDR4 gives the number of resource selector _pairs_,
> +        * hence multiply by 2.
> +        */
> +       for (rselector = 2; rselector < drvdata->nr_resource * 2; rselector++)
> +               if (!config->res_ctrl[rselector])
> +                       break;
> +
> +       if (rselector == drvdata->nr_resource * 2) {
> +               pr_debug("%s: no available resource selector found\n", __func__);
> +               ret = -ENOSPC;
> +               goto out;
> +       }
> +
> +       /* Remember what counter we used */
> +       counter = 1 << ctridx;
> +
> +       /*
> +        * Initialise original and reload counter value to the smallest
> +        * possible value in order to get as much precision as we can.
> +        */
> +       config->cntr_val[ctridx] = 1;
> +       config->cntrldvr[ctridx] = 1;
> +
> +       /* Set the trace counter control register */
> +       val =  0x1 << 16        |  /* Bit 16, reload counter automatically */
> +              0x0 << 7         |  /* Select single resource selector */
> +              0x1;                /* Resource selector 1, i.e always true */
> +
> +       config->cntr_ctrl[ctridx] = val;
> +
> +       val = 0x2 << 16         | /* Group 0b0010 - Counter and sequencers */
> +             counter << 0;       /* Counter to use */
> +
> +       config->res_ctrl[rselector] = val;
> +
> +       val = 0x0 << 7          | /* Select single resource selector */
> +             rselector;          /* Resource selector */
> +
> +       config->ts_ctrl = val;
> +
> +       ret = 0;
> +out:
> +       return ret;
> +}
> +
>  static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
>                                    struct perf_event *event)
>  {
> @@ -239,9 +323,24 @@ static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
>                 /* TRM: Must program this for cycacc to work */
>                 config->ccctlr = ETM_CYC_THRESHOLD_DEFAULT;
>         }
> -       if (attr->config & BIT(ETM_OPT_TS))
> +       if (attr->config & BIT(ETM_OPT_TS)) {
> +               /*
> +                * Configure timestamps to be emitted at regular intervals in
> +                * order to correlate instructions executed on different CPUs
> +                * (CPU-wide trace scenarios).
> +                */
> +               ret = etm4_config_timestamp_event(drvdata);
> +
> +               /*
> +                * No need to go further if timestamp intervals can't
> +                * be configured.
> +                */
> +               if (ret)
> +                       goto out;
> +
>                 /* bit[11], Global timestamp tracing bit */
>                 config->cfg |= BIT(11);
> +       }
>

Here you are committing _all_ timestamp usage to be the "hi-freq"
timestamp required for all CPU - wide perf support.
This increases the amount of non-instruction trace - and my not be
desirable in all cases - especially if cycle counts are live as well.
Perhaps define a new ETM_OPT_FREQ_TS which will switch on TS + trigger
counters, and leave ETM_OPT_TS for standard timestamps.

Mike

>         if (attr->config & BIT(ETM_OPT_CTXTID))
>                 /* bit[6], Context ID tracing bit */
> --
> 2.17.1
>
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
