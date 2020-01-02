Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928FC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080A02465D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bh0JFpDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgABTp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:45:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35338 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABTp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:45:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so18205288plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+UN3qSYQcOwifkJGz4pMANPbaDE0ymHSNwCAW4vn8M=;
        b=Bh0JFpDVMQfGNXJ6TawXCTCGql4PIYiM/cBEign3YIXDdqzMyCbunqXhFmynhp+LfT
         8QgB3La0G5k2z/pxLE6LXt7tgmSnpODZxT3yS0HGwo3OiQHfk/b+7D6QiVeb8OpAC4Ug
         3tJRpbznFCIuQBmQ0gHNoFSVHoxv/XBm55WnTLyufj1uxjYj1V3U7qPSzm1yD/kO/rnK
         w4fhxokpUAvezWLk0aZ0hYgpJM0Z2bEFzkcQ2s0S9xRery/UMOEKqbehMvPSBBfiArSk
         jiT7frF2CwlyzSFVghXzEyzzdNULpIUfH6OVTexr3p6WfadD8o8+jw7kYJorAI/7keey
         +/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+UN3qSYQcOwifkJGz4pMANPbaDE0ymHSNwCAW4vn8M=;
        b=FGIygBgyxnDHITG2EHBcmkzGLtgQ94uTnvCS8sSEFWXLgJpGe6PoTSrdD7v8mD+iL3
         s/oZFHZe4kITjmlLCVCmg/rfgHBw4Nvxp6mMU9XCDO/4H5pz8rMvC6aLLRQoJJGFgQZj
         sKeuxhV8nGy3/D2+VOa31A9ZXTUesms6+JuXMgKf1hmU4mJJOijyLh5sZYNNlArLPAkP
         GAn1PFRyumdXlpKthPdAjp7gI31SQDb+sEkW2LXjlai2i8RCQaa/xjD1J4T0eztPVow5
         pb38IVuN31N6dGJPY6LWUZRw7YrBxy31V4nwl/jiHPyJ89PmxmvxqPxjDs/0o607leaa
         qHIg==
X-Gm-Message-State: APjAAAXIuOAvrECXFLHJZ/YPGhEq+2FcanxyHS1vRM7C74n1EK3QHI75
        +rmKm6xvH0Ot1o2zxnIQUlwhQA==
X-Google-Smtp-Source: APXvYqyEZGFGg9QbEMGWLdIG0/KtFjJac81L7sBMO5nSmou3U6fUVHcsSIcWFATw94ablkbJiWCkrA==
X-Received: by 2002:a17:90a:8a0e:: with SMTP id w14mr22075729pjn.51.1577994355911;
        Thu, 02 Jan 2020 11:45:55 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm65899367pfd.18.2020.01.02.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 11:45:55 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:45:52 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 5/9] drivers: thermal: tsens: Add critical interrupt
 support
Message-ID: <20200102194552.GD988120@minitux>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
 <9e3527ac0f6baa64aeda8eb634ca5020ea7478e5.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3527ac0f6baa64aeda8eb634ca5020ea7478e5.1577976221.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02 Jan 06:54 PST 2020, Amit Kucheria wrote:
[..]
> @@ -189,6 +197,9 @@ static void tsens_set_interrupt_v1(struct tsens_priv *priv, u32 hw_id,
>  	case LOWER:
>  		index = LOW_INT_CLEAR_0 + hw_id;
>  		break;
> +	case CRITICAL:
> +		/* No critical interrupts before v2 */
> +		break;

You need to break harder, right now you're just attempting to write
"enable" to VER_MAJOR in this case.

>  	}
>  	regmap_field_write(priv->rf[index], enable ? 0 : 1);
>  }
[..]
> @@ -321,6 +357,64 @@ static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
>  	return 0;
>  }
>  
> +/**
> + * tsens_critical_irq_thread - Threaded interrupt handler for critical interrupts

() on the function name to denote it being a function.

> + * @irq: irq number
> + * @data: tsens controller private data
> + *
> + * Check all sensors to find ones that violated their critical threshold limits.
> + * Clear and then re-enable the interrupt.
> + *
> + * The level-triggered interrupt might deassert if the temperature returned to
> + * within the threshold limits by the time the handler got scheduled. We
> + * consider the irq to have been handled in that case.
> + *
> + * Return: IRQ_HANDLED
> + */
> +irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> +{
> +	struct tsens_priv *priv = data;
> +	struct tsens_irq_data d;
> +	unsigned long flags;
> +	int temp, ret, i;
> +
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		const struct tsens_sensor *s = &priv->sensor[i];
> +		u32 hw_id = s->hw_id;
> +
> +		if (IS_ERR(s->tzd))
> +			continue;
> +		if (!tsens_threshold_violated(priv, hw_id, &d))
> +			continue;
> +		ret = get_temp_tsens_valid(s, &temp);
> +		if (ret) {
> +			dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
> +			continue;
> +		}
> +
> +		spin_lock_irqsave(&priv->ul_lock, flags);

You meant crit_lock here?

But perhaps more importantly, why do you need a lock here?

> +
> +		tsens_read_irq_state(priv, hw_id, s, &d);
> +
> +		if (d.crit_viol &&
> +		    !masked_irq(hw_id, d.crit_irq_mask, tsens_version(priv))) {
> +			tsens_set_interrupt(priv, hw_id, CRITICAL, false);
> +			if (d.crit_thresh > temp) {
> +				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> +					hw_id, __func__);
> +			} else {
> +				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> +					hw_id, __func__, temp);
> +			}
> +			tsens_set_interrupt(priv, hw_id, CRITICAL, true);
> +		}
> +
> +		spin_unlock_irqrestore(&priv->crit_lock, flags);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
[..]
> @@ -125,6 +125,28 @@ static int tsens_register(struct tsens_priv *priv)
>  		goto err_put_device;
>  	}
>  
> +	if (priv->feat->crit_int) {
> +		irq_crit = platform_get_irq_byname(pdev, "critical");
> +		if (irq_crit < 0) {
> +			ret = irq_crit;
> +			/* For old DTs with no IRQ defined */
> +			if (irq_crit == -ENXIO)
> +				ret = 0;
> +			goto err_crit_int;
> +		}
> +		ret = devm_request_threaded_irq(&pdev->dev, irq_crit,
> +						NULL, tsens_critical_irq_thread,
> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,

You should omit the IRQF_TRIGGER_HIGH here, it will be provided by the
system configuration (DT).

> +						dev_name(&pdev->dev), priv);
> +		if (ret) {
> +			dev_err(&pdev->dev, "%s: failed to get critical irq\n", __func__);
> +			goto err_crit_int;
> +		}
> +
> +		enable_irq_wake(irq_crit);
> +	}
> +
> +err_crit_int:
>  	enable_irq_wake(irq);
>  
>  err_put_device:
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
[..]
> @@ -460,6 +526,8 @@ struct tsens_context {
>   * @srot_map: pointer to SROT register address space
>   * @tm_offset: deal with old device trees that don't address TM and SROT
>   *             address space separately
> + * @ul_lock: lock while processing upper/lower threshold interrupts

This looks like an unrelated fixup to a previous patch? Please keep it
separate.

> + * @crit_lock: lock while processing critical threshold interrupts
>   * @rf: array of regmap_fields used to store value of the field
>   * @ctx: registers to be saved and restored during suspend/resume
>   * @feat: features of the IP
> @@ -479,6 +547,9 @@ struct tsens_priv {
>  	/* lock for upper/lower threshold interrupts */
>  	spinlock_t			ul_lock;
>  
> +	/* lock for critical threshold interrupts */
> +	spinlock_t			crit_lock;

You're lacking a spin_lock_init() of this.

> +
>  	struct regmap_field		*rf[MAX_REGFIELDS];
>  	struct tsens_context		ctx;
>  	struct tsens_features		*feat;
> @@ -500,6 +571,7 @@ int tsens_enable_irq(struct tsens_priv *priv);
>  void tsens_disable_irq(struct tsens_priv *priv);
>  int tsens_set_trips(void *_sensor, int low, int high);
>  irqreturn_t tsens_irq_thread(int irq, void *data);
> +irqreturn_t tsens_critical_irq_thread(int irq, void *data);

I think you should squash tsens.c and tsens-common.c into one file, so
you don't need to keep adding these extern declarations for every
function - separate of this series of course.

Regards,
Bjorn

>  
>  /* TSENS target */
>  extern struct tsens_plat_data data_8960;
> -- 
> 2.20.1
> 
