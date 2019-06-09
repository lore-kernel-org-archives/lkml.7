Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BF5C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A360206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099829;
	bh=9LJBPhhgCXn4j8CTWEVyTQ6fo+0Of7f5Yrs6ApXe3N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XKdz1U5AuR4VNQ4pKoQM/aeySysvAe3azsMeFSmz1mqSUWWGiSEEWC8r/+P7lee2A
	 U8o0H2nAqHu9pOnSpefxteN9RTr9lkXyUxEy7C0mBaUGjdODZJmArDNlX1bM4Lky3E
	 miY5mObrE9fZfe6lHU4QaLbqDHWYgXkm2qFdD83w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbfFIRDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388485AbfFIRDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:03:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C43E8206C3;
        Sun,  9 Jun 2019 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099826;
        bh=9LJBPhhgCXn4j8CTWEVyTQ6fo+0Of7f5Yrs6ApXe3N8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYksygU4cIaPOPZy+JFlFw/ciy6iVfsA2rFsbZ8GQKNa3qSSDCgyNKoJZ/3fzNSpx
         n6GxerVskqBKXDbxGdX5JlmKXiNN/Q/Jmipzetr0oora4BPIVLXCKKPr+o8gJKLF3T
         seXxkeCj2cOoCQ+QPoy0HQdkY4Z3530/8rF2tMBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Lesiak <chris.lesiak@licor.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 178/241] spi: Fix zero length xfer bug
Date:   Sun,  9 Jun 2019 18:42:00 +0200
Message-Id: <20190609164152.975610585@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
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
index 04fd651f9e3e3..c132c676df3a6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -903,6 +903,8 @@ static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
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



