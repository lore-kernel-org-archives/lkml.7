Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F77ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C81B2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="y76gKMwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391126AbfJPHqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:46:14 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56012 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfJPHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:46:13 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9015F5C2224;
        Wed, 16 Oct 2019 09:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1571211970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24LCcIRDu1mOgkMkgGbPXpwZUoN/vIELrMh+T/KtHRI=;
        b=y76gKMwRvWz3dUVPz5sfzwIrm2IoRP/QsBdk95pM2mzHN+u6A1RB6KiE/5ks5VUitgYDsm
        U1WdMT0OUhCpGuBkCkKbXerYUbMLXN9S6ijIK3o7VURhVfs57STDY+8EB9vBWT7Z8sJwtZ
        KrJcikDXTkE63QmPw6oOQ2X0oLL7fhg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Oct 2019 09:46:10 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] drivers: firmware: psci: Register with kernel restart
 handler
In-Reply-To: <20191015145147.1106247-4-thierry.reding@gmail.com>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
 <20191015145147.1106247-4-thierry.reding@gmail.com>
Message-ID: <e354a51deb667269744d6f415c711297@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-15 16:51, Thierry Reding wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Register with kernel restart handler instead of setting arm_pm_restart
> directly. This enables support for replacing the PSCI restart handler
> with a different handler if necessary for a specific board.
> 
> Select a priority of 129 to indicate a higher than default priority, but
> keep it as low as possible since PSCI reset is known to fail on some
> boards.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Looks good to me! And helps also in my case, a board which has a broken
PSCI reset capability.

Reviewed-by: Stefan Agner <stefan.agner@toradex.com>

--
Stefan

> ---
>  drivers/firmware/psci/psci.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 84f4ff351c62..a41c6ba043a2 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -250,7 +250,8 @@ static int get_set_conduit_method(struct device_node *np)
>  	return 0;
>  }
>  
> -static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
> +static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> +			  void *data)
>  {
>  	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>  	    psci_system_reset2_supported) {
> @@ -263,8 +264,15 @@ static void psci_sys_reset(enum reboot_mode
> reboot_mode, const char *cmd)
>  	} else {
>  		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
>  	}
> +
> +	return NOTIFY_DONE;
>  }
>  
> +static struct notifier_block psci_sys_reset_nb = {
> +	.notifier_call = psci_sys_reset,
> +	.priority = 129,
> +};
> +
>  static void psci_sys_poweroff(void)
>  {
>  	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> @@ -431,7 +439,7 @@ static void __init psci_0_2_set_functions(void)
>  
>  	psci_ops.migrate_info_type = psci_migrate_info_type;
>  
> -	arm_pm_restart = psci_sys_reset;
> +	register_restart_handler(&psci_sys_reset_nb);
>  
>  	pm_power_off = psci_sys_poweroff;
>  }
