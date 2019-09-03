Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BBA21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfICMVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:21:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:22708 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfICMVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:21:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 05:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="198760161"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2019 05:21:49 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Sep 2019 15:21:49 +0300
Date:   Tue, 3 Sep 2019 15:21:49 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: tps6598x: Fix build error without
 CONFIG_REGMAP_I2C
Message-ID: <20190903122149.GB23603@kuha.fi.intel.com>
References: <20190903121026.22148-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903121026.22148-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 08:10:26PM +0800, YueHaibing wrote:
> If CONFIG_REGMAP_I2C is not set, building fails:
> 
> drivers/usb/typec/tps6598x.o: In function `tps6598x_probe':
> tps6598x.c:(.text+0x5f0): undefined reference to `__devm_regmap_init_i2c'
> 
> Select REGMAP_I2C to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 89d9193..895e241 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -53,6 +53,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
>  config TYPEC_TPS6598X
>  	tristate "TI TPS6598x USB Power Delivery controller driver"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  Say Y or M here if your system has TI TPS65982 or TPS65983 USB Power
>  	  Delivery controller.
> -- 
> 2.7.4
> 

thanks,

-- 
heikki
