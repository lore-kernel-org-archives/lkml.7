Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9172C2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfCELQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:16:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfCELQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:16:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B0900260648
Subject: Re: [PATCH] platform/chrome: fix wilco-ec dependencies
To:     Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@chromium.org>
Cc:     Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org
References: <20190304200719.1382717-1-arnd@arndb.de>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <21f89413-2d05-565c-eca9-2e9a8c65f3ef@collabora.com>
Date:   Tue, 5 Mar 2019 12:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304200719.1382717-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/3/19 21:06, Arnd Bergmann wrote:
> When CROS_EC_LPC is set to =m, we get a link failure for a
> builtin wilco-ec module:
> 
> drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_remove':
> core.c:(.text+0x26): undefined reference to `cros_ec_lpc_mec_destroy'
> drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_probe':
> core.c:(.text+0x18c): undefined reference to `cros_ec_lpc_mec_init'
> core.c:(.text+0x224): undefined reference to `cros_ec_lpc_mec_destroy'
> drivers/platform/chrome/wilco_ec/mailbox.o: In function `wilco_ec_mailbox':
> mailbox.c:(.text+0x104): undefined reference to `cros_ec_lpc_io_bytes_mec'
> 
> The problem with the existing CROS_EC_LPC_MEC dependency is that this
> is only for a 'bool' symbol, so the information about the exported
> functions being in a module is lost on the way, and we actually have
> to depend on both CROS_EC_LPC and CROS_EC_LPC_MEC.
> 
> Fixes: 7b3d4f44abf0 ("platform/chrome: Add new driver for Wilco EC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/chrome/wilco_ec/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index 4a119ced4d0c..e09e4cebe9b4 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -1,6 +1,6 @@
>  config WILCO_EC
>  	tristate "ChromeOS Wilco Embedded Controller"
> -	depends on ACPI && X86 && CROS_EC_LPC_MEC
> +	depends on ACPI && X86 && CROS_EC_LPC && CROS_EC_LPC_MEC
>  	help
>  	  If you say Y here, you get support for talking to the ChromeOS
>  	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
> 

Applied as a fix to our chrome-platform-5.1 branch.

Thanks,
 Enric
