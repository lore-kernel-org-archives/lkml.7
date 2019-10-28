Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0C0CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A11D21721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572276998;
	bh=ymo9rl9CtwjArSQnfFPyty8tp1BY+ffoTl/pqxOlMJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vKiMabGiaqQ1p/PYpQYgmyTNgyDllHDXxnrmI3k17WalhQMmfnCk+SwoWq2HNvDDa
	 L3JWAa0B+INk16gLV5lrJSbNol2gc7oordUaUPilgjmGPhO6/7447fmisBN2wZ0EQ2
	 zetKZCqqmQzWFDI3+Cjlrq0y6RWy6ccUyZiK0KlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfJ1Pgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJ1Pgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:36:37 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CEE1208C0;
        Mon, 28 Oct 2019 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572276996;
        bh=ymo9rl9CtwjArSQnfFPyty8tp1BY+ffoTl/pqxOlMJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dydQ8BCY/oWvaNr7y/rrFiwxqN7tEIACyy3Kx6qUkXvclMnnCBVfk6NzLkhzdBLbE
         Czf1eVRDF/OtyUbA9RcyKjUILeyDa3mGUdP5tPphPU3Ii8+ltKhyqK6SdE9c5kNXZ8
         HsQgObTenXdM8WzMQKTZpL7DpsrMfN2PKCHgVCU0=
Date:   Mon, 28 Oct 2019 16:34:27 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v11 4/7] drm/sun4i: dsi: Handle bus clock =?utf-8?Q?ex?=
 =?utf-8?Q?plicitly=C2=A0?=
Message-ID: <20191028153427.pc3tnoz2d23filhx@hendrix>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
 <20191025175625.8011-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025175625.8011-5-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:26:22PM +0530, Jagan Teki wrote:
> Usage of clocks are varies between different Allwinner
> DSI controllers. Clocking in A33 would need bus and
> mod clocks where as A64 would need only bus clock.
>
> To support this kind of clocking structure variants
> in the same dsi driver,

There's no variance in the clock structure as far as the bus clock is
concerned.

> explicit handling of common clock would require since the A64
> doesn't need to mention the clock-names explicitly in dts since it
> support only one bus clock.
>
> Also pass clk_id NULL instead "bus" to regmap clock init function
> since the single clock variants no need to mention clock-names
> explicitly.

You don't need explicit clock handling. Passing NULL as the argument
in regmap_init_mmio_clk will make it use the first clock, which is the
bus clock.

Maxime
