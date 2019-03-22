Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B3D2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255868;
	bh=EuZlJORB5spIrLpJK9kP9Rjnkq7cRgHRWWipHE5WYec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lCi3JTL52Dfc+KALJMalgGY5993mk7nf03yqcmG9iB/EB4f45Xm3aR4T8cnvV1hDB
	 Pqhlp+jlVuqxVBMKuI3EkdYELqvEmeNJpTU7EKmgMcZPoin09vyjNRiW+CJjd0GTSW
	 v0DnVtQDkbePg+HtJQWuyHN2iQHqSS0uATRK37tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387733AbfCVL5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbfCVL5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA5720850;
        Fri, 22 Mar 2019 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255861;
        bh=EuZlJORB5spIrLpJK9kP9Rjnkq7cRgHRWWipHE5WYec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PifGJZFqQ87qF/IdpjghfnBiKEiMQ5jNY1CC+92Db/tgMtBLzpJiU1Fvmm5RsCQu
         2MHeSzQXgbJ9VmPkDvN4H5A0muZ/waXb06/2Af2JPnj7CnwP7GdM51UXhdqMM/ehiD
         BnVHY1OoTxMWeTl3qgy9kUeCZY8Ti+Ap+2nnCrBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>,
        Valentine Barshak <valentine.barshak@cogentembedded.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 037/280] ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count check
Date:   Fri, 22 Mar 2019 12:13:10 +0100
Message-Id: <20190322111308.401412954@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d9111d36024de07784f2e1ba2ccf70b16035f378 ]

commit 4d230d1271064 ("ASoC: rsnd: fixup not to call clk_get/set
under non-atomic") added new rsnd_ssi_prepare() and moved
rsnd_ssi_master_clk_start() to .prepare.
But, ssi user count (= ssi->usrcnt) is incremented at .init
(= rsnd_ssi_init()).
Because of these timing exchange, ssi->usrcnt check at
rsnd_ssi_master_clk_start() should be adjusted.
Otherwise, 2nd master clock setup will be no check.
This patch fixup this issue.

Fixes: commit 4d230d1271064 ("ASoC: rsnd: fixup not to call clk_get/set under non-atomic")
Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Reported-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index a566dae3ec8a..9410e0a9b14b 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -283,7 +283,7 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_ssi_is_multi_slave(mod, io))
 		return 0;
 
-	if (ssi->usrcnt > 1) {
+	if (ssi->usrcnt > 0) {
 		if (ssi->rate != rate) {
 			dev_err(dev, "SSI parent/child should use same rate\n");
 			return -EINVAL;
-- 
2.19.1



