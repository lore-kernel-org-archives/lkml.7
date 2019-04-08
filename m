Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBFC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE21021473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qY5Aj+jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfDHOZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:25:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44959 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbfDHOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:25:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so7411832pgj.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=P4vKQmbK14vtbIuUEndCl5MfnUaB3hSyiz0CQzCAQZw=;
        b=qY5Aj+jjp/s1OSKgwZzU3l7+6LRruW6kkAAmrM7wKfUAdxwjQQxdeNZ/RTPhazCg3J
         H+cnE0oznA7ZjQ86s8U5XSbCO9iuZBNwagfDSqpGOeGZQ2AnyTGLShNvbaQaPBb+iw/K
         Hdkouht+z8nSthWNBPdK2PD3K/MmxfyYTaxsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=P4vKQmbK14vtbIuUEndCl5MfnUaB3hSyiz0CQzCAQZw=;
        b=Y+3epFaLysXIGEKuLjupar374NG7GxShj7iCqmZ4gBmW+U0T2Q3/ybyol0MvT/82V3
         blJ12VxIRgThi4shac4FcXA5vgK1afPrQYK3Qo6ttEjHeXNd8Fa40gNCs/MtInKcLgyb
         wCDVN+0TB6imGIERZWeKyacXXZzjMlx+XXSISZNRTQRl6tDax7UwDoOVvZWGSlIDqx7e
         b5/CM70eEkpN5m9BK741hP5EgYZNijCmWccCwcGZzrRoY22M88FOkOFk4iH8xZrz0P2l
         l03I8mBmb1moB82le4IA8dVkfeeq73XOQjHCv6fsoakPG5jpOn4jNWtw0cpLBiqqHL0K
         orlg==
X-Gm-Message-State: APjAAAXMJaC1gHFKvY4qwCs4/hlt8pbpTtgleQswj8fKmO2hMHtu/Uyx
        /clwCwIUk9fNWR/o6oIFnAFfNA==
X-Google-Smtp-Source: APXvYqzsA1AXiPykN+pw3sx+WRcap8ev3d4GcOkTSI8xZZNomj0hdsu8k/FPqteD9t9mt5/PsBrx4A==
X-Received: by 2002:a63:f212:: with SMTP id v18mr27873814pgh.231.1554733547282;
        Mon, 08 Apr 2019 07:25:47 -0700 (PDT)
Received: from localhost (124-171-136-51.dyn.iinet.net.au. [124.171.136.51])
        by smtp.gmail.com with ESMTPSA id z13sm43143504pgc.25.2019.04.08.07.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 07:25:46 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        ego@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
In-Reply-To: <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com> <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
Date:   Tue, 09 Apr 2019 00:25:42 +1000
Message-ID: <87lg0kwp3t.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, just realised another thing I wanted to ask:

> @@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		}
>  	}
>
>
> +#ifdef CPUIDLE_FLAG_AUTO_PROMOTION

Why is this based on CPUIDLE_FLAG_ rather than CONFIG_CPU_IDLE_? Won't
this always be true, given that the flag is defined regardless of the
config option in the header?

> +	if (drv->states[idx].flags & CPUIDLE_FLAG_AUTO_PROMOTION) {
> +		/*
> +		 * Timeout is intended to be defined as sum of target residency
> +		 * of next available state, entry latency and exit latency. If
> +		 * time interval equal to timeout is spent in current state,
> +		 * and if it is a shallow lite state, we may want to auto-
> +		 * promote from such state.
> +		 */

Regards,
Daniel

> +		for (i = idx + 1; i < drv->state_count; i++) {
> +			if (drv->states[i].disabled ||
> +					dev->states_usage[i].disable)
> +				continue;
> +			*timeout = drv->states[i].target_residency +
> +					2 * drv->states[i].exit_latency;
> +			break;
> +		}
> +	}
> +#endif
> +
>  	return idx;
>  }
>  
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 3b3947232..84d76d1ec 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -72,6 +72,13 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
>  #define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
> +/*
> + * State with only and only fast state bit set don't even lose user context.
> + * But such states prevent other sibling threads from thread folding benefits.
> + * And hence we don't want to stay for too long in such states and want to
> + * auto-promote from it.
> + */
> +#define CPUIDLE_FLAG_AUTO_PROMOTION	BIT(3)
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> @@ -243,7 +250,8 @@ struct cpuidle_governor {
>  
>  	int  (*select)		(struct cpuidle_driver *drv,
>  					struct cpuidle_device *dev,
> -					bool *stop_tick);
> +					bool *stop_tick, unsigned long
> +					*timeout);
>  	void (*reflect)		(struct cpuidle_device *dev, int index);
>  };
>  
> -- 
> 2.17.1
