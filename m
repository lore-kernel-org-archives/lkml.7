Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FD0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3131E218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PgFqdHK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfCVKMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:12:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58028 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfCVKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:12:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2MACWpk006917;
        Fri, 22 Mar 2019 05:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553249552;
        bh=a5BFW0ZexZTd5kUCcaCt98sCahj2yxbN9beRd9GDa7o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PgFqdHK7k/GT5xIZHDHZxwnNVGbsVZNLTOrtPD6EhyHcSEZ45h6+/jpW2ThbvFEnu
         JIdmo+c4E0Dz3CFQuKCHhQMIS6MQpawV2mg6OQsQ6Hnl4isfzzOjdDUWJsm/WPWR5G
         VZVH17ICus6CTOwycvu5ZpxF59yYV9m2aym067kw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2MACWSP055601
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 05:12:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 05:12:31 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 05:12:31 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2MACT6W019366;
        Fri, 22 Mar 2019 05:12:29 -0500
Subject: Re: [PATCH v2 01/15] drm/bridge: tc358767: Simplify tc_poll_timeout()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
 <20190322032901.12045-2-andrew.smirnov@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <97427148-0a1f-ceab-e95a-846f1b7924c9@ti.com>
Date:   Fri, 22 Mar 2019 12:12:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322032901.12045-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 05:28, Andrey Smirnov wrote:
> Implementation of tc_poll_timeout() is almost a 100% copy-and-paste of
> the code for regmap_read_poll_timeout(). Replace copied code with a
> call to the original. While at it change tc_poll_timeout to accept
> "struct tc_data *" instead of "struct regmap *" for brevity. No
> functional change intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
