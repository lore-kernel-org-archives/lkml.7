Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3FB20675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cv0yDBK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfDOVAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:00:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39418 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfDOVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:00:38 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so29121800ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2m+OpLOA9wqfqg+vaNnTPXmbZMciiCK62VMT09ujw4=;
        b=Cv0yDBK8CJU58r3YrVuPBxtO/pvovvHi7cqo9b7lqey5znqG+RdoVJvJoOuVZivVko
         EZXe3iKEkOcXEGUUkn1fipK89P3CAerno7luZtvovKogHqqXK9DiPTmSF5gWBF7zhNMv
         Dw0CTXBT3hOP+ZZ3RJU3N02G+ANGTqe39vs2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l2m+OpLOA9wqfqg+vaNnTPXmbZMciiCK62VMT09ujw4=;
        b=JRHXcME6uVhGrBMW8IiSnwRcBkhF9gQBOlvz1uVixd82/eRJ4+eR+Pvo/0eXJvaMIa
         bL3Erwy5orf1rV9Okcs17JoqPHl3Eq6ldLsVm9tMzbQV6XTAlY2SFS1lwDY+09qvXjP0
         L6QXsul1532mx9RoYVDrln4aR0QcMh3mTo5Jx1S7it6kk75JfZjZZiSEK8ybtG2dE4m3
         jKchS9snIXJnKnSo6rzkW7FSYH1cFpFgtYpmaEdCdJ6InheoOB4AoFY+/qzREy66+1FY
         pL2Lym84MvfuBSR+i5UAsPz58u271AyZqo6QF+QTPD2U79osfVm0k8XWIKKyr+FdzAWk
         Ewww==
X-Gm-Message-State: APjAAAWp49L6O7UalKh8QDDcVrD0pSP7jFd031etyBderuv3ptWQN8r1
        OdSy5UQ6mZxkt1Ee2Gw9tidD0A==
X-Google-Smtp-Source: APXvYqyjGTH7SBdKIzp5IAYnUPeEjU8yIIfqyQhcM54nkTQKC6fTO3TpfubkoNUVJiqm0ILERVs3jg==
X-Received: by 2002:a02:a58e:: with SMTP id b14mr23153214jam.77.1555362037046;
        Mon, 15 Apr 2019 14:00:37 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id k201sm8428842itb.10.2019.04.15.14.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 14:00:36 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        linux-kernel@vger.kernel.org,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1] mmc: core: Verify SD bus width
Date:   Mon, 15 Apr 2019 15:00:31 -0600
Message-Id: <20190415210031.54062-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SD Physical Layer Spec says the following: Since the SD Memory Card
shall support at least the two bus modes 1-bit or 4-bit width, then any SD
Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").

This change verifies the card has specified a bus width.

verified it didn't mount.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
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

Here is an example of a bad trace: https://pastebin.com/TY2cF9n0
Look for sd_scr and sd_ssr.

 drivers/mmc/core/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 265e1aeeb9d8..f6481f8e9fe7 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -205,6 +205,13 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
 	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
+
+	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
+	if (!scr->bus_widths) {
+		pr_err("%s: invalid bus width\n", mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
 	if (scr->sda_vsn == SCR_SPEC_VER_2)
 		/* Check if Physical Layer Spec v3.0 is supported */
 		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
-- 
2.21.0.392.gf8f6787159e-goog

