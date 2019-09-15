Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB92C4CEC6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 06:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE920873
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 06:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfIOGaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 02:30:06 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:37060 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfIOGaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 02:30:06 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 8A105440584;
        Sun, 15 Sep 2019 09:30:01 +0300 (IDT)
References: <20190910155507.491230-1-tinywrkb@gmail.com> <20190910185033.GD9761@lunn.ch>
User-agent: mu4e 1.2.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     tinywrkb <tinywrkb@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s max-speed
In-reply-to: <20190910185033.GD9761@lunn.ch>
Date:   Sun, 15 Sep 2019 09:30:00 +0300
Message-ID: <87muf6oyvr.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Sep 10 2019, Andrew Lunn wrote:
> On Tue, Sep 10, 2019 at 06:55:07PM +0300, tinywrkb wrote:
>> Cubox-i Solo/DualLite carrier board has 100Mb/s magnetics while the
>> Atheros AR8035 PHY on the MicroSoM v1.3 CPU module is a 1GbE PHY device.
>>
>> Since commit 5502b218e001 ("net: phy: use phy_resolve_aneg_linkmode in
>> genphy_read_status") ethernet is broken on Cubox-i Solo/DualLite devices.
>
> Hi Tinywrkb
>
> You emailed lots of people, but missed the PHY maintainers :-(
>
> Are you sure this is the patch which broken it? Did you do a git
> bisect.

Tinywrkb confirmed to me in private communication that revert of
5502b218e001 fixes Ethernet for him on effected system.

He also referred me to an old Cubox-i spec that lists 10/100 Ethernet
only for i.MX6 Solo/DualLite variants of Cubox-i. It turns out that
there was a plan to use a different 10/100 PHY for Solo/DualLite
SOMs. This plan never materialized. All SolidRun i.MX6 SOMs use the same
AR8035 PHY that supports 1Gb.

Commit 5502b218e001 might be triggering a hardware issue on the affected
Cubox-i. I could not reproduce the issue here with Cubox-i and a Dual
SOM variant running v5.3-rc8. I have no Solo/DualLite variant handy at
the moment.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
