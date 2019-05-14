Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB62C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576D72086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfENGME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:12:04 -0400
Received: from verein.lst.de ([213.95.11.211]:43834 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfENGMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:12:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8BB1C68AFE; Tue, 14 May 2019 08:11:41 +0200 (CEST)
Date:   Tue, 14 May 2019 08:11:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mario.Limonciello@dell.com
Cc:     hch@lst.de, kbusch@kernel.org, keith.busch@intel.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190514061141.GA7059@lst.de>
References: <20190510212937.11661-1-keith.busch@intel.com> <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM> <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM> <20190513143754.GE15318@localhost.localdomain> <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM> <20190513145708.GA25897@lst.de> <df020e90e8b54244b37910a2a7965671@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df020e90e8b54244b37910a2a7965671@AUSX13MPC105.AMER.DELL.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 06:01:39PM +0000, Mario.Limonciello@dell.com wrote:
> When using HMB the SSD will be writing to some memory mapped region.
> Writing to
> that region would use DMA to access host memory, no?

Memory mapped region?  It will use the devices DMA engine to write
host memory, which we explicitly allowed it.

> If the DMA controller is not functional writing to that region won't work properly as 
> it can't access that memory.

The DMA controller is in the device.  External DMA controllers are only
used on very low-end periphals, usually cheap IP blocks like SPI
controllers or similar.
