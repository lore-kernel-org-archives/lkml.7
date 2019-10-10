Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC0FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF9E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oRIjXMqz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbfJJJyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:54:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36210 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfJJJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:54:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A9pSWI018551;
        Thu, 10 Oct 2019 09:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=O9jqPg9T1QShiR+fwjuMaDwdClMkwHtRLy1Yhznc3qU=;
 b=oRIjXMqz/gl3+axIiDCTYCXWfZykg9EDDf0xYzsZ6pcw7Fbt9uEZsFpIOV3RKX+VO4Gd
 7IP42+diWQv2UxnkmIxklf4KTKz9WcBns49+Eiin2dlm6QSMR0pd0A+p0rndj+DT/gVw
 o5L8TB1X0tIXo2cHL5QBsBsJ3GsMxJgLxAK4ExiYcEQAZIwpk+ihRzwFhqdjpE7KuvPB
 TKyZcv0erK+fvT0SzrtyLobfYjpUh/XQNnYSV6URtcsSZKq6w+JP44/t7feZJteE/6cV
 S+6/ZDDrxjlkRaGX8/DBQ82T+SDF7Q6WpVMXZjrLBA8sKRAUEmd2CWiq+/nn8RDjWp5v UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vektrsudn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:53:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A9hE1Y162309;
        Thu, 10 Oct 2019 09:53:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vh5ccuj7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:53:30 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9A9rO09021352;
        Thu, 10 Oct 2019 09:53:24 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 02:53:23 -0700
Date:   Thu, 10 Oct 2019 12:53:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Message-ID: <20191010095315.GK13286@kadam>
References: <cover.1570699576.git.xji@analogixsemi.com>
 <43f48a7036e5a2991bd6bd8a7361107b27e48c54.1570699576.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f48a7036e5a2991bd6bd8a7361107b27e48c54.1570699576.git.xji@analogixsemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is *so* much nicer than before.  I hope you feel good about
the changes.  It makes me happy to look at this code now.

On Thu, Oct 10, 2019 at 09:34:19AM +0000, Xin Ji wrote:
> +static int edid_read(struct anx7625_data *ctx,
> +		     u8 offset, u8 *pblock_buf)
> +{
> +	int ret, cnt;
> +	struct device *dev = &ctx->client->dev;
> +
> +	for (cnt = 0; cnt < EDID_TRY_CNT; cnt++) {
> +		sp_tx_aux_wr(ctx, offset);
> +		/* set I2C read com 0x01 mot = 0 and read 16 bytes */
> +		ret = sp_tx_aux_rd(ctx, 0xf1);
> +
> +		if (ret) {
> +			sp_tx_rst_aux(ctx);
> +			DRM_DEV_DEBUG_DRIVER(dev, "edid read failed, reset!\n");
> +			cnt++;

I don't think you should increment cnt.  It's just a counter.

> +		} else {
> +			ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
> +						     AP_AUX_BUFF_START,
> +						     MAX_DPCD_BUFFER_SIZE,
> +						     pblock_buf);
> +			if (!ret)
> +				break;
> +		}
> +	}
> +
> +	if (cnt == EDID_TRY_CNT)

And it could mean that "cnt > EDID_TRY_CNT".

> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int segments_edid_read(struct anx7625_data *ctx,
> +			      u8 segment, u8 *buf, u8 offset)
> +{
> +	u8 cnt;
> +	int ret;
> +	struct device *dev = &ctx->client->dev;
> +
> +	/* write address only */
> +	ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +				AP_AUX_ADDR_7_0, 0x30);
> +	ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +				 AP_AUX_COMMAND, 0x04);
> +	ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +				 AP_AUX_CTRL_STATUS,
> +				 AP_AUX_CTRL_ADDRONLY | AP_AUX_CTRL_OP_EN);
> +
> +	ret |= wait_aux_op_finish(ctx);
> +	/* write segment address */
> +	ret |= sp_tx_aux_wr(ctx, segment);
> +	/* data read */
> +	ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +				 AP_AUX_ADDR_7_0, 0x50);
> +	if (ret) {
> +		DRM_ERROR("IO error : aux initial failed.\n");
> +		return ret;
> +	}
> +
> +	for (cnt = 0; cnt < EDID_TRY_CNT; cnt++) {
> +		sp_tx_aux_wr(ctx, offset);
> +		/* set I2C read com 0x01 mot = 0 and read 16 bytes */
> +		ret = sp_tx_aux_rd(ctx, 0xf1);
> +
> +		if (ret) {
> +			ret = sp_tx_rst_aux(ctx);
> +			DRM_DEV_ERROR(dev, "segment read failed, reset!\n");
> +			cnt++;

Same.

> +		} else {
> +			ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
> +						     AP_AUX_BUFF_START,
> +						     MAX_DPCD_BUFFER_SIZE, buf);
> +			if (!ret)
> +				break;
> +		}
> +	}
> +
> +	if (cnt == EDID_TRY_CNT)
> +		return -EIO;
> +
> +	return 0;
> +}

regards,
dan carpenter
