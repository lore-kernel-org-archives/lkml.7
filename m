Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC8F217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zy9STjlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCNGaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:30:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42755 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfCNGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:30:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so400140pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KhSnHeqe4D/fyy9G25ccbfzI7LfytwdlOPC5x6nf/rU=;
        b=Zy9STjlD3rFg9SbA6g1AFD5jaEmAwI2zyZpMraFfKiS+a9GcQhIYA6EElFTm4ERBHC
         611MW3WUJcEbZQyBUGnuzFmOp1sc/m6AN6CcL2KjFBbX1iSCMcIvhFdLPEZIjSTgjAvn
         cPUzr+7PT0hWHeHG5RKigsqEWB1R0nuH/NLzj769n1OEeXJmbHxLxmxFR9tGID5Z786+
         bGOmP0EWudf6kVZQyvUPkgeGc+t5Tz0S67yuKUm5imS2R4RFkfnOg6XAlNkyzae8tnjq
         ynt1Ssnt9QMMdWVEh3waK9eawdiZKRvpulzz37osZ65CoKq+NpmusuAqDIDDAPK4X+uE
         PAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KhSnHeqe4D/fyy9G25ccbfzI7LfytwdlOPC5x6nf/rU=;
        b=CmUowYyXxUquVAt6YhTtJg4Qh9GEbByjxSNYE9BYxM7Sk7LCnV/8rSbOFsi+27GopQ
         ZnW8OJpbxECv9UZ8yxq88ot1faOhfMZvnnGngAopgCje3VhfOxRFoHBx1yFyEKz7i5bW
         itN3sDAk9seDOKvODl1UFIGfctPvMId0aqhPZaxhASKLllAnmUTndWIu5ZnIUC009fMu
         Q5doa8zRSY5mfX+pUTiyAfU5wM3to5VlDfXZxG2wGLc/HeJ3F+IfuhUT9Q+hzaE0n12t
         ycLwYBqjEDl0F3kFkPfdG65wj9fMW3TccuBOL6api60MzN2kQ2yYw00CrvYebnfT4vAz
         xF3A==
X-Gm-Message-State: APjAAAXrMbcd00mPSqlekErtzmKikNP8nApdzHHbsjQ/YJtsKWhcRFYA
        t4VajITwd5cH/4UZeO3zSSu6XQ==
X-Google-Smtp-Source: APXvYqwJW2qpEoWlD23Jf/ykKwTgWaQ+G8q5FZ20AmFJhsXwqVBggewCQzqh+zJZpZ6TtwTMadJGYA==
X-Received: by 2002:a62:ae0b:: with SMTP id q11mr47887121pff.199.1552545050726;
        Wed, 13 Mar 2019 23:30:50 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id s6sm18749906pfe.37.2019.03.13.23.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:30:49 -0700 (PDT)
Date:   Thu, 14 Mar 2019 12:00:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] OPP: Add support for parsing the interconnect
 bandwidth
Message-ID: <20190314063047.urmzez52bdyrkdsu@vireshk-i7>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
 <20190313090010.20534-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313090010.20534-3-georgi.djakov@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-19, 11:00, Georgi Djakov wrote:
> The OPP bindings now support bandwidth values, so add support to parse it
> from device tree and store it into the new dev_pm_opp_icc_bw struct, which
> is part of the dev_pm_opp.
> 
> Also add and export the dev_pm_opp_set_path() and dev_pm_opp_put_path()
> helpers, to set (and release) an interconnect path to a device. The
> bandwidth of this path will be updated when the OPPs are switched.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/opp/core.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/opp/of.c       | 44 +++++++++++++++++++++++++++
>  drivers/opp/opp.h      |  6 ++++
>  include/linux/pm_opp.h | 14 +++++++++
>  4 files changed, 131 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e06a0ab05ad6..4b019cecaa07 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/interconnect.h>
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -1645,6 +1646,72 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
>  
> +/**
> + * dev_pm_opp_set_path() - Set interconnect path for a device
> + * @dev: Device for which interconnect path is being set.
> + * @name: Interconnect path name or NULL.
> + *
> + * This must be called before any OPPs are initialized for the device.
> + */
> +struct opp_table *dev_pm_opp_set_path(struct device *dev, const char *name)

Maybe the OPP core can do it itself in a similar way to how we do
clk_get() today ?

> +{
> +	struct opp_table *opp_table;
> +	int ret;
> +
> +	opp_table = dev_pm_opp_get_opp_table(dev);
> +	if (!opp_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* This should be called before OPPs are initialized */
> +	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
> +		ret = -EBUSY;
> +		goto err;
> +	}
> +
> +	/* Another CPU that shares the OPP table has set the path */
> +	if (opp_table->path)
> +		return opp_table;
> +
> +	/* Find interconnect path for the device */
> +	opp_table->path = of_icc_get(dev, name);
> +	if (IS_ERR(opp_table->path)) {
> +		ret = PTR_ERR(opp_table->clk);
> +		if (ret != -EPROBE_DEFER) {
> +			dev_err(dev, "%s: Couldn't find path: %d\n", __func__,
> +				ret);
> +		}
> +		goto err;
> +	}
> +
> +	return opp_table;
> +
> +err:
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_path);
> +
> +/**
> + * dev_pm_opp_put_path() - Release interconnect path resources
> + * @opp_table: OPP table returned from dev_pm_opp_set_path().
> + */
> +void dev_pm_opp_put_path(struct opp_table *opp_table)
> +{
> +	if (!opp_table->path)
> +		goto put_opp_table;
> +
> +	/* Make sure there are no concurrent readers while updating opp_table */
> +	WARN_ON(!list_empty(&opp_table->opp_list));
> +
> +	icc_put(opp_table->path);
> +	opp_table->path = NULL;
> +
> +put_opp_table:
> +	dev_pm_opp_put_opp_table(opp_table);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_put_path);
> +
>  /**
>   * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
>   * @dev: Device for which the helper is getting registered.
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 1779f2c93291..96fb7fdda8c7 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu.h>
>  #include <linux/errno.h>
>  #include <linux/device.h>
> +#include <linux/interconnect.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/slab.h>
> @@ -526,6 +527,45 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>  	return ret;
>  }
>  
> +static int opp_parse_icc_bw(struct dev_pm_opp *opp, struct device *dev,
> +			    struct opp_table *opp_table)
> +{
> +	struct property *prop = NULL;
> +	char name[NAME_MAX];
> +	int count;
> +	u32 avg = 0;
> +	u32 peak = 0;

Why init to 0 ?

> +
> +	/* Search for "opp-bw-MBs" */
> +	sprintf(name, "opp-bw-MBs");
> +	prop = of_find_property(opp->np, name, NULL);
> +
> +	/* Missing property is not a problem */
> +	if (!prop) {
> +		dev_dbg(dev, "%s: Missing opp-bw-MBs\n", __func__);
> +		return 0;
> +	}
> +
> +	count = of_property_count_u32_elems(opp->np, name);
> +	if (count != 2) {
> +		dev_err(dev, "%s: Invalid number of elements in %s property\n",
> +			__func__, name);
> +		return -EINVAL;
> +	}
> +
> +	opp->bandwidth = kzalloc(sizeof(*opp->bandwidth), GFP_KERNEL);

You forgot to free it.

> +	if (!opp->bandwidth)
> +		return -ENOMEM;
> +
> +	of_property_read_u32_index(opp->np, name, 0, &avg);
> +	of_property_read_u32_index(opp->np, name, 1, &peak);
> +
> +	opp->bandwidth->avg = MBps_to_icc(avg);
> +	opp->bandwidth->peak = MBps_to_icc(peak);
> +
> +	return 0;
> +}
> +
>  /**
>   * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
>   *				  entries
> @@ -619,6 +659,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (ret)
>  		goto free_required_opps;
>  
> +	ret = opp_parse_icc_bw(new_opp, dev, opp_table);
> +	if (ret)
> +		goto free_required_opps;
> +
>  	if (opp_table->is_genpd)
>  		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
>  
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 4458175aa661..b4287d065c24 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -24,6 +24,7 @@
>  
>  struct clk;
>  struct regulator;
> +struct icc_path;
>  
>  /* Lock to allow exclusive modification to the device and opp lists */
>  extern struct mutex opp_table_lock;
> @@ -62,6 +63,7 @@ extern struct list_head opp_tables;
>   * @rate:	Frequency in hertz
>   * @level:	Performance level
>   * @supplies:	Power supplies voltage/current values
> + * @bandwidth:	Interconnect bandwidth values
>   * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
>   *		frequency from any other OPP's frequency.
>   * @required_opps: List of OPPs that are required by this OPP.
> @@ -85,6 +87,8 @@ struct dev_pm_opp {
>  
>  	struct dev_pm_opp_supply *supplies;
>  
> +	struct dev_pm_opp_icc_bw *bandwidth;
> +
>  	unsigned long clock_latency_ns;
>  
>  	struct dev_pm_opp **required_opps;
> @@ -152,6 +156,7 @@ enum opp_table_access {
>   * property).
>   * @genpd_performance_state: Device's power domain support performance state.
>   * @is_genpd: Marks if the OPP table belongs to a genpd.
> + * @path: Interconnect path handle
>   * @set_opp: Platform specific set_opp callback
>   * @set_opp_data: Data to be passed to set_opp callback
>   * @dentry:	debugfs dentry pointer of the real device directory (not links).
> @@ -196,6 +201,7 @@ struct opp_table {
>  	int regulator_count;
>  	bool genpd_performance_state;
>  	bool is_genpd;
> +	struct icc_path *path;
>  
>  	int (*set_opp)(struct dev_pm_set_opp_data *data);
>  	struct dev_pm_set_opp_data *set_opp_data;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 900359342965..5edce71a15d6 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -43,6 +43,18 @@ struct dev_pm_opp_supply {
>  	unsigned long u_amp;
>  };
>  
> +/**
> + * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
> + * @avg:	Average bandwidth corresponding to this OPP (in icc units)
> + * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
> + *
> + * This structure stores the bandwidth values for a single interconnect path.
> + */
> +struct dev_pm_opp_icc_bw {
> +	u32 avg;
> +	u32 peak;
> +};

There is only one user of this structure, maybe we can directly add
the elements in teh dev_pm_opp structure.

> +
>  /**
>   * struct dev_pm_opp_info - OPP freq/voltage/current values
>   * @rate:	Target clk rate in hz
> @@ -127,6 +139,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * con
>  void dev_pm_opp_put_regulators(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
>  void dev_pm_opp_put_clkname(struct opp_table *opp_table);
> +struct opp_table *dev_pm_opp_set_path(struct device *dev, const char *name);
> +void dev_pm_opp_put_path(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
>  void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
>  struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);

-- 
viresh
