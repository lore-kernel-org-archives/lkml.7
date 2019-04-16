Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B03C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45F12063F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JunfYtDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfDPS5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:57:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34532 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbfDPS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:57:10 -0400
Received: by mail-io1-f65.google.com with SMTP id n11so18540673ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l1KWYHAuYUVf8bjjh0jDa0cfeK+F4GWiyYfdHN7gxb4=;
        b=JunfYtDIw9UNsyNXQAnGtBLYVcaP/YEfWP6ay7qK3JApcUo4Bdg0EhRdybpiDnvrID
         k+DhGwd2OKDGOy/9ImfL8t+Ij4Ynq+c6LRp/CGwneyqjqZNKig6+vGqXgW59sQNhuY7e
         SzYnykZSuPytzLIjQyZf51XUcEZ4N7g8C9e9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l1KWYHAuYUVf8bjjh0jDa0cfeK+F4GWiyYfdHN7gxb4=;
        b=pzn1kW3yw7RbmYnmHxQ24MjYFJfX0qe9HCH2ZxzuLjheByoR7ejONprnNI9K5FwgIC
         gTkj13AnDegWinZDHX5h7C2zqaPP7XFOuCos30oYwSlPf2Apsyacvh1R3tnkTqmGqI+n
         seG0Y4HzJYJpBd/KDO/T9dI63wvoyJTE/EMTM1I0EneeL8PnAGj6dlO2ymaBDXWqYs86
         MTqj39PkBufEF1ikq8YlhSmX5/1JiK6lY4/hpMdIicewBEcxRJvS/5170yrk4r8Tqn/F
         DrnLkpFR8iC62zsHmTR/FXS/pylrZ+qJF1k2C4ifVpjmn2qouvtVwyXdYDPWEJnQNsAV
         88XA==
X-Gm-Message-State: APjAAAXKlGuTuguaBIO6QdyQW9eqvRFxCVxBFxKooKQg1WuSO5re3Fyi
        /KRcWKEKePZPR0iVVU/9JQNH5w==
X-Google-Smtp-Source: APXvYqzEotswXO+6o5G9+5O8hsntC99kx4Z7vLQCrKm1XxDUXThLqY7j/8sed487xniHAti8P0kpJA==
X-Received: by 2002:a6b:fe07:: with SMTP id x7mr18403013ioh.3.1555441029456;
        Tue, 16 Apr 2019 11:57:09 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id 19sm140814itm.6.2019.04.16.11.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:57:08 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        hongjiefang <hongjiefang@asrmicro.com>,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] mmc: core: Verify SD bus width
Date:   Tue, 16 Apr 2019 12:57:05 -0600
Message-Id: <20190416185705.256369-1-rrangel@chromium.org>
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

Acked-by: Avri Altman <avri.altman@wdc.com>

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
This patch currently requires the SD trace events patch to be applied
first for it to apply cleanly.

See: https://patchwork.kernel.org/cover/10903761

This is because I want the check to happen after the trace call. This
way the invalid valid response is traced.

I can also change the base so it applies cleanly to master if that is
desired.

Here is the testing I did:

Good Trace: https://paste.fedoraproject.org/paste/oVEI5b0IzHD23Yo7CDZgEg
[   30.103686] mmc0: new high speed SDHC card at address 0001
[   30.105262] mmcblk0: mmc0:0001 00000 7.41 GiB
[   30.108258]  mmcblk0: p1
[   31.947250] mmc0: card 0001 removed

Bad Trace (before patch): https://paste.fedoraproject.org/paste/jBWfpFBM8gdEmGOzxij~hw

Bad Trace (after patch): https://paste.fedoraproject.org/paste/8gB8MLYOKEUZEgHXmQ0W1Q
[   33.810760] mmc0: invalid bus width
[   33.810782] mmc0: error -22 whilst initialising SD card
[   34.068818] mmc0: invalid bus width
[   34.068839] mmc0: error -22 whilst initialising SD card
[   34.329521] mmc0: invalid bus width
[   34.329543] mmc0: error -22 whilst initialising SD card
[   34.592061] mmc0: invalid bus width
[   34.592084] mmc0: error -22 whilst initialising SD card

In the traces you can see sd_scr is different

Changes in v2:
- Made the bus width check stricter. It now requires the value to match
  the spec.
- Rebased on SD Trace Event patch

 drivers/mmc/core/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 3b2e09fa72c5..a73f3dbb6029 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -229,6 +229,13 @@ static int mmc_decode_scr(struct mmc_card *card)
 
 	trace_sd_scr(card, scr);
 
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
2.21.0.392.gf8f6787159e-goog

