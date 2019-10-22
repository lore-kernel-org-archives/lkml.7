Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31962CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EE42084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mg7Pf6PH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbfJVQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:52:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38315 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfJVQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:52:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so11002856pfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qgxiAMf8J9Rb3V0ha9CD2NE6QHGIl7mLwyD/YuBmDvA=;
        b=Mg7Pf6PHJ2wLZLrBOWHx8MHvbmSkzdFJbQBIubvtYAGXgZfIohd84Tkw/jIjrrOuXn
         WD+L1CimI92csjXlfYkhOskJPpWuYMRq2tW31mQy5Uddkz0pTEX6yM1VeqB8NyjQ+96j
         HAj08nS33ib/aK6hVA1gIykm5fDINl8TqTAeY8+74eBVpu3Q+bH6FzAAGv5C/IYtef6I
         XvKUr8YHonGfHudkY0RmqTDUOTLXEFT32pKdNLrIJWeZkBGRxTvjGHcg4muEFveiYOnI
         Rn6E3Mr6V9/cBfpcTAb3qwUEYWjRI4iwR2tZ3f7ElyB9Ip2v3+cfDFa0kuhJDPUSFAgW
         zt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qgxiAMf8J9Rb3V0ha9CD2NE6QHGIl7mLwyD/YuBmDvA=;
        b=ipn3xcPEFh4mpmQ5h/rCaS4v4Vn7P68rqUCo/uRK9tOodVuMuVu+3IyNZbjyL5cWgo
         PIM19SBgkImnxZuqZkXuwhfTRPmUNHlYfejEYyCDG1WBnU4QcWd0l3S/gxfJ+FtZkmdl
         we297UCUX21q3JGSZN6HdqQ5/oTPgsfGgHtu9muCwP6WqwMZayOh4oV5FGHOgnvGwhpS
         RHFS4qjFaLY1sDVy5ySNQMXVwuPvD4loA0LuoIT7/EsDIwq0SX8QFmejsurvHbxMQQIC
         KhSquhgv/Wwszib94U7+jEmj7Z83UlFxbCwhpa3nxGeWuTPKaFrStRP+AMN2bEFz5KnG
         PQEQ==
X-Gm-Message-State: APjAAAUnpr2WAjavuLMhGYPladHVH6ESs9qSNFtEMIZJuF0I1HmoCU8y
        Sb/mtE6jS+sob/Yl4rlrC5iFag==
X-Google-Smtp-Source: APXvYqwG28pUeMKVh8JqoybKDQymZgRZ3reYnBiPfJhaAoKRteW9IpS5SQ7LOzNtzj6H7/Iubgdrig==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr5375661pfb.60.1571763133435;
        Tue, 22 Oct 2019 09:52:13 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y9sm20005610pgq.11.2019.10.22.09.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 09:52:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:52:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coresight: Serialize enabling/disabling a link device.
Message-ID: <20191022165210.GA6360@xps15>
References: <20191018181403.106836-1-yabinc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018181403.106836-1-yabinc@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Yabin,

On Fri, Oct 18, 2019 at 11:14:03AM -0700, Yabin Cui wrote:
> When tracing etm data of multiple threads on multiple cpus through perf
> interface, some link devices are shared between paths of different cpus.
> It creates race conditions when different cpus wants to enable/disable
> the same link device at the same time.
> 
> Example 1:
> Two cpus want to enable different ports of a coresight funnel, thus
> calling the funnel enable operation at the same time. But the funnel
> enable operation isn't reentrantable.
> 
> Example 2:
> For an enabled coresight dynamic replicator with refcnt=1, one cpu wants
> to disable it, while another cpu wants to enable it. Ideally we still have
> an enabled replicator with refcnt=1 at the end. But in reality the result
> is uncertain.
> 
> Since coresight devices claim themselves when enabled for self-hosted
> usage, the race conditions above usually make the link devices not usable
> after many cycles.
> 
> To fix the race conditions, this patch uses spinlocks to serialize
> enabling/disabling link devices.
> 
> Fixes: a06ae8609b3d ("coresight: add CoreSight core layer framework")
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> 
> v3 -> v4: moved lock from coresight_enable/disable_link() to
> enable/disable functions of each link device.
> 
> I also removed lock protection of csdev->enable in v3. Because that
> needs to move csdev->enable inside the enable/disable functions of
> each link device. That's much effort with almost no benefits.
> csdev->enable seems only used for source devices in sysfs interface.
> 
> ---
>  .../hwtracing/coresight/coresight-funnel.c    | 29 ++++++++----
>  .../coresight/coresight-replicator.c          | 31 +++++++++----
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 39 ++++++++--------
>  drivers/hwtracing/coresight/coresight.c       | 45 ++++++-------------
>  4 files changed, 77 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 05f7896c3a01..8326d03a0d03 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -44,6 +44,7 @@ struct funnel_drvdata {
>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
>  	unsigned long		priority;
> +	spinlock_t		spinlock;

Please document the new entry as it is for other fields of the structure.

>  };
>  
>  static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
> @@ -76,12 +77,20 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
>  {
>  	int rc = 0;
>  	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
>  
> -	if (drvdata->base)
> -		rc = dynamic_funnel_enable_hw(drvdata, inport);
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_inc_return(&csdev->refcnt[inport]) == 1) {
> +		if (drvdata->base)
> +			rc = dynamic_funnel_enable_hw(drvdata, inport);
>  
> -	if (!rc)
> -		dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n", inport);
> +		if (rc)
> +			atomic_dec(&csdev->refcnt[inport]);
> +		else
> +			dev_dbg(&csdev->dev, "FUNNEL inport %d enabled\n",
> +				inport);

Calling dev_dbg() within an atomic context is guaranteed to make the lockdep
mechanic very angry.  Move it outside of the spinlock scope and control the
output of the message with a variable.

The same comment applies for the following hunks.

Thanks,
Mathieu

> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  	return rc;
>  }
>  
> @@ -107,11 +116,15 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
>  			   int outport)
>  {
>  	struct funnel_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
>  
> -	if (drvdata->base)
> -		dynamic_funnel_disable_hw(drvdata, inport);
> -
> -	dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_dec_return(&csdev->refcnt[inport]) == 0) {
> +		if (drvdata->base)
> +			dynamic_funnel_disable_hw(drvdata, inport);
> +		dev_dbg(&csdev->dev, "FUNNEL inport %d disabled\n", inport);
> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  }
>  
>  static const struct coresight_ops_link funnel_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index b29ba640eb25..427d8b8d0917 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -36,6 +36,7 @@ struct replicator_drvdata {
>  	void __iomem		*base;
>  	struct clk		*atclk;
>  	struct coresight_device	*csdev;
> +	spinlock_t		spinlock;
>  };
>  
>  static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
> @@ -97,11 +98,20 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
>  {
>  	int rc = 0;
>  	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	if (drvdata->base)
> -		rc = dynamic_replicator_enable(drvdata, inport, outport);
> -	if (!rc)
> -		dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_inc_return(&csdev->refcnt[outport]) == 1) {
> +		if (drvdata->base)
> +			rc = dynamic_replicator_enable(drvdata, inport,
> +						       outport);
> +
> +		if (rc)
> +			atomic_dec(&csdev->refcnt[outport]);
> +		else
> +			dev_dbg(&csdev->dev, "REPLICATOR enabled\n");
> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  	return rc;
>  }
>  
> @@ -137,10 +147,15 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
>  			       int outport)
>  {
>  	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	unsigned long flags;
>  
> -	if (drvdata->base)
> -		dynamic_replicator_disable(drvdata, inport, outport);
> -	dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
> +	spin_lock_irqsave(&drvdata->spinlock, flags);
> +	if (atomic_dec_return(&csdev->refcnt[outport]) == 0) {
> +		if (drvdata->base)
> +			dynamic_replicator_disable(drvdata, inport, outport);
> +		dev_dbg(&csdev->dev, "REPLICATOR disabled\n");
> +	}
> +	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  }
>  
>  static const struct coresight_ops_link replicator_link_ops = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 807416b75ecc..cb4a38541bf8 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -334,23 +334,25 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
>  static int tmc_enable_etf_link(struct coresight_device *csdev,
>  			       int inport, int outport)
>  {
> -	int ret;
> +	int ret = 0;
>  	unsigned long flags;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (drvdata->reading) {
> -		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -		return -EBUSY;
> +	if (atomic_inc_return(&csdev->refcnt[0]) == 1) {
> +		if (drvdata->reading)
> +			ret = -EBUSY;
> +		else
> +			ret = tmc_etf_enable_hw(drvdata);
> +
> +		if (ret) {
> +			atomic_dec(&csdev->refcnt[0]);
> +		} else {
> +			drvdata->mode = CS_MODE_SYSFS;
> +			dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
> +		}
>  	}
> -
> -	ret = tmc_etf_enable_hw(drvdata);
> -	if (!ret)
> -		drvdata->mode = CS_MODE_SYSFS;
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -
> -	if (!ret)
> -		dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
>  	return ret;
>  }
>  
> @@ -361,16 +363,13 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
> -	if (drvdata->reading) {
> -		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -		return;
> -	}
> -
> -	tmc_etf_disable_hw(drvdata);
> -	drvdata->mode = CS_MODE_DISABLED;
> +	if (atomic_dec_return(&csdev->refcnt[0]) == 0)
> +		if (!drvdata->reading) {
> +			tmc_etf_disable_hw(drvdata);
> +			drvdata->mode = CS_MODE_DISABLED;
> +			dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
> +		}
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -
> -	dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
>  }
>  
>  static void *tmc_alloc_etf_buffer(struct coresight_device *csdev,
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 6453c67a4d01..0bbce0d29158 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -253,9 +253,9 @@ static int coresight_enable_link(struct coresight_device *csdev,
>  				 struct coresight_device *parent,
>  				 struct coresight_device *child)
>  {
> -	int ret;
> +	int ret = 0;
>  	int link_subtype;
> -	int refport, inport, outport;
> +	int inport, outport;
>  
>  	if (!parent || !child)
>  		return -EINVAL;
> @@ -264,29 +264,17 @@ static int coresight_enable_link(struct coresight_device *csdev,
>  	outport = coresight_find_link_outport(csdev, child);
>  	link_subtype = csdev->subtype.link_subtype;
>  
> -	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG)
> -		refport = inport;
> -	else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT)
> -		refport = outport;
> -	else
> -		refport = 0;
> -
> -	if (refport < 0)
> -		return refport;
> +	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG && inport < 0)
> +		return inport;
> +	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && outport < 0)
> +		return outport;
>  
> -	if (atomic_inc_return(&csdev->refcnt[refport]) == 1) {
> -		if (link_ops(csdev)->enable) {
> -			ret = link_ops(csdev)->enable(csdev, inport, outport);
> -			if (ret) {
> -				atomic_dec(&csdev->refcnt[refport]);
> -				return ret;
> -			}
> -		}
> -	}
> -
> -	csdev->enable = true;
> +	if (link_ops(csdev)->enable)
> +		ret = link_ops(csdev)->enable(csdev, inport, outport);
> +	if (!ret)
> +		csdev->enable = true;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void coresight_disable_link(struct coresight_device *csdev,
> @@ -295,7 +283,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
>  {
>  	int i, nr_conns;
>  	int link_subtype;
> -	int refport, inport, outport;
> +	int inport, outport;
>  
>  	if (!parent || !child)
>  		return;
> @@ -305,20 +293,15 @@ static void coresight_disable_link(struct coresight_device *csdev,
>  	link_subtype = csdev->subtype.link_subtype;
>  
>  	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
> -		refport = inport;
>  		nr_conns = csdev->pdata->nr_inport;
>  	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
> -		refport = outport;
>  		nr_conns = csdev->pdata->nr_outport;
>  	} else {
> -		refport = 0;
>  		nr_conns = 1;
>  	}
>  
> -	if (atomic_dec_return(&csdev->refcnt[refport]) == 0) {
> -		if (link_ops(csdev)->disable)
> -			link_ops(csdev)->disable(csdev, inport, outport);
> -	}
> +	if (link_ops(csdev)->disable)
> +		link_ops(csdev)->disable(csdev, inport, outport);
>  
>  	for (i = 0; i < nr_conns; i++)
>  		if (atomic_read(&csdev->refcnt[i]) != 0)
> -- 
> 2.23.0.866.gb869b98d4c-goog
> 
