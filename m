Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F4EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B9C22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 05:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A4qO+TJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfH1FsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 01:48:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45838 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfH1FsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 01:48:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7S5m72M090170;
        Wed, 28 Aug 2019 00:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566971287;
        bh=5iPmxBNFAmOe0sdDGNM9TCYJMd88VRMWnVdbR8bUhvg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A4qO+TJ0Jq9LOoJtcXrrEA6nfYdOBINWyppibfvcLKE6u6lwXaqYXu+6p1wbl4BFs
         Mcna+9Kd7RlNkazujE6sMel6xxI7mgmQBY8y3hK/KpmEiuJdWG5ralYZyhoCoZjZIa
         IvdNY5LZeOcPfoIt/asrRgHR92q9JO2Kz0EKCr0Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7S5m7Lo094179
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Aug 2019 00:48:07 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 28
 Aug 2019 00:48:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 28 Aug 2019 00:48:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7S5m4AD011070;
        Wed, 28 Aug 2019 00:48:05 -0500
Subject: Re: [PATCH] drm/bridge: tc358767: Expose test mode functionality via
 debugfs
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190826182524.5064-1-andrew.smirnov@gmail.com>
 <20190826220807.GK5031@pendragon.ideasonboard.com>
 <CAHQ1cqHuJNTH=HDfEP9de0Df_D45VV034riH4J3+ix23v=aM4Q@mail.gmail.com>
 <20190827080644.GF5054@pendragon.ideasonboard.com>
 <CAHQ1cqHqKvjB51UUbAHcm-=vp1O2-ncE23H8UuOz5gUJDP1wXQ@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <75c9c9b2-b5b2-44bc-3ffa-e69e069cf2bd@ti.com>
Date:   Wed, 28 Aug 2019 08:48:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHqKvjB51UUbAHcm-=vp1O2-ncE23H8UuOz5gUJDP1wXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 01:51, Andrey Smirnov wrote:

>> The whole point of a
>> driver is to avoid needing detailed knowledge of the device's internals
>> in userspace.
>>
> 
> You won't avoid needing detailed knowledge of the device's internals
> if you don't have a priori knowledge in the form of a agreed upon/well
> known abstraction you are exposing from the driver. There is no such
> abstraction in this case. Whether you present "tstctl" that takes a
> magic value or "red", "green", "blue" and "pattern" taking numbers and
> special strings, as a user, you still would have to go read the driver
> code in order to figure out how that stuff works.
> 
> Given how this is an obscure _debug_ feature for a niche part, I think
> exposing raw register and leaving a comment in the driver source code
> explaining how it works is reasonably user-friendly (for all 10 - 15
> unique users that this feature would ever have).
> 
> To avoid any further back and forth of this subject, how about the
> following. If this is up to me, then I'd like to move forward to v2
> with the interface as is. If you feel strongly about this and insist
> on your vision of the interface, please let me know what it looks like
> (e.g. is what I described above good enough) and I'll rework v2 to
> have that.

I agree, I don't see a point in adding a pile of code to make a device 
specific debug feature to hide the device internals. If someone is going 
to use this feature, most likely he either has the datasheet or he has 
been asked by someone with the datasheet to try the feature.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
