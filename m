Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BC6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ABC20659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997892;
	bh=hClCOuEvdCADNVMvizEYVegquX/rvm/xd/UZKcrbk18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z4f8itrmg9G97g8IYW6tapEBg4JWQO+9k/69ekF8Hm/KuQTxs0SAMfoGFykyWHBPf
	 7UWK3Z1mOsHhA8/t5DQ9uhzNI59EDOnzTupRj6eDonx8Un/0PiS6ELYTPzllTxjoka
	 iW1UCV/c6wdB3zknXa0o2wwTuBNZqKbgRWpomSSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404012AbfGXTva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:51:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403955AbfGXTv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:51:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 796C720665;
        Wed, 24 Jul 2019 19:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997886;
        bh=hClCOuEvdCADNVMvizEYVegquX/rvm/xd/UZKcrbk18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjBHukrZbe9LDpqiXxeTzl8avWb7fP/TJH+ia5Ofyn6O02z6HDurmNj8OnETeXMjr
         2o81/qFcsTkBrxDWiW4pNw4ZlBcqmvaSvoJ0PuowGu3X1QgggRl9z6xP4veF1DYQpf
         rHiKJxmKlJyv/JSU2ftIkNO54xs48kctQGNn/YVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vedang Patel <vedang.patel@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 178/371] igb: clear out skb->tstamp after reading the txtime
Date:   Wed, 24 Jul 2019 21:18:50 +0200
Message-Id: <20190724191738.595031767@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1e08511d5d01884a3c9070afd52a47799312074a ]

If a packet which is utilizing the launchtime feature (via SO_TXTIME socket
option) also requests the hardware transmit timestamp, the hardware
timestamp is not delivered to the userspace. This is because the value in
skb->tstamp is mistaken as the software timestamp.

Applications, like ptp4l, request a hardware timestamp by setting the
SOF_TIMESTAMPING_TX_HARDWARE socket option. Whenever a new timestamp is
detected by the driver (this work is done in igb_ptp_tx_work() which calls
igb_ptp_tx_hwtstamps() in igb_ptp.c[1]), it will queue the timestamp in the
ERR_QUEUE for the userspace to read. When the userspace is ready, it will
issue a recvmsg() call to collect this timestamp.  The problem is in this
recvmsg() call. If the skb->tstamp is not cleared out, it will be
interpreted as a software timestamp and the hardware tx timestamp will not
be successfully sent to the userspace. Look at skb_is_swtx_tstamp() and the
callee function __sock_recv_timestamp() in net/socket.c for more details.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 580d14b49fda..a725dc709632 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5687,6 +5687,7 @@ static void igb_tx_ctxtdesc(struct igb_ring *tx_ring,
 	 */
 	if (tx_ring->launchtime_enable) {
 		ts = ns_to_timespec64(first->skb->tstamp);
+		first->skb->tstamp = 0;
 		context_desc->seqnum_seed = cpu_to_le32(ts.tv_nsec / 32);
 	} else {
 		context_desc->seqnum_seed = 0;
-- 
2.20.1



