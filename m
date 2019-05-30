Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22490C28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBB824AF0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187028;
	bh=9cnLBFqP/liz1+ZUjA7+63ydi1ZxnYtGSzg8LDqXNq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y6zZyp78Ol4HlvMy90G4BH24zYV5UuIiLlv5DbzphmnsuP4YfQPI1KeX+Jjvzu+H+
	 bwpivukXL62pMrL6EnbsaMEQc0IsgwgI/vTAttaziroQcD80j8s6QUc5AgYzOppQDw
	 u0gHnWTt2o3+ZGtUA2H+dwQBqUt0Y/L4wfEz/Uqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbfE3Da1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732559AbfE3DV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:26 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8828F24A03;
        Thu, 30 May 2019 03:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186485;
        bh=9cnLBFqP/liz1+ZUjA7+63ydi1ZxnYtGSzg8LDqXNq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkJYtCgzMlIqPqqY8mmSSLJNgXgOh6RZ4eZH1J7YwS8Ml3lQmrWijPTlbrMZRp9Uh
         dAjfJafat/mz2xWMCTrsE4pDqxJqKzcVbx+xin3H1dhZx+eyDIs6eh2idw4148QhDM
         kGa0bW/Yv1PVSOzw+nnECuoETqTdKcrSYhRTfxXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 125/128] spi: rspi: Fix sequencer reset during initialization
Date:   Wed, 29 May 2019 20:07:37 -0700
Message-Id: <20190530030456.775197787@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 26843bb128590edd7eba1ad7ce22e4b9f1066ce3 ]

While the sequencer is reset after each SPI message since commit
880c6d114fd79a69 ("spi: rspi: Add support for Quad and Dual SPI
Transfers on QSPI"), it was never reset for the first message, thus
relying on reset state or bootloader settings.

Fix this by initializing it explicitly during configuration.

Fixes: 0b2182ddac4b8837 ("spi: add support for Renesas RSPI")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rspi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 093c9cf92bfd3..07612e8c58ee8 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -279,7 +279,8 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 	/* Sets parity, interrupt mask */
 	rspi_write8(rspi, 0x00, RSPI_SPCR2);
 
-	/* Sets SPCMD */
+	/* Resets sequencer */
+	rspi_write8(rspi, 0, RSPI_SPSCR);
 	rspi->spcmd |= SPCMD_SPB_8_TO_16(access_size);
 	rspi_write16(rspi, rspi->spcmd, RSPI_SPCMD0);
 
@@ -323,7 +324,8 @@ static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 	rspi_write8(rspi, 0x00, RSPI_SSLND);
 	rspi_write8(rspi, 0x00, RSPI_SPND);
 
-	/* Sets SPCMD */
+	/* Resets sequencer */
+	rspi_write8(rspi, 0, RSPI_SPSCR);
 	rspi->spcmd |= SPCMD_SPB_8_TO_16(access_size);
 	rspi_write16(rspi, rspi->spcmd, RSPI_SPCMD0);
 
@@ -374,7 +376,8 @@ static int qspi_set_config_register(struct rspi_data *rspi, int access_size)
 	/* Sets buffer to allow normal operation */
 	rspi_write8(rspi, 0x00, QSPI_SPBFCR);
 
-	/* Sets SPCMD */
+	/* Resets sequencer */
+	rspi_write8(rspi, 0, RSPI_SPSCR);
 	rspi_write16(rspi, rspi->spcmd, RSPI_SPCMD0);
 
 	/* Enables SPI function in master mode */
-- 
2.20.1



