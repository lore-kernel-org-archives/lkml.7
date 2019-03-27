Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F9BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE782075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfC0Jbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:31:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46612 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfC0Jbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:31:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A787A280C97
Subject: Re: [PATCH v2] mfd: cros: Update EC protocol to match current EC code
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <CAPUE2usTh3Th8FySCUsbgp_WGEL2k94pxDfwp4GT1uUkksok8w@mail.gmail.com>
 <CAPUE2usMGzQVnL-rSrRoeWm=BHYD6pKkWXGNkaMpDOvFOy0HAQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f7e7b21c-60e4-fd38-d836-49550eb55e50@collabora.com>
Date:   Wed, 27 Mar 2019 10:31:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPUE2usMGzQVnL-rSrRoeWm=BHYD6pKkWXGNkaMpDOvFOy0HAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Unless my pwclient or patchwork is doing something weird I have some issues
trying to apply this patch. Could you check that is correctly formatted?

$ pwclient git-am 1055029

Applying patch #1055029 using u'git am'
Description: [v2] mfd: cros: Update EC protocol to match current EC code
Applying: mfd: cros: Update EC protocol to match current EC code
error: patch fragment without header at line 11: @@ -105,15 +120,24 @@
Patch failed at 0001 mfd: cros: Update EC protocol to match current EC code
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
'git am' failed with exit status 128

Also if I try to apply the patch directly I got:

$ git am --show-current-patch | patch -p1
patching file include/linux/mfd/cros_ec_commands.h
patch: **** malformed patch at line 5615: (8-bit) */

On 26/3/19 18:21, Gwendal Grignou wrote:
> Chromebook Embedded Controller protocol is defined in the kernel at
> cros_ec_commands.h.
> The source of trust for the EC protocol is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> 
> Only needed changes have been picked up from this file to the kernel
> include file leading to gaps between the upstream version and what the
> latest ECs can do.
> 
> Fill the gaps to ease future integrations. Changes from the original
> files is header/footer for license and include files for alignment.
> 
> Check this include file works on ChomeOS kernel 4.14 and 4.19 on eve.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes in v2:
> - Replace 1 << with BIT()
> - Check checkpatch warning/errors are outside kernel scope.
> - Update .h with latest changes.
> 
>  include/linux/mfd/cros_ec_commands.h | 3723 +++++++++++++++++++++-----
>  1 file changed, 2992 insertions(+), 731 deletions(-)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h
> b/include/linux/mfd/cros_ec_commands.h
> index fc91082d4c35..5c4764e3db6f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h

[snip]

> @@ -33,7 +46,7 @@
>  #define EC_PROTO_VERSION          0x00000002
> 
>  /* Command version mask */
> -#define EC_VER_MASK(version) (1UL << (version))
> +#define EC_VER_MASK(version) BIT(version)
> 
>  /* I/O addresses for ACPI commands */
>  #define EC_LPC_ADDR_ACPI_DATA  0x62
> @@ -59,13 +72,13 @@
>  #define EC_HOST_CMD_REGION_SIZE 0x80
> 
>  /* EC command register bit functions */
> -#define EC_LPC_CMDR_DATA	(1 << 0)  /* Data ready for host to read */
> -#define EC_LPC_CMDR_PENDING	(1 << 1)  /* Write pending to EC */
> -#define EC_LPC_CMDR_BUSY	(1 << 2)  /* EC is busy processing a command */
> -#define EC_LPC_CMDR_CMD		(1 << 3)  /* Last host write was a command */
> -#define EC_LPC_CMDR_ACPI_BRST	(1 << 4)  /* Burst mode (not used) */
> -#define EC_LPC_CMDR_SCI		(1 << 5)  /* SCI event is pending */
> -#define EC_LPC_CMDR_SMI		(1 << 6)  /* SMI event is pending */
> +#define EC_LPC_CMDR_DATA	BIT(0)  /* Data ready for host to read */
> +#define EC_LPC_CMDR_PENDING	BIT(1)  /* Write pending to EC */
> +#define EC_LPC_CMDR_BUSY	BIT(2)  /* EC is busy processing a command */
> +#define EC_LPC_CMDR_CMD		BIT(3)  /* Last host write was a command */
> +#define EC_LPC_CMDR_ACPI_BRST	BIT(4)  /* Burst mode (not used) */
> +#define EC_LPC_CMDR_SCI		BIT(5)  /* SCI event is pending */
> +#define EC_LPC_CMDR_SMI		BIT(6)  /* SMI event is pending */
> 
>  #define EC_LPC_ADDR_MEMMAP       0x900
>  #define EC_MEMMAP_SIZE         255 /* ACPI IO buffer max is 255 bytes */
> @@ -85,13 +98,15 @@
>  /* Unused 0x28 - 0x2f */
>  #define EC_MEMMAP_SWITCHES         0x30	/* 8 bits */
>  /* Unused 0x31 - 0x33 */
> -#define EC_MEMMAP_HOST_EVENTS      0x34 /* 32 bits */
> -/* Reserve 0x38 - 0x3f for additional host event-related stuff */
> -/* Battery values are all 32 bits */
> +#define EC_MEMMAP_HOST_EVENTS      0x34 /* 64 bits */
> +/* Battery values are all 32 bits, unless otherwise noted. */
>  #define EC_MEMMAP_BATT_VOLT        0x40 /* Battery Present Voltage */
>  #define EC_MEMMAP_BATT_RATE        0x44 /* Battery Present Rate */
>  #define EC_MEMMAP_BATT_CAP         0x48 /* Battery Remaining Capacity */
> -#define EC_MEMMAP_BATT_FLAG        0x4c /* Battery State, defined below */
> +#define EC_MEMMAP_BATT_FLAG        0x4c /* Battery State, see below (8-bit) */
> +#define EC_MEMMAP_BATT_COUNT       0x4d /* Battery Count (8-bit) */
> +#define EC_MEMMAP_BATT_INDEX       0x4e /* Current Battery Data Index
> (8-bit) */

Complains about this malformed line, but even after fix this I got other issues.

Thanks,
 Enric
