Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCA8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC7D20663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vcegoY05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfLIJi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:38:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52302 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLIJi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:38:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB99cgDA086815;
        Mon, 9 Dec 2019 03:38:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575884322;
        bh=oqaWO0NPBKmyeLqC24LmgGny4o2Jfye2gEw2ZGBx4rY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vcegoY05FwzGDm0/docJe+rjQ+79dAnO/Upmj5EQ1TdOxaRl8mehfJMVRNOzzchL5
         gDZrYMU5422klUz478q/ze5VQkkETK5J630Q22kNEUkvMv3DkB5kk6OgA0+BvohinY
         V8EnMlbUQKsWPVI9XM1s0ZvfPkwRPbQy1yAxWnjk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB99cg0F034198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 03:38:42 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 03:38:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 03:38:42 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB99cdB3083025;
        Mon, 9 Dec 2019 03:38:40 -0600
Subject: Re: [PATCH v3 2/2] drm/bridge: tc358767: Expose test mode
 functionality via debugfs
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
References: <20191209050857.31624-1-andrew.smirnov@gmail.com>
 <20191209050857.31624-3-andrew.smirnov@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <45afdff8-4f91-f5be-a299-d0c7fed71ea7@ti.com>
Date:   Mon, 9 Dec 2019 11:38:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209050857.31624-3-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc'ing Daniel for the last paragraph)

On 09/12/2019 07:08, Andrey Smirnov wrote:
> Presently, the driver code artificially limits test pattern mode to a
> single pattern with fixed color selection. It being a kernel module
> parameter makes switching "test pattern" <-> "proper output" modes
> on-the-fly clunky and outright impossible if the driver is built into
> the kernel.

That's not correct, /sys/module/tc358767/parameters/test is there even if the driver is built-in.

I think the bigger problems are that there's just one value, even if there are multiple devices, and 
that with kernel parameter the driver can't act on it dynamically (afaik).

> To improve the situation a bit, convert current test pattern code to
> use debugfs instead by exposing "TestCtl" register. This way old
> "tc_test_pattern=1" functionality can be emulated via:
> 
>      echo -n 0x78146302 > tstctl
> 
> and switch back to regular mode can be done with:
> 
>      echo -n 0x78146300 > tstctl

In the comment in the code you have 0 as return-to-regular-mode.

With my setup, enabling test mode seems to work, but when I return to regular mode, the first echo 
results in black display, but echoing 0 a second time will restore the display.

Hmm, actually, just echoing 0 to tstctl multiple times, it makes the screen go black and then 
restores it with every other echo.

> +	debugfs = debugfs_create_dir(dev_name(dev), NULL);
> +	if (!IS_ERR(debugfs)) {
> +		debugfs_create_file_unsafe("tstctl", 0200, debugfs, tc,
> +					   &tc_tstctl_fops);
> +		devm_add_action_or_reset(dev, tc_remove_debugfs, debugfs);
> +	}
> +

For me this creates debugfs/3-000f/tstctl. I don't think that's a clear or usable path, and could 
even cause a name conflict in the worst case.

Not sure what's a good solution here, but only two semi-good ones come to mind: have it in sysfs 
under the device's dir, or debugfs/dri/something. The latter probably needs some thought and common 
agreement on how to handle bridge and panel debugfs files. But that would be a good thing to have, 
as I'm sure there are other similar cases (at least I have a few).

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
