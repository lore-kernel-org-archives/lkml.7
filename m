Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0272075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sCcuVfyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfCDMZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:25:40 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18744 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCDMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:25:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7d193a0001>; Mon, 04 Mar 2019 04:25:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Mar 2019 04:25:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Mar 2019 04:25:37 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar
 2019 12:25:37 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 Mar 2019 12:25:36 +0000
Received: from [10.21.24.139] (Not Verified[10.21.24.139]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7d193e0001>; Mon, 04 Mar 2019 04:25:37 -0800
Subject: Re: [RFC PATCH v2 6/7] i2c: tegra-bpmp: convert to use new atomic
 callbacks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
From:   Timo Alho <talho@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <66ad8bfa-12fc-3bda-a2f0-55a9f82e82a2@nvidia.com>
Date:   Mon, 4 Mar 2019 14:25:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190302134735.4393-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551702330; bh=tkx6dOeECawjII7ZM4RCHNO6TRXAAJAI2ekdDjZ8hsQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Language:Content-Transfer-Encoding;
        b=sCcuVfydBCqpWwrsQi6yddOgDJh1TtfCZ7XEK3D5607FscDJ07vuFy84DikWZ9uDh
         6/KUCcTJoAKkOFCuD4sd2fsckHqbzBxVKI6Yj36xTmi38sn7BRlQPASS2oHlN0HWpu
         GN8zFWyCDeyib5FE46Wy2Sa06b5M+qWnb0aWSBal/OCLGZ8fYVTI1zY7nK9fV6U43r
         zDyZtGK+sRGuYdijy0t0Gy6xWgIme8fc1xNoYp4RsqhFEoodpA8sNDg4lsJ2qylSnK
         mSSNrceprhndIjcXzLHBoXSJR4R8e2MyJ/DHf79kXG0Uzrx2DnHmEevlmvEA6ngAGF
         Ay8alzFZyCAJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.3.2019 15.47, Wolfram Sang wrote:
> The driver did handle this internally, convert it to use the new
> callbacks.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/i2c/busses/i2c-tegra-bpmp.c | 27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-tegra-bpmp.c b/drivers/i2c/busses/i2c-tegra-bpmp.c
> index f6cd35d0a2ac..02b78ba5b23b 100644
> --- a/drivers/i2c/busses/i2c-tegra-bpmp.c
> +++ b/drivers/i2c/busses/i2c-tegra-bpmp.c
> @@ -207,7 +207,8 @@ static int tegra_bpmp_i2c_msg_len_check(struct i2c_msg *msgs, unsigned int num)
>   
>   static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
>   				   struct mrq_i2c_request *request,
> -				   struct mrq_i2c_response *response)
> +				   struct mrq_i2c_response *response,
> +				   bool atomic)
>   {
>   	struct tegra_bpmp_message msg;
>   	int err;
> @@ -222,7 +223,7 @@ static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
>   	msg.rx.data = response;
>   	msg.rx.size = sizeof(*response);
>   
> -	if (irqs_disabled())
> +	if (atomic)
>   		err = tegra_bpmp_transfer_atomic(i2c->bpmp, &msg);
>   	else
>   		err = tegra_bpmp_transfer(i2c->bpmp, &msg);
> @@ -230,8 +231,9 @@ static int tegra_bpmp_i2c_msg_xfer(struct tegra_bpmp_i2c *i2c,
>   	return err;
>   }
>   
> -static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
> -			       struct i2c_msg *msgs, int num)
> +static int tegra_bpmp_i2c_xfer_common(struct i2c_adapter *adapter,
> +				      struct i2c_msg *msgs, int num,
> +				      bool atomic)
>   {
>   	struct tegra_bpmp_i2c *i2c = i2c_get_adapdata(adapter);
>   	struct mrq_i2c_response response;
> @@ -253,7 +255,7 @@ static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
>   		return err;
>   	}
>   
> -	err = tegra_bpmp_i2c_msg_xfer(i2c, &request, &response);
> +	err = tegra_bpmp_i2c_msg_xfer(i2c, &request, &response, atomic);
>   	if (err < 0) {
>   		dev_err(i2c->dev, "failed to transfer message: %d\n", err);
>   		return err;
> @@ -268,6 +270,20 @@ static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
>   	return num;
>   }
>   
> +static int tegra_bpmp_i2c_xfer(struct i2c_adapter *adapter,
> +			       struct i2c_msg *msgs, int num)
> +
> +{
> +	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, false);
> +}
> +
> +static int tegra_bpmp_i2c_xfer_atomic(struct i2c_adapter *adapter,
> +				      struct i2c_msg *msgs, int num)
> +
> +{
> +	return tegra_bpmp_i2c_xfer_common(adapter, msgs, num, true);
> +}
> +
>   static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
>   {
>   	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
> @@ -276,6 +292,7 @@ static u32 tegra_bpmp_i2c_func(struct i2c_adapter *adapter)
>   
>   static const struct i2c_algorithm tegra_bpmp_i2c_algo = {
>   	.master_xfer = tegra_bpmp_i2c_xfer,
> +	.master_xfer_atomic = tegra_bpmp_i2c_xfer_atomic,
>   	.functionality = tegra_bpmp_i2c_func,
>   };
>   
> 

Looks good to me.

Reviewed-by: Timo Alho <talho@nvidia.com>
