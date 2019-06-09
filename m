Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE42C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8997E205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100266;
	bh=gF7m42X1PrEptWyk5LBiKFn0g3ZJIyjsxi25BehhXFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P9F/nfZ0mCoKUQpLWWot+56e9AZ2KGHciZsd6fK6gdpwGE+6Xz/dh/g1n8P3SrlD7
	 /vcb7iNrvdSsVm6KKeWLcj+fNtMldbV6wxTgXC/Zaj17iprOAFV4WUiAZfhQdJjDFX
	 pbC88kBUB5gN7gtgz94bzdYA2I5zd8/rQcsRd43w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfFIRLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbfFIRBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:01:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5D5208C0;
        Sun,  9 Jun 2019 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099710;
        bh=gF7m42X1PrEptWyk5LBiKFn0g3ZJIyjsxi25BehhXFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rbtQnkWhrpuepuQnsADvEBcEAUkTY4ljEeE9nYiWWZ42YyV/JWdiMlBIWKA2BJc4I
         Qov6AeLNriBeEU/N7HVovoUBbVfKmHsS+fcu0fqqR+YsQl5qtBvSDltPVeeP//wb+P
         2UzJ6vjdkPOLp1baJkJ911T6zum/4wnzFJHK5U5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 095/241] mmc: core: Verify SD bus width
Date:   Sun,  9 Jun 2019 18:40:37 +0200
Message-Id: <20190609164150.538605430@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9e4be8d03f50d1b25c38e2b59e73b194c130df7d ]

The SD Physical Layer Spec says the following: Since the SD Memory Card
shall support at least the two bus modes 1-bit or 4-bit width, then any SD
Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").

This change verifies the card has specified a bus width.

AMD SDHC Device 7806 can get into a bad state after a card disconnect
where anything transferred via the DATA lines will always result in a
zero filled buffer. Currently the driver will continue without error if
the HC is in this condition. A block device will be created, but reading
from it will result in a zero buffer. This makes it seem like the SD
device has been erased, when in actuality the data is never getting
copied from the DATA lines to the data buffer.

SCR is the first command in the SD initialization sequence that uses the
DATA lines. By checking that the response was invalid, we can abort
mounting the card.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 967535d76e346..fb8741f18c1f5 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -216,6 +216,14 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	if (scr->sda_spec3)
 		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+
+	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
+	if (!(scr->bus_widths & SD_SCR_BUS_WIDTH_1) ||
+	    !(scr->bus_widths & SD_SCR_BUS_WIDTH_4)) {
+		pr_err("%s: invalid bus width\n", mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.20.1



