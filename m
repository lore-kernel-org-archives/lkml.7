Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9E6C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF31622CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 07:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfHWHV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 03:21:28 -0400
Received: from shell.v3.sk ([90.176.6.54]:40155 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731211AbfHWHV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:21:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 55174D7697;
        Fri, 23 Aug 2019 09:21:24 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pMkOYpuRgxH6; Fri, 23 Aug 2019 09:21:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E8F49D7699;
        Fri, 23 Aug 2019 09:21:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5ToaOpSmwFul; Fri, 23 Aug 2019 09:21:19 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B15DFD7697;
        Fri, 23 Aug 2019 09:21:18 +0200 (CEST)
Message-ID: <424d2881edcaf7cedbfa5cbbf2e73aaff5355df3.camel@v3.sk>
Subject: Re: [PATCH v2 00/20] Initial support for Marvell MMP3 SoC
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <maz@kernel.org>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Date:   Fri, 23 Aug 2019 09:21:17 +0200
In-Reply-To: <244fdc87-0fe5-be79-d9cd-2395d0ac3f57@kernel.org>
References: <20190822092643.593488-1-lkundrak@v3.sk>
         <244fdc87-0fe5-be79-d9cd-2395d0ac3f57@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-22 at 11:31 +0100, Marc Zyngier wrote:
> On 22/08/2019 10:26, Lubomir Rintel wrote:
> > Hi, 
> > 
> > this is a second spin of a patch set that adds support for the Marvell
> > MMP3 processor. MMP3 is used in OLPC XO-4 laptops, Panasonic Toughpad
> > FZ-A1 tablet and Dell Wyse 3020 Tx0D thin clients. 
> > 
> > Compared to v1, there's a handful of fixes in response to reviews. Patch
> > 02/20 is new. Details in individual patches.
> >  
> > Apart from the adjustments in mach-mmp/, the patch makes necessary 
> > changes to the irqchip driver and adds an USB2 PHY driver. The latter 
> > has a dependency on the mach-mmp/ changes, so it can't be submitted 
> > separately.
> >  
> > The patch set has been tested to work on Wyse Tx0D and not ruin MMP2 
> > support on XO-1.75. 
> 
> How do you want this series to be merged? I'm happy to take the irqchip
> related patches as well as the corresponding DT change (once reviewed)
> through my tree.

I was hoping for the Arm SoC tree, because there are some dependencies
(MMP3 USB PHY depends on MMP3 SoC).

That said, the irqchip patches are rather independent and the only
downside of them going in via a different tree will be that the other
tree that will lack them won't boot on MMP3 (things will compile
though). I don't know if that's okay. What's typically done in cases
like these?


> Thanks,
> 
> 	M.

Thank you
Lubo

