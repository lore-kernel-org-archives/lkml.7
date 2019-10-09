Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D299C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE1C206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HpC0QAbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfJINH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:07:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfJINH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:07:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99D4Zs5172377;
        Wed, 9 Oct 2019 13:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Oks/0v4+cEI4DXjuhEPuS+2hzvux1aGr0Tslm3/CeGs=;
 b=HpC0QAbNwrvFFWfScOjx2tUzw/VQXOGJ5gKbf+n0c/Z2/iCD/EsyXTWht5YQvpHsAJGa
 erYeNEqWgWnxdXDqPhILlYR47u1OTrMVcIpxKJhErgVdCqOA6p4W92ouLlb9rv5c45DT
 xkHaaPQ/rjGrh2Uu/bNmzykrdWGORRNTmUHALyYcbgcDK1oK5q8LgS+Nc5vQo9JsOOc1
 xDJ4Q5cyq1NRr8H/Wkh4bwy5gvchZZMNH/yJFjVaeRMQk1/GTY9qSZ1L/Rvrbs/XIUkj
 fGYq3N+WVEOBzcm7dyUzz9ES3DfzYoI5QqJP2qhE+YvVJ7dl2zXL3agKQhqucbq+9jxh Mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4qm8jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 13:07:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99D4ATS088871;
        Wed, 9 Oct 2019 13:07:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vgefcnett-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 13:07:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x99D6xac008352;
        Wed, 9 Oct 2019 13:07:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 06:06:59 -0700
Date:   Wed, 9 Oct 2019 16:06:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Message-ID: <20191009130645.GN25098@kadam>
References: <cover.1570588741.git.xji@analogixsemi.com>
 <6ad16e52cd7591d320001a842fc357d976006ef7.1570588741.git.xji@analogixsemi.com>
 <20191009113032.GL25098@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009113032.GL25098@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:30:32PM +0300, Dan Carpenter wrote:
> > +	platform = kzalloc(sizeof(*platform), GFP_KERNEL);
> > +	if (!platform) {
> > +		DRM_DEV_ERROR(dev, "failed to allocate driver data\n");
> > +		ret = -ENOMEM;
> > +		goto exit;
> 
> return -ENOMEM;
> 
> > +	}
> > +
> > +	pdata = &platform->pdata;
> > +
> > +	/* device tree parsing function call */
> > +	ret = anx7625_parse_dt(&client->dev, pdata);
> > +	if (ret != 0)	/* if occurs error */
> > +		goto err0;
> 
> != 0 is double negative.  Choose better label names.  Remove the obvious
> comment.
> 
> if (ret)
> 	goto free_platform;
> 
> > +
> > +	anx7625_init_gpio(platform);
> > +
> > +	/* to access global platform data */
> > +	platform->client = client;
> > +	i2c_set_clientdata(client, platform);
> > +
> > +	if (platform->pdata.extcon_supported) {
> > +		/* get extcon device from DTS */
> > +		platform->extcon = extcon_get_edev_by_phandle(&client->dev, 0);
> > +		if (PTR_ERR(platform->extcon) == -EPROBE_DEFER)
> > +			goto err0;
> 
> Preserve the error code.
> 
> > +		if (IS_ERR(platform->extcon)) {
> > +			DRM_DEV_ERROR(&client->dev,
> > +				      "can not get extcon device!");
> > +			goto err0;
> 
> Prerve the error code.
> 
> > +		}
> > +
> > +		ret = anx7625_extcon_notifier_init(platform);
> > +		if (ret < 0)
> > +			goto err0;
> > +	}
> > +
> > +	atomic_set(&platform->power_status, 0);
> > +
> > +	mutex_init(&platform->lock);
> > +
> > +	if (platform->pdata.gpio_intr_hpd) {
> > +		INIT_WORK(&platform->work, anx7625_work_func);
> > +		platform->workqueue = create_workqueue("anx7625_work");
> > +		if (!platform->workqueue) {
> > +			DRM_DEV_ERROR(dev, "failed to create work queue\n");
> > +			ret = -ENOMEM;
> > +			goto err1;
> 
> This goto will crash.  Because you have forgotten what the most recently
> allocated resource was.  It should be "goto free_platform;" still.
> 
> > +		}
> > +
> > +		platform->pdata.hpd_irq =
> > +			gpiod_to_irq(platform->pdata.gpio_intr_hpd);
> > +		if (platform->pdata.hpd_irq < 0) {
> > +			DRM_DEV_ERROR(dev, "failed to get gpio irq\n");
> > +			goto err1;
> 
> goto free_wq;
> 
> > +		}
> > +
> > +		ret = request_threaded_irq(platform->pdata.hpd_irq,
> > +					   NULL, anx7625_intr_hpd_isr,
> > +					   IRQF_TRIGGER_FALLING |
> > +					   IRQF_TRIGGER_RISING |
> > +					   IRQF_ONESHOT,
> > +					   "anx7625-hpd", platform);
> > +		if (ret < 0) {
> > +			DRM_DEV_ERROR(dev, "failed to request irq\n");
> > +			goto err1;
> > +		}
> > +
> > +		ret = irq_set_irq_wake(platform->pdata.hpd_irq, 1);
> > +		if (ret < 0) {
> > +			DRM_DEV_ERROR(dev, "Request irq for hpd");
> > +			DRM_DEV_ERROR(dev, "interrupt wake set fail\n");
> > +			goto err1;
> > +		}
> > +
> > +		ret = enable_irq_wake(platform->pdata.hpd_irq);
> > +		if (ret < 0) {
> > +			DRM_DEV_ERROR(dev, "Enable irq for HPD");
> > +			DRM_DEV_ERROR(dev, "interrupt wake enable fail\n");
> > +			goto err1;
> > +		}
> > +	}
> > +
> > +	if (anx7625_register_i2c_dummy_clients(platform, client) != 0) {
> 
> Preserve the error code.
> 
> 	ret = anx7625_register_i2c_dummy_clients();
> 	if (ret)
> 		goto free_platform;
> 

I meant goto free_wq here.  That's the most recent allocation.

regards,
dan carpenter

