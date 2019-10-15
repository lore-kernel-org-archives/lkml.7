Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8F1ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0856217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qr7X/dmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfJOJUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:20:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33360 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfJOJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:20:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9F9DCsw015460;
        Tue, 15 Oct 2019 09:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=XOS9EXMDrfcapa0yCPVW2tWQBekI+jT6QODKtdRu1OU=;
 b=Qr7X/dmJF+BJSy/GF+LmiqYPiI+bOcgWHfpXFx/5BLQ6rY4195UOzl0XLlo993ZEA5j3
 6nI7jwwM2pGULD13DKQRxvmtC76O8SlY9peYOEUcdupYGw52asJDIxLFPMdUe7DbdzFZ
 A0Mmjkwxv6LNYGWWYJm+EtDbhSUgOrbbUh4piVJWdYGu7kxyRJbOkk9GzowxQjvFIiNk
 JOMHwxkSnPB1PECWXFjn4AsQnzAnMIht/SOl3vWpQ7cTyn2Tdt8vpIKu1x1/CUvthX6+
 B7jI+RzhhZ6dQxmvyLZenQFzC+707MWvqQEvdezbZSa2KJuveo6jNiFlXKdq3P5noZ1g JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vk68ueh7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 09:19:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9F98DWJ147688;
        Tue, 15 Oct 2019 09:19:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vnb0erxc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 09:19:39 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9F9JV6N021786;
        Tue, 15 Oct 2019 09:19:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 09:19:30 +0000
Date:   Tue, 15 Oct 2019 12:19:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Xin Ji <xji@analogixsemi.com>
Cc:     kbuild-all@lists.01.org,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Message-ID: <20191015091921.GC21344@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55295c49503a963f3417b917fd7163feb26ed0b6.1570760115.git.xji@analogixsemi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[  These are automated text from the 0-day bot -dan ]

Hi Xin,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Xin-Ji/dt-bindings-drm-bridge-anx7625-MIPI-to-DP-transmitter-binding/20191014-043019

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/bridge/analogix/anx7625.c:1274 anx7625_start_dp_work() error: uninitialized symbol 'sp_tx_lane_count'.

# https://github.com/0day-ci/linux/commit/152a82b6747f10d6c13c7a422173947c2f2e1aa2
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 152a82b6747f10d6c13c7a422173947c2f2e1aa2
vim +/sp_tx_lane_count +1274 drivers/gpu/drm/bridge/analogix/anx7625.c

152a82b6747f10 Xin Ji 2019-10-11  1253  static void anx7625_start_dp_work(struct anx7625_data *ctx)
152a82b6747f10 Xin Ji 2019-10-11  1254  {
152a82b6747f10 Xin Ji 2019-10-11  1255  	int ret;
152a82b6747f10 Xin Ji 2019-10-11  1256  	u8 buf[MAX_DPCD_BUFFER_SIZE];
152a82b6747f10 Xin Ji 2019-10-11  1257  	u8 hdcp_cap;
152a82b6747f10 Xin Ji 2019-10-11  1258  	struct device *dev = &ctx->client->dev;
152a82b6747f10 Xin Ji 2019-10-11  1259  	u8 sp_tx_bw; /* linktraining banwidth */
152a82b6747f10 Xin Ji 2019-10-11  1260  	u8 sp_tx_lane_count; /* link training lane count */
152a82b6747f10 Xin Ji 2019-10-11  1261  
152a82b6747f10 Xin Ji 2019-10-11  1262  	if (ctx->hpd_high_cnt >= 2) {
152a82b6747f10 Xin Ji 2019-10-11  1263  		DRM_DEV_DEBUG_DRIVER(dev, "anx7625 filter useless HPD\n");
152a82b6747f10 Xin Ji 2019-10-11  1264  		return;
152a82b6747f10 Xin Ji 2019-10-11  1265  	}
152a82b6747f10 Xin Ji 2019-10-11  1266  
152a82b6747f10 Xin Ji 2019-10-11  1267  	ctx->hpd_high_cnt++;
152a82b6747f10 Xin Ji 2019-10-11  1268  
152a82b6747f10 Xin Ji 2019-10-11  1269  	sp_tx_get_rx_bw(ctx, &sp_tx_bw);
152a82b6747f10 Xin Ji 2019-10-11  1270  
152a82b6747f10 Xin Ji 2019-10-11  1271  	sp_tx_aux_dpcdread_bytes(ctx, 0x00, 0x00, DPCD_MAX_LANE_COUNT,
152a82b6747f10 Xin Ji 2019-10-11  1272  				 1, &sp_tx_lane_count);
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Smatch thinks sp_tx_aux_dpcdread_bytes() can fail and we don't check
for errors.

152a82b6747f10 Xin Ji 2019-10-11  1273  
152a82b6747f10 Xin Ji 2019-10-11 @1274  	sp_tx_lane_count = sp_tx_lane_count & 0x1f;
152a82b6747f10 Xin Ji 2019-10-11  1275  	sp_tx_aux_dpcdread_bytes(ctx, 0x06, 0x80, 0x28, 1, buf);/* read Bcap */
152a82b6747f10 Xin Ji 2019-10-11  1276  
152a82b6747f10 Xin Ji 2019-10-11  1277  	hdcp_cap = buf[0] & 0x01;
152a82b6747f10 Xin Ji 2019-10-11  1278  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
