Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A93C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B998620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKbBdaaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFZK2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:28:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34110 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfFZK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so2126784wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2uYpOpXs+pbPux8Et5aQ4qoOceeJiTpOWIeON9aqJw=;
        b=TKbBdaaGYBpQghXpwDdVwuYb2eCWIDnI0Lq2bX+5Ha7ssWcmvOzVFnhTmq7RY7F16j
         3i7coj0QCT3zQ3ystfb83L4SINRepuK4shd6GTXtBWTQ3M81th5gOmuB1aces34W8oqi
         XrpOYvnk6LNfhvIwp44XXW8jCEy6FLEt0J/KQBAIhGBLt0xL5JQR3fKTxMUjomnxVfPx
         VBdOjiimLfLkrbfAObkmp8FdRuZ+y7cqEKd7UQHhieS7xDaBotVrBkFIL1zfQ1bkV2pQ
         eIUIfb7Nm85ZDgU5lkZZWG64qigVpgceTPCphe/S4LtxEaWbqQrvZpnlvzlnyTICxriQ
         LSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2uYpOpXs+pbPux8Et5aQ4qoOceeJiTpOWIeON9aqJw=;
        b=VHfYvc4k4wbUTgT12pRfRcVcaQqWYOg5Ifski1zrwP8U7pDpfjDmV4v98o3EvaLoW7
         KSAa7C6aOa+mZa/9AjThQzY+ampkCEHuzoRAU8YCKLk2XQ4N5nCEafwsM7TQTD3CZVSc
         gfD1IS3jOlJ3ElR2vYOov/aNambpzXsmw3O0kDN58T6Yk9/DSmoklC7k909H0bi3DlnS
         cudMp7MSgxReEeQHQ887xwDLJ25m04J0mqqtgFBueCKdGSu8qAYK24ZQikiQSNGqNIlc
         ZXWjrS6YLLAObN6iR+qbJgAiLB4SmsV4MH97Rup/nwe7OGe7mRP5ctCSlZq3n+m7Zf4B
         ryJA==
X-Gm-Message-State: APjAAAV21XquVePq4+DsPf1AJg70QfpcmqsA3yGOypB9dn84v74nBT8o
        XX73mFWJOz+Q/Iu+Ail6oKMXGg==
X-Google-Smtp-Source: APXvYqxt3xXw6zPmzq+Jg1Wkb/bwFGikCdRC/55sVP0S3p2sNDd+C0O3qGrll+hpAOrNtxDvex5vQQ==
X-Received: by 2002:adf:e490:: with SMTP id i16mr3068418wrm.280.1561544883691;
        Wed, 26 Jun 2019 03:28:03 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z19sm2212042wmi.7.2019.06.26.03.28.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:28:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] nvmem: imx-ocotp: Change TIMING calculation to u-boot algorithm
Date:   Wed, 26 Jun 2019 11:27:30 +0100
Message-Id: <20190626102733.11708-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
References: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

The RELAX field of the OCOTP block is turning out as a zero on i.MX8MM.
This messes up the subsequent re-load of the fuse shadow registers.

After some discussion with people @ NXP its clear we have missed a trick
here in Linux.

The OCOTP fuse programming time has a physical minimum 'burn time' that is
not related to the ipg_clk.

We need to define the RELAX, STROBE_READ and STROBE_PROG fields in terms of
desired timings to allow for the burn-in to safely complete. Right now only
the RELAX field is calculated in terms of an absolute time and we are
ending up with a value of zero.

This patch inherits the u-boot timings for the OCOTP_TIMING calculation on
the i.MX6 and i.MX8. Those timings are known to work and critically specify
values such as STROBE_PROG as a minimum timing.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Suggested-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index f4e117bbf2c3..b7dacf53c715 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -44,7 +44,9 @@
 #define IMX_OCOTP_BM_CTRL_ERROR		0x00000200
 #define IMX_OCOTP_BM_CTRL_REL_SHADOWS	0x00000400
 
-#define DEF_RELAX			20	/* > 16.5ns */
+#define TIMING_STROBE_PROG_US		10	/* Min time to blow a fuse */
+#define TIMING_STROBE_READ_NS		37	/* Min time before read */
+#define TIMING_RELAX_NS			17
 #define DEF_FSOURCE			1001	/* > 1000 ns */
 #define DEF_STROBE_PROG			10000	/* IPG clocks */
 #define IMX_OCOTP_WR_UNLOCK		0x3E770000
@@ -176,12 +178,38 @@ static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 	 * fields with timing values to match the current frequency of the
 	 * ipg_clk. OTP writes will work at maximum bus frequencies as long
 	 * as the HW_OCOTP_TIMING parameters are set correctly.
+	 *
+	 * Note: there are minimum timings required to ensure an OTP fuse burns
+	 * correctly that are independent of the ipg_clk. Those values are not
+	 * formally documented anywhere however, working from the minimum
+	 * timings given in u-boot we can say:
+	 *
+	 * - Minimum STROBE_PROG time is 10 microseconds. Intuitively 10
+	 *   microseconds feels about right as representative of a minimum time
+	 *   to physically burn out a fuse.
+	 *
+	 * - Minimum STROBE_READ i.e. the time to wait post OTP fuse burn before
+	 *   performing another read is 37 nanoseconds
+	 *
+	 * - Minimum RELAX timing is 17 nanoseconds. This final RELAX minimum
+	 *   timing is not entirely clear the documentation says "This
+	 *   count value specifies the time to add to all default timing
+	 *   parameters other than the Tpgm and Trd. It is given in number
+	 *   of ipg_clk periods." where Tpgm and Trd refer to STROBE_PROG
+	 *   and STROBE_READ respectively. What the other timing parameters
+	 *   are though, is not specified. Experience shows a zero RELAX
+	 *   value will mess up a re-load of the shadow registers post OTP
+	 *   burn.
 	 */
 	clk_rate = clk_get_rate(priv->clk);
 
-	relax = clk_rate / (1000000000 / DEF_RELAX) - 1;
-	strobe_prog = clk_rate / (1000000000 / 10000) + 2 * (DEF_RELAX + 1) - 1;
-	strobe_read = clk_rate / (1000000000 / 40) + 2 * (DEF_RELAX + 1) - 1;
+	relax = DIV_ROUND_UP(clk_rate * TIMING_RELAX_NS, 1000000000) - 1;
+	strobe_read = DIV_ROUND_UP(clk_rate * TIMING_STROBE_READ_NS,
+				   1000000000);
+	strobe_read += 2 * (relax + 1) - 1;
+	strobe_prog = DIV_ROUND_CLOSEST(clk_rate * TIMING_STROBE_PROG_US,
+					1000000);
+	strobe_prog += 2 * (relax + 1) - 1;
 
 	timing = readl(priv->base + IMX_OCOTP_ADDR_TIMING) & 0x0FC00000;
 	timing |= strobe_prog & 0x00000FFF;
-- 
2.21.0

