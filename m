Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59486C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0760C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfDPKfI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:35:08 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:44326 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbfDPKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:35:08 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 06:35:07 EDT
Received: from mail-sh.amlogic.com (10.18.11.5) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 16 Apr
 2019 18:20:05 +0800
Received: from mail-sh.amlogic.com ([::1]) by mail-sh.amlogic.com ([::1]) with
 mapi id 15.01.1591.012; Tue, 16 Apr 2019 18:20:05 +0800
From:   Sky Zhou <Sky.Zhou@amlogic.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/meson: add size and alignment requirements for dumb
 buffers
Thread-Topic: [PATCH] drm/meson: add size and alignment requirements for dumb
 buffers
Thread-Index: AQHU7emyYXrKpM5Hu0ukuwfto14jpw==
Date:   Tue, 16 Apr 2019 10:20:05 +0000
Message-ID: <cd3674423da344e0a98ca58737efc1f5@amlogic.com>
References: <20190408090137.2402-1-narmstrong@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.18.29.243]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/8 17:01, Neil Armstrong wrote:
> The Amlogic SoCs Canvas buffers stride must be aligned on 64bytes
> and overall size should be aligned on PAGE width.
> 
> Adds a custom dumb_create op to adds these requirements.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Suggested-by: Sky Zhou <sky.zhou@amlogic.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>   drivers/gpu/drm/meson/meson_drv.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index faf1b1b0357c..72b01e6be0d9 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -90,6 +90,18 @@ static irqreturn_t meson_irq(int irq, void *arg)
>   	return IRQ_HANDLED;
>   }
>   
> +static int meson_dumb_create(struct drm_file *file, struct drm_device *dev,
> +			     struct drm_mode_create_dumb *args)
> +{
> +	/*
> +	 * We need 64bytes aligned stride, and PAGE aligned size
> +	 */
> +	args->pitch = ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8), SZ_64);
> +	args->size = PAGE_ALIGN(args->pitch * args->height);
> +
> +	return drm_gem_cma_dumb_create_internal(file, dev, args);
> +}
> +
>   DEFINE_DRM_GEM_CMA_FOPS(fops);
>   
>   static struct drm_driver meson_driver = {
> @@ -112,7 +124,7 @@ static struct drm_driver meson_driver = {
>   	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
>   
>   	/* GEM Ops */
> -	.dumb_create		= drm_gem_cma_dumb_create,
> +	.dumb_create		= meson_dumb_create,
>   	.gem_free_object_unlocked = drm_gem_cma_free_object,
>   	.gem_vm_ops		= &drm_gem_cma_vm_ops,
>   
> 

Reviewed-by: Sky Zhou <sky.zhou@amlogic.com>
