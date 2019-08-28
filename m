Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696332339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfH1ODd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:03:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfH1ODa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:03:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77932B005;
        Wed, 28 Aug 2019 14:03:29 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next 00/15] ioc3-eth improvements
Date:   Wed, 28 Aug 2019 16:02:59 +0200
Message-Id: <20190828140315.17048-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In my patch series for splitting out the serial code from ioc3-eth
by using a MFD device there was one big patch for ioc3-eth.c,
which wasn't really usefull for reviews. This series contains the
ioc3-eth changes splitted in smaller steps and few more cleanups.
Only the conversion to MFD will be done later in a different series.

Thomas Bogendoerfer (15):
  MIPS: SGI-IP27: remove ioc3 ethernet init
  MIPS: SGI-IP27: restructure ioc3 register access
  net: sgi: ioc3-eth: remove checkpatch errors/warning
  net: sgi: ioc3-eth: use defines for constants dealing with desc rings
  net: sgi: ioc3-eth: allocate space for desc rings only once
  net: sgi: ioc3-eth: get rid of ioc3_clean_rx_ring()
  net: sgi: ioc3-eth: separate tx and rx ring handling
  net: sgi: ioc3-eth: introduce chip start function
  net: sgi: ioc3-eth: split ring cleaning/freeing and allocation
  net: sgi: ioc3-eth: refactor rx buffer allocation
  net: sgi: ioc3-eth: use dma-direct for dma allocations
  net: sgi: ioc3-eth: use csum_fold
  net: sgi: ioc3-eth: Fix IPG settings
  net: sgi: ioc3-eth: protect emcr in all cases
  net: sgi: ioc3-eth: no need to stop queue set_multicast_list

 arch/mips/include/asm/sn/ioc3.h     |  357 +++++-------
 arch/mips/sgi-ip27/ip27-console.c   |    5 +-
 arch/mips/sgi-ip27/ip27-init.c      |   13 -
 drivers/net/ethernet/sgi/ioc3-eth.c | 1038 ++++++++++++++++++-----------------
 4 files changed, 666 insertions(+), 747 deletions(-)

-- 
2.13.7

