Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D84C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C122084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bVYVxQgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDCSya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:54:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37780 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:54:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x33IsNbQ087492;
        Wed, 3 Apr 2019 13:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554317664;
        bh=8ja4jQk473PWfS3bvTNVH8/cLMGVdPkw04qDoaKXOlA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bVYVxQgCb5k7nXga1ivUWdmQyredobK0JqvUjPEOWu48xR2Mt0TsiLcH2HK4wYRln
         pvOU4XnNwsoRUeSK4Yyv5vQNOGXFGO3Ih+K/bi92Z1K4ZEaUbrgqsOAjKb6QfK8r6S
         8kfUZxTl+u+YOjRi727o9Q+LORn04yDNorRpgAaU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x33IsN3a075306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 13:54:24 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 13:54:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 13:54:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x33IsNV6060964;
        Wed, 3 Apr 2019 13:54:23 -0500
Date:   Wed, 3 Apr 2019 13:54:23 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <od@zcrc.me>
Subject: Re: [PATCH] usb: musb: Force-disable pullup on shutdown
Message-ID: <20190403185423.GS25852@uda0271908>
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
 <20190403154654.GR25852@uda0271908>
 <1554306740.1177.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554306740.1177.1@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:52:20PM +0200, Paul Cercueil wrote:
> 
> 
> Le mer. 3 avril 2019 à 17:46, Bin Liu <b-liu@ti.com> a écrit :
> >On Wed, Apr 03, 2019 at 05:31:31PM +0200, Paul Cercueil wrote:
> >>
> >>
> >> Le mer. 3 avril 2019 à 15:26, Bin Liu <b-liu@ti.com> a écrit :
> >> >On Tue, Apr 02, 2019 at 09:58:42PM +0200, Paul Cercueil wrote:
> >> >> Hi,
> >> >>
> >> >> Le lun. 1 avril 2019 à 20:20, Bin Liu <b-liu@ti.com> a écrit :
> >> >> >On Mon, Apr 01, 2019 at 07:46:22PM +0200, Paul Cercueil wrote:
> >> >> >>
> >> >> >>
> >> >> >> Le lun. 1 avril 2019 à 19:17, Bin Liu <b-liu@ti.com> a
> >>écrit :
> >> >> >> >On Thu, Mar 21, 2019 at 03:42:46PM +0100, Paul Cercueil
> >>wrote:
> >> >> >> >> When the musb is shutdown, for instance when the driver is
> >> >> >>unloaded,
> >> >> >> >> force-disable the pullup. Otherwise, the host will
> >>still see
> >> >> >> >>the gadget
> >> >> >> >> device even after the shutdown.
> >> >> >> >
> >> >> >> >how would this happen?
> >> >> >> >
> >> >> >> >when musb-hdrc driver is unloaded, udc core removes the bound
> >> >> >>gadget
> >> >> >> >driver which calls musb_gadget_pullup() to disable the
> >>pullup.
> >> >> >>
> >> >> >> I'm testing with the jz4740-musb driver. I don't unload the
> >> >> >>module (it's
> >> >> >> built-in) but unbind it from sysfs.
> >> >> >
> >> >> >I did unbind too.
> >> >> >
> >> >> >root@am335x-evm:/sys/bus/platform/drivers/musb-hdrc# echo
> >> >> >musb-hdrc.0 > unbind
> >> >> >
> >> >> >or unbind the glue driver:
> >> >> >
> >> >> >root@am335x-evm:/sys/bus/platform/drivers/musb-dsps# echo
> >> >> >47401400.usb > unbind
> >> >> >
> >> >> >musb_gadget_pullup() is called in both cases.
> >> >> >
> >> >> >[ 3880.597014] [<bf444ab0>] (musb_gadget_pullup
> >>[musb_hdrc]) from
> >> >> >[<bf402cbc>] (usb_gadget_disconnect+0x3c/0xf4 [udc_core])
> >> >> >[ 3880.607959] [<bf402cbc>] (usb_gadget_disconnect [udc_core])
> >> >> >from [<bf403b28>] (usb_gadget_remove_driver+0x4c/0x90
> >>[udc_core])
> >> >> >[ 3880.619338] [<bf403b28>] (usb_gadget_remove_driver
> >>[udc_core])
> >> >> >from [<bf403d20>] (usb_del_gadget_udc+0x5c/0xc0 [udc_core])
> >> >>
> >> >> In my case this stops here, usb_del_gadget_udc() does not call
> >> >> usb_gadget_remove_driver(), that's why the pullup is never
> >>disabled.
> >> >>
> >> >> I guess that's because udc->driver is NULL; I'm testing with
> >> >
> >> >then the pullup should be disable by now.
> >> >
> >> >> CONFIG_USB_CONFIGFS,
> >> >> and I don't configure anything in sysfs before unbinding the
> >>driver.
> >> >
> >> >I didn't check on this, but I could imagine that
> >> >- when a configfs gadget is bound to the udc, .pullup() is called;
> >> >- when the configfs gadget is unbound from the udc, .pullup
> >>should be
> >> >  called again to disable the pullup.
> >>
> >> An important thing that I did not mention, is that the SoC boots
> >> from USB,
> >> so the pullup is active before the musb driver loads. Since in
> >>my case a
> >
> >It sounds to me that the musb driver should disable the pullup during
> >init.  Isn't it?
> 
> Yes. I can move it to musb_gadget_setup(). Should I still protect it
> with
> the spinlock then?

Thanks. I don't think spinlock is necessary here.

-Bin.
