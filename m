Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91433C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CD0205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OaB/4ACU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfEGU56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:57:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36444 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfEGU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:57:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so1281180plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TzIDRvnZo9wzh0xH3koUcb27TGvZ58GI6x5LKLeUe9I=;
        b=OaB/4ACU/IWVZycUh57X29GmMnkaQrLyMkJ3KidBs2HBMnVPyuS8/OBUtIfMxShvCn
         WgUQF4rEGtZONQ4PmLZ2gf/8xYixQd+1MwAMSvyy+W7G2Jrrw7gY9Hiqu/RRw8+PtJqE
         X2bMJd2tWgRU7o3C1/rJU8nhc5o8adgsUhM0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TzIDRvnZo9wzh0xH3koUcb27TGvZ58GI6x5LKLeUe9I=;
        b=paFJwAuazFz5v+BiXGVZBz2bOF/ibPoxml5P4O3IbpE1uQ0qIpLUtjpqizXngX+E1E
         qXCdteMtN3t2nH5iz8TPU3FwlvZruVwVje7ufWExIgvoq+tY1tLdqbt9AXbtAFo2/qzK
         f1BROHlUf3+buUNgDdI4x/hPLDdsoRte0PLgHpaYiY2vbfVXuK4w970pJch+QYH9gyFv
         SUHgz3XKeuEtrWjydi/+ZL5clwHhAvbpVi4TLNIU+f0BqcoN5JS75UEkY9JgKwanqiwl
         32jL81UI/mXFs2jqgXtWmDLFjW/1Y9qAnHV25UibCq96Q4EuTjkPHmdntP3UhsbgnbKp
         phhQ==
X-Gm-Message-State: APjAAAWdLZxwoBpxWwogSG5hKwWGrpbUTqK0ky0VonMSwUduNeI1O8D0
        yhCuGvKTttjA+6l1eHRNJmHYHw==
X-Google-Smtp-Source: APXvYqzYlHZ7coikKWCS9HQ5qQvpgCjiuR9K5Lq4yfRHG4UsIqkyhrUN0ehUlirvQ6B8bDiFku6CcQ==
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr42103644plo.54.1557262677391;
        Tue, 07 May 2019 13:57:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id m6sm16482035pgq.0.2019.05.07.13.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:57:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>, hal@halemmerich.com,
        amstan@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: rockchip: Slightly more accurate math in rockchip_mmc_get_phase()
Date:   Tue,  7 May 2019 13:57:42 -0700
Message-Id: <20190507205742.50835-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bit of math in rockchip_mmc_get_phase() to calculate the
"fine delay".  This math boils down to:

 PSECS_PER_SEC = 1000000000000.
 ROCKCHIP_MMC_DELAY_ELEMENT_PSEC = 60
 card_clk * ROCKCHIP_MMC_DELAY_ELEMENT_PSEC * 360 * x / PSECS_PER_SEC

...but we do it in pieces to avoid overflowing 32-bits.  Right now we
overdo it a little bit, though, and end up getting less accurate math
than we could.  Right now we do:

 DIV_ROUND_CLOSEST((card_clk / 1000000) *
                   (ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10) *
                   (360 / 10) *
		   delay_num,
		   PSECS_PER_SEC / 1000000 / 10 / 10)

This is non-ideal because:
A) The pins on Rockchip SoCs are rated to go at most 150 MHz, so the
   max card clock is 150 MHz.  Even ignoring this the maximum SD card
   clock (for SDR104) would be 208 MHz.  This means you can decrease
   your division by 100x and still not overflow:
     hex(208000000 / 10000 * 6 * 36 * 0xff) == 0x44497200
B) On many Rockchip SoCs we end up with a card clock that is actually
   148500000 because we parent off the 297 MHz PLL.  That means the
   math we're actually doing today is less than ideal.  Specifically:
   148500000 / 1000000 = 148

Let's fix the math to be slightly more accurate.

NOTE: no known problems are fixed by this.  It was found simply by
code inspection.  If you want to see the difference between the old
and the new on a 148.5 MHz clock, this python can help:

  old = [x for x in
         (int(round(148 * 6 * 36 * x / 10000.)) for x in range(256))
	 if x < 90]
  new = [x for x in
         (int(round(1485 * 6 * 36 * x / 100000.)) for x in range(256))
	 if x < 90]

The only differences are:
  delay_num=17 54=>55
  delay_num=22 70=>71
  delay_num=27 86=>87

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/rockchip/clk-mmc-phase.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 026a26bb702d..9b2f4c094adf 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -71,13 +71,13 @@ static int rockchip_mmc_get_phase(struct clk_hw *hw)
 	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
 
 	if (raw_value & ROCKCHIP_MMC_DELAY_SEL) {
-		/* degrees/delaynum * 10000 */
+		/* degrees/delaynum * 1000000 */
 		unsigned long factor = (ROCKCHIP_MMC_DELAY_ELEMENT_PSEC / 10) *
-					36 * (rate / 1000000);
+					36 * (rate / 10000);
 
 		delay_num = (raw_value & ROCKCHIP_MMC_DELAYNUM_MASK);
 		delay_num >>= ROCKCHIP_MMC_DELAYNUM_OFFSET;
-		degrees += DIV_ROUND_CLOSEST(delay_num * factor, 10000);
+		degrees += DIV_ROUND_CLOSEST(delay_num * factor, 1000000);
 	}
 
 	return degrees % 360;
-- 
2.21.0.1020.gf2820cf01a-goog

