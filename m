Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E349CC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BB520883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y8t63eB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfDARRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:17:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59440 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfDARRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:35 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31HHQPJ006903;
        Mon, 1 Apr 2019 12:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554139046;
        bh=Hz+FzB7+XOKZvJ/ZefHXtkc3KP8cSOgTDsfAi3PyNdg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=y8t63eB0lF1QDLd21Qq/mzPPYU1a2Nn0xvoKw9eWrI6yKijWWWBLJMC31arF7DiU6
         nLnDkPdhGyRBRufm5uSusoUsuil41sZ1Dp3ipAtPABEz0gQF/hkaKqvp0aSI6bYQQi
         WvgzZjDMSBWkF1/g4deOQh+KcxzrDy+vby5dlX+Y=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31HHPIe100162
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 12:17:25 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 12:17:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 12:17:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31HHPe0122648;
        Mon, 1 Apr 2019 12:17:25 -0500
Date:   Mon, 1 Apr 2019 12:17:25 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <od@zcrc.me>
Subject: Re: [PATCH] usb: musb: Force-disable pullup on shutdown
Message-ID: <20190401171725.GK25852@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
References: <20190321144246.3547-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190321144246.3547-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:42:46PM +0100, Paul Cercueil wrote:
> When the musb is shutdown, for instance when the driver is unloaded,
> force-disable the pullup. Otherwise, the host will still see the gadget
> device even after the shutdown.

how would this happen?

when musb-hdrc driver is unloaded, udc core removes the bound gadget
driver which calls musb_gadget_pullup() to disable the pullup.

Regards,
-Bin.
