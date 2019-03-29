Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C6B218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfC2Sjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:39:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:47730 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbfC2Sjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:39:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 11:39:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,285,1549958400"; 
   d="scan'208";a="146409558"
Received: from lparisol-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.46.120])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2019 11:39:28 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 318F121E50; Fri, 29 Mar 2019 20:39:24 +0200 (EET)
Date:   Fri, 29 Mar 2019 20:39:24 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: ov6650: Move v4l2_clk_get() to
 ov6650_video_probe() helper
Message-ID: <20190329183923.t7sxzqf5qa4z3yfs@kekkonen.localdomain>
References: <20190325003501.14687-1-jmkrzyszt@gmail.com>
 <20190325003501.14687-2-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325003501.14687-2-jmkrzyszt@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janus,

Thanks for the patchset.

On Mon, Mar 25, 2019 at 01:35:00AM +0100, Janusz Krzysztofik wrote:
> In preparation for adding asynchronous subdevice support to the driver,
> don't acquire v4l2_clk from the driver .probe() callback as that may
> fail if the clock is provided by a bridge driver which may be not yet
> initialized.  Move the v4l2_clk_get() to ov6650_video_probe() helper
> which is going to be converted to v4l2_subdev_internal_ops.registered()
> callback, executed only when the bridge driver is ready.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/media/i2c/ov6650.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
> index c33fd584cb44..f10b8053ed73 100644
> --- a/drivers/media/i2c/ov6650.c
> +++ b/drivers/media/i2c/ov6650.c
> @@ -810,9 +810,16 @@ static int ov6650_video_probe(struct i2c_client *client)
>  	u8		pidh, pidl, midh, midl;
>  	int		ret;
>  
> +	priv->clk = v4l2_clk_get(&client->dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		ret = PTR_ERR(priv->clk);
> +		dev_err(&client->dev, "v4l2_clk request err: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = ov6650_s_power(&priv->subdev, 1);
>  	if (ret < 0)
> -		return ret;
> +		goto eclkput;
>  
>  	/*
>  	 * check and show product ID and manufacturer ID
> @@ -847,6 +854,11 @@ static int ov6650_video_probe(struct i2c_client *client)
>  
>  done:
>  	ov6650_s_power(&priv->subdev, 0);
> +	if (ret) {
> +eclkput:
> +		v4l2_clk_put(priv->clk);

Could you rework the error handling, please? Labels should be outside
conditionals. See e.g. the smiapp driver
(drivers/media/i2c/smiapp/smiapp-core.c). I've pushed my master branch
here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/log/>

The patch also does not apply on top of the media tree master + your
earlier patch cleanly.

> +	}
> +
>  	return ret;
>  }
>  
> @@ -989,18 +1001,9 @@ static int ov6650_probe(struct i2c_client *client,
>  	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
>  	priv->colorspace  = V4L2_COLORSPACE_JPEG;
>  
> -	priv->clk = v4l2_clk_get(&client->dev, NULL);
> -	if (IS_ERR(priv->clk)) {
> -		ret = PTR_ERR(priv->clk);
> -		goto eclkget;
> -	}
> -
>  	ret = ov6650_video_probe(client);
> -	if (ret) {
> -		v4l2_clk_put(priv->clk);
> -eclkget:
> +	if (ret)
>  		v4l2_ctrl_handler_free(&priv->hdl);
> -	}
>  
>  	return ret;
>  }

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
