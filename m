Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C8CC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AED420684
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLPKxg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:53:36 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38131 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLPKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:53:36 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EB18C24000F;
        Mon, 16 Dec 2019 10:53:32 +0000 (UTC)
Date:   Mon, 16 Dec 2019 11:53:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] drm/panel: simple: Support reset GPIOs
Message-ID: <20191216115331.5c6047f7@xps13>
In-Reply-To: <20191214102354.GB2967@ravnborg.org>
References: <20191213181325.26228-1-miquel.raynal@bootlin.com>
        <20191214102354.GB2967@ravnborg.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Sam Ravnborg <sam@ravnborg.org> wrote on Sat, 14 Dec 2019 11:23:54
+0100:

> Hi Miquel.
> 
> On Fri, Dec 13, 2019 at 07:13:25PM +0100, Miquel Raynal wrote:
> > The panel common bindings provide a gpios-reset property which is
> > active low by default. Let's support it in the simple driver.
> > 
> > De-asserting the reset pin implies a physical high, which in turns is
> > a logic low.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Code looks fine - but I fail to see why simple panels would require a
> reset pin.
> 
> Do you have any simple panels that requires this, or did you add it
> because you saw it in the panel-common.yaml file?

My hardware is:

LVDS IP <----------> LVDS to RGB bridge <------------> Panel

While there is a simple "RGB to LVDS" bridge driver, there is none
doing the work the other way around. In my case, the bridge has a reset
pin.

As until now there is no way to represent the "LVDS to RGB" bridge and
because the bindings already document such reset pin, I decided to add
support for it in the simple panel driver.

Thanks,
Miquèl
