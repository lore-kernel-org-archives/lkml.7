Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A43C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0C220652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129073;
	bh=1/SyIu0OXXX2OtItZtMTZDyFUPZSjpx3GPUXkohNUIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q4iylqD4zVMgEGgzrmggpbpZ1r3CwbKZl7MrIKuKIAZQjis0e3J5J+WCQTMXWgnJz
	 fwpiJtlGqPnraJlSR5wbUEG7b9wLMYucrE0SphN5kRW4fgSR3fOYz6jf3OVFvM+Xbu
	 zfuUwt19fiBAFN5Sj4QsIkyX8GCQozUvcuP1Z17Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389761AbfDXSEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387953AbfDXRTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:17 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D64205ED;
        Wed, 24 Apr 2019 17:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126355;
        bh=1/SyIu0OXXX2OtItZtMTZDyFUPZSjpx3GPUXkohNUIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hK5dWuUifKEhIktAjRVg8e4AmeHHWMB683FAbLNNbbzMS0St/TjYgzMMehym5oAFc
         mBgXIV4qhKNxvDxyo3HHVfc2POc7N8Zg4JkN2yUQEYhxm/+fjeB1kOJxALkgY19dtU
         t1k67Lebq6NuOM1J9tTq3zkspJgI8WiRtESjI4Qs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>,
        Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 083/168] tcp: Ensure DCTCP reacts to losses
Date:   Wed, 24 Apr 2019 19:08:47 +0200
Message-Id: <20190424170928.734963793@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>

[ Upstream commit aecfde23108b8e637d9f5c5e523b24fb97035dc3 ]

RFC8257 §3.5 explicitly states that "A DCTCP sender MUST react to
loss episodes in the same way as conventional TCP".

Currently, Linux DCTCP performs no cwnd reduction when losses
are encountered. Optionally, the dctcp_clamp_alpha_on_loss resets
alpha to its maximal value if a RTO happens. This behavior
is sub-optimal for at least two reasons: i) it ignores losses
triggering fast retransmissions; and ii) it causes unnecessary large
cwnd reduction in the future if the loss was isolated as it resets
the historical term of DCTCP's alpha EWMA to its maximal value (i.e.,
denoting a total congestion). The second reason has an especially
noticeable effect when using DCTCP in high BDP environments, where
alpha normally stays at low values.

This patch replace the clamping of alpha by setting ssthresh to
half of cwnd for both fast retransmissions and RTOs, at most once
per RTT. Consequently, the dctcp_clamp_alpha_on_loss module parameter
has been removed.

The table below shows experimental results where we measured the
drop probability of a PIE AQM (not applying ECN marks) at a
bottleneck in the presence of a single TCP flow with either the
alpha-clamping option enabled or the cwnd halving proposed by this
patch. Results using reno or cubic are given for comparison.

                          |  Link   |   RTT    |    Drop
                 TCP CC   |  speed  | base+AQM | probability
        ==================|=========|==========|============
                    CUBIC |  40Mbps |  7+20ms  |    0.21%
                     RENO |         |          |    0.19%
        DCTCP-CLAMP-ALPHA |         |          |   25.80%
         DCTCP-HALVE-CWND |         |          |    0.22%
        ------------------|---------|----------|------------
                    CUBIC | 100Mbps |  7+20ms  |    0.03%
                     RENO |         |          |    0.02%
        DCTCP-CLAMP-ALPHA |         |          |   23.30%
         DCTCP-HALVE-CWND |         |          |    0.04%
        ------------------|---------|----------|------------
                    CUBIC | 800Mbps |   1+1ms  |    0.04%
                     RENO |         |          |    0.05%
        DCTCP-CLAMP-ALPHA |         |          |   18.70%
         DCTCP-HALVE-CWND |         |          |    0.06%

We see that, without halving its cwnd for all source of losses,
DCTCP drives the AQM to large drop probabilities in order to keep
the queue length under control (i.e., it repeatedly faces RTOs).
Instead, if DCTCP reacts to all source of losses, it can then be
controlled by the AQM using similar drop levels than cubic or reno.

Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
Cc: Bob Briscoe <research@bobbriscoe.net>
Cc: Lawrence Brakmo <brakmo@fb.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Daniel Borkmann <borkmann@iogearbox.net>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Andrew Shewmaker <agshew@gmail.com>
Cc: Glenn Judd <glenn.judd@morganstanley.com>
Acked-by: Florian Westphal <fw@strlen.de>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_dctcp.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -66,11 +66,6 @@ static unsigned int dctcp_alpha_on_init
 module_param(dctcp_alpha_on_init, uint, 0644);
 MODULE_PARM_DESC(dctcp_alpha_on_init, "parameter for initial alpha value");
 
-static unsigned int dctcp_clamp_alpha_on_loss __read_mostly;
-module_param(dctcp_clamp_alpha_on_loss, uint, 0644);
-MODULE_PARM_DESC(dctcp_clamp_alpha_on_loss,
-		 "parameter for clamping alpha on loss");
-
 static struct tcp_congestion_ops dctcp_reno;
 
 static void dctcp_reset(const struct tcp_sock *tp, struct dctcp *ca)
@@ -211,21 +206,23 @@ static void dctcp_update_alpha(struct so
 	}
 }
 
-static void dctcp_state(struct sock *sk, u8 new_state)
+static void dctcp_react_to_loss(struct sock *sk)
 {
-	if (dctcp_clamp_alpha_on_loss && new_state == TCP_CA_Loss) {
-		struct dctcp *ca = inet_csk_ca(sk);
+	struct dctcp *ca = inet_csk_ca(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 
-		/* If this extension is enabled, we clamp dctcp_alpha to
-		 * max on packet loss; the motivation is that dctcp_alpha
-		 * is an indicator to the extend of congestion and packet
-		 * loss is an indicator of extreme congestion; setting
-		 * this in practice turned out to be beneficial, and
-		 * effectively assumes total congestion which reduces the
-		 * window by half.
-		 */
-		ca->dctcp_alpha = DCTCP_MAX_ALPHA;
-	}
+	ca->loss_cwnd = tp->snd_cwnd;
+	tp->snd_ssthresh = max(tp->snd_cwnd >> 1U, 2U);
+}
+
+static void dctcp_state(struct sock *sk, u8 new_state)
+{
+	if (new_state == TCP_CA_Recovery &&
+	    new_state != inet_csk(sk)->icsk_ca_state)
+		dctcp_react_to_loss(sk);
+	/* We handle RTO in dctcp_cwnd_event to ensure that we perform only
+	 * one loss-adjustment per RTT.
+	 */
 }
 
 static void dctcp_cwnd_event(struct sock *sk, enum tcp_ca_event ev)
@@ -237,6 +234,9 @@ static void dctcp_cwnd_event(struct sock
 	case CA_EVENT_ECN_NO_CE:
 		dctcp_ce_state_1_to_0(sk);
 		break;
+	case CA_EVENT_LOSS:
+		dctcp_react_to_loss(sk);
+		break;
 	default:
 		/* Don't care for the rest. */
 		break;


