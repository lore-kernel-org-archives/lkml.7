Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B69C17498
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AD0217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfKEOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbfKEOvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:51:55 -0500
Received: from arrakis.emea.arm.com (unknown [46.69.195.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525C220663;
        Tue,  5 Nov 2019 14:51:53 +0000 (UTC)
Date:   Tue, 5 Nov 2019 14:51:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
Message-ID: <20191105145150.GB22987@arrakis.emea.arm.com>
References: <20191104135412.32118-1-nsaenzjulienne@suse.de>
 <20191104135412.32118-2-nsaenzjulienne@suse.de>
 <588d05b4-e66c-4aa0-436e-12d244a6efd8@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588d05b4-e66c-4aa0-436e-12d244a6efd8@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 06:09:39PM +0100, Stefan Wahren wrote:
> Hi Nicolas,
> 
> Am 04.11.19 um 14:54 schrieb Nicolas Saenz Julienne:
> > arm64 places the CMA in ZONE_DMA32, which is not good enough for the
> > Raspberry Pi 4 since it contains peripherals that can only address the
> > first GB of memory. Explicitly place the CMA into that area.
> >
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> do you want this in Linux 5.5 via devicetree/fixes? In this case please
> add an fixes tag.

That's not really a fix since AFAICT CMA never worked properly on RPi4
with mainline. For 5.5, I queued the arm64 for-next/zone-dma patches
which would allow RPi4 to get a CMA in the correct physical address
range. However, since these patches cause a regression on other
platforms that don't need a small ZOEN_DMA, my suggestion was to leave
the CMA handling for RPi4 as per the current mainline (i.e. broken) and
allow CMA from the full ZONE_DMA32 range (second patch in this series).

IIUC, this dts patch can be merged independently of the ZONE_DMA patches
for arm64 and it may be beneficial for current mainline (even without
the arm64/for-next/zone-dma patches).

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/zone-dma

> Otherwise this will be queued for Linux 5.6.

I'm happy to queue them together with your ack for 5.5, otherwise I'll
only pick the second patch in this series.

Thanks.

-- 
Catalin
