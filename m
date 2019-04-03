Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D214C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BBA2147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDCJSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:18:03 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49067 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:18:03 -0400
X-Originating-IP: 90.88.30.125
Received: from aptenodytes (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B0A292001D;
        Wed,  3 Apr 2019 09:17:58 +0000 (UTC)
Message-ID: <1fd78b8ea259ebb1c0d2f29a5faa14cc01db9ac3.camel@bootlin.com>
Subject: Re: [PATCH v2 1/2] drm/vc4: Use common helpers for debugfs setup by
 the driver components.
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Wed, 03 Apr 2019 11:17:58 +0200
In-Reply-To: <20190401183559.3823-1-eric@anholt.net>
References: <20190401183559.3823-1-eric@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 01 avril 2019 à 11:35 -0700, Eric Anholt a écrit :
> The global list of all debugfs entries for the driver was painful: the
> list couldn't see into the components' structs, so each component had
> its own debugs show function to find the component, then find the
> regset and dump it.  The components also had to be careful to check
> that they were actually registered in vc4 before dereferencing
> themselves, in case they weren't probed on a particular platform.
> They routinely failed at that.
> 
> Instead, we can have the components add their debugfs callbacks to a
> little list in vc4 to be registered at drm_dev_register() time, which
> gets vc4_debugfs.c out of the business of knowing the whole list of
> components.
> 
> Thanks to this change, dsi0 (if it existed) would register its node.
> 
> v2: Rebase on hvs_underrun addition.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/vc4/vc4_bo.c      |  6 +--
>  drivers/gpu/drm/vc4/vc4_crtc.c    | 33 +++----------
>  drivers/gpu/drm/vc4/vc4_debugfs.c | 82 ++++++++++++++++++++++++-------
>  drivers/gpu/drm/vc4/vc4_dpi.c     | 20 +-------
>  drivers/gpu/drm/vc4/vc4_drv.c     |  1 +
>  drivers/gpu/drm/vc4/vc4_drv.h     | 41 +++++++++++-----
>  drivers/gpu/drm/vc4/vc4_dsi.c     | 24 ++-------
>  drivers/gpu/drm/vc4/vc4_hdmi.c    |  6 +--
>  drivers/gpu/drm/vc4/vc4_hvs.c     | 20 ++------
>  drivers/gpu/drm/vc4/vc4_txp.c     | 20 +-------
>  drivers/gpu/drm/vc4/vc4_v3d.c     | 19 ++-----
>  drivers/gpu/drm/vc4/vc4_vec.c     | 20 +-------
>  12 files changed, 126 insertions(+), 166 deletions(-)

[...]

> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index f6c9de75d465..be85656024fa 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -210,7 +210,12 @@ struct vc4_dev {
>  
>  	struct drm_modeset_lock ctm_state_lock;
>  	struct drm_private_obj ctm_manager;
> -	struct drm_private_obj load_tracker;
> + 	struct drm_private_obj load_tracker;

FYI git am tells me you have a space-before-tab here :)

Cheers,

Paul

> +
> +	/* List of vc4_debugfs_info_entry for adding to debugfs once
> +	 * the minor is available (after drm_dev_register()).
> +	 */
> +	struct list_head debugfs_list;
>  };
>  
>  static inline struct vc4_dev *
> @@ -429,6 +434,7 @@ struct vc4_crtc_data {
>  	int hvs_channel;
>  
>  	enum vc4_encoder_type encoder_types[4];
> +	const char *debugfs_name;
>  };
>  
>  struct vc4_crtc {
> @@ -715,7 +721,6 @@ struct drm_gem_object *vc4_prime_import_sg_table(struct drm_device *dev,
>  void *vc4_prime_vmap(struct drm_gem_object *obj);
>  int vc4_bo_cache_init(struct drm_device *dev);
>  void vc4_bo_cache_destroy(struct drm_device *dev);
> -int vc4_bo_stats_debugfs(struct seq_file *m, void *arg);
>  int vc4_bo_inc_usecnt(struct vc4_bo *bo);
>  void vc4_bo_dec_usecnt(struct vc4_bo *bo);
>  void vc4_bo_add_to_purgeable_pool(struct vc4_bo *bo);
> @@ -723,7 +728,6 @@ void vc4_bo_remove_from_purgeable_pool(struct vc4_bo *bo);
>  
>  /* vc4_crtc.c */
>  extern struct platform_driver vc4_crtc_driver;
> -int vc4_crtc_debugfs_regs(struct seq_file *m, void *arg);
>  bool vc4_crtc_get_scanoutpos(struct drm_device *dev, unsigned int crtc_id,
>  			     bool in_vblank_irq, int *vpos, int *hpos,
>  			     ktime_t *stime, ktime_t *etime,
> @@ -736,17 +740,37 @@ void vc4_crtc_get_margins(struct drm_crtc_state *state,
>  
>  /* vc4_debugfs.c */
>  int vc4_debugfs_init(struct drm_minor *minor);
> +#ifdef CONFIG_DEBUG_FS
> +void vc4_debugfs_add_file(struct drm_device *drm,
> +			  const char *filename,
> +			  int (*show)(struct seq_file*, void*),
> +			  void *data);
> +void vc4_debugfs_add_regset32(struct drm_device *drm,
> +			      const char *filename,
> +			      struct debugfs_regset32 *regset);
> +#else
> +static inline void vc4_debugfs_add_file(struct drm_device *drm,
> +					const char *filename,
> +					int (*show)(struct seq_file*, void*),
> +					void *data)
> +{
> +}
> +
> +static inline void vc4_debugfs_add_regset32(struct drm_device *drm,
> +					    const char *filename,
> +					    struct debugfs_regset32 *regset)
> +{
> +}
> +#endif
>  
>  /* vc4_drv.c */
>  void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
>  
>  /* vc4_dpi.c */
>  extern struct platform_driver vc4_dpi_driver;
> -int vc4_dpi_debugfs_regs(struct seq_file *m, void *unused);
>  
>  /* vc4_dsi.c */
>  extern struct platform_driver vc4_dsi_driver;
> -int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused);
>  
>  /* vc4_fence.c */
>  extern const struct dma_fence_ops vc4_fence_ops;
> @@ -774,15 +798,12 @@ int vc4_gem_madvise_ioctl(struct drm_device *dev, void *data,
>  
>  /* vc4_hdmi.c */
>  extern struct platform_driver vc4_hdmi_driver;
> -int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused);
>  
>  /* vc4_vec.c */
>  extern struct platform_driver vc4_vec_driver;
> -int vc4_vec_debugfs_regs(struct seq_file *m, void *unused);
>  
>  /* vc4_txp.c */
>  extern struct platform_driver vc4_txp_driver;
> -int vc4_txp_debugfs_regs(struct seq_file *m, void *unused);
>  
>  /* vc4_irq.c */
>  irqreturn_t vc4_irq(int irq, void *arg);
> @@ -794,8 +815,6 @@ void vc4_irq_reset(struct drm_device *dev);
>  /* vc4_hvs.c */
>  extern struct platform_driver vc4_hvs_driver;
>  void vc4_hvs_dump_state(struct drm_device *dev);
> -int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
> -int vc4_hvs_debugfs_underrun(struct seq_file *m, void *unused);
>  void vc4_hvs_unmask_underrun(struct drm_device *dev, int channel);
>  void vc4_hvs_mask_underrun(struct drm_device *dev, int channel);
>  
> @@ -812,8 +831,6 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
>  
>  /* vc4_v3d.c */
>  extern struct platform_driver vc4_v3d_driver;
> -int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused);
> -int vc4_v3d_debugfs_regs(struct seq_file *m, void *unused);
>  int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
>  int vc4_v3d_pm_get(struct vc4_dev *vc4);
>  void vc4_v3d_pm_put(struct vc4_dev *vc4);
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 806cfaa2a6a7..9412709067f5 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -657,25 +657,6 @@ static const struct debugfs_reg32 dsi1_regs[] = {
>  	VC4_REG32(DSI1_ID),
>  };
>  
> -#ifdef CONFIG_DEBUG_FS
> -int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused)
> -{
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *drm = node->minor->dev;
> -	struct vc4_dev *vc4 = to_vc4_dev(drm);
> -	int dsi_index = (uintptr_t)node->info_ent->data;
> -	struct vc4_dsi *dsi = (dsi_index == 1 ? vc4->dsi1 : NULL);
> -	struct drm_printer p = drm_seq_file_printer(m);
> -
> -	if (!dsi)
> -		return 0;
> -
> -	drm_print_regset32(&p, &dsi->regset);
> -
> -	return 0;
> -}
> -#endif
> -
>  static void vc4_dsi_encoder_destroy(struct drm_encoder *encoder)
>  {
>  	drm_encoder_cleanup(encoder);
> @@ -1637,6 +1618,11 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
>  	 */
>  	dsi->encoder->bridge = NULL;
>  
> +	if (dsi->port == 0)
> +		vc4_debugfs_add_regset32(drm, "dsi0_regs", &dsi->regset);
> +	else
> +		vc4_debugfs_add_regset32(drm, "dsi1_regs", &dsi->regset);
> +
>  	pm_runtime_enable(dev);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 38c9172cfe52..99fc8569e0f5 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -187,8 +187,7 @@ static const struct debugfs_reg32 hd_regs[] = {
>  	VC4_REG32(VC4_HD_FRAME_COUNT),
>  };
>  
> -#ifdef CONFIG_DEBUG_FS
> -int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
> +static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>  {
>  	struct drm_info_node *node = (struct drm_info_node *)m->private;
>  	struct drm_device *dev = node->minor->dev;
> @@ -201,7 +200,6 @@ int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_DEBUG_FS */
>  
>  static enum drm_connector_status
>  vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
> @@ -1432,6 +1430,8 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>  	if (ret)
>  		goto err_destroy_encoder;
>  
> +	vc4_debugfs_add_file(drm, "hdmi_regs", vc4_hdmi_debugfs_regs, hdmi);
> +
>  	return 0;
>  
>  #ifdef CONFIG_DRM_VC4_HDMI_CEC
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index c463453f941b..f746e9a7a88c 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -80,20 +80,7 @@ void vc4_hvs_dump_state(struct drm_device *dev)
>  	}
>  }
>  
> -#ifdef CONFIG_DEBUG_FS
> -int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused)
> -{
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct vc4_dev *vc4 = to_vc4_dev(dev);
> -	struct drm_printer p = drm_seq_file_printer(m);
> -
> -	drm_print_regset32(&p, &vc4->hvs->regset);
> -
> -	return 0;
> -}
> -
> -int vc4_hvs_debugfs_underrun(struct seq_file *m, void *data)
> +static int vc4_hvs_debugfs_underrun(struct seq_file *m, void *data)
>  {
>  	struct drm_info_node *node = m->private;
>  	struct drm_device *dev = node->minor->dev;
> @@ -104,7 +91,6 @@ int vc4_hvs_debugfs_underrun(struct seq_file *m, void *data)
>  
>  	return 0;
>  }
> -#endif
>  
>  /* The filter kernel is composed of dwords each containing 3 9-bit
>   * signed integers packed next to each other.
> @@ -316,6 +302,10 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>  	if (ret)
>  		return ret;
>  
> +	vc4_debugfs_add_regset32(drm, "hvs_regs", &hvs->regset);
> +	vc4_debugfs_add_file(drm, "hvs_underrun", vc4_hvs_debugfs_underrun,
> +			     NULL);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index c8f80064c179..1220f4a5aac4 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -169,24 +169,6 @@ static const struct debugfs_reg32 txp_regs[] = {
>  	VC4_REG32(TXP_PROGRESS),
>  };
>  
> -#ifdef CONFIG_DEBUG_FS
> -int vc4_txp_debugfs_regs(struct seq_file *m, void *unused)
> -{
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct vc4_dev *vc4 = to_vc4_dev(dev);
> -	struct vc4_txp *txp = vc4->txp;
> -	struct drm_printer p = drm_seq_file_printer(m);
> -
> -	if (!txp)
> -		return 0;
> -
> -	drm_print_regset32(&p, &txp->regset);
> -
> -	return 0;
> -}
> -#endif
> -
>  static int vc4_txp_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct drm_device *dev = connector->dev;
> @@ -424,6 +406,8 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
>  	dev_set_drvdata(dev, txp);
>  	vc4->txp = txp;
>  
> +	vc4_debugfs_add_regset32(drm, "txp_regs", &txp->regset);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
> index 27c70eb52405..36e6c7086ecf 100644
> --- a/drivers/gpu/drm/vc4/vc4_v3d.c
> +++ b/drivers/gpu/drm/vc4/vc4_v3d.c
> @@ -22,7 +22,6 @@
>  #include "vc4_drv.h"
>  #include "vc4_regs.h"
>  
> -#ifdef CONFIG_DEBUG_FS
>  static const struct debugfs_reg32 v3d_regs[] = {
>  	VC4_REG32(V3D_IDENT0),
>  	VC4_REG32(V3D_IDENT1),
> @@ -104,19 +103,7 @@ static const struct debugfs_reg32 v3d_regs[] = {
>  	VC4_REG32(V3D_ERRSTAT),
>  };
>  
> -int vc4_v3d_debugfs_regs(struct seq_file *m, void *unused)
> -{
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct vc4_dev *vc4 = to_vc4_dev(dev);
> -	struct drm_printer p = drm_seq_file_printer(m);
> -
> -	drm_print_regset32(&p, &vc4->v3d->regset);
> -
> -	return 0;
> -}
> -
> -int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
> +static int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
>  {
>  	struct drm_info_node *node = (struct drm_info_node *)m->private;
>  	struct drm_device *dev = node->minor->dev;
> @@ -141,7 +128,6 @@ int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_DEBUG_FS */
>  
>  /**
>   * Wraps pm_runtime_get_sync() in a refcount, so that we can reliably
> @@ -442,6 +428,9 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
>  	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
>  	pm_runtime_enable(dev);
>  
> +	vc4_debugfs_add_file(drm, "v3d_ident", vc4_v3d_debugfs_ident, NULL);
> +	vc4_debugfs_add_regset32(drm, "v3d_regs", &v3d->regset);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> index 83227d2440aa..0a27e48fab31 100644
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -252,24 +252,6 @@ static const struct debugfs_reg32 vec_regs[] = {
>  	VC4_REG32(VEC_DAC_MISC),
>  };
>  
> -#ifdef CONFIG_DEBUG_FS
> -int vc4_vec_debugfs_regs(struct seq_file *m, void *unused)
> -{
> -	struct drm_info_node *node = (struct drm_info_node *)m->private;
> -	struct drm_device *dev = node->minor->dev;
> -	struct vc4_dev *vc4 = to_vc4_dev(dev);
> -	struct vc4_vec *vec = vc4->vec;
> -	struct drm_printer p = drm_seq_file_printer(m);
> -
> -	if (!vec)
> -		return 0;
> -
> -	drm_print_regset32(&p, &vec->regset);
> -
> -	return 0;
> -}
> -#endif
> -
>  static void vc4_vec_ntsc_mode_set(struct vc4_vec *vec)
>  {
>  	VEC_WRITE(VEC_CONFIG0, VEC_CONFIG0_NTSC_STD | VEC_CONFIG0_PDEN);
> @@ -609,6 +591,8 @@ static int vc4_vec_bind(struct device *dev, struct device *master, void *data)
>  
>  	vc4->vec = vec;
>  
> +	vc4_debugfs_add_regset32(drm, "vec_regs", &vec->regset);
> +
>  	return 0;
>  
>  err_destroy_encoder:
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

