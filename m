Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E452C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87EF206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PteYC7nI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfDYVlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:41:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41286 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbfDYVli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:41:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so1396334wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2BbnDHSdmo9EsPssh4+cDnse2PF+EKLkrPxXRQPRv3U=;
        b=PteYC7nIBAGD7LJdOjlhH4ErRzLpUucdh0PzJOri70keJcE7oe0VK7tGnyw1aiQsk4
         0/feRsGlYVbxk7CwpvZE3ekPa8qnds9kBeQUapImzenbNioGaURUe5lF8ejlirbODlsy
         lMLFZjIx8DtmPEtiQ7BA6Iy+PHNd7TetVLFcWvXsnfNdW0+6BEsCZ+juYgEhEbXByH3/
         7hY0BoYvYXbboHWFluYE583WL8Tgzr5F4CRo4dYbYOr+w5RZ3Jqsm7UX9JTCP87U56+d
         mwV7dHGb0eeGUQ11DYvQLw39RWRXQ7beN0IbZtSRTPIwmr/Oy39EH53q8liJOWada7sE
         S7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2BbnDHSdmo9EsPssh4+cDnse2PF+EKLkrPxXRQPRv3U=;
        b=LFjgNYt2fsme9+FpTu3dLetBUm3HjvcxSIpIpXha1vt416F4DDlIiQIOgPY6YWYupp
         OVMGPGcd5fBoyg62ohUTM0spMndQ8htE5rtEVHGynQAdWP8uTAVCcB0QR4WgLgyJKy+8
         ruhpQB4g7rpBCNqJKWpOGrcjLAFGT1vHuu4B2RlPT7KNYGE0SKNwjhDN7gLUCzTgvn8L
         3Gh9UZLLeOyRDKLKautHFl6OjthT6wVNmB0ByUgiziOj2tuw+VuFZyd0nTban012QyHg
         jxraphM73Qh5bGeBUC77Q8K4gNTJWiplJy2O4jghRqvajGu3J53KCXhVdUtAeIthxaA+
         oM9g==
X-Gm-Message-State: APjAAAUYs/VnJpJBtStqAVZMkz0z9/APtWDRLqzirMGWG1J102insBDH
        dzkBiI+Ff/jsngq+5fzhYR/KmA==
X-Google-Smtp-Source: APXvYqz/NnZShgYYb2LoFn+nXFrxK9q4LhZMsDhREk9lrIWFfGYHfWkP8HiIoZIZPHJ9BIYQL7qRyg==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr22325094wrn.235.1556228496305;
        Thu, 25 Apr 2019 14:41:36 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id d11sm10703499wrc.32.2019.04.25.14.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:41:35 -0700 (PDT)
Subject: Re: [PATCH v10 14/18] drivers/clocksource: timer-fsl-ftm: use common
 header for FlexTimer #defines
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, tglx@linutronix.de, thierry.reding@gmail.com,
        esben@haabendal.dk, linux-pwm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <95ce444a-2f10-ec89-cb13-578349511f6b@linaro.org>
Date:   Thu, 25 Apr 2019 23:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2019 08:30, William Breathitt Gray wrote:
> From: Patrick Havelange <patrick.havelange@essensium.com>
> 
> Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
> this file.
> Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.
> 
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Please, do pick my Acked-by from V2.

> ---
>  drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
> index 846d18daf893..e1c34b2f53a5 100644
> --- a/drivers/clocksource/timer-fsl-ftm.c
> +++ b/drivers/clocksource/timer-fsl-ftm.c
> @@ -19,20 +19,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/slab.h>
> +#include <linux/fsl/ftm.h>
>  
> -#define FTM_SC		0x00
> -#define FTM_SC_CLK_SHIFT	3
> -#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_PS_MASK	0x7
> -#define FTM_SC_TOIE	BIT(6)
> -#define FTM_SC_TOF	BIT(7)
> -
> -#define FTM_CNT		0x04
> -#define FTM_MOD		0x08
> -#define FTM_CNTIN	0x4C
> -
> -#define FTM_PS_MAX	7
> +#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
>  
>  struct ftm_clock_device {
>  	void __iomem *clksrc_base;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

