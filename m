Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6294C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814C4207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAFJKv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:10:51 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43753 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgAFJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:10:51 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8640324000B;
        Mon,  6 Jan 2020 09:10:44 +0000 (UTC)
Date:   Mon, 6 Jan 2020 10:10:42 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] drm/panel: simple: Support reset GPIOs
Message-ID: <20200106101042.5bb5b742@xps13>
In-Reply-To: <20200102172700.GA15341@ravnborg.org>
References: <20191224142134.22902-1-miquel.raynal@bootlin.com>
        <20200102172700.GA15341@ravnborg.org>
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

Sam Ravnborg <sam@ravnborg.org> wrote on Thu, 2 Jan 2020 18:27:00 +0100:

> Hi Miquel
> 
> On Tue, Dec 24, 2019 at 03:21:34PM +0100, Miquel Raynal wrote:
> > The panel common bindings provide a gpios-reset property. Let's
> > support it in the simple driver.
> > 
> > Two fields are added to the panel description structure: the time to
> > assert the reset and the time to wait right after before starting to
> > interact with it in any manner. In case these default values are not
> > filled but the GPIO is present in the DT, default values are applied.  
> 
> Wehn we discussed this the last time you wrote:
> 
> """
> my hardware is:
> 
> LVDS IP <----------> LVDS to RGB bridge <------------> Panel
> 
> While there is a simple "RGB to LVDS" bridge driver, there is none
> doing the work the other way around. In my case, the bridge has a reset
> pin.
> 
> As until now there is no way to represent the "LVDS to RGB" bridge and
> because the bindings already document such reset pin, I decided to add
> support for it in the simple panel driver.
> """
> 
> Based on the information provided it seems that the correct way is to
> add a "LVDS to RGB bridge" and then let the bridge handle the reset
> functionality.

This I agree, but we are talking about my current situation. 

> 
> It is obviously much more code to do it this way but then
> other panels using the same type of brigde have the
> same functionality without adding bridge functionality to the panel.

This, I do not fully agree as bindings for the panel reset already
exist and we could have a reset on both: the bridge and the panel.
I choose to use a wrong (private) DT representation because I am not
willing to add an LVDS->RGB bridge: as you say, it is much more work to
do. But, IMHO, this is not related to the patch. If you consider this
patch wrong because a panel cannot have a reset, then it should be
stated clearly and maybe removed from the bindings?

Anyway if you think this change can't be useful, let's put it aside.

Thanks for your time,
Miquèl

