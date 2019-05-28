Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6580C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE44208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jKZXaT5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfE1Kud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:50:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42586 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfE1Kud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:50:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4SAo9M5071145;
        Tue, 28 May 2019 05:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559040609;
        bh=3KI4TZCi5svmvrs/+WfaxacZZlvuTjo1DGtT0rt3dWA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=jKZXaT5vjwf3nk0m/96lzgkrJiflhp3wRwspDaqU2XvZVmj+06hjp/D/7qSOxA4fh
         Sr/q/h5y1kp62fONWkVhpP0HakggdKA5c7ztnHyAg9UV1BJ4opX9qMvGya2Xtv1Nt3
         1O38sDyVizyeYv7Q5gxjnv+cYJic/w/03BzKfr4w=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4SAo9XG043109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 05:50:09 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 05:50:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 05:50:09 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4SAo5Pl127389;
        Tue, 28 May 2019 05:50:06 -0500
Subject: Re: [PATCH] drm/omap: Make sure device_id tables are NULL terminated
To:     Thomas Meyer <thomas@m3y3r.de>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <1558989631144-20791398-0-diffsplit-thomas@m3y3r.de>
 <1558989631162-1860150863-1-diffsplit-thomas@m3y3r.de>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <7bb26068-36fe-33d2-b374-079cdedab76d@ti.com>
Date:   Tue, 28 May 2019 13:50:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558989631162-1860150863-1-diffsplit-thomas@m3y3r.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2019 23:41, Thomas Meyer wrote:
> Make sure (of/i2c/platform)_device_id tables are NULL terminated.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> @@ -198,6 +198,7 @@ static const struct of_device_id omapdss
>   	{ .compatible = "toppoly,td028ttec1" },
>   	{ .compatible = "tpo,td028ttec1" },
>   	{ .compatible = "tpo,td043mtea1" },
> +	{},
>   };
>   
>   static int __init omapdss_boot_init(void)
> 

Thanks! I've picked this up.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
