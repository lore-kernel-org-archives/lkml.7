Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634BA217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfC2Ngf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:36:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57568 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbfC2Ngf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:36:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3BBB826CF5B
Subject: Re: [PATCH v3] mfd: cros: Update EC protocol to match current EC code
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <CAPUE2ut9MjVuvOxZuVNBnZiFvz9Y2XBgCPSQRrdM=6w+p4Rv1Q@mail.gmail.com>
 <CAPUE2uvhfwwt31=AMKvH-kPGYZsjpGqbetGJ46sBU4owFPRgsg@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <af561dfd-ae1d-16a6-ed2b-b3876486e5e0@collabora.com>
Date:   Fri, 29 Mar 2019 14:36:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPUE2uvhfwwt31=AMKvH-kPGYZsjpGqbetGJ46sBU4owFPRgsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

After fix my problems manually ...

On 28/3/19 22:52, Gwendal Grignou wrote:
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
> Changes in v3:
> - No changes, resending
> 
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

> 
>  /*
> - * For subcommand EC_CODEC_GET_GAIN.
> + * Entering Verified Boot Mode Command
> + * Default mode is VBOOT_MODE_NORMAL if EC did not receive this command.
> + * Valid Modes are: normal, developer, and recovery.
>   */
> -struct ec_response_codec_gain {
> -	uint8_t left;
> -	uint8_t right;
> -} __packed;

This causes a build problem in mainline as ec_response_codec_gain is used in
sound/soc/codecs/cros_ec_codec.c file, I don't see this struct anymore.

Apart from this the patch looks good to me.

Thanks,
 Enric
