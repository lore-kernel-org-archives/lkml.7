Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DCC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBEC20842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 00:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NCxT1PtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfKJAai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 19:30:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43774 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfKJAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 19:30:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so6586810pgh.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 16:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=QJ9M/1JvgfL9a3naUkuoeUKHp140e3y+7LN+oRlvvF0=;
        b=NCxT1PtSjVriRDY0McvWgqg1c96vuIp6GwyYFPzUd8SsWhDu6AwFt1cy+ZjLXPFvGF
         LhFFE+gwmzFecxdZ7WNuy7InOhsm6d1xROIkSmVm+R/UZHOYYc7nSCM4IoA5iXAfPatm
         I6bAdoT4eqFv5eCSyEzQQq9jCwzRNgp0LEGoIgQ9u1tfVLi6LtpyzphrogFujaLOJVAY
         OpDqbE7AQHo3fmg66SEF31pePDtgnfa8yQZZJK3WeV2qZX2nI++q4iPd7J0bGKA18H42
         6mx/bhK0qpDwTlrSoV9ISWG//olIHZOODsFZWsDrk43o7EN8QE9jfWMqBCkPc44h1l1/
         NRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QJ9M/1JvgfL9a3naUkuoeUKHp140e3y+7LN+oRlvvF0=;
        b=FNAMu23WJl1/bN0peKEB/9NMrpqUhz61F6qLhXdJzUi8lb6i2QHO+XoepEjYlgmaLa
         umJUuLvDzrERT/wLhN9XgOlicc9ekruCpgICrtLH7xSOVKikhzD6TlxeamWQSt4juara
         2XVC+dNC4Yuz68CQZu/J+zQANFFm7GN8pnZ5My5qG4NL4+oik2e4X0X8OzzH2qM+yizd
         oX6Y/pYQihwL85TlwMrZXsqWEa6icCIpohsgwA4zkZT9Fwxy2oS5CJmQjwwlxvha5ev4
         Bkd4MjfWr6PseqW5ZUGQxEucxLizKbHxsjrYTClon6uFxfLBGmf+L5Kjog/xJQdRk1Zm
         tDkA==
X-Gm-Message-State: APjAAAV9e0oFlUXua44GXP9b/OQ+dfRHTShyvff645GapsJGJQ2eb0q2
        mTG9kFIFnPe8dfoJ5I7qj5xcfA==
X-Google-Smtp-Source: APXvYqxu6JimPLetLyzs5b3fNNN+T5TOM3IxKtOOtZlw0hsFzmo99TMBKf40oTi9kAjJRpBteOx8Ug==
X-Received: by 2002:a17:90a:d792:: with SMTP id z18mr24756222pju.34.1573345835992;
        Sat, 09 Nov 2019 16:30:35 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:7c60:912:1380:6df8])
        by smtp.gmail.com with ESMTPSA id 126sm3785679pgi.9.2019.11.09.16.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Nov 2019 16:30:35 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v4 3/4] soc: amlogic: Add support for Secure power domains controller
In-Reply-To: <1572868028-73076-4-git-send-email-jianxin.pan@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com> <1572868028-73076-4-git-send-email-jianxin.pan@amlogic.com>
Date:   Sat, 09 Nov 2019 21:09:31 +0100
Message-ID: <7hmud4stfo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Add support for the Amlogic Secure Power controller. In A1/C1 series, power
> control registers are in secure domain, and should be accessed by smc.
>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>

This driver is looking pretty good.  A few more minor comments below.

[...]

> +static bool pwrc_secure_is_off(struct meson_secure_pwrc_domain *pwrc_domain)
> +{
> +	int sts = 1;

What does 'sts' mean?  status?  or something else?  Please use a more
descriptive name.

> +	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_GET, &sts,
> +			  pwrc_domain->index, 0, 0, 0, 0) < 0)
> +		pr_err("failed to get power domain status\n");

Does any bit in this register mean the power domain is off?  I think it
would be better (and more future proof) if you checked the specific bit
(or mask)

> +	return !!sts;

and then:

    return sts & bitmask;
    
> +}
> +
> +static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
> +{
> +	int sts = 0;

Like above, what does sts mean?

> +	struct meson_secure_pwrc_domain *pwrc_domain =
> +		container_of(domain, struct meson_secure_pwrc_domain, base);
> +
> +	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_SET, NULL,
> +			  pwrc_domain->index, PWRC_OFF, 0, 0, 0) < 0) {
> +		pr_err("failed to set power domain off\n");
> +		sts = -EINVAL;
> +	}
> +
> +	return sts;

It looks to me like sts is only used as a return code, so maybe call it
ret for clarity?  or rename it to something more descriptive.

> +}
> +
> +static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
> +{
> +	int sts = 0;
> +	struct meson_secure_pwrc_domain *pwrc_domain =
> +		container_of(domain, struct meson_secure_pwrc_domain, base);
> +
> +	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_SET, NULL,
> +			  pwrc_domain->index, PWRC_ON, 0, 0, 0) < 0) {
> +		pr_err("failed to set power domain on\n");
> +		sts = -EINVAL;
> +	}
> +
> +	return sts;

same comment as above.

> +}
> +
> +#define SEC_PD(__name, __flag)			\
> +[PWRC_##__name##_ID] =				\
> +{						\
> +	.name = #__name,			\
> +	.index = PWRC_##__name##_ID,		\
> +	.is_off = pwrc_secure_is_off,	\
> +	.flags = __flag,			\
> +}
> +
> +static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
> +	SEC_PD(DSPA,	0),
> +	SEC_PD(DSPB,	0),
> +	/* UART should keep working in ATF after suspend and before resume */
> +	SEC_PD(UART,	GENPD_FLAG_ALWAYS_ON),
> +	/* DMC is for DDR PHY ana/dig and DMC, and should be always on */
> +	SEC_PD(DMC,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(I2C,	0),
> +	SEC_PD(PSRAM,	0),
> +	SEC_PD(ACODEC,	0),
> +	SEC_PD(AUDIO,	0),
> +	SEC_PD(OTP,	0),
> +	SEC_PD(DMA,	0),
> +	SEC_PD(SD_EMMC,	0),
> +	SEC_PD(RAMA,	0),
> +	/* SRAMB is used as AFT runtime memory, and should be always on */

AFT?  I assume you mean ATF?

> +	SEC_PD(RAMB,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(IR,	0),
> +	SEC_PD(SPICC,	0),
> +	SEC_PD(SPIFC,	0),
> +	SEC_PD(USB,	0),
> +	/* NIC is for NIC400, and should be always on */

Why?

> +	SEC_PD(NIC,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(PDMIN,	0),
> +	SEC_PD(RSA,	0),
> +};

[...]

Kevin
