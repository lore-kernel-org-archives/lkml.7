Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4034C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A253220842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392974AbfIFJtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:49:40 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:46212 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfIFJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:49:39 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2019 05:49:38 EDT
Received: from localhost.localdomain (10.28.8.29) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 6 Sep 2019
 17:35:25 +0800
From:   chunguo feng <chunguo.feng@amlogic.com>
To:     <edumazet@google.com>
CC:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <netdev@vger.kernel.org>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        fengchunguo <chunguo.feng@amlogic.com>
Subject: [PATCH] tcp: fix tcp_disconnect() not clear tp->fastopen_rsk sometimes
Date:   Fri, 6 Sep 2019 17:34:29 +0800
Message-ID: <20190906093429.930-1-chunguo.feng@amlogic.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.29]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: fengchunguo <chunguo.feng@amlogic.com>

This patch avoids fastopen_rsk not be cleared every times, then occur 
the below BUG_ON:
tcp_v4_destroy_sock
	->BUG_ON(tp->fastopen_rsk);

When playback some videos from netwrok,used tcp_disconnect continually.
        Call trace:
        kfree+0x210/0x250
        tcp_v4_destroy_sock+0xb8/0x1b0
        tcp_v6_destroy_sock+0x20/0x34
        inet_csk_destroy_sock+0x58/0x114
        tcp_done+0x144/0x148
        tcp_rcv_state_process+0x5d4/0xe3c
        tcp_v4_do_rcv+0x74/0x240
        tcp_v4_rcv+0xaac/0xba0
        ip_local_deliver_finish+0xe8/0x25c
        ip_local_deliver+0x60/0x118
        ip_rcv+0x70/0x108
        __netif_receive_skb_core+0x6f8/0xb80
        process_backlog+0xe4/0x1f4
        napi_poll+0x94/0x1ec
        net_rx_action+0xe4/0x224
        __do_softirq+0x16c/0x3bc
        do_softirq.part.15+0x70/0x74
        do_softirq+0x24/0x2c
        netif_rx_ni+0x108/0x138
        dhd_rxf_thread+0x134/0x1e4
        kthread+0x114/0x140
        ret_from_fork+0x10/0x18

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
---
 net/ipv4/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 61082065b26a..f5c354c0b24c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2655,6 +2655,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	/* Clean up fastopen related fields */
 	tcp_free_fastopen_req(tp);
 	inet->defer_connect = 0;
+	tp->fastopen_rsk = 0;
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 
-- 
2.22.0

