Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC13C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408B42054F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/hpIkYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfJJJ6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:58:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41458 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbfJJJ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:58:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A9pM40018431;
        Thu, 10 Oct 2019 09:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bZLQHgADENUAKtzY+jcRvaI+uF1F1KYVnt4wJndku4I=;
 b=k/hpIkYg9Ktkz0dc2+f3ehhOPH7fd6JWtAhLNq8vRZowj/mYK4SVB7XtMT2CV7D07NwK
 QmJQlluTMewhCX2naksqj1tJfwnty+TQcZjyaPuYhtVBglVGxtydG1r0aUS/Pu0QBiXX
 d6WMbAQDiY8loy6b+bInfYQ3mdb7TtJwXidz8D2ZNCAdzNvmT/jG7qB3KsnD2+nQYbAB
 QKSEdoZCEUkGd101/WkL1MM4j250ellwvGuleftvp30gl8nnDXEKiz3LfXUXZUspMZvk
 Qxg07UPNBUIeWZvfjxqTvRLZe4dmq6FBPVOjvPO6SmyMZQY/DS5mDnE5C7L4aF07oU0H Rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vektrsv69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:58:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A9spb1155142;
        Thu, 10 Oct 2019 09:56:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vh8k2j7g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:56:30 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9A9uRMx024510;
        Thu, 10 Oct 2019 09:56:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 09:56:26 +0000
Date:   Thu, 10 Oct 2019 12:56:17 +0300
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
Message-ID: <20191010095617.GL13286@kadam>
References: <cover.1570699576.git.xji@analogixsemi.com>
 <43f48a7036e5a2991bd6bd8a7361107b27e48c54.1570699576.git.xji@analogixsemi.com>
 <20191010095315.GK13286@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010095315.GK13286@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100088
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

On Thu, Oct 10, 2019 at 12:53:15PM +0300, Dan Carpenter wrote:
> This code is *so* much nicer than before.  I hope you feel good about
> the changes.  It makes me happy to look at this code now.
> 
> On Thu, Oct 10, 2019 at 09:34:19AM +0000, Xin Ji wrote:
> > +static int edid_read(struct anx7625_data *ctx,
> > +		     u8 offset, u8 *pblock_buf)
> > +{
> > +	int ret, cnt;
> > +	struct device *dev = &ctx->client->dev;
> > +
> > +	for (cnt = 0; cnt < EDID_TRY_CNT; cnt++) {
                                          ^^^^^

> > +		sp_tx_aux_wr(ctx, offset);
> > +		/* set I2C read com 0x01 mot = 0 and read 16 bytes */
> > +		ret = sp_tx_aux_rd(ctx, 0xf1);
> > +
> > +		if (ret) {
> > +			sp_tx_rst_aux(ctx);
> > +			DRM_DEV_DEBUG_DRIVER(dev, "edid read failed, reset!\n");
> > +			cnt++;
                        ^^^^^

I mean that it's incremented twice, yeah?

regards,
dan carpenter

