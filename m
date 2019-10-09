Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB99C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA1E2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfJIIWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:22:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:64466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfJIIWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:22:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 01:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="206829981"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 09 Oct 2019 01:22:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Oct 2019 11:22:35 +0300
Date:   Wed, 9 Oct 2019 11:22:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     gregkh@linuxfoundation.org, biju.das@bp.renesas.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] usb: typec: add dependency for TYPEC_HD3SS3220
Message-ID: <20191009082235.GE12909@kuha.fi.intel.com>
References: <20191009014707.38716-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009014707.38716-1-maowenan@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:47:07AM +0800, Mao Wenan wrote:
> If CONFIG_TYPEC_HD3SS3220=y, CONFIG_USB_ROLE_SWITCH=m, below errors
> can be found:
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_remove':
> hd3ss3220.c:(.text+0x64): undefined reference to `usb_role_switch_put'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_dr_set':
> hd3ss3220.c:(.text+0x154): undefined reference to `usb_role_switch_set_role'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_set_role':
> hd3ss3220.c:(.text+0x294): undefined reference to `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x2f4): undefined reference to `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x348): undefined reference to `usb_role_switch_set_role'
> hd3ss3220.c:(.text+0x390): undefined reference to `usb_role_switch_set_role'
> drivers/usb/typec/hd3ss3220.o: In function `hd3ss3220_probe':
> hd3ss3220.c:(.text+0x5e8): undefined reference to `fwnode_usb_role_switch_get'
> hd3ss3220.c:(.text+0x8a4): undefined reference to `usb_role_switch_put'
> make: *** [vmlinux] Error 1
> 
> This patch add dependency USB_ROLE_SWITCH for TYPEC_HD3SS3220.
> 
> Fixes: 1c48c759ef4b ("usb: typec: driver for TI HD3SS3220 USB Type-C DRP port controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index aceb2af..b4f2aac 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -53,6 +53,7 @@ source "drivers/usb/typec/ucsi/Kconfig"
>  config TYPEC_HD3SS3220
>  	tristate "TI HD3SS3220 Type-C DRP Port controller driver"
>  	depends on I2C
> +	depends on USB_ROLE_SWITCH
>  	help
>  	  Say Y or M here if your system has TI HD3SS3220 Type-C DRP Port
>  	  controller driver.
> -- 
> 2.7.4

thanks,

-- 
heikki
