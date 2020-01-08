Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B6C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C39206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgAHKjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:39:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgAHKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:39:03 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id AFB7F2920FA
Subject: Re: [PATCH] platform/chrome: wilco_ec: Fix keyboard backlight probing
To:     Daniel Campello <campello@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>
References: <20200107112400.1.Iedcdbae5a7ed79291b557882130e967f72168a9f@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ab377eeb-f1bc-13c2-8bbc-ccc53ecb7c4d@collabora.com>
Date:   Wed, 8 Jan 2020 11:38:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200107112400.1.Iedcdbae5a7ed79291b557882130e967f72168a9f@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Many thanks for sending the patch upstream.

On 7/1/20 19:24, Daniel Campello wrote:
> The EC on the Wilco platform responds with 0xFF to commands related to
> the keyboard backlight on the absence of a keyboard backlight module.
> This change allows the EC driver to continue loading even if the
> backlight module is not present.
> 

Could you explain a bit more which is the problem you're trying to solve? I am
not sure I understand it, isn't the kbbl_exist call for that purpose? (in
absence of the keyboard backligh module just don't init the device?)

Thanks,
 Enric


> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
> 
>  .../platform/chrome/wilco_ec/keyboard_leds.c  | 28 +++++++++++++------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/chrome/wilco_ec/keyboard_leds.c b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
> index bb0edf51dfda..5731d1b60e28 100644
> --- a/drivers/platform/chrome/wilco_ec/keyboard_leds.c
> +++ b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
> @@ -73,13 +73,6 @@ static int send_kbbl_msg(struct wilco_ec_device *ec,
>  		return ret;
>  	}
> 
> -	if (response->status) {
> -		dev_err(ec->dev,
> -			"EC reported failure sending keyboard LEDs command: %d",
> -			response->status);
> -		return -EIO;
> -	}
> -
>  	return 0;
>  }
> 
> @@ -87,6 +80,7 @@ static int set_kbbl(struct wilco_ec_device *ec, enum led_brightness brightness)
>  {
>  	struct wilco_keyboard_leds_msg request;
>  	struct wilco_keyboard_leds_msg response;
> +	int ret;
> 
>  	memset(&request, 0, sizeof(request));
>  	request.command = WILCO_EC_COMMAND_KBBL;
> @@ -94,7 +88,18 @@ static int set_kbbl(struct wilco_ec_device *ec, enum led_brightness brightness)
>  	request.mode    = WILCO_KBBL_MODE_FLAG_PWM;
>  	request.percent = brightness;
> 
> -	return send_kbbl_msg(ec, &request, &response);
> +	ret = send_kbbl_msg(ec, &request, &response);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (response.status) {
> +		dev_err(ec->dev,
> +			"EC reported failure sending keyboard LEDs command: %d",
> +			response.status);
> +		return -EIO;
> +	}
> +
> +	return 0;
>  }
> 
>  static int kbbl_exist(struct wilco_ec_device *ec, bool *exists)
> @@ -140,6 +145,13 @@ static int kbbl_init(struct wilco_ec_device *ec)
>  	if (ret < 0)
>  		return ret;
> 
> +	if (response.status) {
> +		dev_err(ec->dev,
> +			"EC reported failure sending keyboard LEDs command: %d",
> +			response.status);
> +		return -EIO;
> +	}
> +
>  	if (response.mode & WILCO_KBBL_MODE_FLAG_PWM)
>  		return response.percent;
> 
> --
> 2.24.1.735.g03f4e72817-goog
> 
