Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4701C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8472206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfFRIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:43:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59876 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbfFRIn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:43:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7A25D26023F
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
To:     Ting Shen <phoenixshen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
References: <20190614065438.142867-1-phoenixshen@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <6a5c8385-6875-d999-a274-bbc592057934@collabora.com>
Date:   Tue, 18 Jun 2019 10:43:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190614065438.142867-1-phoenixshen@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/6/19 8:54, Ting Shen wrote:
> http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> the event_type field, the receiver side should mask out this extra bit when
> processing the event.
> 
> Signed-off-by: Ting Shen <phoenixshen@chromium.org>
> 
> ---
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index d5600118159835..38cb6d82d8fe67 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
>  		return NOTIFY_OK;
>  
> -	switch (ckdev->ec->event_data.event_type) {
> +	switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
>  	case EC_MKBP_EVENT_KEY_MATRIX:
>  		pm_wakeup_event(ckdev->dev, 0);
>  
> 

Applied for chrome-platform-5.3

Thanks,
~ Enric
