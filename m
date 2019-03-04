Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D3720661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfCDNbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:31:44 -0500
Received: from mailbnc103.isp.belgacom.be ([195.238.20.237]:40266 "EHLO
        mailbnc103.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbfCDNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:31:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A4AQDSJ31c/8jN9C5kGgEBAQICAQE?=
 =?us-ascii?q?BCAIBAQGBZgKCDoFrJ40BizMDAQEBAQEBBoExBDUBiQaQYA0rAYQ6AgIBAQI?=
 =?us-ascii?q?IhBkjOBIBAQMBAQMBAwJtKEIBDgGEeAEBAQQ6HCMQCAMOBwMJGgsPBSUDIRO?=
 =?us-ascii?q?FCxGpd4okIoENAYs+eIEHgRGDEog8giYCiimZWwmSaAwZgXSIfyuIBJleg1C?=
 =?us-ascii?q?BXiGBVk0gGIMnghYXE44MQTCBAQEeCBMFBQEBgi2NIQEB?=
X-IPAS-Result: =?us-ascii?q?A2A4AQDSJ31c/8jN9C5kGgEBAQICAQEBCAIBAQGBZgKCD?=
 =?us-ascii?q?oFrJ40BizMDAQEBAQEBBoExBDUBiQaQYA0rAYQ6AgIBAQIIhBkjOBIBAQMBA?=
 =?us-ascii?q?QMBAwJtKEIBDgGEeAEBAQQ6HCMQCAMOBwMJGgsPBSUDIROFCxGpd4okIoENA?=
 =?us-ascii?q?Ys+eIEHgRGDEog8giYCiimZWwmSaAwZgXSIfyuIBJleg1CBXiGBVk0gGIMng?=
 =?us-ascii?q?hYXE44MQTCBAQEeCBMFBQEBgi2NIQEB?=
Received: from ppp-46-244-205-200.dynamic.mnet-online.de (HELO albert) ([46.244.205.200])
  by relay.proximus.be with ESMTP/TLS/AES128-GCM-SHA256; 04 Mar 2019 14:31:40 +0100
Received: from libv by albert with local (Exim 4.84_2)
        (envelope-from <libv@skynet.be>)
        id 1h0ngx-0007Xa-Qu; Mon, 04 Mar 2019 14:31:39 +0100
Date:   Mon, 4 Mar 2019 14:31:39 +0100
From:   Luc Verhaegen <libv@skynet.be>
To:     Priit Laes <plaes@plaes.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Priit Laes <priit.laes@paf.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [linux-sunxi] [RESEND PATCH] drm/sun4i: hdmi: Improve
 compatibility with hpd-less HDMI displays
Message-ID: <20190304133139.GA26394@skynet.be>
References: <20190304130616.27525-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304130616.27525-1-plaes@plaes.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 03:06:16PM +0200, Priit Laes wrote:
> From: Priit Laes <priit.laes@paf.com>
> 
> Even though HDMI connector features hotplug detect pin (HPD), there
> are older devices which do not support it. For these devices fall
> back to additional check on I2C bus to probe for EDID data.
> 
> One known example is HDMI/DVI display with following edid:
> 
> $ xxd -p display.edid
> 00ffffffffffff0005a1e00301000000150f0103800f05780a0f6ea05748
> 9a2610474f200000010101010101010101010101010101012a08804520e0
> 0b1020004000953600000018000000fd0034441a2403000a202020202020
> 0000001000310a20202020202020202020200000001000002a4030701300
> 782d1100001e006b
> 
> $ edid-decode display.edid
> EDID version: 1.3
> Manufacturer: AMA Model 3e0 Serial Number 1
> Digital display
> Maximum image size: 15 cm x 5 cm
> Gamma: 2.20
> RGB color display
> First detailed timing is preferred timing
> Display x,y Chromaticity:
>   Red:   0.6250, 0.3398
>   Green: 0.2841, 0.6044
>   Blue:  0.1494, 0.0644
>   White: 0.2802, 0.3105
> 
> Established timings supported:
>   640x480@60Hz 4:3 HorFreq: 31469 Hz Clock: 25.175 MHz
> Standard timings supported:
> Detailed mode: Clock 20.900 MHz, 149 mm x 54 mm
>                640  672  672  709 hborder 0
>                480  484  484  491 vborder 0
>                -hsync -vsync
>                VertFreq: 60 Hz, HorFreq: 29478 Hz
> Monitor ranges (GTF): 52-68Hz V, 26-36kHz H, max dotclock 30MHz
> Dummy block
> Dummy block
> Checksum: 0x6b (valid)
> 
> Now, current implementation is still flawed, as HDMI uses the
> HPD signal to indicate that the source should re-read the EDID
> due to change in device capabilities. With current HPD polling
> implementation we would most certainly miss those notifications
> as one can try just swapping two HDMI monitors really fast.
> 
> Proper fix would be skipping the HPD pin detection and relying
> on just EDID fetching and acting on its changes.

HPD has been a hard requirement since DDWG came up with DVI somewhere in 
the late 90s. This monitor is plainly broken, and should not get an 
expensive i2c address polling based workaround at the driver level.

Luc Verhaegen.
