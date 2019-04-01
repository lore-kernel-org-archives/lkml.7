Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9D20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139822;
	bh=+95QN+Vvo3g+LWVSnRpyJSONKHKwaR7AOQqpLnc2/Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sROcySOY61Uqyzb6bEoIZcwTv8Ksa/RsGM6yn093J6wTewmDgbfVgTPk8afhUUmj2
	 4nYe8Urx5FvljZjrsEED2ftJG627/7VWyO4PmCkuH9EJe0u3G2e/WoLejlMGzcVUHM
	 +j1RysljaCHaXUwxfOs2Vx3o4wX2METVjC+ZCUwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfDARaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732690AbfDARaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464F620856;
        Mon,  1 Apr 2019 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139816;
        bh=+95QN+Vvo3g+LWVSnRpyJSONKHKwaR7AOQqpLnc2/Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6RRroPlIRevQdYtnZNAmPFi1PAYXJh8b4yqHdz9kgFaBa5h6BfPahGhj6gflWPwY
         /jusOH1LM8lpxFEKSQaGoUcw+JB7d1eFFMhDgO0BF1zrB1m3UJYwyKTdnuClHeADLk
         x/g5D/smXxRqSf5R+Y8zQWKlZRUKXpt9iIK0rgeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 022/131] mmc: core: fix using wrong io voltage if mmc_select_hs200 fails
Date:   Mon,  1 Apr 2019 19:01:32 +0200
Message-Id: <20190401170053.864928086@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dong Aisheng <aisheng.dong@nxp.com>

commit e51534c806609c806d81bfb034f02737461f855c upstream.

Currently MMC core will keep going if HS200/HS timing switch failed
with -EBADMSG error by the assumption that the old timing is still valid.

However, for mmc_select_hs200 case, the signal voltage may have already
been switched. If the timing switch failed, we should fall back to
the old voltage in case the card is continue run with legacy timing.

If fall back signal voltage failed, we explicitly report an EIO error
to force retry during the next power cycle.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/mmc.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1251,10 +1251,11 @@ static int mmc_select_hs200(struct mmc_c
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
 
@@ -1263,7 +1264,7 @@ static int mmc_select_hs200(struct mmc_c
 
 	/* If fails try again during next card power cycle */
 	if (err)
-		goto err;
+		return err;
 
 	mmc_select_driver_type(card);
 
@@ -1297,9 +1298,14 @@ static int mmc_select_hs200(struct mmc_c
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
 


