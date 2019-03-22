Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0E2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2572083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256881;
	bh=FX/TvHuBurcW/orFJCjrgAD73kg+1PAxSTM2BOCNl3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qRM16V2EBlE0ljgQvmdjDEiLfV4asw9fnZPIIaJnSq79CIUA3ZFHFU+0gKfHYgc2e
	 ocQ2rnUj86pxpvKEebUn+KmrrUurmcWcwNpK4icY86r0QG7t3ebDT7D4hrrqogG4Gt
	 VhggfNwaNDd32XB5lynZJ9unCLbLUSbLpx1OkniU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbfCVMOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389215AbfCVMOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807682083D;
        Fri, 22 Mar 2019 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256876;
        bh=FX/TvHuBurcW/orFJCjrgAD73kg+1PAxSTM2BOCNl3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAgblGnf6Dgcq5vZA9nycDHeIEKZ07iJikO7WvFJQSmjYy9e1DmbawcG5WG/Sw25n
         dAr2NMtAD0MV4PfNyyij3v5xyR1yTixi4j3CFkDC3NNNILL60fiq80OdtO6gPRZZhJ
         w34kaa6s0IZUw/yuYrLIWDUypnyb1coZkrLFUc4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiong Wu <Lohengrin1024@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.0 064/238] mmc:fix a bug when max_discard is 0
Date:   Fri, 22 Mar 2019 12:14:43 +0100
Message-Id: <20190322111302.359209256@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiong Wu <lohengrin1024@gmail.com>

commit d4721339dcca7def04909a8e60da43c19a24d8bf upstream.

The original purpose of the code I fix is to replace max_discard with
max_trim if max_trim is less than max_discard. When max_discard is 0
we should replace max_discard with max_trim as well, because
max_discard equals 0 happens only when the max_do_calc_max_discard
process is overflowed, so if mmc_can_trim(card) is true, max_discard
should be replaced by an available max_trim.
However, in the original code, there are two lines of code interfere
the right process.
1) if (max_discard && mmc_can_trim(card))
when max_discard is 0, it skips the process checking if max_discard
needs to be replaced with max_trim.
2) if (max_trim < max_discard)
the condition is false when max_discard is 0. it also skips the process
that replaces max_discard with max_trim, in fact, we should replace the
0-valued max_discard with max_trim.

Signed-off-by: Jiong Wu <Lohengrin1024@gmail.com>
Fixes: b305882fbc87 (mmc: core: optimize mmc_calc_max_discard)
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2381,9 +2381,9 @@ unsigned int mmc_calc_max_discard(struct
 		return card->pref_erase;
 
 	max_discard = mmc_do_calc_max_discard(card, MMC_ERASE_ARG);
-	if (max_discard && mmc_can_trim(card)) {
+	if (mmc_can_trim(card)) {
 		max_trim = mmc_do_calc_max_discard(card, MMC_TRIM_ARG);
-		if (max_trim < max_discard)
+		if (max_trim < max_discard || max_discard == 0)
 			max_discard = max_trim;
 	} else if (max_discard < card->erase_size) {
 		max_discard = 0;


