Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE463C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A6218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947097;
	bh=l2YNntziq5/IXjI2hxmN5NXKaQAoKbhgICVAzS5Y+CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VtmuT9p1NfaFzqloMlDDhufKg5UDj6F/FHQx8s6C6/hEjMxQk+nDC/l/+R2I+C+Hz
	 jDqcNmAsdoxw1+gg/LbbGpCsznLAW9dP7u3/3MyjmQ60KPtOT4HYPqL58diGb12VeO
	 C++qPEfy2YcZNEgiouyzQ2OfeqajU3Huj04OqmFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfIHMvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732615AbfIHMv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:51:27 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C4A2218AC;
        Sun,  8 Sep 2019 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947087;
        bh=l2YNntziq5/IXjI2hxmN5NXKaQAoKbhgICVAzS5Y+CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5n9xi+BI24PLCGydYhBoeEgPSctlt6He3El4rr/WhlmX4BB+ghUWsQWSv3bLpenl
         Qu+tOy67IMFabdkzW4yVwtW0/h3LpJlMEXq8Bdr+TYe7iDisgfW8ZZgMT3XHdlQ7pB
         /9Be6D69pL09o3CzlyCFDZpP+TQfzwUxNO1Xtjlg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leandro Dorileo <leandro.maciel.dorileo@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 14/94] net/sched: cbs: Set default link speed to 10 Mbps in cbs_set_port_rate
Date:   Sun,  8 Sep 2019 13:41:10 +0100
Message-Id: <20190908121150.841099193@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

The discussion to be made is absolutely the same as in the case of
previous patch ("taprio: Set default link speed to 10 Mbps in
taprio_set_picos_per_byte"). Nothing is lost when setting a default.

Cc: Leandro Dorileo <leandro.maciel.dorileo@intel.com>
Fixes: e0a7683d30e9 ("net/sched: cbs: fix port_rate miscalculation")
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_cbs.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -181,11 +181,6 @@ static struct sk_buff *cbs_dequeue_soft(
 	s64 credits;
 	int len;
 
-	if (atomic64_read(&q->port_rate) == -1) {
-		WARN_ONCE(1, "cbs: dequeue() called with unknown port rate.");
-		return NULL;
-	}
-
 	if (q->credits < 0) {
 		credits = timediff_to_credits(now - q->last, q->idleslope);
 
@@ -303,11 +298,19 @@ static int cbs_enable_offload(struct net
 static void cbs_set_port_rate(struct net_device *dev, struct cbs_sched_data *q)
 {
 	struct ethtool_link_ksettings ecmd;
+	int speed = SPEED_10;
 	int port_rate = -1;
+	int err;
+
+	err = __ethtool_get_link_ksettings(dev, &ecmd);
+	if (err < 0)
+		goto skip;
+
+	if (ecmd.base.speed != SPEED_UNKNOWN)
+		speed = ecmd.base.speed;
 
-	if (!__ethtool_get_link_ksettings(dev, &ecmd) &&
-	    ecmd.base.speed != SPEED_UNKNOWN)
-		port_rate = ecmd.base.speed * 1000 * BYTES_PER_KBIT;
+skip:
+	port_rate = speed * 1000 * BYTES_PER_KBIT;
 
 	atomic64_set(&q->port_rate, port_rate);
 	netdev_dbg(dev, "cbs: set %s's port_rate to: %lld, linkspeed: %d\n",


