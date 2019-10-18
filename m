Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F376DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CB720820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGaCctYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502639AbfJRSWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:22:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40609 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394258AbfJRSWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:22:12 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so3236010pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OnK5lWkiyqDZC+wf98tKaPFQMaH5nw66vTCTgBsETB0=;
        b=HGaCctYWGOAh8+SVwpWSXyL2fpNLAwxTirQ1Uzay239tz4ROoP9VrzqTTnhFs2Mq13
         KhPAlO/FmLn5DbqD++IyGQmSTqATiHX/lmyl/iRTca0KXbS1JGEWuHcOipEk0T9xU3JI
         VxVEGWqPwlXfB33KGZfhfqfSTe62DbnIO0IVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OnK5lWkiyqDZC+wf98tKaPFQMaH5nw66vTCTgBsETB0=;
        b=TUisMf5NEGpDnXK6URQD/LYcUbjZBQX0eOro/I8mImpYCPPA1Tb5b4qGw7Pvy6oBAi
         SYBQu8FzgDPWjFpzSqLFvgzruCAJ6HHbJ2oWnGgO9Lo5NGe2hN/9sWlAhICrfA3Qo99F
         gYnbJD6K4JM9yYjctarY3J6vOF6rvaNlB7IKWCqe8ND8+926448bY0pwfmMNquA9FEeG
         idv2JcGiTOUSv7wRSnXc5/SY/wefqDVi7mqVbNeUCn0jwnKkdugH6yr/EVhxNwM9J4am
         Vkztya9x1SjXlQakKWzmDPclq7fvAVfzYEc1h0U/HD/ADuIAzUWdDClZrPuDDgMs/f5K
         vnqg==
X-Gm-Message-State: APjAAAWXgABzdyUtYHuGg7bw/81dgsGoZ2VhsWgcpWQTH71BZh//Rs/q
        IeByGKPrWnnu2H+AKZzRmUqrbw==
X-Google-Smtp-Source: APXvYqxPSP1qykyeISMV2cQbBkFbqceh5sdYOZivsz+bTllz3hlP4kD6ayq3dwx3gk8fjjO3VijRmQ==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4mr11514118plt.9.1571422931266;
        Fri, 18 Oct 2019 11:22:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id s1sm5995397pgi.52.2019.10.18.11.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 11:22:06 -0700 (PDT)
Date:   Fri, 18 Oct 2019 11:22:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] Bluetooth: hci_qca: Don't vote for specific voltage
Message-ID: <20191018182205.GA20212@google.com>
References: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
 <20191018052405.3693555-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018052405.3693555-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:24:02PM -0700, Bjorn Andersson wrote:
> Devices with specific voltage requirements should not request voltage
> from the driver, but instead rely on the system configuration to define
> appropriate voltages for each rail.
> 
> This ensures that PMIC and board variations are accounted for, something
> that the 0.1V range in the hci_qca driver currently tries to address.
> But on the Lenovo Yoga C630 (with wcn3990) vddch0 is 3.1V, which means
> the driver will fail to set the voltage.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/bluetooth/hci_qca.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c07c529b0d81..54aafcc69d06 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -130,8 +130,6 @@ enum qca_speed_type {
>   */
>  struct qca_vreg {
>  	const char *name;
> -	unsigned int min_uV;
> -	unsigned int max_uV;
>  	unsigned int load_uA;
>  };
>  
> @@ -1332,10 +1330,10 @@ static const struct hci_uart_proto qca_proto = {
>  static const struct qca_vreg_data qca_soc_data_wcn3990 = {
>  	.soc_type = QCA_WCN3990,
>  	.vregs = (struct qca_vreg []) {
> -		{ "vddio",   1800000, 1900000,  15000  },
> -		{ "vddxo",   1800000, 1900000,  80000  },
> -		{ "vddrf",   1300000, 1350000,  300000 },
> -		{ "vddch0",  3300000, 3400000,  450000 },
> +		{ "vddio", 15000  },
> +		{ "vddxo", 80000  },
> +		{ "vddrf", 300000 },
> +		{ "vddch0", 450000 },
>  	},
>  	.num_vregs = 4,
>  };
> @@ -1343,10 +1341,10 @@ static const struct qca_vreg_data qca_soc_data_wcn3990 = {
>  static const struct qca_vreg_data qca_soc_data_wcn3998 = {
>  	.soc_type = QCA_WCN3998,
>  	.vregs = (struct qca_vreg []) {
> -		{ "vddio",   1800000, 1900000,  10000  },
> -		{ "vddxo",   1800000, 1900000,  80000  },
> -		{ "vddrf",   1300000, 1352000,  300000 },
> -		{ "vddch0",  3300000, 3300000,  450000 },
> +		{ "vddio", 10000  },
> +		{ "vddxo", 80000  },
> +		{ "vddrf", 300000 },
> +		{ "vddch0", 450000 },
>  	},
>  	.num_vregs = 4,
>  };
> @@ -1386,13 +1384,6 @@ static int qca_power_off(struct hci_dev *hdev)
>  static int qca_enable_regulator(struct qca_vreg vregs,
>  				struct regulator *regulator)
>  {
> -	int ret;
> -
> -	ret = regulator_set_voltage(regulator, vregs.min_uV,
> -				    vregs.max_uV);
> -	if (ret)
> -		return ret;
> -
>  	return regulator_enable(regulator);
>  
>  }
> @@ -1401,7 +1392,6 @@ static void qca_disable_regulator(struct qca_vreg vregs,
>  				  struct regulator *regulator)
>  {
>  	regulator_disable(regulator);
> -	regulator_set_voltage(regulator, 0, vregs.max_uV);
>  
>  }

This was brought up multiple times during the initial review, but
wasn't addressed.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>


