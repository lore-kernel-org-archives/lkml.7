Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE43E20693
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k3CIxc8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfC2Jnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:43:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39708 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbfC2Jnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:43:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2T9gwA7070616;
        Fri, 29 Mar 2019 04:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553852578;
        bh=AAzBPtf/lf+VpBFBLV8+rGw3virlDGYzyhZqK3zltCE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k3CIxc8CPK8R+W6EOK8XbgR6dpsoSIyMoy0ssY+lI6+U+YrFg+p+OqplC7E8gJH8J
         L5BvXxXnIptPs64ZgzD4Jd8rMQu3YNEMpgkwpnqV5y2RoBPJs7XZiqRDnGveNoyW7h
         P95qODXvCFz0CCW7Uu7DLDFzIXYdzMkaveTRmbig=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2T9gwbJ050165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 04:42:58 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 04:42:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 04:42:57 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2T9gqt8100035;
        Fri, 29 Mar 2019 04:42:52 -0500
Subject: Re: [PATCH v7 0/4] drm: add support for Cadence MHDP DPI/DP bridge.
To:     Damian Kos <dkos@cadence.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Anil Joy Varughese <aniljoy@cadence.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "quentin.schulz@bootlin.com" <quentin.schulz@bootlin.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "Sarha, Jyri" <jsarha@ti.com>
References: <1548846209-16406-1-git-send-email-dkos@cadence.com>
 <0f11a4d8-d576-5af8-b7f4-afe3ff26678f@ti.com>
 <ce6ed2e6-90d5-fc7a-4d6d-ab27d62c5432@ti.com>
 <BYAPR07MB43111E34594899FC375D16BDCD580@BYAPR07MB4311.namprd07.prod.outlook.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <5f7a3cdf-b5b5-34ef-ca58-b75b9bc1c326@ti.com>
Date:   Fri, 29 Mar 2019 11:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB43111E34594899FC375D16BDCD580@BYAPR07MB4311.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 16:58, Damian Kos wrote:

> We would be very happy to have a separate driver for mhdp8546 instead of
> mixing it with Rockchip's driver. Unfortunately we need to have one driver
> for both IP's, so I'll just change mhdp8546.ko to cdns-mhdp.ko. (Unless,
> maintainers give us a green light for the dedicated driver?)

Ok. I don't know about the differences, so I can't say much here. But I
do think that you shouldn't combine drivers for two different IPs unless
they are very similar. And if two different IPs have a block that's the
same/similar, the code for that block can be extracted to a "library"
used by both drivers.

>>> I see some audio functions in the code, but it's not mentioned in the DT
>>> bindings. I'm not an audio guy, but the display bridges with audio
>>> support I have seen have had DT bindings for the audio source too. Is
>>> audio supported in the current driver?
>>>
> As far as I know, audio is working, but I can't double check it right now
> due to heavy load on my back right now. I'll try to find time for that in the
> next week. But, like I've mentioned earlier I don't see a reason why audio
> code (that exists in the mainline) wouldn't work.
> I'm not an audio guy myself. When updating dt bindings I took the dt bindings
> for other bridges as an example, but I did not see any bindings for audio in
> them. I didn't check all of them. Can you please let me know which bridges
> are you were referring to? In our test environment we didn't use any audio
> driver as audio generator is so simple that it is part of the register space
> of IP and we didn't even need to include this device in .dts file. Audio (like
> the video) is configured and enabled by code that is not included in the patch
> (for obvious reasons).
> So, in short, yes, driver supports audio and we will include description for
> audio input port in the dt bindings.

Ok. Jyri Sarha <jsarha@ti.com> recently sent "drm/bridge: sii902x:
HDMI-audio support and some fixes" series, and I think tda998x_drv.c
also has some audio support. But I'm no audio guy either =). I was just
curious about the status of the audio.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
