Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E30FC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150FF206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="efyKKdhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfLKTKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:10:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42554 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:10:32 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBBJASte023513;
        Wed, 11 Dec 2019 13:10:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576091428;
        bh=nKnU1b9WLE/FNteiZVJsLC+IhQTpwehDnuT9USqSHa0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=efyKKdhCs7JAHXQmAKQgm7IzkaIJnFW0cNIZz3iguwEt/VFp3FZtzOsTLrKtySlKu
         r9N5HZ750w23srehZjT38xfcEGpAGaarLC2F17yDJN7WPBYhDVGle8ejiLX3A+7JGF
         TOhpOFwAQokcIRhu6W4Ily1JDl7JscvNNnb9zf3E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBBJAS6S037443
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Dec 2019 13:10:28 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Dec 2019 13:10:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Dec 2019 13:10:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBBJASrD028535;
        Wed, 11 Dec 2019 13:10:28 -0600
Date:   Wed, 11 Dec 2019 13:09:53 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saurav.girepunje@hotmail.com>
Subject: Re: [PATCH] usb: musb: Fix external abort on non-linefetch
Message-ID: <20191211190953.GH16429@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>;,
        gregkh@linuxfoundation.org;, linux-usb@vger.kernel.org;,
        linux-kernel@vger.kernel.org;, saurav.girepunje@hotmail.com
References: <20191027083616.GA13761@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191027083616.GA13761@saurav>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Oct 27, 2019 at 02:06:21PM +0530, Saurav Girepunje wrote:
> While setting the usb mode from sysfs. Below error came on kernel
> version 4.19.
> 
> On latest kernel vserion api name changed. Therefore API
> name and backtrace API name are different.
> 
>     [  821.908066] Backtrace:
>     [  821.910695] [<bf078fc0>] (musb_default_readl [musb_hdrc]) from [<bf0af738>] (dsps_musb_set_mode+0x38/0x12c [musb_dsps])
>     [  821.922059] [<bf0af700>] (dsps_musb_set_mode [musb_dsps]) from [<bf07899c>] (musb_mode_store+0xc8/0x12c [musb_hdrc])
>     [  821.933105]  r7:a0010013 r6:0000000b r5:cd79d200 r4:cb634010
>     [  821.939096] [<bf0788d4>] (musb_mode_store [musb_hdrc]) from [<c0425184>] (dev_attr_store+0x20/0x2c)
>     [  821.948593]  r7:cd79d200 r6:c5abbf78 r5:00000000 r4:bf0788d4
>     [  821.954549] [<c0425164>] (dev_attr_store) from [<c0285b08>] (sysfs_kf_write+0x48/0x4c)
>     [  821.962859]  r5:00000000 r4:c0425164
>     [  821.966620] [<c0285ac0>] (sysfs_kf_write) from [<c0285274>] (kernfs_fop_write+0xfc/0x1fc)
>     [  821.975200]  r5:00000000 r4:cd79d080
>     [  821.978966] [<c0285178>] (kernfs_fop_write) from [<c020ec00>] (__vfs_write+0x34/0x120)
>     [  821.987280]  r10:00000000 r9:0000000b r8:00000000 r7:0000000b r6:c5abbf78 r5:c0285178
>     [  821.995493]  r4:cb67a3c0
>     [  821.998160] [<c020ebcc>] (__vfs_write) from [<c020fae8>] (vfs_write+0xa8/0x170)
>     [  822.005835]  r9:0000000b r8:00000000 r7:c5abbf78 r6:000def80 r5:cb67a3c0 r4:0000000b
>     [  822.013969] [<c020fa40>] (vfs_write) from [<c02108d0>] (SyS_write+0x44/0x98)
>     [  822.021371]  r9:0000000b r8:000def80 r7:00000000 r6:00000000 r5:cb67a3c0 r4:cb67a3c0
>     [  822.029517] [<c021088c>] (SyS_write) from [<c010d8a0>] (ret_fast_syscall+0x0/0x3c)
>     [  822.037467]  r9:c5aba000 r8:c010daa8 r7:00000004 r6:b6f0ad58 r5:000def80 r4:0000000b
>     [  822.045599] Code: e1a0c00d e92dd800 e24cb004 e0801001 (e5910000)
> 
>     Without pm_runtime_{get,put}_sync calls in place,
>     Similar issue come on "mode_show" and "vbus_store" also.

Do you really get the kernel dump on mode_show() and vbus_store()? It
shouldn't because the two functions don't access musb registers. What
platform have you tested on?

> 
>     fix- call pm_runtime_{get,put}_sync before reading/writing
>     usb mode/vbus from sysfs.
> 
>     As sugguested on commit '2d15f69ed5c1c33f283e77ec161578badde33eaf'

This seems to be your private commit id. You don't have to refer to it,
including the quote below.

>     Merged all the fix which reslove same bug in the same file.
>     "
>       commit '2d15f69ed5c1c33f283e77ec161578badde33eaf'
>       Author: Saurav Girepunje <saurav.girepunje@gmail.com>
>       Date:   Thu Aug 8 00:05:03 2019 +0530
> 
>       usb: musb: Fix external abort on non-linefetch for vbus_store
> 
>       Without pm_runtime_{get,put}_sync calls in place, writing
>       vbus value via /sys causes the error
> 
>       "Unhandled fault external abort on non-linefetch"
> 
>         On Thu, Aug 08, 2019 at 12:11:46AM +0530, Saurav Girepunje wrote:
> 	> Without pm_runtime_{get,put}_sync calls in place, writing
> 	> vbus value via /sys causes the error
> 	>
> 	> "Unhandled fault external abort on non-linefetch"
> 	>
> 	> Signed-off-by: Saurav Girepunje <saurav.girepunje@xxxxxxxxx>
> 
> 	Thanks for the patch. Can you please merge another two similar patches
> 	you just sent with this one? They all fix the same bug in the same file
> 	so could be just in one patch.
> 
> 	-Bin.
>     "
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

-Bin.
