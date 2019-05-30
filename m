Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30B0C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6E24BE9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187651;
	bh=MJTDkh2AziCPNSnC+hzsNYoXww07ZvlQBMAu8wg5LDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L6F3zOjWe2Ui7/ggS0miteRAYyOwVz2DgrYZZDKCh/nqz4BuNPUXs2CVXcpEZry9Z
	 8JYol74xe5Jt8j0wIfNMYDC6wYEqn0W/bgEt5fWjcfqmSaSjnJMyBsmilDTP+sGTQG
	 zaH+gaIDgi/vjd3KnKEmUXwiuwGvBMYZaYe7iDvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfE3Dkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbfE3DV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:26 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D6324A19;
        Thu, 30 May 2019 03:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186486;
        bh=MJTDkh2AziCPNSnC+hzsNYoXww07ZvlQBMAu8wg5LDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGuzi7UhIQId9uUpgYQEYonFZXhuGr7GVkXKy91s0guL/FcsH3PSuwW2M715O8Ex9
         4rPAZl1g3Q29zqO7FRO86ZD7cD/vcWUEnLicL4ix8+9UNogJGF5ORcmC1VbLTWR31Y
         wg+SUDKVaNramgPGuFeXEPnelMSkl32TcmQmBF/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Lesiak <chris.lesiak@licor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 126/128] spi: Fix zero length xfer bug
Date:   Wed, 29 May 2019 20:07:38 -0700
Message-Id: <20190530030456.870544376@linuxfoundation.org>
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

[ Upstream commit 5442dcaa0d90fc376bdfc179a018931a8f43dea4 ]

This fixes a bug for messages containing both zero length and
unidirectional xfers.

The function spi_map_msg will allocate dummy tx and/or rx buffers
for use with unidirectional transfers when the hardware can only do
a bidirectional transfer.  That dummy buffer will be used in place
of a NULL buffer even when the xfer length is 0.

Then in the function __spi_map_msg, if he hardware can dma,
the zero length xfer will have spi_map_buf called on the dummy
buffer.

Eventually, __sg_alloc_table is called and returns -EINVAL
because nents == 0.

This fix prevents the error by not using the dummy buffer when
the xfer length is zero.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c2e85e23d538e..d74d341f9890d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -955,6 +955,8 @@ static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
 		if (max_tx || max_rx) {
 			list_for_each_entry(xfer, &msg->transfers,
 					    transfer_list) {
+				if (!xfer->len)
+					continue;
 				if (!xfer->tx_buf)
 					xfer->tx_buf = master->dummy_tx;
 				if (!xfer->rx_buf)
-- 
2.20.1



