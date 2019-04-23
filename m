Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B77C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4338F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfDWGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:12:40 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:41112 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDWGMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:12:39 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hIofK-0001t1-K9 from Jiada_Wang@mentor.com ; Mon, 22 Apr 2019 23:12:26 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 22 Apr 2019 23:12:22 -0700
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <joshua_frkuska@mentor.com>,
        <jiada_wang@mentor.com>, <horms+renesas@verge.net.au>,
        <niklas.soderlund+renesas@ragnatech.se>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>
Subject: [PATCH v2 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Date:   Tue, 23 Apr 2019 15:12:16 +0900
Message-ID: <20190423061218.29705-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are issues with interrupt handling in rcar_gen3_thermal driver.

Currently IRQ is remain enabled after .remove, later if device is probed,
IRQ is requested before .thermal_init, this may cause IRQ function be
triggered but not able to clear IRQ status, thus cause system to hang.

Since the irq line isn't shared between different devices,
so the proper interrupt type flag should be IRQF_ONESHOT.

This patch-set fix these interrupt handling retated issues. 

---
v2: use irq type IRQF_ONESHOT instead of IRQF_SHARED
    disable interrupt in .remove

v1: initial version

Jiada Wang (2):
  thermal: rcar_gen3_thermal: fix interrupt type
  thermal: rcar_gen3_thermal: disable interrupt in .remove

 drivers/thermal/rcar_gen3_thermal.c | 43 +++++++++--------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

-- 
2.19.2

