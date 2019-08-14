Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B8C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E3E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TZd4nJXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfHNXD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:03:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58014 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfHNXD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:03:58 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A05F22B2;
        Thu, 15 Aug 2019 01:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1565823836;
        bh=7rjq1+WTQtEBslyTncl52343F+jqivZznNsMY2CvsXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZd4nJXuM7XtZmPpE5gUnKffirX+JpaOI3qZQYJ5TbAFStRsbXLH/+iEtGzY/WLNX
         AP7xiFzkav6Ecs4GiT8OOsf4vlhJ8GdSmt3uY0Xx/s6Is+/qKqZKdXIKo5ClDYD7ah
         cQcpb6ZVsEuPKGeWIbSgXSBnF15jZIm40EAo2VtM=
Date:   Thu, 15 Aug 2019 02:03:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 4/5] media: i2c: ov5670: Report the camera location
Message-ID: <20190814230353.GF5015@pendragon.ideasonboard.com>
References: <20190814202815.32491-1-jacopo@jmondi.org>
 <20190814202815.32491-5-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190814202815.32491-5-jacopo@jmondi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Wed, Aug 14, 2019 at 10:28:14PM +0200, Jacopo Mondi wrote:
> The camera location is retrieved from the firmware interface parsing
> the "location" device property and reported through the read-only
> V4L2_CID_LOCATION control.
> 
> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  drivers/media/i2c/ov5670.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
> index 041fcbb4eebd..1446aef1fc1e 100644
> --- a/drivers/media/i2c/ov5670.c
> +++ b/drivers/media/i2c/ov5670.c
> @@ -2059,10 +2059,12 @@ static const struct v4l2_ctrl_ops ov5670_ctrl_ops = {
>  /* Initialize control handlers */
>  static int ov5670_init_controls(struct ov5670 *ov5670)
>  {
> +	struct i2c_client *client = v4l2_get_subdevdata(&ov5670->sd);
>  	struct v4l2_ctrl_handler *ctrl_hdlr;
>  	s64 vblank_max;
>  	s64 vblank_def;
>  	s64 vblank_min;
> +	u32 location;
>  	s64 exposure_max;
>  	int ret;
>  
> @@ -2124,6 +2126,15 @@ static int ov5670_init_controls(struct ov5670 *ov5670)
>  				     ARRAY_SIZE(ov5670_test_pattern_menu) - 1,
>  				     0, 0, ov5670_test_pattern_menu);
>  
> +	ret = device_property_read_u32(&client->dev, "location", &location);
> +	if (!ret) {
> +		v4l2_ctrl_new_std(ctrl_hdlr, &ov5670_ctrl_ops,
> +				  V4L2_CID_LOCATION, V4L2_LOCATION_FRONT,
> +				  V4L2_LOCATION_BACK, 1,
> +				  location == V4L2_LOCATION_FRONT ?
> +				  V4L2_LOCATION_FRONT : V4L2_LOCATION_BACK);
> +	}
> +

As most camera sensors should do this, I think it would make sense to
create a helper function. We could add parsing of other standard
sensor-related controls there (such as the link frequencies), and also
create the pixel rate control.

>  	if (ctrl_hdlr->error) {
>  		ret = ctrl_hdlr->error;
>  		goto error;

-- 
Regards,

Laurent Pinchart
