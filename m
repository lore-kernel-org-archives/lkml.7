Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69511C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0702084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919037;
	bh=6e0KJ9qdVyxIwIx3iB73d1TJGGtIu0OJ8kF/k9AbIrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P4mkIPK/kWdS0YFKLLE+54nYKkCWAnYvzI4uBchidN7iwYOgOEYoulLTSr64Vg2vE
	 Y8tUtyvv8QVOB0yNwlsSVltWaA5bMI4wBfcWCCHYrRxc0gLMGksPDU9qTzz20FDNVa
	 +dv+jwrJjh0iCo/Zi1VfdmwAFF9Zrs1xCmitSiVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfEOLRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbfEOLRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:17:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B602084E;
        Wed, 15 May 2019 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919032;
        bh=6e0KJ9qdVyxIwIx3iB73d1TJGGtIu0OJ8kF/k9AbIrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQaOtBuMEkAw6uCuupHC67pWyM95naJ0+YHHByZ8Xeqk3tbDDLb72AhAJ54KGaucE
         Ty194/2NOrB/u0SP07j2VWG44HFmLPmxg/Qe6SXdRcMyjC3PtZDGRsSVHjcR6XTgp2
         ZpSdv79KF9PDpZrNycQiOIJWucfBfcFqiCu/rHOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 040/115] sparc64: Export __node_distance.
Date:   Wed, 15 May 2019 12:55:20 +0200
Message-Id: <20190515090702.397924596@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2b4792eaa9f553764047d157365ed8b7787751a3 ]

Some drivers reference it via node_distance(), for example the
NVME host driver core.

ERROR: "__node_distance" [drivers/nvme/host/nvme-core.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sparc/mm/init_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 984e9d65ea0d1..76977296dc9c6 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1383,6 +1383,7 @@ int __node_distance(int from, int to)
 	}
 	return numa_latency[from][to];
 }
+EXPORT_SYMBOL(__node_distance);
 
 static int __init find_best_numa_node_for_mlgroup(struct mdesc_mlgroup *grp)
 {
-- 
2.20.1



