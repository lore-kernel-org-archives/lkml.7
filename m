Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C72C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BB1217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfC2Wf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:35:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:51806 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfC2Wf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:35:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 15:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="scan'208";a="129890618"
Received: from lparisol-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.46.120])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2019 15:35:54 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 7A1E821E50; Sat, 30 Mar 2019 00:35:50 +0200 (EET)
Date:   Sat, 30 Mar 2019 00:35:50 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: ov6650: Register with asynchronous
 subdevice framework
Message-ID: <20190329223549.7lbmcwqvubcmw4zs@kekkonen.localdomain>
References: <20190325003501.14687-1-jmkrzyszt@gmail.com>
 <20190329202903.5622-1-jmkrzyszt@gmail.com>
 <20190329202903.5622-3-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329202903.5622-3-jmkrzyszt@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Fri, Mar 29, 2019 at 09:29:03PM +0100, Janusz Krzysztofik wrote:
> Register V4L2 subdevice implemented by the driver to the V4L2
> asynchronous subdevice framework.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/media/i2c/ov6650.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
> index de7d9790f054..50e60da73036 100644
> --- a/drivers/media/i2c/ov6650.c
> +++ b/drivers/media/i2c/ov6650.c
> @@ -804,8 +804,9 @@ static int ov6650_prog_dflt(struct i2c_client *client)
>  	return ret;
>  }
>  
> -static int ov6650_video_probe(struct i2c_client *client)
> +static int ov6650_video_probe(struct v4l2_subdev *sd)
>  {
> +	struct i2c_client *client = v4l2_get_subdevdata(sd);
>  	struct ov6650 *priv = to_ov6650(client);
>  	u8		pidh, pidl, midh, midl;
>  	int		ret;
> @@ -817,7 +818,7 @@ static int ov6650_video_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	ret = ov6650_s_power(&priv->subdev, 1);
> +	ret = ov6650_s_power(sd, 1);
>  	if (ret < 0)
>  		goto eclkput;
>  
> @@ -855,7 +856,7 @@ static int ov6650_video_probe(struct i2c_client *client)
>  		ret = v4l2_ctrl_handler_setup(&priv->hdl);
>  
>  done:
> -	ov6650_s_power(&priv->subdev, 0);
> +	ov6650_s_power(sd, 0);
>  	if (!ret)
>  		return 0;
>  eclkput:
> @@ -943,6 +944,10 @@ static const struct v4l2_subdev_ops ov6650_subdev_ops = {
>  	.pad	= &ov6650_pad_ops,
>  };
>  
> +static const struct v4l2_subdev_internal_ops ov6650_internal_ops = {
> +	.registered = ov6650_video_probe,
> +};
> +
>  /*
>   * i2c_driver function
>   */
> @@ -1003,7 +1008,12 @@ static int ov6650_probe(struct i2c_client *client,
>  	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
>  	priv->colorspace  = V4L2_COLORSPACE_JPEG;
>  
> -	ret = ov6650_video_probe(client);
> +	priv->subdev.internal_ops = &ov6650_internal_ops;
> +	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +	snprintf(priv->subdev.name, sizeof(priv->subdev.name), "%s %d-%04x",
> +		 did->name, i2c_adapter_id(client->adapter), client->addr);

Could you use v4l2_i2c_subdev_set_name()?

> +
> +	ret = v4l2_async_register_subdev(&priv->subdev);
>  	if (ret)
>  		v4l2_ctrl_handler_free(&priv->hdl);
>  
> @@ -1015,7 +1025,7 @@ static int ov6650_remove(struct i2c_client *client)
>  	struct ov6650 *priv = to_ov6650(client);
>  
>  	v4l2_clk_put(priv->clk);
> -	v4l2_device_unregister_subdev(&priv->subdev);
> +	v4l2_async_unregister_subdev(&priv->subdev);
>  	v4l2_ctrl_handler_free(&priv->hdl);
>  	return 0;
>  }
> -- 
> 2.19.2
> 

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
