Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66248C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4147424672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgAITPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:15:16 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47143 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgAITPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:15:15 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DCB0E24000B;
        Thu,  9 Jan 2020 19:15:12 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: mtd: rawnand: stm32_fmc2: avoid to lock the CPU bus
Date:   Thu,  9 Jan 2020 20:15:10 +0100
Message-Id: <20200109191510.10963-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1576486915-7517-1-git-send-email-christophe.kerello@st.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 4114b17af41272e14939b000ce8f3ed7ba937e3c
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-16 at 09:01:55 UTC, Christophe Kerello wrote:
> We are currently using nand_soft_waitrdy to poll the status of the NAND
> flash. FMC2 enables the wait feature bit (this feature is mandatory for
> the sequencer mode). By enabling this feature, we can't poll the status
> of the NAND flash, the read status command is stucked in FMC2 pipeline
> until R/B# signal is high, and locks the CPU bus.
> To avoid to lock the CPU bus, we poll FMC2 ISR register. This register
> reports the status of the R/B# signal.
> 
> Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash controller driver")
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
