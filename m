Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD6CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDB3217F9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383274;
	bh=rO5Ymxks7kg5ZyiaqSYr7HLsnVe6+q4sVurNX5WsIzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C2Dy63W/EgA9e4DVl5kfgs0MwqPK24ZYpYqr8fKxSK1l/L7Th2enhm1WNcw0XmmTp
	 FCwinTQpF4g+ATIV3hin5FBDhcwPQk3J0kfwKHmmhr4eToHwdkTj2iM0++u97+mt1+
	 wOQPWeRw8z45Orp7YCUe33CrE6h4rNyEXcWSBWpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfJFRee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbfJFRe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:34:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980602087E;
        Sun,  6 Oct 2019 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383268;
        bh=rO5Ymxks7kg5ZyiaqSYr7HLsnVe6+q4sVurNX5WsIzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Td3zVIYhEyZZ5XTFH1vp/WcRqdFMZqUAJ0ThPpiYgkW79c1uPv76s4ASSwNrZFP2L
         t12/Q9bCPf6ACCoQfOeoEgqeAFugN3TcMilb2s5gEZtaGDIM8qjj3C3SNrI3RKbFoM
         DDMu+Hsi4TCzLa2XozFUiDHc1BseAtoNSGEMgjtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 008/137] net: sched: taprio: Fix potential integer overflow in taprio_set_picos_per_byte
Date:   Sun,  6 Oct 2019 19:19:52 +0200
Message-Id: <20191006171210.257170105@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit 68ce6688a5baefde30914fc07fc27292dbbe8320 ]

The speed divisor is used in a context expecting an s64, but it is
evaluated using 32-bit arithmetic.

To avoid that happening, instead of multiplying by 1,000,000 in the
first place, simplify the fraction and do a standard 32 bit division
instead.

Fixes: f04b514c0ce2 ("taprio: Set default link speed to 10 Mbps in taprio_set_picos_per_byte")
Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_taprio.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -672,8 +672,7 @@ static void taprio_set_picos_per_byte(st
 		speed = ecmd.base.speed;
 
 skip:
-	picos_per_byte = div64_s64(NSEC_PER_SEC * 1000LL * 8,
-				   speed * 1000 * 1000);
+	picos_per_byte = (USEC_PER_SEC * 8) / speed;
 
 	atomic64_set(&q->picos_per_byte, picos_per_byte);
 	netdev_dbg(dev, "taprio: set %s's picos_per_byte to: %lld, linkspeed: %d\n",


