Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECAC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdFQ5XtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfDJRo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:44:56 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51539 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfDJRoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:44:55 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so4905322itk.1;
        Wed, 10 Apr 2019 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MV7KVJPMaMQx2Z9TncqSkCN/S9HTCt2ZwsjI0DEsHM4=;
        b=TdFQ5XtCSzZ0YvcqEVhgnY+OfFtN3pQs80IpIEiDK8z6zrmBfXiJ/JHSAqXB95zFvi
         MHIo7TlvMpjaQHIBWMnXY3LR8nDksuWPAFMhz5TWJaYLGnqK8Kqt+y4dIJmO+s1/aTmc
         BKhGKTPUFmdrxdiNs2PoTurB9/+mQ8Qf5jfYrYfHtJAyNkMsF+lMpyndo8+3BwXgUXz0
         06n9K4zE9G9pDnHjxLcdgCJmrlABwbqw39E+UNyzuHpF6O9v3lQocFPmKgYR5CPSSyMb
         KgRSVI2LO1tv/bnnkLX+ejhVJ7zXsEQ6dLWHCoyUVy2GwDpLxYBcmNfY80SsfOfKqPSm
         B9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MV7KVJPMaMQx2Z9TncqSkCN/S9HTCt2ZwsjI0DEsHM4=;
        b=F68o1MQ1m8NAD1rBlxgFIh1AyEWNGdKZWbPKWpnsAbwjn3ExqA2+HK78Fn4PtPkzsq
         glHHafrGpq/Pwz4/+OkDlhQOy1SvQzzaP+ifQlsH4SFSXFmqBgCu0qYEB+SfQkMyTGFS
         RAgxDSzGZox8v5k3hQ0CqPjOacsNE2+fZ1Oo+u30FWT9fAb4i9YxWva095Yr1Q00y52H
         iBS0l7y0RVsRCV5m5x09uXPS67Z++1kOkDcoByZc6oy6Tx/cu9R6D/2gEuuGf89Pg0x6
         xKbnDV2bskyMV0xlYSXZZlx/aJ9tv46RGXu9pBNeZRo6sOlS5idsawIq9mXQyQH4L76L
         oTEw==
X-Gm-Message-State: APjAAAXHJ1K6jngwcb67br2TBtrk61CUXrPJqgeRPvVhFLFUdHwfFurN
        Xv6oLapu3pgwCt0QzEPxkQQwBOaA9myIumJmLrDANNse
X-Google-Smtp-Source: APXvYqx8JTK2BbZhjYazxQ3r/8SI19BSRChchEVxn9RdHJA52NjDNRYL8fZLhw/IudwQX2nOl7sG7VtxNh5WNtn2EYo=
X-Received: by 2002:a24:9b8b:: with SMTP id o133mr4573561itd.74.1554918294637;
 Wed, 10 Apr 2019 10:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190409172558.18778-1-tiny.windzz@gmail.com> <20190409172558.18778-2-tiny.windzz@gmail.com>
 <20190410032404.eskk4qxbsws6fbec@vireshk-i7>
In-Reply-To: <20190410032404.eskk4qxbsws6fbec@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 11 Apr 2019 01:44:43 +0800
Message-ID: <CAEExFWvUzPcGckJ_ceAhRM9wduo+=nEgSiwePmvpKcxx5gBDkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpufreq: Add sunxi nvmem based CPU scaling driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-04-19, 13:25, Yangtao Li wrote:
> > +static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
> > +     .efuse_xlate = sun50i_efuse_xlate,
> > +     .nvmem_mask = 0x7,
> > +     .nvmem_shift = 5,
> > +};
> > +
> > +static const struct of_device_id sunxi_cpufreq_match_list[] = {
> > +     { .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
> > +     {}
> > +};
> > +
> > +static const struct of_device_id *sunxi_cpufreq_match_node(void)
> > +{
> > +     struct device_node *np;
> > +     const struct of_device_id *match;
> > +
> > +     np = of_find_node_by_path("/");
> > +     match = of_match_node(sunxi_cpufreq_match_list, np);
> > +     of_node_put(np);
> > +
> > +     return match;
> > +}
> > +
>
> Above code can be placed just above sunxi_cpufreq_init(), if you ...
>
> > +static int sunxi_cpufreq_nvmem_probe(struct platform_device *pdev)
> > +{
> > +     const struct sunxi_cpufreq_soc_data *soc_data;
> > +     struct opp_table **opp_tables;
> > +     const struct of_device_id *match;
> > +     char name[MAX_NAME_LEN];
> > +     unsigned int cpu;
> > +     u32 speed = 0;
> > +     int ret;
> > +
> > +     opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
> > +                          GFP_KERNEL);
> > +     if (!opp_tables)
> > +             return -ENOMEM;
> > +
> > +     match = sunxi_cpufreq_match_node();
>
> ... avoid this and ...
>
> > +     soc_data = match->data;
> > +     if (!soc_data)
> > +             return -EINVAL;
> > +
> > +     ret = sunxi_cpufreq_get_efuse(soc_data, &speed);
> > +     if (ret)
> > +             return ret;
> > +
> > +     snprintf(name, MAX_NAME_LEN, "speed%d", speed);
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             struct device *cpu_dev = get_cpu_device(cpu);
> > +
> > +             if (NULL == cpu_dev) {
> > +                     ret = -ENODEV;
> > +                     goto free_opp;
> > +             }
> > +
> > +             opp_tables[cpu] = dev_pm_opp_set_prop_name(cpu_dev, name);
> > +             if (IS_ERR(opp_tables[cpu])) {
> > +                     ret = PTR_ERR(opp_tables[cpu]);
> > +                     pr_err("Failed to set prop name\n");
> > +                     goto free_opp;
> > +             }
> > +     }
> > +
> > +     cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
> > +                                                       NULL, 0);
> > +     if (!IS_ERR(cpufreq_dt_pdev)) {
> > +             platform_set_drvdata(pdev, opp_tables);
> > +             return 0;
> > +     }
> > +
> > +     ret = PTR_ERR(cpufreq_dt_pdev);
> > +     pr_err("Failed to register platform device\n");
> > +
> > +free_opp:
> > +     for_each_possible_cpu(cpu) {
> > +             if (IS_ERR_OR_NULL(opp_tables[cpu]))
> > +                     break;
> > +             dev_pm_opp_put_prop_name(opp_tables[cpu]);
> > +     }
> > +     kfree(opp_tables);
> > +
> > +     return ret;
> > +}
> > +
> > +static int sunxi_cpufreq_nvmem_remove(struct platform_device *pdev)
> > +{
> > +     struct opp_table **opp_tables = platform_get_drvdata(pdev);
> > +     unsigned int cpu;
> > +
> > +     platform_device_unregister(cpufreq_dt_pdev);
> > +
> > +     for_each_possible_cpu(cpu)
> > +             dev_pm_opp_put_prop_name(opp_tables[cpu]);
> > +
> > +     kfree(opp_tables);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver sunxi_cpufreq_driver = {
> > +     .probe = sunxi_cpufreq_nvmem_probe,
> > +     .remove = sunxi_cpufreq_nvmem_remove,
> > +     .driver = {
> > +             .name = "sunxi-cpufreq-nvmem",
> > +     },
> > +};
> > +
> > +/*
> > + * Since the driver depends on nvmem drivers, which may return EPROBE_DEFER,
> > + * all the real activity is done in the probe, which may be defered as well.
> > + * The init here is only registering the driver and the platform device.
> > + */
> > +static int __init sunxi_cpufreq_init(void)
> > +{
> > +     const struct of_device_id *match;
> > +     int ret;
> > +
> > +     match = sunxi_cpufreq_match_node();
> > +     if (!match)
> > +             return -ENODEV;
> > +
> > +     ret = platform_driver_register(&sunxi_cpufreq_driver);
> > +     if (unlikely(ret < 0))
> > +             return ret;
> > +
> > +     sunxi_cpufreq_pdev = platform_device_register_simple(
> > +             "sunxi-cpufreq-nvmem", -1, NULL, 0);
>
> ... pass match->data as platform device's data here..
Yead, it is.

Thanks,
Yangtao
>
> > +     ret = PTR_ERR_OR_ZERO(sunxi_cpufreq_pdev);
> > +     if (0 == ret)
> > +             return 0;
> > +
> > +     platform_driver_unregister(&sunxi_cpufreq_driver);
> > +     return ret;
> > +}
> > +module_init(sunxi_cpufreq_init);
> > +
> > +static void __exit sunxi_cpufreq_exit(void)
> > +{
> > +     platform_device_unregister(sunxi_cpufreq_pdev);
> > +     platform_driver_unregister(&sunxi_cpufreq_driver);
> > +}
> > +module_exit(sunxi_cpufreq_exit);
> > +
> > +MODULE_DESCRIPTION("Sunxi cpufreq driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.0
>
> --
> viresh
