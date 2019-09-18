Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9060C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF52A218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787917;
	bh=7l0Qn+InndDwxNrrnKMKwhfiIuLGtZhtjryuZ43ojTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ctPZWQ5oEJrVnFJMp5orBDUMtuUUFO5eH8zGNpMStmxj81qFntmTSV+mimB27ttvb
	 ENgtpnTIVJZf36uuqdHVXq0A5qAMIs6U8sUncmIeu0L6i52UokZ0eZtZ9FrWLZXlsa
	 R1hQqgaEIP9RU3bd8nF6hylmkV6jmq8wspMxF6MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfIRGZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbfIRGZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:25:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C63218AF;
        Wed, 18 Sep 2019 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787914;
        bh=7l0Qn+InndDwxNrrnKMKwhfiIuLGtZhtjryuZ43ojTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAlEtd9BoHGhcut8dRmzTfo9SsL4OtP6/1OApmOnj2J2hUg3l20HuRA8nRcJ3m1oB
         ZNLXra9CXZBrndPIaFpxgwhdtKqZsz0fk+4e8K029LOCv3LDdv0FMDgR4euoxPnaVy
         rwC42C3xsfq8R3X7LUiG7Grw2pjDMscTJfMrSdS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 03/85] ipv6: Fix the link time qualifier of ping_v6_proc_exit_net()
Date:   Wed, 18 Sep 2019 08:18:21 +0200
Message-Id: <20190918061234.234303445@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d23dbc479a8e813db4161a695d67da0e36557846 ]

The '.exit' functions from 'pernet_operations' structure should be marked
as __net_exit, not __net_init.

Fixes: d862e5461423 ("net: ipv6: Implement /proc/net/icmp6.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -223,7 +223,7 @@ static int __net_init ping_v6_proc_init_
 	return 0;
 }
 
-static void __net_init ping_v6_proc_exit_net(struct net *net)
+static void __net_exit ping_v6_proc_exit_net(struct net *net)
 {
 	remove_proc_entry("icmp6", net->proc_net);
 }


