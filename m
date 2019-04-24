Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DFDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EE8218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfDXMJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:09:25 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:45111 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726932AbfDXMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:09:25 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud9.xs4all.net with ESMTPA
        id JGiCh9lVJNExlJGiGhQuJN; Wed, 24 Apr 2019 14:09:20 +0200
Subject: Re: [RFC PATCH v2] media: cec: expose HDMI connector to CEC dev
 mapping
To:     Dariusz Marcinkiewicz <darekm@google.com>,
        linux-media@vger.kernel.org, hans.verkuil@cisco.com
Cc:     linux-kernel@vger.kernel.org
References: <20190416083852.126786-1-darekm@google.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <dcb189af-f67f-ede3-b4fb-de1da7b53ccb@xs4all.nl>
Date:   Wed, 24 Apr 2019 14:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190416083852.126786-1-darekm@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLNAUT3GKCb5xMosDcJw3QPXSbZovvqHOVFUT08lM5wxPN0eAj2U0/9Zj4o6lFoqf/jUz+R7xifPf/fe8+S/I7Esuf+jvuKl1FeUDpB3dreMnKrtwQdJ
 WgD6hesj17nF5mOJO0eW8DpAW2dEiUboKNsDkeOEH/gwmlATC5XBSGIilN0IymTs4nyApix0krFkakmQewQdTkbvqGi7uFffgHZc15GL6s89PO+qQ1Jpo4jg
 fO8mkdK5efMXJc1cD2+tXCNVuBfj3pvEJHKYuuYP8N82dteXOQjabW46EkrB9fleEyhtU2CeGY38/Hsj9l+tdEbMGDa68f+Jk7Ptx1+3FWVWkZnbGsElUXZy
 REP/AYeh3M+uAzrhS7Q7XZ2pnePy0eaN6ESNBjrFbwU50W4Jwj8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dariusz,

This is getting close, so I think for the next version you can drop
the RFC tag.

Some comments:

On 4/16/19 10:38 AM, Dariusz Marcinkiewicz wrote:
> This patch proposes to expose explicit mapping between HDMI connectors
> and /dev/cecX adapters to userland.
> 
> New structure with connector info (card number and connector id in case
> of DRM connectors) is added to cec_adapter. That connector info is expected
> to be provided when an adapter is created.
> 
> CEC notifier is extended so that it can be used to communicate the
> connector's info to CEC adapters' creators.
> 
> New ioctl, exposing connector info to userland, is added to /dev/cec.
> 
> Changes since v2:
>  - cec_s_connector_info removed, the connector info is now passed to
>    cec_allocate_adapter
>  - updated commit message
> Changes since v1:
>  - removed the unnecessary event,
>  - extended cec_connctor_info to allow for various types of connectors.
> 
> Signed-off-by: Dariusz Marcinkiewicz <darekm@google.com>
> ---
>  Documentation/media/kapi/cec-core.rst         |  6 +++-
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c  |  3 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c |  2 +-
>  drivers/gpu/drm/drm_dp_cec.c                  | 24 ++++++++------
>  drivers/gpu/drm/i2c/tda9950.c                 |  3 +-
>  drivers/gpu/drm/i915/intel_dp.c               |  5 ++-
>  drivers/gpu/drm/i915/intel_hdmi.c             | 11 ++++++-
>  drivers/gpu/drm/nouveau/nouveau_connector.c   |  3 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c                |  2 +-
>  drivers/media/cec/cec-api.c                   | 12 +++++++
>  drivers/media/cec/cec-core.c                  | 13 ++++++--
>  drivers/media/cec/cec-notifier.c              | 19 +++++++++++-
>  drivers/media/i2c/tc358743.c                  |  3 +-
>  .../media/platform/cros-ec-cec/cros-ec-cec.c  |  4 ++-
>  drivers/media/platform/meson/ao-cec.c         |  3 +-
>  drivers/media/platform/s5p-cec/s5p_cec.c      |  3 +-
>  drivers/media/platform/sti/cec/stih-cec.c     |  2 +-
>  drivers/media/platform/stm32/stm32-cec.c      |  2 +-
>  drivers/media/platform/tegra-cec/tegra_cec.c  |  2 +-
>  drivers/media/platform/vivid/vivid-cec.c      |  2 +-
>  drivers/media/usb/pulse8-cec/pulse8-cec.c     |  3 +-
>  .../media/usb/rainshadow-cec/rainshadow-cec.c |  3 +-
>  include/drm/drm_dp_helper.h                   | 14 ++++-----
>  include/media/cec-notifier.h                  | 31 +++++++++++++++++--
>  include/media/cec.h                           |  6 ++--
>  include/uapi/linux/cec.h                      | 24 ++++++++++++++
>  27 files changed, 161 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/media/kapi/cec-core.rst b/Documentation/media/kapi/cec-core.rst
> index 3ce26b7c2b2b6..6df2b9efac22d 100644
> --- a/Documentation/media/kapi/cec-core.rst
> +++ b/Documentation/media/kapi/cec-core.rst
> @@ -37,7 +37,7 @@ calling cec_allocate_adapter() and deleted by calling cec_delete_adapter():
>  
>  .. c:function::
>     struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops, void *priv,
> -   const char *name, u32 caps, u8 available_las);
> +   const char *name, u32 caps, u8 available_las, struct cec_connector_info* connector_info);

Make this const and put the space before the *:

const struct cec_connector_info *connector_info

>  
>  .. c:function::
>     void cec_delete_adapter(struct cec_adapter *adap);
> @@ -65,6 +65,10 @@ available_las:
>  	the number of simultaneous logical addresses that this
>  	adapter can handle. Must be 1 <= available_las <= CEC_MAX_LOG_ADDRS.
>  
> +cec_connector_info:
> +        poiner to a struct describing connector this adapter is associated with,

pointer

> +        can be NULL.
> +
>  To obtain the priv pointer use this helper function:
>  
>  .. c:function::
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 6e205ee36ac3b..7f2eb4eb1035b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -394,7 +394,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>  
>  	drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
>  	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
> -				      aconnector->base.name, dm->adev->dev);
> +				      &aconnector->base);
>  	aconnector->mst_mgr.cbs = &dm_mst_cbs;
>  	drm_dp_mst_topology_mgr_init(
>  		&aconnector->mst_mgr,
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> index a20a45c0b353f..6400ad9b85502 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
> @@ -310,7 +310,8 @@ int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
>  		goto err_cec_parse_dt;
>  
>  	adv7511->cec_adap = cec_allocate_adapter(&adv7511_cec_adap_ops,
> -		adv7511, dev_name(dev), CEC_CAP_DEFAULTS, ADV7511_MAX_ADDRS);
> +		adv7511, dev_name(dev), CEC_CAP_DEFAULTS, ADV7511_MAX_ADDRS,
> +		NULL);
>  	if (IS_ERR(adv7511->cec_adap)) {
>  		ret = PTR_ERR(adv7511->cec_adap);
>  		goto err_cec_alloc;
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> index 6c323510f1288..84fb7b6a0a5e0 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
> @@ -261,7 +261,7 @@ static int dw_hdmi_cec_probe(struct platform_device *pdev)
>  	cec->adap = cec_allocate_adapter(&dw_hdmi_cec_ops, cec, "dw_hdmi",
>  					 CEC_CAP_LOG_ADDRS | CEC_CAP_TRANSMIT |
>  					 CEC_CAP_RC | CEC_CAP_PASSTHROUGH,
> -					 CEC_MAX_LOG_ADDRS);
> +					 CEC_MAX_LOG_ADDRS, NULL);

Hmm, the connector information is actually available through cec->hdmi.

I think it would make sense to create a helper function that fills in
struct cec_connector_info based on a struct drm_connector pointer.
And add a function to drivers/gpu/drm/bridge/synopsys/dw-hdmi.c that
dw-hdmi-cec.c can call that does the same.

>  	if (IS_ERR(cec->adap))
>  		return PTR_ERR(cec->adap);
>  
> diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
> index b15cee85b702b..53879c7b41dfb 100644
> --- a/drivers/gpu/drm/drm_dp_cec.c
> +++ b/drivers/gpu/drm/drm_dp_cec.c
> @@ -8,7 +8,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <drm/drm_connector.h>
>  #include <drm/drm_dp_helper.h>
> +#include <drm/drmP.h>
>  #include <media/cec.h>
>  
>  /*
> @@ -295,7 +297,13 @@ static void drm_dp_cec_unregister_work(struct work_struct *work)
>   */
>  void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
>  {
> +	struct drm_connector *connector = aux->cec.connector;
>  	u32 cec_caps = CEC_CAP_DEFAULTS | CEC_CAP_NEEDS_HPD;
> +	struct cec_connector_info connector_info = {
> +		.type = CEC_CONNECTOR_TYPE_DRM,
> +		.drm.card_no = connector->dev->primary->index,
> +		.drm.connector_id = connector->base.id
> +	};
>  	unsigned int num_las = 1;
>  	u8 cap;
>  
> @@ -344,13 +352,13 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
>  
>  	/* Create a new adapter */
>  	aux->cec.adap = cec_allocate_adapter(&drm_dp_cec_adap_ops,
> -					     aux, aux->cec.name, cec_caps,
> -					     num_las);
> +					     aux, connector->name, cec_caps,
> +					     num_las, &connector_info);
>  	if (IS_ERR(aux->cec.adap)) {
>  		aux->cec.adap = NULL;
>  		goto unlock;
>  	}
> -	if (cec_register_adapter(aux->cec.adap, aux->cec.parent)) {
> +	if (cec_register_adapter(aux->cec.adap, connector->dev->dev)) {
>  		cec_delete_adapter(aux->cec.adap);
>  		aux->cec.adap = NULL;
>  	} else {
> @@ -406,22 +414,20 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
>  /**
>   * drm_dp_cec_register_connector() - register a new connector
>   * @aux: DisplayPort AUX channel
> - * @name: name of the CEC device
> - * @parent: parent device
> + * @connector: drm connector
>   *
>   * A new connector was registered with associated CEC adapter name and
>   * CEC adapter parent device. After registering the name and parent
>   * drm_dp_cec_set_edid() is called to check if the connector supports
>   * CEC and to register a CEC adapter if that is the case.
>   */
> -void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char *name,
> -				   struct device *parent)
> +void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> +				   struct drm_connector *connector)
>  {
>  	WARN_ON(aux->cec.adap);
>  	if (WARN_ON(!aux->transfer))
>  		return;
> -	aux->cec.name = name;
> -	aux->cec.parent = parent;
> +	aux->cec.connector = connector;
>  	INIT_DELAYED_WORK(&aux->cec.unregister_work,
>  			  drm_dp_cec_unregister_work);
>  }
> diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
> index 250b5e02a314a..b944dd9df85e1 100644
> --- a/drivers/gpu/drm/i2c/tda9950.c
> +++ b/drivers/gpu/drm/i2c/tda9950.c
> @@ -424,7 +424,8 @@ static int tda9950_probe(struct i2c_client *client,
>  
>  	priv->adap = cec_allocate_adapter(&tda9950_cec_ops, priv, "tda9950",
>  					  CEC_CAP_DEFAULTS,
> -					  CEC_MAX_LOG_ADDRS);
> +					  CEC_MAX_LOG_ADDRS,
> +					  NULL);

Here too the drm_connector can be found via struct tda9950_glue.
So it is easy to provide proper connector information.

>  	if (IS_ERR(priv->adap))
>  		return PTR_ERR(priv->adap);
>  
> diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_dp.c
> index 72c49070ed14c..a20f806daa4a9 100644
> --- a/drivers/gpu/drm/i915/intel_dp.c
> +++ b/drivers/gpu/drm/i915/intel_dp.c
> @@ -5550,7 +5550,6 @@ static int
>  intel_dp_connector_register(struct drm_connector *connector)
>  {
>  	struct intel_dp *intel_dp = intel_attached_dp(connector);
> -	struct drm_device *dev = connector->dev;
>  	int ret;
>  
>  	ret = intel_connector_register(connector);
> @@ -5565,8 +5564,7 @@ intel_dp_connector_register(struct drm_connector *connector)
>  	intel_dp->aux.dev = connector->kdev;
>  	ret = drm_dp_aux_register(&intel_dp->aux);
>  	if (!ret)
> -		drm_dp_cec_register_connector(&intel_dp->aux,
> -					      connector->name, dev->dev);
> +		drm_dp_cec_register_connector(&intel_dp->aux, connector);
>  	return ret;
>  }
>  
> @@ -7435,3 +7433,4 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
>  		}
>  	}
>  }
> +
> diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
> index 26767785f14aa..5aea26ffedd60 100644
> --- a/drivers/gpu/drm/i915/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/intel_hdmi.c
> @@ -3021,8 +3021,17 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
>  
>  	intel_hdmi->cec_notifier = cec_notifier_get_conn(dev->dev,
>  							 port_identifier(port));

The connector information should be added as an argument to
cec_notifier_get_conn(). That way the notifier connector information is
always set atomically.

> -	if (!intel_hdmi->cec_notifier)
> +	if (intel_hdmi->cec_notifier) {
> +		struct cec_connector_info info;
> +
> +		info.type = CEC_CONNECTOR_TYPE_DRM;
> +		info.drm.card_no = connector->dev->primary->index;
> +		info.drm.connector_id = connector->base.id;
> +		cec_notifier_set_connector_info(intel_hdmi->cec_notifier,
> +						&info);

So drop this function.

> +	} else {
>  		DRM_DEBUG_KMS("CEC notifier get failed\n");
> +	}
>  }
>  
>  void intel_hdmi_init(struct drm_i915_private *dev_priv,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 4116ee62adafe..4438824ca88b0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1413,8 +1413,7 @@ nouveau_connector_create(struct drm_device *dev,
>  	switch (type) {
>  	case DRM_MODE_CONNECTOR_DisplayPort:
>  	case DRM_MODE_CONNECTOR_eDP:
> -		drm_dp_cec_register_connector(&nv_connector->aux,
> -					      connector->name, dev->dev);
> +		drm_dp_cec_register_connector(&nv_connector->aux, connector);
>  		break;
>  	}
>  
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 88fd5df7e7dc6..a58ddfbd32bd8 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1418,7 +1418,7 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>  					      CEC_CAP_TRANSMIT |
>  					      CEC_CAP_LOG_ADDRS |
>  					      CEC_CAP_PASSTHROUGH |
> -					      CEC_CAP_RC, 1);
> +					      CEC_CAP_RC, 1, NULL);

Here too the drm_connector pointer is readily available.

>  	ret = PTR_ERR_OR_ZERO(hdmi->cec_adap);
>  	if (ret < 0)
>  		goto err_destroy_conn;
> diff --git a/drivers/media/cec/cec-api.c b/drivers/media/cec/cec-api.c
> index 156a0d76ab2a1..2ed312ad34a39 100644
> --- a/drivers/media/cec/cec-api.c
> +++ b/drivers/media/cec/cec-api.c
> @@ -187,6 +187,15 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
>  	return 0;
>  }
>  
> +static long cec_adap_g_connector_info(struct cec_adapter *adap,
> +				      struct cec_log_addrs __user *parg)
> +{
> +	if (copy_to_user(parg, &adap->connector_info,
> +			 sizeof(adap->connector_info)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>  static long cec_transmit(struct cec_adapter *adap, struct cec_fh *fh,
>  			 bool block, struct cec_msg __user *parg)
>  {
> @@ -514,6 +523,9 @@ static long cec_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	case CEC_ADAP_S_LOG_ADDRS:
>  		return cec_adap_s_log_addrs(adap, fh, block, parg);
>  
> +	case CEC_ADAP_G_CONNECTOR_INFO:
> +		return cec_adap_g_connector_info(adap, parg);
> +

Note that this should be documented in Documentation/media/uapi/cec/.

>  	case CEC_TRANSMIT:
>  		return cec_transmit(adap, fh, block, parg);
>  
> diff --git a/drivers/media/cec/cec-core.c b/drivers/media/cec/cec-core.c
> index f5d1578e256a7..cae96c61aff30 100644
> --- a/drivers/media/cec/cec-core.c
> +++ b/drivers/media/cec/cec-core.c
> @@ -195,7 +195,8 @@ void cec_register_cec_notifier(struct cec_adapter *adap,
>  		return;
>  
>  	adap->notifier = notifier;
> -	cec_notifier_register(adap->notifier, adap, cec_cec_notify);
> +	cec_notifier_register(adap->notifier, adap,
> +			      cec_cec_notify);

Unnecessary change.

>  }
>  EXPORT_SYMBOL_GPL(cec_register_cec_notifier);
>  #endif
> @@ -250,8 +251,9 @@ static const struct file_operations cec_error_inj_fops = {
>  #endif
>  
>  struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
> -					 void *priv, const char *name, u32 caps,
> -					 u8 available_las)
> +			void *priv, const char *name, u32 caps,
> +			u8 available_las,
> +			struct cec_connector_info *connector_info)

Should be a const pointer.

>  {
>  	struct cec_adapter *adap;
>  	int res;
> @@ -288,6 +290,11 @@ struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
>  	INIT_LIST_HEAD(&adap->wait_queue);
>  	init_waitqueue_head(&adap->kthread_waitq);
>  
> +	if (connector_info)
> +		adap->connector_info = *connector_info;
> +	else
> +		adap->connector_info.type = CEC_CONNECTOR_TYPE_NO_CONNECTOR;
> +
>  	/* adap->devnode initialization */
>  	INIT_LIST_HEAD(&adap->devnode.fhs);
>  	mutex_init(&adap->devnode.lock);
> diff --git a/drivers/media/cec/cec-notifier.c b/drivers/media/cec/cec-notifier.c
> index dd2078b27a419..a3c172ee0999b 100644
> --- a/drivers/media/cec/cec-notifier.c
> +++ b/drivers/media/cec/cec-notifier.c
> @@ -26,6 +26,7 @@ struct cec_notifier {
>  	void (*callback)(struct cec_adapter *adap, u16 pa);
>  
>  	u16 phys_addr;
> +	struct cec_connector_info connector_info;
>  };
>  
>  static LIST_HEAD(cec_notifiers);
> @@ -51,6 +52,7 @@ struct cec_notifier *cec_notifier_get_conn(struct device *dev, const char *conn)

The connector info should be passed as an argument.

>  	if (conn)
>  		n->conn = kstrdup(conn, GFP_KERNEL);
>  	n->phys_addr = CEC_PHYS_ADDR_INVALID;
> +	n->connector_info.type = CEC_CONNECTOR_TYPE_NO_CONNECTOR;
>  	mutex_init(&n->lock);
>  	kref_init(&n->kref);
>  	list_add_tail(&n->head, &cec_notifiers);
> @@ -106,9 +108,24 @@ void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
>  }
>  EXPORT_SYMBOL_GPL(cec_notifier_set_phys_addr_from_edid);
>  
> +void cec_notifier_set_connector_info(struct cec_notifier *n,
> +				     struct cec_connector_info *c)
> +{
> +	memcpy(&n->connector_info, c, sizeof(*c));
> +}
> +EXPORT_SYMBOL_GPL(cec_notifier_set_connector_info);

Drop this function.

> +
> +struct cec_connector_info *cec_notifier_get_connector_info(

const

> +	struct cec_notifier *n)

const

> +{
> +	return &n->connector_info;
> +}
> +EXPORT_SYMBOL_GPL(cec_notifier_get_connector_info);
> +
>  void cec_notifier_register(struct cec_notifier *n,
>  			   struct cec_adapter *adap,
> -			   void (*callback)(struct cec_adapter *adap, u16 pa))
> +			   void (*callback)(struct cec_adapter *adap,
> +					    u16 pa))

Unnecessary change.

>  {
>  	kref_get(&n->kref);
>  	mutex_lock(&n->lock);
> diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
> index bc2e35e5ce615..14a686c80a9e6 100644
> --- a/drivers/media/i2c/tc358743.c
> +++ b/drivers/media/i2c/tc358743.c
> @@ -2117,7 +2117,8 @@ static int tc358743_probe(struct i2c_client *client,
>  #ifdef CONFIG_VIDEO_TC358743_CEC
>  	state->cec_adap = cec_allocate_adapter(&tc358743_cec_adap_ops,
>  		state, dev_name(&client->dev),
> -		CEC_CAP_DEFAULTS | CEC_CAP_MONITOR_ALL, CEC_MAX_LOG_ADDRS);
> +		CEC_CAP_DEFAULTS | CEC_CAP_MONITOR_ALL, CEC_MAX_LOG_ADDRS,
> +		NULL);
>  	if (IS_ERR(state->cec_adap)) {
>  		err = PTR_ERR(state->cec_adap);
>  		goto err_hdl;
> diff --git a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> index 7bc4d8a9af287..5416db63b8c2e 100644
> --- a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> +++ b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> @@ -282,7 +282,9 @@ static int cros_ec_cec_probe(struct platform_device *pdev)
>  	}
>  
>  	cros_ec_cec->adap = cec_allocate_adapter(&cros_ec_cec_ops, cros_ec_cec,
> -						 DRV_NAME, CEC_CAP_DEFAULTS, 1);
> +				DRV_NAME, CEC_CAP_DEFAULTS, 1,
> +				cec_notifier_get_connector_info(
> +					cros_ec_cec->notify));

This is probably more readable if the connector info is assigned
to a temp variable first.

>  	if (IS_ERR(cros_ec_cec->adap))
>  		return PTR_ERR(cros_ec_cec->adap);
>  
> diff --git a/drivers/media/platform/meson/ao-cec.c b/drivers/media/platform/meson/ao-cec.c
> index cd4be38ab5acc..0154e7aa9d058 100644
> --- a/drivers/media/platform/meson/ao-cec.c
> +++ b/drivers/media/platform/meson/ao-cec.c
> @@ -632,7 +632,8 @@ static int meson_ao_cec_probe(struct platform_device *pdev)
>  					    CEC_CAP_TRANSMIT |
>  					    CEC_CAP_RC |
>  					    CEC_CAP_PASSTHROUGH,
> -					    1); /* Use 1 for now */
> +					    1 /* Use 1 for now */,

Please put the , after 1, so: 1, /* Use 1 for now */

> +					    NULL);

Here too you need to pass the connector info obtained from the
notifier. This is true for all drivers that call cec_register_cec_notifier().

>  	if (IS_ERR(ao_cec->adap)) {
>  		ret = PTR_ERR(ao_cec->adap);
>  		goto out_probe_notify;
> diff --git a/drivers/media/platform/s5p-cec/s5p_cec.c b/drivers/media/platform/s5p-cec/s5p_cec.c
> index 8837e2678bdeb..9abbfd5452fbc 100644
> --- a/drivers/media/platform/s5p-cec/s5p_cec.c
> +++ b/drivers/media/platform/s5p-cec/s5p_cec.c
> @@ -229,7 +229,8 @@ static int s5p_cec_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	cec->adap = cec_allocate_adapter(&s5p_cec_adap_ops, cec, CEC_NAME,
> -		CEC_CAP_DEFAULTS | (needs_hpd ? CEC_CAP_NEEDS_HPD : 0), 1);
> +		CEC_CAP_DEFAULTS | (needs_hpd ? CEC_CAP_NEEDS_HPD : 0), 1,
> +		NULL);

Ditto.

>  	ret = PTR_ERR_OR_ZERO(cec->adap);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/media/platform/sti/cec/stih-cec.c b/drivers/media/platform/sti/cec/stih-cec.c
> index d34099f759901..c76d20098bb03 100644
> --- a/drivers/media/platform/sti/cec/stih-cec.c
> +++ b/drivers/media/platform/sti/cec/stih-cec.c
> @@ -348,7 +348,7 @@ static int stih_cec_probe(struct platform_device *pdev)
>  	}
>  
>  	cec->adap = cec_allocate_adapter(&sti_cec_adap_ops, cec,
> -			CEC_NAME, CEC_CAP_DEFAULTS, CEC_MAX_LOG_ADDRS);
> +			CEC_NAME, CEC_CAP_DEFAULTS, CEC_MAX_LOG_ADDRS, NULL);

Ditto.

>  	ret = PTR_ERR_OR_ZERO(cec->adap);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/media/platform/stm32/stm32-cec.c b/drivers/media/platform/stm32/stm32-cec.c
> index 7c496bc1cf381..ee23b9efd45ec 100644
> --- a/drivers/media/platform/stm32/stm32-cec.c
> +++ b/drivers/media/platform/stm32/stm32-cec.c
> @@ -304,7 +304,7 @@ static int stm32_cec_probe(struct platform_device *pdev)
>  	 * available for example when a drm driver can provide edid
>  	 */
>  	cec->adap = cec_allocate_adapter(&stm32_cec_adap_ops, cec,
> -			CEC_NAME, caps,	CEC_MAX_LOG_ADDRS);
> +			CEC_NAME, caps,	CEC_MAX_LOG_ADDRS, NULL);
>  	ret = PTR_ERR_OR_ZERO(cec->adap);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/media/platform/tegra-cec/tegra_cec.c b/drivers/media/platform/tegra-cec/tegra_cec.c
> index aba488cd0e645..6344c3993bdce 100644
> --- a/drivers/media/platform/tegra-cec/tegra_cec.c
> +++ b/drivers/media/platform/tegra-cec/tegra_cec.c
> @@ -408,7 +408,7 @@ static int tegra_cec_probe(struct platform_device *pdev)
>  
>  	cec->adap = cec_allocate_adapter(&tegra_cec_ops, cec, TEGRA_CEC_NAME,
>  			CEC_CAP_DEFAULTS | CEC_CAP_MONITOR_ALL,
> -			CEC_MAX_LOG_ADDRS);
> +			CEC_MAX_LOG_ADDRS, 0);

Ditto.

>  	if (IS_ERR(cec->adap)) {
>  		ret = -ENOMEM;
>  		dev_err(&pdev->dev, "Couldn't create cec adapter\n");
> diff --git a/drivers/media/platform/vivid/vivid-cec.c b/drivers/media/platform/vivid/vivid-cec.c
> index 4d822dbed9726..ef15c9c58c2a6 100644
> --- a/drivers/media/platform/vivid/vivid-cec.c
> +++ b/drivers/media/platform/vivid/vivid-cec.c
> @@ -283,5 +283,5 @@ struct cec_adapter *vivid_cec_alloc_adap(struct vivid_dev *dev,
>  		 is_source ? dev->vid_out_dev.name : dev->vid_cap_dev.name,
>  		 idx);
>  	return cec_allocate_adapter(&vivid_cec_adap_ops, dev,
> -		name, caps, 1);
> +		name, caps, 1, NULL);
>  }
> diff --git a/drivers/media/usb/pulse8-cec/pulse8-cec.c b/drivers/media/usb/pulse8-cec/pulse8-cec.c
> index b085b14f3f877..b1a741584a648 100644
> --- a/drivers/media/usb/pulse8-cec/pulse8-cec.c
> +++ b/drivers/media/usb/pulse8-cec/pulse8-cec.c
> @@ -656,7 +656,8 @@ static int pulse8_connect(struct serio *serio, struct serio_driver *drv)
>  
>  	pulse8->serio = serio;
>  	pulse8->adap = cec_allocate_adapter(&pulse8_cec_adap_ops, pulse8,
> -					    dev_name(&serio->dev), caps, 1);
> +					    dev_name(&serio->dev), caps, 1,
> +					    NULL);
>  	err = PTR_ERR_OR_ZERO(pulse8->adap);
>  	if (err < 0)
>  		goto free_device;
> diff --git a/drivers/media/usb/rainshadow-cec/rainshadow-cec.c b/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
> index d9964da05976b..8681e4d6b3d59 100644
> --- a/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
> +++ b/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
> @@ -323,7 +323,8 @@ static int rain_connect(struct serio *serio, struct serio_driver *drv)
>  
>  	rain->serio = serio;
>  	rain->adap = cec_allocate_adapter(&rain_cec_adap_ops, rain,
> -					  dev_name(&serio->dev), caps, 1);
> +					  dev_name(&serio->dev), caps, 1,
> +					  NULL);
>  	err = PTR_ERR_OR_ZERO(rain->adap);
>  	if (err < 0)
>  		goto free_device;
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 97ce790a5b5aa..ded0ff01f2ac7 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1208,6 +1208,7 @@ struct drm_dp_aux_msg {
>  
>  struct cec_adapter;
>  struct edid;
> +struct drm_connector;
>  
>  /**
>   * struct drm_dp_aux_cec - DisplayPort CEC-Tunneling-over-AUX
> @@ -1220,8 +1221,7 @@ struct edid;
>  struct drm_dp_aux_cec {
>  	struct mutex lock;
>  	struct cec_adapter *adap;
> -	const char *name;
> -	struct device *parent;
> +	struct drm_connector *connector;
>  	struct delayed_work unregister_work;
>  };
>  
> @@ -1418,8 +1418,8 @@ drm_dp_has_quirk(const struct drm_dp_desc *desc, enum drm_dp_quirk quirk)
>  
>  #ifdef CONFIG_DRM_DP_CEC
>  void drm_dp_cec_irq(struct drm_dp_aux *aux);
> -void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char *name,
> -				   struct device *parent);
> +void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> +				   struct drm_connector *connector);
>  void drm_dp_cec_unregister_connector(struct drm_dp_aux *aux);
>  void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid);
>  void drm_dp_cec_unset_edid(struct drm_dp_aux *aux);
> @@ -1428,9 +1428,9 @@ static inline void drm_dp_cec_irq(struct drm_dp_aux *aux)
>  {
>  }
>  
> -static inline void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> -						 const char *name,
> -						 struct device *parent)
> +static inline
> +void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> +				   struct drm_connector *connector)
>  {
>  }
>  
> diff --git a/include/media/cec-notifier.h b/include/media/cec-notifier.h
> index 814eeef35a5cf..f98cb81b1c68f 100644
> --- a/include/media/cec-notifier.h
> +++ b/include/media/cec-notifier.h
> @@ -63,6 +63,21 @@ void cec_notifier_set_phys_addr(struct cec_notifier *n, u16 pa);
>  void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
>  					  const struct edid *edid);
>  
> +/**
> + * cec_notifier_get_connector_info - get connector info associatied with
> + * a notifier
> + * @n: the CEC notifier
> + */
> +struct cec_connector_info *cec_notifier_get_connector_info(
> +				struct cec_notifier *n);
> +
> +/**
> + * cec_notifier_set_connector_info - associates connector info with a notifier
> + * @n: the CEC notifier
> + * @c: the connector info
> + */
> +void cec_notifier_set_connector_info(struct cec_notifier *n,
> +				     struct cec_connector_info *c);
>  /**
>   * cec_notifier_register - register a callback with the notifier
>   * @n: the CEC notifier
> @@ -108,9 +123,21 @@ static inline void cec_notifier_set_phys_addr_from_edid(struct cec_notifier *n,
>  {
>  }
>  
> +static inline const struct cec_connector_info*
> +	cec_notifier_get_connector_info(struct cec_notifier *n)
> +{
> +	return NULL;
> +}
> +
> +static inline void cec_notifier_set_connector_info(
> +			struct cec_notifier *n,
> +			struct cec_connector_info *c)
> +{
> +}

Can be dropped.

> +
>  static inline void cec_notifier_register(struct cec_notifier *n,
> -			 struct cec_adapter *adap,
> -			 void (*callback)(struct cec_adapter *adap, u16 pa))
> +			struct cec_adapter *adap,
> +			void (*callback)(struct cec_adapter *adap, u16 pa))
>  {
>  }

Unnecessary change.

>  
> diff --git a/include/media/cec.h b/include/media/cec.h
> index 707411ef8ba28..8871398eadada 100644
> --- a/include/media/cec.h
> +++ b/include/media/cec.h
> @@ -200,6 +200,8 @@ struct cec_adapter {
>  	u32 sequence;
>  
>  	char input_phys[32];
> +
> +	struct cec_connector_info connector_info;
>  };
>  
>  static inline void *cec_get_drvdata(const struct cec_adapter *adap)
> @@ -236,7 +238,8 @@ struct edid;
>  
>  #if IS_REACHABLE(CONFIG_CEC_CORE)
>  struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
> -		void *priv, const char *name, u32 caps, u8 available_las);
> +		void *priv, const char *name, u32 caps, u8 available_las,
> +		struct cec_connector_info *connector_info);
>  int cec_register_adapter(struct cec_adapter *adap, struct device *parent);
>  void cec_unregister_adapter(struct cec_adapter *adap);
>  void cec_delete_adapter(struct cec_adapter *adap);
> @@ -249,7 +252,6 @@ void cec_s_phys_addr_from_edid(struct cec_adapter *adap,
>  			       const struct edid *edid);
>  int cec_transmit_msg(struct cec_adapter *adap, struct cec_msg *msg,
>  		     bool block);
> -
>  /* Called by the adapter */
>  void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
>  			  u8 arb_lost_cnt, u8 nack_cnt, u8 low_drive_cnt,
> diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
> index 3094af68b6e76..618ef95ce79a1 100644
> --- a/include/uapi/linux/cec.h
> +++ b/include/uapi/linux/cec.h
> @@ -411,6 +411,27 @@ struct cec_event_lost_msgs {
>  	__u32 lost_msgs;
>  };
>  
> +/**
> + * struct cec_event_connector - tells if and which connector is associated
> + * with the CEC adapter.
> + * @card_no: drm card number, -1 if no connector

If there is no connector, then type is NO_CONNECTOR. So this
doesn't make sense. Wouldn't it be better to just use '__u32 card_no'?

> + * @connector_id: drm connector id.
> + */
> +struct cec_drm_connector_info {
> +	int card_no;
> +	__u32 connector_id;
> +};
> +
> +#define CEC_CONNECTOR_TYPE_NO_CONNECTOR	0
> +#define CEC_CONNECTOR_TYPE_DRM		1
> +struct cec_connector_info {
> +	int type;

	__u32 type;

> +	union {
> +		struct cec_drm_connector_info drm;
> +		__u32 raw[16];
> +	};
> +};
> +
>  /**
>   * struct cec_event - CEC event structure
>   * @ts: the timestamp of when the event was sent.
> @@ -475,6 +496,9 @@ struct cec_event {
>  #define CEC_G_MODE		_IOR('a',  8, __u32)
>  #define CEC_S_MODE		_IOW('a',  9, __u32)
>  
> +/* Gets the connector info */
> +#define CEC_ADAP_G_CONNECTOR_INFO _IOR('a',  10, struct cec_connector_info)
> +
>  /*
>   * The remainder of this header defines all CEC messages and operands.
>   * The format matters since it the cec-ctl utility parses it to generate
> 

Regards,

	Hans
