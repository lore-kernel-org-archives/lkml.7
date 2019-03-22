Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1289C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98803206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gKXTWob7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfCVIGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:06:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53694 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfCVIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:06:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2M8625l004159;
        Fri, 22 Mar 2019 03:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553241962;
        bh=XRP07dl9X1HSTKLkw6K2+RYCT5/tkAjMnOC/BJ7lpQo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gKXTWob7slXnZ2nVMh6t7QQL8OeQ9gdDQ3kLfWSMKx3OOO4GOIr5sDKSJvXHnwYoA
         xgnAEvTkpPEJ4ZoJzAQ5I+lNEL/PzczLp1uhW1wOdHgSQb7BUCBF5Q/4oLyv37j+Nu
         LwKgPJXSpdUn4v+a3D/feHCvNgdjzd/aRu3nJfKM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2M862cs034927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Mar 2019 03:06:02 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 22
 Mar 2019 03:06:01 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 22 Mar 2019 03:06:00 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2M85wKl006779;
        Fri, 22 Mar 2019 03:05:59 -0500
Subject: Re: [PATCH v2 00/15] tc358767 driver improvements
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        <dri-devel@lists.freedesktop.org>
CC:     Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <13bb7213-54bd-b38b-57ad-c8adc7950200@ti.com>
Date:   Fri, 22 Mar 2019 10:05:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/03/2019 05:28, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains various improvements (at least in my mind) and
> fixes that I made to tc358767 while working with the code of the
> driver. Hopefuly each patch is self explanatory.
> 
> Feedback is welcome!

Ah, I hadn't realized there was another series for tc358767 going
around. I should've checked dri-devel list. Sorry about that!

I'm not able to apply your patches, it fails at "Simplify
tc_set_video_mode()", even if I think I've got the exact same base as
you have.

Can you push your branch somewhere?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
