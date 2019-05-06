Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DEFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6D3206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153650;
	bh=dm6ifMpfXiurS4QVclu7KofyLbAIH7zrtJpf5C4whmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vUH3XK6l0Qk6nF7dLba6tMmNgn77+2RJnRP9v0ggJyTfj+9BTGI3CACVUZx8Tb+rg
	 2xARZMBes75vAB6gr5gCQ+pcLbwFWMPXqQMOB+hEey6CRD9Nrz2vS5ffF1i84PW6v8
	 hgpgXa5hqr7/eAINTMfuVloiyDJwqAsRJ0irqbi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEFOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfEFOko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:40:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC39920449;
        Mon,  6 May 2019 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153643;
        bh=dm6ifMpfXiurS4QVclu7KofyLbAIH7zrtJpf5C4whmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/3SzNlMxYEEgGHMSlLRvGc0hj9adD/4nPPzN2GBykxb9atJWt/9i2cCYmXetQ5wD
         8JNUXo1Rya0p4l1u44o8ewJAs+zZyhmgxiBVU9OvZ9HLx780ZO5VLUSlxlk06xLCys
         Me04CywUCQNRv7HkoMre6IkdfNZw5+KCjzcDCAn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@nokia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 42/99] net: stmmac: fix dropping of multi-descriptor RX frames
Date:   Mon,  6 May 2019 16:32:15 +0200
Message-Id: <20190506143057.775937269@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8ac0c24fe1c256af6644caf3d311029440ec2fbd ]

Packets without the last descriptor set should be dropped early. If we
receive a frame larger than the DMA buffer, the HW will continue using the
next descriptor. Driver mistakes these as individual frames, and sometimes
a truncated frame (without the LD set) may look like a valid packet.

This fixes a strange issue where the system replies to 4098-byte ping
although the MTU/DMA buffer size is set to 4096, and yet at the same
time it's logging an oversized packet.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index c42ef6c729c0..5202d6ad7919 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -201,6 +201,11 @@ static int enh_desc_get_rx_status(void *data, struct stmmac_extra_stats *x,
 	if (unlikely(rdes0 & RDES0_OWN))
 		return dma_own;
 
+	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
+		stats->rx_length_errors++;
+		return discard_frame;
+	}
+
 	if (unlikely(rdes0 & RDES0_ERROR_SUMMARY)) {
 		if (unlikely(rdes0 & RDES0_DESCRIPTOR_ERROR)) {
 			x->rx_desc++;
-- 
2.20.1



