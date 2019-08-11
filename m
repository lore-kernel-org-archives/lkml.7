Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14AEC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865E420844
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfHKVcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:32:21 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37802 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHKVcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:32:21 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id AB9CF803E5;
        Sun, 11 Aug 2019 23:32:16 +0200 (CEST)
Date:   Sun, 11 Aug 2019 23:32:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>
Subject: Best practice for embedded code samles? [Was: drm/drv: Use // for
 comments in example code]
Message-ID: <20190811213215.GA26468@ravnborg.org>
References: <20190808163629.14280-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808163629.14280-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=VVlED5B4AAAA:8
        a=e5mUnYsNAAAA:8 a=hR6eB8P5VIS1gKZY23kA:9 a=wPNLvfGTeEIA:10
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:36:28PM +0200, Jonathan Neuschäfer wrote:
> This improves Sphinx output in two ways:
> 
> - It avoids an unmatched single-quote ('), about which Sphinx complained:
> 
>   /.../Documentation/gpu/drm-internals.rst:298:
>     WARNING: Could not lex literal_block as "c". Highlighting skipped.
> 
>   An alternative approach would be to replace "can't" with a word that
>   doesn't have a single-quote.
> 
> - It lets Sphinx format the comments in italics and grey, making the
>   code slightly easier to read.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

The result looks much better now - thanks.

I wonder if there is a better way to embed a code sample
than reverting to // style comments.

As the kernel do not like // comments we should try to avoid them in
examples.

Mauro/Jon?

	Sam

> ---
>  drivers/gpu/drm/drm_drv.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 9d00947ca447..769feefeeeef 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -328,11 +328,9 @@ void drm_minor_release(struct drm_minor *minor)
>   *		struct drm_device *drm;
>   *		int ret;
>   *
> - *		[
> - *		  devm_kzalloc() can't be used here because the drm_device
> - *		  lifetime can exceed the device lifetime if driver unbind
> - *		  happens when userspace still has open file descriptors.
> - *		]
> + *		// devm_kzalloc() can't be used here because the drm_device '
> + *		// lifetime can exceed the device lifetime if driver unbind
> + *		// happens when userspace still has open file descriptors.
>   *		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>   *		if (!priv)
>   *			return -ENOMEM;
> @@ -355,7 +353,7 @@ void drm_minor_release(struct drm_minor *minor)
>   *		if (IS_ERR(priv->pclk))
>   *			return PTR_ERR(priv->pclk);
>   *
> - *		[ Further setup, display pipeline etc ]
> + *		// Further setup, display pipeline etc
>   *
>   *		platform_set_drvdata(pdev, drm);
>   *
> @@ -370,7 +368,7 @@ void drm_minor_release(struct drm_minor *minor)
>   *		return 0;
>   *	}
>   *
> - *	[ This function is called before the devm_ resources are released ]
> + *	// This function is called before the devm_ resources are released
>   *	static int driver_remove(struct platform_device *pdev)
>   *	{
>   *		struct drm_device *drm = platform_get_drvdata(pdev);
> @@ -381,7 +379,7 @@ void drm_minor_release(struct drm_minor *minor)
>   *		return 0;
>   *	}
>   *
> - *	[ This function is called on kernel restart and shutdown ]
> + *	// This function is called on kernel restart and shutdown
>   *	static void driver_shutdown(struct platform_device *pdev)
>   *	{
>   *		drm_atomic_helper_shutdown(platform_get_drvdata(pdev));
> --
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
