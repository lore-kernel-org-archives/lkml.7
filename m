Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CAAC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CF122CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfHTGgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:36:06 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:37344 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728657AbfHTGgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:36:06 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 02:36:05 EDT
Received: from webmail.promanet.nl (edge2.prtnl [192.168.1.170])
        by sparta (Postfix) with ESMTP id DD9E744A00CB;
        Tue, 20 Aug 2019 08:30:25 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Aug 2019 08:28:29 +0200
From:   Robin van der Gracht <robin@protonic.nl>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     miguel.ojeda.sandonis@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: ht16k33: Make ht16k33_fb_fix and
 ht16k33_fb_var constant
Organization: Protonic Holland
In-Reply-To: <20190819075126.870-1-nishkadg.linux@gmail.com>
References: <20190819075126.870-1-nishkadg.linux@gmail.com>
Message-ID: <894371cda58112ee77cc0c8a5d336d2d@protonic.nl>
X-Sender: robin@protonic.nl
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-19 09:51, Nishka Dasgupta wrote:
> The static structures ht16k33_fb_fix and ht16k33_fb_var, of types
> fb_fix_screeninfo and fb_var_screeninfo respectively, are not used
> except to be copied into other variables. Hence make both of them
> constant to prevent unintended modification.
> Issue found with
> Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/auxdisplay/ht16k33.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c 
> b/drivers/auxdisplay/ht16k33.c
> index 9c0bb771751d..a2fcde582e2a 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -74,7 +74,7 @@ struct ht16k33_priv {
>  	struct ht16k33_fbdev fbdev;
>  };
> 
> -static struct fb_fix_screeninfo ht16k33_fb_fix = {
> +static const struct fb_fix_screeninfo ht16k33_fb_fix = {
>  	.id		= DRIVER_NAME,
>  	.type		= FB_TYPE_PACKED_PIXELS,
>  	.visual		= FB_VISUAL_MONO10,
> @@ -85,7 +85,7 @@ static struct fb_fix_screeninfo ht16k33_fb_fix = {
>  	.accel		= FB_ACCEL_NONE,
>  };
> 
> -static struct fb_var_screeninfo ht16k33_fb_var = {
> +static const struct fb_var_screeninfo ht16k33_fb_var = {
>  	.xres = HT16K33_MATRIX_LED_MAX_ROWS,
>  	.yres = HT16K33_MATRIX_LED_MAX_COLS,
>  	.xres_virtual = HT16K33_MATRIX_LED_MAX_ROWS,

ACK

Robin
