Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA5321EF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rPqKTEz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbfHGS55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:57:57 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58252 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388728AbfHGS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:57:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77IvY7d030044;
        Wed, 7 Aug 2019 13:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565204254;
        bh=SobSK+XTRicwfT84j/gf9bC0ofQzxtzKQ+T13Ia7Pog=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rPqKTEz98nrXfblvTVhzbNhq7nf7N4Q/BI+tflArw/rUt2/Qo9KvUQcMBGlAOFOlR
         skm/wdshS+IZbJ/gBnhwtvifvagHSvHRijeqXAzFes1xU2+/9IXb2cQMcJF+7koDFb
         m+SwQh9ipFfQEVSAfViAPaHhkQzQ70N0dgn6LUzU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77IvYC9108583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 13:57:34 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 13:57:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 13:57:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77IvY7d061832;
        Wed, 7 Aug 2019 13:57:34 -0500
Date:   Wed, 7 Aug 2019 13:57:34 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Mans Rullgard <mans@mansr.com>
CC:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH] usb: musb: sunxi: propagate devicetree node to
 glue pdev
Message-ID: <20190807185734.GA14027@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Mans Rullgard <mans@mansr.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190806113458.3304-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190806113458.3304-1-mans@mansr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 12:34:58PM +0100, Mans Rullgard wrote:
> In order for devicetree nodes to be correctly associated with attached
> devices, the controller node needs to be propagated to the glue device.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied. Thanks.

-Bin.

