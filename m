Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB0C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7869521835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgACIRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:17:30 -0500
Received: from fgw23-4.mail.saunalahti.fi ([62.142.5.110]:40068 "EHLO
        fgw23-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbgACIRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:17:30 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-105-219-nat.elisa-mobile.fi [85.76.105.219])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 7a28ac90-2e01-11ea-90c5-005056bdfda7;
        Fri, 03 Jan 2020 10:17:27 +0200 (EET)
Date:   Fri, 3 Jan 2020 10:17:26 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BISECTED, REGRESSION] OMAP3 onenand/DMA broken
Message-ID: <20200103081726.GD15023@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When booting v5.4 (or v5.5-rc4) on N900, the console gets flooded with:

[    8.335754] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.365753] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.395751] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.425750] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.455749] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.485748] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.515777] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.545776] omap2-onenand 1000000.onenand: timeout waiting for DMA
[    8.575775] omap2-onenand 1000000.onenand: timeout waiting for DMA

making the system unusable.

Bisected to:

4689d35c765c696bdf0535486a990038b242a26b is the first bad commit
commit 4689d35c765c696bdf0535486a990038b242a26b
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Tue Jul 16 11:24:59 2019 +0300

    dmaengine: ti: omap-dma: Improved memcpy polling support

The commit does not revert cleanly anymore. Any ideas how to fix this?

A.
