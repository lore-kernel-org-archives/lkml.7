Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C7B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901561;
	bh=jivYS5UEm7E6lDEv875zNgGT6QlgYFNPzTzhKY7wPB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1S6idmgJgf+dh5FyxmGpl0IBOQYVAM/mP5uRpvfYtZxw9d+KlGnyXw7TQCOo227vW
	 u+SCGFWri4Z8bLI/LiluobPi3r3DM2tnjnN8abQ67GVNoOs+/sw9V2lQAZM/OwpDQ2
	 BBGtPZyW8+5x+5gzwgMXH5P7qV0MfHS5F24SRpoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfCRJcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfCRJcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:35 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB6B2083D;
        Mon, 18 Mar 2019 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901554;
        bh=jivYS5UEm7E6lDEv875zNgGT6QlgYFNPzTzhKY7wPB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h198dv63D2PskdJb5Xr/PPt7/NSJFq2Oe0joliQesEucollTioN2VLavbA0qG4J6E
         5AOLl3nMFUAmLgNohTnkG1ktEk0xug4mhHpvsRaXxBpI8wPsX2W9s+lk0MiEs3g7xX
         UtDFKS+BdIypQHWR23OJTco40lVssWNMR7tWqIq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        George Wilkie <gwilkie@vyatta.att-mail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 29/52] team: use operstate consistently for linkup
Date:   Mon, 18 Mar 2019 10:25:26 +0100
Message-Id: <20190318084016.976307474@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Wilkie <gwilkie@vyatta.att-mail.com>

[ Upstream commit 8c7a77267eec81dd81af8412f29e50c0b1082548 ]

When a port is added to a team, its initial state is derived
from netif_carrier_ok rather than netif_oper_up.
If it is carrier up but operationally down at the time of being
added, the port state.linkup will be set prematurely.
port state.linkup should be set consistently using
netif_oper_up rather than netif_carrier_ok.

Fixes: f1d22a1e0595 ("team: account for oper state")
Signed-off-by: George Wilkie <gwilkie@vyatta.att-mail.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1259,7 +1259,7 @@ static int team_port_add(struct team *te
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
 	__team_compute_features(team);
-	__team_port_change_port_added(port, !!netif_carrier_ok(port_dev));
+	__team_port_change_port_added(port, !!netif_oper_up(port_dev));
 	__team_options_change_check(team);
 
 	netdev_info(dev, "Port device %s added\n", portname);
@@ -2918,7 +2918,7 @@ static int team_device_event(struct noti
 
 	switch (event) {
 	case NETDEV_UP:
-		if (netif_carrier_ok(dev))
+		if (netif_oper_up(dev))
 			team_port_change_check(port, true);
 		break;
 	case NETDEV_DOWN:


