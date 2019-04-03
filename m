Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F27F206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GZhXroXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDCPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:47:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50964 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:47:01 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x33FksBY006711;
        Wed, 3 Apr 2019 10:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554306414;
        bh=1SxRNBxXqrGOtmIugPdYV1xoiQbhgHjw6Z3uheGLN0M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GZhXroXSkIwGPRUd2WxD35UEHVZwcGvE61vXpMJ7O0/3T/VIjbuFO6keo+tnEj/hH
         +8joeF2wN4CXgaMLsYwVdf14eSbq9j41qtaMHBdMR5bo/ZnQrCwHO3oKBuadAeWrd1
         X5DantRXzgdyqTAjFnbUe4uUqBVkjugaZAmNRwTU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x33Fkskb076745
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 10:46:54 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 10:46:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 10:46:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x33FksNF023012;
        Wed, 3 Apr 2019 10:46:54 -0500
Date:   Wed, 3 Apr 2019 10:46:54 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <od@zcrc.me>
Subject: Re: [PATCH] usb: musb: Force-disable pullup on shutdown
Message-ID: <20190403154654.GR25852@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
References: <20190321144246.3547-1-paul@crapouillou.net>
 <20190401171725.GK25852@uda0271908>
 <1554140782.10471.0@crapouillou.net>
 <20190401182008.GL25852@uda0271908>
 <1554235122.13181.0@crapouillou.net>
 <20190403132600.GQ25852@uda0271908>
 <1554305491.1177.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554305491.1177.0@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:31:31PM +0200, Paul Cercueil wrote:
> 
> 
> Le mer. 3 avril 2019 à 15:26, Bin Liu <b-liu@ti.com> a écrit :
> >On Tue, Apr 02, 2019 at 09:58:42PM +0200, Paul Cercueil wrote:
> >> Hi,
> >>
> >> Le lun. 1 avril 2019 à 20:20, Bin Liu <b-liu@ti.com> a écrit :
> >> >On Mon, Apr 01, 2019 at 07:46:22PM +0200, Paul Cercueil wrote:
> >> >>
> >> >>
> >> >> Le lun. 1 avril 2019 à 19:17, Bin Liu <b-liu@ti.com> a écrit :
> >> >> >On Thu, Mar 21, 2019 at 03:42:46PM +0100, Paul Cercueil wrote:
> >> >> >> When the musb is shutdown, for instance when the driver is
> >> >>unloaded,
> >> >> >> force-disable the pullup. Otherwise, the host will still see
> >> >> >>the gadget
> >> >> >> device even after the shutdown.
> >> >> >
> >> >> >how would this happen?
> >> >> >
> >> >> >when musb-hdrc driver is unloaded, udc core removes the bound
> >> >>gadget
> >> >> >driver which calls musb_gadget_pullup() to disable the pullup.
> >> >>
> >> >> I'm testing with the jz4740-musb driver. I don't unload the
> >> >>module (it's
> >> >> built-in) but unbind it from sysfs.
> >> >
> >> >I did unbind too.
> >> >
> >> >root@am335x-evm:/sys/bus/platform/drivers/musb-hdrc# echo
> >> >musb-hdrc.0 > unbind
> >> >
> >> >or unbind the glue driver:
> >> >
> >> >root@am335x-evm:/sys/bus/platform/drivers/musb-dsps# echo
> >> >47401400.usb > unbind
> >> >
> >> >musb_gadget_pullup() is called in both cases.
> >> >
> >> >[ 3880.597014] [<bf444ab0>] (musb_gadget_pullup [musb_hdrc]) from
> >> >[<bf402cbc>] (usb_gadget_disconnect+0x3c/0xf4 [udc_core])
> >> >[ 3880.607959] [<bf402cbc>] (usb_gadget_disconnect [udc_core])
> >> >from [<bf403b28>] (usb_gadget_remove_driver+0x4c/0x90 [udc_core])
> >> >[ 3880.619338] [<bf403b28>] (usb_gadget_remove_driver [udc_core])
> >> >from [<bf403d20>] (usb_del_gadget_udc+0x5c/0xc0 [udc_core])
> >>
> >> In my case this stops here, usb_del_gadget_udc() does not call
> >> usb_gadget_remove_driver(), that's why the pullup is never disabled.
> >>
> >> I guess that's because udc->driver is NULL; I'm testing with
> >
> >then the pullup should be disable by now.
> >
> >> CONFIG_USB_CONFIGFS,
> >> and I don't configure anything in sysfs before unbinding the driver.
> >
> >I didn't check on this, but I could imagine that
> >- when a configfs gadget is bound to the udc, .pullup() is called;
> >- when the configfs gadget is unbound from the udc, .pullup should be
> >  called again to disable the pullup.
> 
> An important thing that I did not mention, is that the SoC boots
> from USB,
> so the pullup is active before the musb driver loads. Since in my case a

It sounds to me that the musb driver should disable the pullup during
init.  Isn't it?

> configfs gadget is never bound, then .pullup() is never called, and when
> I unbind the driver the pullup is still enabled.

Regards,
-Bin.
