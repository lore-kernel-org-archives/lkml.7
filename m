Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF3C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B497217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZ9tQjYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgABJBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:01:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52524 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgABJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:01:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so4994281wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bY5c7mhj+MB1IJ1i7uGo/Kc8EYzOKkXDomOXublBO3U=;
        b=QZ9tQjYXqLoZLvcnLHcsTY2qVjqjJB70qBvkd87z+jX4Z5ulLtpvH9KLzOCuCBoqEC
         puvrqTQUSRQdxQ2OkmKp9rujNom5nuO41UowatKn5ddUTUBgZ0wc7WbgAf1/5VvZTnX6
         FZcZuuCEqFipHb8M3BBCwGKial148goxN+jTgRhnHIqg8KrHN2ssouFPxNhGFRqpsV0p
         VwaerlyXe6hyznrWziPw7nJ9Sggsgr8B4Sorf61KUKPYNglNXczlUghUxkCb2+xesvVf
         B6GseKrt7B1pCfpqcWW496RV+ckSdKeK+UjUWSEloQPpMNDLblBJQYnMaLcc1mgJxZFO
         8w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bY5c7mhj+MB1IJ1i7uGo/Kc8EYzOKkXDomOXublBO3U=;
        b=b4VDtM8HunShIol4xQJ/ukTBEiqNhznsDsLRR5cWBErJcAv9/1xf0Nqr8wenUZ9uFf
         IvzWMctNcW49aEqnIDn3+cG93I4wc2BSB2wupxLycj3VSIftyyDFW6kw39kGmQrd9ghn
         2RtgJPEAz4eSDVb20+I656QYBpNZ0d++h2T9ddaQyjwRWj0cC7SW4D9LNgRc5wJnEkIk
         mNKqW10Qqvr8NJGnxzSf+oDcXka9cJxlKTCUP7BTXH8DmCrYRfRXAMpj6nWbbLde+vOA
         SmOGPKnFAYw4LByMiNk94LzB8sQRfYK8z5ttydomMfOwQogQ8vn076SUq/Q2J7sTPTqf
         UU7Q==
X-Gm-Message-State: APjAAAWxRDvZcBvv5MAAMBcxc1a3S0TJgmubnhDZBvve10OmE1/9ot1Q
        FRAIvkWs67GPHlsDtVF4qVMJEQ==
X-Google-Smtp-Source: APXvYqzc1qfuS3RLws+tTcAymTsxhv+zMZcC9R7yOp7ylZs5RuOakRlsYmFitrb+VuJMsIiZ5HPG5w==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr13333290wmi.152.1577955680655;
        Thu, 02 Jan 2020 01:01:20 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id m21sm7872660wmi.27.2020.01.02.01.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 01:01:20 -0800 (PST)
Date:   Thu, 2 Jan 2020 09:01:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/37] mfd: intel_soc_pmic: Add SCU IPC member to struct
 intel_soc_pmic
Message-ID: <20200102090132.GD22390@dell>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
 <20191223141716.13727-27-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223141716.13727-27-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Mika Westerberg wrote:

> Both PMIC drivers (intel_soc_pmic_mrfld and intel_soc_pmic_bxtwc) will
> be using this field going forward to access the SCU IPC instance.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  include/linux/mfd/intel_soc_pmic.h | 1 +
>  1 file changed, 1 insertion(+)

This might be a good time to add a Kerneldoc header.

> diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
> index bfecd6bd4990..8ac130428bb4 100644
> --- a/include/linux/mfd/intel_soc_pmic.h
> +++ b/include/linux/mfd/intel_soc_pmic.h
> @@ -24,6 +24,7 @@ struct intel_soc_pmic {
>  	struct regmap_irq_chip_data *irq_chip_data_chgr;
>  	struct regmap_irq_chip_data *irq_chip_data_crit;
>  	struct device *dev;
> +	struct intel_scu_ipc_dev *scu;
>  };
>  
>  int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
