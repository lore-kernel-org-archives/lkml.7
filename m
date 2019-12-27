Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D826C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6912E2467D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468679;
	bh=9462vG5edP5NlOFapzQiIpj5nmD1Vr4MejU5jmqmX/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kD0b4R1oZBIX5BRR+FL0HXqjtQ2w9zwRQiqLZl5A2R/dUeXa1jFCIfeFZBg1O2Lpq
	 rzbxH5VNAc/ghY2tERBCSatPu8EhVxT+HiKFkYYO7k1dubHcV4FB5HROTiR3Ldsm1V
	 NSSzVRNbSmy0jMrWBYGhl+3KNwBLg+8nCqTMWbyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfL0Roi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfL0Ro2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF3520740;
        Fri, 27 Dec 2019 17:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468667;
        bh=9462vG5edP5NlOFapzQiIpj5nmD1Vr4MejU5jmqmX/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IK+VFOrIQ1z6rI+0kTNleEXTvbzotXFM5dQdNUsLPPdScrhVgPfrs/fHsFz6NVPdI
         /3eTxfZQPdjb1cBXft0Gs4QpXRgfBAxfdW/JXP+0WCgXi+D7uG9+2fhzHvV68rKnsj
         29D0v2fd/htVD0iTOqroPedNb3EAq/EbZR6niMPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        Xiao Jiangfeng <xiaojiangfeng@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/84] af_packet: set defaule value for tmo
Date:   Fri, 27 Dec 2019 12:42:56 -0500
Message-Id: <20191227174352.6264-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit b43d1f9f7067c6759b1051e8ecb84e82cef569fe ]

There is softlockup when using TPACKET_V3:
...
NMI watchdog: BUG: soft lockup - CPU#2 stuck for 60010ms!
(__irq_svc) from [<c0558a0c>] (_raw_spin_unlock_irqrestore+0x44/0x54)
(_raw_spin_unlock_irqrestore) from [<c027b7e8>] (mod_timer+0x210/0x25c)
(mod_timer) from [<c0549c30>]
(prb_retire_rx_blk_timer_expired+0x68/0x11c)
(prb_retire_rx_blk_timer_expired) from [<c027a7ac>]
(call_timer_fn+0x90/0x17c)
(call_timer_fn) from [<c027ab6c>] (run_timer_softirq+0x2d4/0x2fc)
(run_timer_softirq) from [<c021eaf4>] (__do_softirq+0x218/0x318)
(__do_softirq) from [<c021eea0>] (irq_exit+0x88/0xac)
(irq_exit) from [<c0240130>] (msa_irq_exit+0x11c/0x1d4)
(msa_irq_exit) from [<c0209cf0>] (handle_IPI+0x650/0x7f4)
(handle_IPI) from [<c02015bc>] (gic_handle_irq+0x108/0x118)
(gic_handle_irq) from [<c0558ee4>] (__irq_usr+0x44/0x5c)
...

If __ethtool_get_link_ksettings() is failed in
prb_calc_retire_blk_tmo(), msec and tmo will be zero, so tov_in_jiffies
is zero and the timer expire for retire_blk_timer is turn to
mod_timer(&pkc->retire_blk_timer, jiffies + 0),
which will trigger cpu usage of softirq is 100%.

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Tested-by: Xiao Jiangfeng <xiaojiangfeng@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7204e7bbebb0..ac65e66d1d72 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -552,7 +552,8 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 			msec = 1;
 			div = ecmd.base.speed / 1000;
 		}
-	}
+	} else
+		return DEFAULT_PRB_RETIRE_TOV;
 
 	mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
 
-- 
2.20.1

