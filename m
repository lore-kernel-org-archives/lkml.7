Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91177C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD8C20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfDBIYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:24:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:3338 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfDBIYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:24:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 01:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="scan'208";a="139410754"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2019 01:24:13 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 2E339205BA; Tue,  2 Apr 2019 11:24:12 +0300 (EEST)
Date:   Tue, 2 Apr 2019 11:24:12 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] media: ov6650: Register with asynchronous
 subdevice framework
Message-ID: <20190402082411.nakjtcxu2ggbb472@paasikivi.fi.intel.com>
References: <20190329202903.5622-1-jmkrzyszt@gmail.com>
 <20190330010610.15094-1-jmkrzyszt@gmail.com>
 <20190330010610.15094-3-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330010610.15094-3-jmkrzyszt@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Sat, Mar 30, 2019 at 02:06:10AM +0100, Janusz Krzysztofik wrote:
> Register V4L2 subdevice implemented by the driver to the V4L2
> asynchronous subdevice framework.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/media/i2c/ov6650.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
> index de7d9790f054..7145bb68a9e1 100644
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
> @@ -1003,7 +1008,11 @@ static int ov6650_probe(struct i2c_client *client,
>  	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
>  	priv->colorspace  = V4L2_COLORSPACE_JPEG;
>  
> -	ret = ov6650_video_probe(client);
> +	priv->subdev.internal_ops = &ov6650_internal_ops;
> +	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +	v4l2_i2c_subdev_set_name(&priv->subdev, client, NULL, NULL);

I missed that v4l2_i2c_subdev_init() already calls
v4l2_i2c_subdev_set_name(), so it can be removed from the driver. I've made
the change to the applied patch:

diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index 7145bb68a9e1..1b972e591b48 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -1010,7 +1010,6 @@ static int ov6650_probe(struct i2c_client *client,
 
 	priv->subdev.internal_ops = &ov6650_internal_ops;
 	priv->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
-	v4l2_i2c_subdev_set_name(&priv->subdev, client, NULL, NULL);
 
 	ret = v4l2_async_register_subdev(&priv->subdev);
 	if (ret)


> +
> +	ret = v4l2_async_register_subdev(&priv->subdev);
>  	if (ret)
>  		v4l2_ctrl_handler_free(&priv->hdl);
>  
> @@ -1015,7 +1024,7 @@ static int ov6650_remove(struct i2c_client *client)
>  	struct ov6650 *priv = to_ov6650(client);
>  
>  	v4l2_clk_put(priv->clk);
> -	v4l2_device_unregister_subdev(&priv->subdev);
> +	v4l2_async_unregister_subdev(&priv->subdev);
>  	v4l2_ctrl_handler_free(&priv->hdl);
>  	return 0;
>  }

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
