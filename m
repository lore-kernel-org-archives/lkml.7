Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC1C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC7722314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003534;
	bh=Dg46M6RfONjea1nRE7p9aUkV4jq5ajF4GZjU/LofH3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ea1G0arzASb9cSMVWhvnVtaIcezS+8e3wxlOVOsrTLnMJXYVhbqDAghTRBwhfgxeG
	 ++Yp1HIy9Z3H4K+zT2R31I7HNsKQbiI+tZMbK+4NQ8Y/I5T/XZS5PGQr5/auTIxzYN
	 0rde2Bk4yfEoEnA5jNc8ICTYkWK+DLyxTlfVNc4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgABWSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgABWSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:18:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7974D21582;
        Thu,  2 Jan 2020 22:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003528;
        bh=Dg46M6RfONjea1nRE7p9aUkV4jq5ajF4GZjU/LofH3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vk3UY0N3wwg6NNXZw+jo/jIxb4T24DhPFZj1jCIFZr+CNyCfH7pJ/3NICJW9/vRlI
         owI3fZBGnYC30QWPbO3CqaJGuqNG2b4sZaDzIKo5Gj4n7qTm0eE4MXPMmpVPbZHPRO
         yy/w5Hz71xPRiVOD3O1kuVI/WjzGwQFYlIh0vCCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jay Vosburgh <jay.vosburgh@canonical.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 5.4 179/191] bonding: fix active-backup transition after link failure
Date:   Thu,  2 Jan 2020 23:07:41 +0100
Message-Id: <20200102215848.449636427@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 5d485ed88d48f8101a2067348e267c0aaf4ed486 ]

After the recent fix in commit 1899bb325149 ("bonding: fix state
transition issue in link monitoring"), the active-backup mode with
miimon initially come-up fine but after a link-failure, both members
transition into backup state.

Following steps to reproduce the scenario (eth1 and eth2 are the
slaves of the bond):

    ip link set eth1 up
    ip link set eth2 down
    sleep 1
    ip link set eth2 up
    ip link set eth1 down
    cat /sys/class/net/eth1/bonding_slave/state
    cat /sys/class/net/eth2/bonding_slave/state

Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
CC: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2225,9 +2225,6 @@ static void bond_miimon_commit(struct bo
 			} else if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
 				/* make it immediately active */
 				bond_set_active_slave(slave);
-			} else if (slave != primary) {
-				/* prevent it from being the active one */
-				bond_set_backup_slave(slave);
 			}
 
 			slave_info(bond->dev, slave->dev, "link status definitely up, %u Mbps %s duplex\n",


