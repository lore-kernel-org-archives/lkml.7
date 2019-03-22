Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A98C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726A82183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfCVPr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:47:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCVPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:47:27 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXY6b-1hUrZP1Wvv-00Z2OT; Fri, 22 Mar 2019 16:47:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 11/25] mmc: core: fix using wrong io voltage if mmc_select_hs200 fails
Date:   Fri, 22 Mar 2019 16:44:02 +0100
Message-Id: <20190322154425.3852517-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AUdmkZ5z4T+73YX5eDFD7nmt0VVn8VFjTyPcIjAgXkBryoY38Sj
 KEcTEgx2j4b1CAowPC21uD6NWeJPhVix5lXJxvPisKKZMMLTRUE+GzTDFNAGLXmNC8CW03q
 hA9kqPKM+DHGYRHZj4/ktdzzz1eL9xENAZSY5XspO741kft7ouFaXIbZ8zfzPdrUBfZPUA1
 FuaD1Hf2yB4JzAoLOtEdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6UQKPJz7PE=:vYowmL9ByE7hVEvss4ayn1
 woXB+qzcoNA4PzL6YY12oOviTzsKDgsrlF34hj39WmZUFmSY6On06LDxDrPDOKCBIfDkMAFtq
 HLJSFNaiA2hOdOSewbr2iwec/BeWTm9kPHClLEV+f+c7Q701UFG7LbZqkG2ZKmMEeKs4QpgUz
 exfXn1hgSeC4MgoaBmcL+MjJtNkdnuef75gmhAP1yiAdAGHy5YMCzRzVcEgOFHIOim8FOd1/4
 xMiykaSEwBU3rRAffLXAHHxbE/jveSdkvTdWXIc2Blo8pd+8fTk/UOHEzoTta0Lqw8YMMvFuN
 OVeqbyXS5F/TPP9hY1Dk5BtfCxFdD6F6ZhidQuz9RoywmB2iebJnD0Rdej6NRT6YJv9wKpTqQ
 hqCpId7RBpXo79BJmMpFb4GJQZMUiev4zYKwUcWY+78KLGydZekwr2X6BRbpr44yrY+W8+8OA
 p91HpFRUM+1SqFKeGY6VpZZskmPa2UVOMrBF3mm1hITPng52DP3ae1feG01mwMkVogwBMLMID
 g2kdgPOzp1WB7RqrulQ6EvhoCny8JjZF9APCS6M13VJjwTdVLTriswhrOYR/8YdgvVsrKxX2k
 vle3P1ivlGvmfwSDvIyX/CKvE8C9Sd2ONVQPzrBlS+aPLHYtD2qi6NRatqAXEolm/IPkioaMf
 qY+YxXeLpfQzhUvR5tViimndJoFOa6whKUyUea+irh/yxewFbP+xmDYJKDZRSdC/sQqDyH6pp
 OshfE9+T4JLKngiDterlyd3CkYuTG8mAMtUE5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Currently MMC core will keep going if HS200/HS timing switch failed
with -EBADMSG error by the assumption that the old timing is still valid.

However, for mmc_select_hs200 case, the signal voltage may have already
been switched. If the timing switch failed, we should fall back to
the old voltage in case the card is continue run with legacy timing.

If fall back signal voltage failed, we explicitly report an EIO error
to force retry during the next power cycle.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit e51534c806609c806d81bfb034f02737461f855c)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/mmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7286d0d324e1..7844baecf306 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1251,10 +1251,11 @@ static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	bool send_status = true;
-	unsigned int old_timing;
+	unsigned int old_timing, old_signal_voltage;
 	int err = -EINVAL;
 	u8 val;
 
+	old_signal_voltage = host->ios.signal_voltage;
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
 		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
@@ -1263,7 +1264,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	/* If fails try again during next card power cycle */
 	if (err)
-		goto err;
+		return err;
 
 	mmc_select_driver_type(card);
 
@@ -1297,9 +1298,14 @@ static int mmc_select_hs200(struct mmc_card *card)
 		}
 	}
 err:
-	if (err)
+	if (err) {
+		/* fall back to the old signal voltage, if fails report error */
+		if (__mmc_set_signal_voltage(host, old_signal_voltage))
+			err = -EIO;
+
 		pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
 		       __func__, err);
+	}
 	return err;
 }
 
-- 
2.20.0

