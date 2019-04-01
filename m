Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E294C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB3D20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RcLnIFoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfDASUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:20:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39606 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfDASUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:20:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31IK9O5011727;
        Mon, 1 Apr 2019 13:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554142809;
        bh=hKLKhAj1bb69DV25Byjd5WkAHfiQxIydUOjBsP+D5yE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RcLnIFoMJL5iuG5m+Y/pv149AbYi9ngvSCwzLAIycxNCTaQ7IAP2MA0WQlozH/4Va
         9wAnMxZHxGtxwiWhnwuHT/dhSZkKt/0NuRSfY0IRmgmGIJMxuPYHZjxXXm/qMOA9UU
         WGhEviQrTbSsZzvSlR2RyzbP21aIhBTzGvreBTTE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31IK9hJ041243
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 13:20:09 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 13:20:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 13:20:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31IK85n048717;
        Mon, 1 Apr 2019 13:20:08 -0500
Date:   Mon, 1 Apr 2019 13:20:08 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <od@zcrc.me>
Subject: Re: [PATCH] usb: musb: Force-disable pullup on shutdown
Message-ID: <20190401182008.GL25852@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
References: <20190321144246.3547-1-paul@crapouillou.net>
 <20190401171725.GK25852@uda0271908>
 <1554140782.10471.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554140782.10471.0@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 07:46:22PM +0200, Paul Cercueil wrote:
> 
> 
> Le lun. 1 avril 2019 à 19:17, Bin Liu <b-liu@ti.com> a écrit :
> >On Thu, Mar 21, 2019 at 03:42:46PM +0100, Paul Cercueil wrote:
> >> When the musb is shutdown, for instance when the driver is unloaded,
> >> force-disable the pullup. Otherwise, the host will still see
> >>the gadget
> >> device even after the shutdown.
> >
> >how would this happen?
> >
> >when musb-hdrc driver is unloaded, udc core removes the bound gadget
> >driver which calls musb_gadget_pullup() to disable the pullup.
> 
> I'm testing with the jz4740-musb driver. I don't unload the module (it's
> built-in) but unbind it from sysfs.

I did unbind too.

root@am335x-evm:/sys/bus/platform/drivers/musb-hdrc# echo musb-hdrc.0 > unbind

or unbind the glue driver:

root@am335x-evm:/sys/bus/platform/drivers/musb-dsps# echo 47401400.usb > unbind

musb_gadget_pullup() is called in both cases.

[ 3880.597014] [<bf444ab0>] (musb_gadget_pullup [musb_hdrc]) from [<bf402cbc>] (usb_gadget_disconnect+0x3c/0xf4 [udc_core])
[ 3880.607959] [<bf402cbc>] (usb_gadget_disconnect [udc_core]) from [<bf403b28>] (usb_gadget_remove_driver+0x4c/0x90 [udc_core])
[ 3880.619338] [<bf403b28>] (usb_gadget_remove_driver [udc_core]) from [<bf403d20>] (usb_del_gadget_udc+0x5c/0xc0 [udc_core])
[ 3880.630471] [<bf403d20>] (usb_del_gadget_udc [udc_core]) from [<bf439ff8>] (musb_remove+0x50/0x134 [musb_hdrc])
[ 3880.640648] [<bf439ff8>] (musb_remove [musb_hdrc]) from [<c05668cc>] (platform_drv_remove+0x28/0x48)
[ 3880.649831] [<c05668cc>] (platform_drv_remove) from [<c0564e3c>] (device_release_driver_internal+0xe4/0x1b4)
[ 3880.659708] [<c0564e3c>] (device_release_driver_internal) from [<c05633e4>] (bus_remove_device+0xe0/0x140)
[ 3880.669409] [<c05633e4>] (bus_remove_device) from [<c055f358>] (device_del+0x140/0x374)
[ 3880.677455] [<c055f358>] (device_del) from [<c0566ff0>] (platform_device_del.part.3+0x18/0x80)
[ 3880.686110] [<c0566ff0>] (platform_device_del.part.3) from [<c0567098>] (platform_device_unregister+0x24/0x30)
[ 3880.696170] [<c0567098>] (platform_device_unregister) from [<bf48c3e0>] (dsps_remove+0x1c/0x38 [musb_dsps])
[ 3880.706010] [<bf48c3e0>] (dsps_remove [musb_dsps]) from [<c05668cc>] (platform_drv_remove+0x28/0x48)
[ 3880.715190] [<c05668cc>] (platform_drv_remove) from [<c0564e3c>] (device_release_driver_internal+0xe4/0x1b4)
[ 3880.725065] [<c0564e3c>] (device_release_driver_internal) from [<c0562b2c>] (unbind_store+0x64/0xd8)
[ 3880.734253] [<c0562b2c>] (unbind_store) from [<c0350c58>] (kernfs_fop_write+0xf4/0x1cc)

Regards,
-Bin.


