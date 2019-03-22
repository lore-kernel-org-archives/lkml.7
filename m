Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B062C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70852183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfCVPsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:48:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfCVPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:48:06 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1Hi8-1hA7He3ZN4-002mWu; Fri, 22 Mar 2019 16:47:53 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Martin Hicks <mort@bork.org>
Cc:     Ziyuan Xu <xzy.xu@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 17/25] mmc: core: don't try to switch block size for dual rate mode
Date:   Fri, 22 Mar 2019 16:44:08 +0100
Message-Id: <20190322154425.3852517-18-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Up6hvE5bt3o/vSsgJuCZN3OfmzkMDswwd0o14/Q/eUjurBBO/3c
 78coqjWfdKnwPvALN2Mji5pfrU/Em0bTpvUCoi2FruCjQ+Iw5ZdNO/pgLgV0aDbjTMdR0Gc
 fx+0xasgAsErwZbxrSAtheeXGGT417xtCLpe5Fc5wUIh+fRHn0XwDVkiub50tST2TR5+4QT
 3+MnUuZfPuzxoviPfPHUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V6unOQIF1tY=:VNjvKIu+JKJD9f+Z+tIja+
 gACnTL9EtUPYw75NentheME7zykhMYM6y24ycmoU7fiefKLq7NB5A+y3apgwGmYwpULzG05cj
 zJuJogd0wF21L6Cc3LzvT0F1bQvP0Wu3OXhkD55r/HoUMempR1/ASxVLzT76JacW5+/Sr/Mqk
 neJ1Xu/uzsA1FiGc/xlOcZB7/LpglNzRvNT3GjaGSo4TmIlYwim5XZeYhn+7fBGjc6cRFaYg9
 JQ2UgnHZbzs/PfdXzJlo3m1SnT3aJBMegI2iUCPto0ES7aLceQEIQoWLNc4CrN6TvQCX3d8x/
 hU+2gW02c+qsVgsFIO7vJf5oJ4wYfIlJFnZHS7dPZZgzOpSwFOeGeU6XuDF5S9U+7C2Ng+KwV
 f4u6co97xlqYnTxAP0Z59EogvveqwTjlIYhc2yVJqI5QFCydAM/PTX9uf2ycmZFUbDT/e1ZoQ
 +Jdh9+5cvEK2jaHyZ/F+Rz7ARp3dTQdTnByhJzlG0DstWvl9zKXi/Tq6nRkFJWyubT4ZKNaRQ
 My4VezSTZLcWNGraXn73YRQ1uKvoWAWGwkpSu5p1Bj4kTHhIW3QV0LVTUQXhIU9Qq+SgRCo3g
 ZmfoQ/85aKTuEgVCNk5Bay6/CyECP6ISU0dxp5Rvxxt6ZVo5pW5+NaXE1PWQJyn5Cjdynvp+3
 xr+y/J6t1kt4kCoD3ya76l/xCUE+6rVAO2J0AOEuviRsW8cHpgyHp8Oj4qr1fQS0lClQTy1DG
 CF5k1oywOG2pGy2dTGgkqV/iNR0zCP9Q7dhnrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziyuan Xu <xzy.xu@rock-chips.com>

Per spec, block size should always be 512 bytes for dual rate mode,
so any attempts to switch the block size under dual rate mode should
be neglected.

Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 1712c9373f98ae8ed41599a8d7841a6fba29c264)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index df074f8c7cb7..3e17268b9994 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2406,7 +2406,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd = {0};
 
-	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
+	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
+	    mmc_card_hs400(card) || mmc_card_hs400es(card))
 		return 0;
 
 	cmd.opcode = MMC_SET_BLOCKLEN;
-- 
2.20.0

