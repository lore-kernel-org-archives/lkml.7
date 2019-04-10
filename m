Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB11C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B7820830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="orYAjUEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfDJJm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:42:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49263 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729685AbfDJJm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:42:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190410094253euoutp01afc5c69e234fff5c753f3d2ebdd6e8fd~UE6W6Ee7f2346123461euoutp01F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:42:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190410094253euoutp01afc5c69e234fff5c753f3d2ebdd6e8fd~UE6W6Ee7f2346123461euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554889373;
        bh=vtXmODPzrhWdamfhZHD6hfgypE0QC8u8YBMy2IWIpk8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=orYAjUEKl/wW7xjx3oeeVqJ5tb/qHiuMfGUSyD5zYHIk2noFGVsVgz/1Ym77EHoFJ
         NJDdeVlrRHaz479Nm/MMqM5LRHpd43knlZj2jiVKpcg+xtgKdpKhyjLrw/V0WhXsw7
         ZA/mAYSVGRR0jioBkRYoQTl23I3D9KRKJ/Yb9YU0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190410094253eucas1p26ed78648e31c52a2d5911ad48472afe5~UE6WTY_9s1948119481eucas1p2i;
        Wed, 10 Apr 2019 09:42:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A1.5E.04325.C9ABDAC5; Wed, 10
        Apr 2019 10:42:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190410094252eucas1p14e9f89a5bb5783eb4de48950463f7ca4~UE6Vlt4FM2474224742eucas1p1s;
        Wed, 10 Apr 2019 09:42:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190410094252eusmtrp2619b257cd459da47df2b23a5536256d9~UE6VXoHa90249502495eusmtrp2g;
        Wed, 10 Apr 2019 09:42:52 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-21-5cadba9c423c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.45.04140.C9ABDAC5; Wed, 10
        Apr 2019 10:42:52 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190410094251eusmtip17f492a6e7d78f33b962fcb644602a508~UE6U3SQdJ1285612856eusmtip1k;
        Wed, 10 Apr 2019 09:42:51 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] drm/bridge: sil_sii8620: make remote control
 optional.
To:     =?UTF-8?Q?Ronald_Tschal=c3=a4r?= <ronald@innovation.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <c861091d-f659-614d-65f4-6fe983885e09@samsung.com>
Date:   Wed, 10 Apr 2019 11:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190407050358.2976-2-ronald@innovation.ch>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUgUYRjG/XZmd8bNlXG1fFHxWAjUShMFJwopKhjKP4oOpaRadTzKix21
        TKiwwwNMV0Jz14tSFDM0c8X1JKVsM0Mz8ahWTdPFkrwlS2vXMfK/3/u87/O97wMfiUn7hXZk
        ZEw8q4iRR8lEYrz+1c93ewoanwbtLRvxpTNT8gR0xyMDot8srYno24+rRXTOSDZOpytLCXpo
        fllI9zUWiGjDlD1t0M8I6NfLuYKD25iFymkho1V9Jhh1Wr6QeZAOTJHuJNNWWEUw9+sqEdOi
        r8OZhVpH5mFqvfCE+Jz4QCgbFZnIKjz9LokjvnQpibg8+pp2VU/cQrMeGcicBMoHGj6OExlI
        TEqpCgST6dk4XywiGFdqEV8sIJjuvIv9s4y9L8P4RjmC6lm1kC9mEPT1ZCLTlDV1GrRZjzcc
        NtQqgn79ho5RBgStkw4mFlFusPZ8SGRiCeUHKTnPcBPj1E6YX2vb0LdTgfDjaxPOz1iBLn9i
        g82pffCrdhXj33SC2xr1JtvC8ESxwHQQUHME5Oomcf7sI9A9qBTxbG2MU0fw7AB/tCaDiW/C
        SMUdjDenIdDUaDcz74eOzl5jTNK4wQ2qGz15+RDkpwwQJhkoSxicseJvsISc+jyMlyWQdk/K
        T7vASLdm80FbKOtZEmUjmWpLMtWWNKotaVT/95YgvBLZsglcdDjLecewVz04eTSXEBPuERIb
        XYuMn61rvXOpAbX+Dm5HFIlkFpLAoqogqVCeyCVFtyMgMZmNZO67UZKEypOus4rYi4qEKJZr
        R/YkLrOVJJuNnpdS4fJ49grLxrGKf10BaW53CwXHvviVMDru3X2m8iw+2nL8woB2PSDsU5eP
        evf01GxhccFLs8EbK4JZjcAVX9eVFFxuOsx983c+5Vvj69QVsuDV4C7zW3E9djzVuTnyzPQO
        s4DsZtwlzLArcaLKP7mp8K2F3eRohpBynDnUS6hTS9XDT8o1H3KVRzVZTuFj+v5FGc5FyL3c
        MQUn/wsWJaDPaAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7pzdq2NMfh8h92it2k6k8XhRS8Y
        LU59/ctm0bx4PZvFpPsTWCw6Jy5ht7j56RurxeVdc9gsXjyXtnhx7y2TxYlv05gcuD0+r3rF
        6rFz1l12j9kdM1k9pnRKeMw7Geixf+4ado++LasYPfbe28Li8XmTnMeM9m2sAVxRejZF+aUl
        qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmPTk9kL5huUbHz
        1z32BsYPel2MnBwSAiYSDy8tZQaxhQSWMko0X0mAiItL7J7/lhnCFpb4c62LrYuRC6jmNaPE
        oUf3wRLCAiESO/sXM4MkRAT+MEosONELVsUs8IJR4teeT1Atuxkl9u47xgrSwiagKfF38002
        EJtXwE6iadJGFhCbRUBV4tPf/WBxUYEIibsXX7BA1AhKnJz5BMzmFLCU+L3pF9hqZgF1iT/z
        LkHZ8hLNW2dD2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusZFecWJucWle
        ul5yfu4mRmA0bzv2c8sOxq53wYcYBTgYlXh4A6aviRFiTSwrrsw9xCjBwawkwvvxDVCINyWx
        siq1KD++qDQntfgQoynQcxOZpUST84GJJq8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6Yklq
        dmpqQWoRTB8TB6dUA+PmE7MO5Vk90pyS+/Zl9J3CW79a60SFXglbmk9W/vPzSBir6+SgA3bs
        1orv2lbJ/zMwnv23Lm7K9i1siW8ui7S5Rf5Q/hH2TKJzp1GZYf4VBjEFp3BJgaSta2YGsIpd
        uhSgkXdS/fXUn8saeNX3m/rNsSqVV9xl+enArbrei6v69G5Wf9mww0OJpTgj0VCLuag4EQDu
        UfRW/AIAAA==
X-CMS-MailID: 20190410094252eucas1p14e9f89a5bb5783eb4de48950463f7ca4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190407050410epcas1p3ec1f887f8ccf8ff4495f4557437cd594
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190407050410epcas1p3ec1f887f8ccf8ff4495f4557437cd594
References: <20190407050358.2976-1-ronald@innovation.ch>
        <CGME20190407050410epcas1p3ec1f887f8ccf8ff4495f4557437cd594@epcas1p3.samsung.com>
        <20190407050358.2976-2-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.04.2019 07:03, Ronald Tschalär wrote:
> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> However, this causes problems with other drivers, in particular an input
> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> commit):
>
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
>
> According to the docs and general consensus, select should only be used
> for non user-visible symbols, but both RC_CORE and INPUT are
> user-visible. Furthermore almost all other references to INPUT
> throughout the kernel config are depends, not selects. For this reason
> the first part of this change reverts commit d6abe6df706c.
>
> In order to address the original reason for commit d6abe6df706c, namely
> that not all boards use the remote controller functionality and hence
> should not need have to deal with RC_CORE, the second part of this
> change now makes the remote control support in the driver optional and
> contingent on RC_CORE being defined. And with this the hard dependency
> on INPUT also goes away as that is only needed if RC_CORE is defined
> (which in turn already depends on INPUT).
>
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/gpu/drm/bridge/Kconfig       |  3 +--
>  drivers/gpu/drm/bridge/sil-sii8620.c | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b0d50b..9cf07105b73a 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -85,8 +85,7 @@ config DRM_SIL_SII8620
>  	depends on OF
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
> -	select RC_CORE
> +	imply RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>  
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index a6e8f4591e63..f8dfbf01caa8 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -66,7 +66,9 @@ enum sii8620_mt_state {
>  struct sii8620 {
>  	struct drm_bridge bridge;
>  	struct device *dev;
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  	struct rc_dev *rc_dev;
> +#endif
>  	struct clk *clk_xtal;
>  	struct gpio_desc *gpio_reset;
>  	struct gpio_desc *gpio_int;
> @@ -1757,6 +1759,7 @@ static void sii8620_send_features(struct sii8620 *ctx)
>  	sii8620_write_buf(ctx, REG_MDT_XMIT_WRITE_PORT, buf, ARRAY_SIZE(buf));
>  }
>  
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
>  {
>  	bool pressed = !(scancode & MHL_RCP_KEY_RELEASED_MASK);
> @@ -1775,6 +1778,12 @@ static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
>  
>  	return true;
>  }
> +#else
> +static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
> +{
> +	return false;
> +}
> +#endif
>  
>  static void sii8620_msc_mr_set_int(struct sii8620 *ctx)
>  {
> @@ -2098,6 +2107,7 @@ static void sii8620_cable_in(struct sii8620 *ctx)
>  	enable_irq(to_i2c_client(ctx->dev)->irq);
>  }
>  
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>  {
>  	struct rc_dev *rc_dev;
> @@ -2127,6 +2137,11 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>  	}
>  	ctx->rc_dev = rc_dev;
>  }
> +#else
> +static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
> +{
> +}
> +#endif
>  
>  static void sii8620_cable_out(struct sii8620 *ctx)
>  {
> @@ -2213,12 +2228,18 @@ static int sii8620_attach(struct drm_bridge *bridge)
>  	return sii8620_clear_error(ctx);
>  }
>  
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  static void sii8620_detach(struct drm_bridge *bridge)
>  {
>  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
>  
>  	rc_unregister_device(ctx->rc_dev);
>  }
> +#else
> +static void sii8620_detach(struct drm_bridge *bridge)
> +{
> +}
> +#endif
>  
>  static int sii8620_is_packing_required(struct sii8620 *ctx,
>  				       const struct drm_display_mode *mode)

What about:

---------

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 8840f396a7b6..298189067929 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -86,8 +86,7 @@ config DRM_SIL_SII8620
        depends on OF
        select DRM_KMS_HELPER
        imply EXTCON
-       select INPUT
-       select RC_CORE
+       imply RC_CORE
        help
          Silicon Image SII8620 HDMI/MHL bridge chip driver.
 
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c
b/drivers/gpu/drm/bridge/sil-sii8620.c
index 0cc293a6ac24..df0f9dbbe839 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -1762,10 +1762,8 @@ static bool sii8620_rcp_consume(struct sii8620
*ctx, u8 scancode)
 
        scancode &= MHL_RCP_KEY_ID_MASK;
 
-       if (!ctx->rc_dev) {
-               dev_dbg(ctx->dev, "RCP input device not initialized\n");
+       if (!IS_ENABLED(RC_CORE) || !ctx->rc_dev)
                return false;
-       }
 
        if (pressed)
                rc_keydown(ctx->rc_dev, RC_PROTO_CEC, scancode, 0);
@@ -2102,6 +2100,9 @@ static void sii8620_init_rcp_input_dev(struct
sii8620 *ctx)
        struct rc_dev *rc_dev;
        int ret;
 
+       if (!IS_ENABLED(RC_CORE))
+               return;
+
        rc_dev = rc_allocate_device(RC_DRIVER_SCANCODE);
        if (!rc_dev) {
                dev_err(ctx->dev, "Failed to allocate RC device\n");
@@ -2216,6 +2217,9 @@ static void sii8620_detach(struct drm_bridge *bridge)
 {
        struct sii8620 *ctx = bridge_to_sii8620(bridge);
 
+       if (!IS_ENABLED(RC_CORE))
+               return;
+
        rc_unregister_device(ctx->rc_dev);
 }
-----------

Less changes, no conditional compilation - better compiler coverage,
more readable.


Regards

Andrzej


