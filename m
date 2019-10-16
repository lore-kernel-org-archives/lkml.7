Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933EFECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662CE207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264299;
	bh=mYrFo0W9gI8djX/nmVkmDQqAzDr5zN+mypISr36JtF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KAWoeJEU2ztiQYtncsEaZ/REwNGO4YQwQ0wnd+r2IEg2wezCgeHNBBvA0ogIfTVHj
	 gsEHXb09tzFGoGSS9ZjWnYxHAm9Jz1Oh9DyIfRjdabeUE6UnDqaxbBhhLo6I0LDEr9
	 N4usBTmEU1+W5dB17qRNUx+VtbCzfnv2OyVpW6Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390917AbfJPWSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbfJPVya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:30 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8146E20872;
        Wed, 16 Oct 2019 21:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262869;
        bh=mYrFo0W9gI8djX/nmVkmDQqAzDr5zN+mypISr36JtF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JF8MeTixq16GkEXDmmBuAa4bCNaIG9+M9oGChFnK1hpyr1grGN6eE4ysJciyXohfE
         HOCBlf21E+CXXRmeuMl+r342TLEZJuH6SL4ne6t5sUnimphIcGIv2WEmXaUdhUhXv8
         I7RxwqZeQzxTnA8UQ1Sf7kkiKfLGEA/Uf+xBGifs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 08/92] can: mcp251x: mcp251x_hw_reset(): allow more time after a reset
Date:   Wed, 16 Oct 2019 14:49:41 -0700
Message-Id: <20191016214805.498638552@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit d84ea2123f8d27144e3f4d58cd88c9c6ddc799de upstream.

Some boards take longer than 5ms to power up after a reset, so allow
some retries attempts before giving up.

Fixes: ff06d611a31c ("can: mcp251x: Improve mcp251x_hw_reset()")
Cc: linux-stable <stable@vger.kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/spi/mcp251x.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -627,7 +627,7 @@ static int mcp251x_setup(struct net_devi
 static int mcp251x_hw_reset(struct spi_device *spi)
 {
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
-	u8 reg;
+	unsigned long timeout;
 	int ret;
 
 	/* Wait for oscillator startup timer after power up */
@@ -641,10 +641,19 @@ static int mcp251x_hw_reset(struct spi_d
 	/* Wait for oscillator startup timer after reset */
 	mdelay(MCP251X_OST_DELAY_MS);
 
-	reg = mcp251x_read_reg(spi, CANSTAT);
-	if ((reg & CANCTRL_REQOP_MASK) != CANCTRL_REQOP_CONF)
-		return -ENODEV;
-
+	/* Wait for reset to finish */
+	timeout = jiffies + HZ;
+	while ((mcp251x_read_reg(spi, CANSTAT) & CANCTRL_REQOP_MASK) !=
+	       CANCTRL_REQOP_CONF) {
+		usleep_range(MCP251X_OST_DELAY_MS * 1000,
+			     MCP251X_OST_DELAY_MS * 1000 * 2);
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(&spi->dev,
+				"MCP251x didn't enter in conf mode after reset\n");
+			return -EBUSY;
+		}
+	}
 	return 0;
 }
 


