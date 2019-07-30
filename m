Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435DCC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C472064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PpasndDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfG3G2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:28:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43228 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbfG3G2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:28:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6U6SnuI045723;
        Tue, 30 Jul 2019 01:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564468129;
        bh=PLsC8/r/ZZEgAbNdLAv4EtCcWJ7e6fBvFcibZ2kPfTU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PpasndDWg0rr4B2SEIKXGNzQlkWnHMz6YikArudSUz1MLjK9tKRJqN1684l5tyTs0
         h9OAn2SGkrP97ZFZ3EFtMe0uyldYBuUZJqPA00Gmy7i/wJ6x8xz0+4/brmOAb30agC
         L6i0VXr89Gzke4aBF5+47UxqnkIZIglziteZp//c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6U6SnVP081171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 01:28:49 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 01:28:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 01:28:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6U6Sk8j101709;
        Tue, 30 Jul 2019 01:28:46 -0500
Subject: Re: [PATCH] gpu: drm/tilcdc: Fix switch case fallthrough
To:     Keerthy <j-keerthy@ti.com>, <jsarha@ti.com>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20190717050946.18488-1-j-keerthy@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <f378f2dc-6a74-35cc-a380-2eba0ebcf004@ti.com>
Date:   Tue, 30 Jul 2019 09:28:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717050946.18488-1-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2019 08:09, Keerthy wrote:
> Fix the below build warning/Error
> 
> drivers/gpu/drm/tilcdc/tilcdc_crtc.c: In function ‘tilcdc_crtc_set_mode’:
> drivers/gpu/drm/tilcdc/tilcdc_crtc.c:384:8: error: this statement may fall
> through [-Werror=implicit-fallthrough=]
>      reg |= LCDC_V2_TFT_24BPP_UNPACK;
>      ~~~~^~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/tilcdc/tilcdc_crtc.c:386:3: note: here
>     case DRM_FORMAT_BGR888:
>     ^~~~
> cc1: all warnings being treated as errors
> make[5]: *** [drivers/gpu/drm/tilcdc/tilcdc_crtc.o] Error 1
> make[4]: *** [drivers/gpu/drm/tilcdc] Error 2
> make[4]: *** Waiting for unfinished jobs....
> 
> Fixes: f6382f186d2982750 ("drm/tilcdc: Add tilcdc_crtc_mode_set_nofb()")
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
