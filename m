Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6262339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfHTXOn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:14:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60263 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHTXOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:14:42 -0400
Received: from 1.general.jvosburgh.us.vpn ([10.172.68.206] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1i0DKm-0000pJ-DP; Tue, 20 Aug 2019 23:14:36 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id B17DE5FF70; Tue, 20 Aug 2019 16:14:34 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id A9F9BA6A93;
        Tue, 20 Aug 2019 16:14:34 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     zhangsha.zhang@huawei.com
cc:     vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuehaibing@huawei.com, hunongda@huawei.com, alex.chen@huawei.com
Subject: Re: [PATCH] bonding: force enable lacp port after link state recovery for 802.3ad
In-reply-to: <20190820133822.2508-1-zhangsha.zhang@huawei.com>
References: <20190820133822.2508-1-zhangsha.zhang@huawei.com>
Comments: In-reply-to <zhangsha.zhang@huawei.com>
   message dated "Tue, 20 Aug 2019 21:38:22 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27041.1566342874.1@famine>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 20 Aug 2019 16:14:34 -0700
Message-ID: <27042.1566342874@famine>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<zhangsha.zhang@huawei.com> wrote:

>From: Sha Zhang <zhangsha.zhang@huawei.com>
>
>After the commit 334031219a84 ("bonding/802.3ad: fix slave link
>initialization transition states") merged,
>the slave's link status will be changed to BOND_LINK_FAIL
>from BOND_LINK_DOWN in the following scenario:
>- Driver reports loss of carrier and
>  bonding driver receives NETDEV_CHANGE notifier
>- slave's duplex and speed is zerod and
>  its port->is_enabled is cleard to 'false';
>- Driver reports link recovery and
>  bonding driver receives NETDEV_UP notifier;
>- If speed/duplex getting failed here, the link status
>  will be changed to BOND_LINK_FAIL;
>- The MII monotor later recover the slave's speed/duplex
>  and set link status to BOND_LINK_UP, but remains
>  the 'port->is_enabled' to 'false'.
>
>In this scenario, the lacp port will not be enabled even its speed
>and duplex are valid. The bond will not send LACPDU's, and its
>state is 'AD_STATE_DEFAULTED' forever. The simplest fix I think
>is to force enable lacp after port slave speed check in
>bond_miimon_commit. As enabled, the lacp port can run its state machine
>normally after link recovery.
>
>Signed-off-by: Sha Zhang <zhangsha.zhang@huawei.com>
>---
> drivers/net/bonding/bond_main.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
>index 931d9d9..379253a 100644
>--- a/drivers/net/bonding/bond_main.c
>+++ b/drivers/net/bonding/bond_main.c
>@@ -2194,6 +2194,7 @@ static void bond_miimon_commit(struct bonding *bond)
> {
> 	struct list_head *iter;
> 	struct slave *slave, *primary;
>+	struct port *port;
> 
> 	bond_for_each_slave(bond, slave, iter) {
> 		switch (slave->new_link) {
>@@ -2205,8 +2206,13 @@ static void bond_miimon_commit(struct bonding *bond)
> 			 * link status
> 			 */
> 			if (BOND_MODE(bond) == BOND_MODE_8023AD &&
>-			    slave->link == BOND_LINK_UP)
>+			    slave->link == BOND_LINK_UP) {
> 				bond_3ad_adapter_speed_duplex_changed(slave);
>+				if (slave->duplex == DUPLEX_FULL) {
>+					port = &(SLAVE_AD_INFO(slave)->port);
>+					port->is_enabled = true;
>+				}
>+			}

	I don't believe that testing duplex here is correct; is_enabled
is not controlled by duplex, but by carrier state.  Duplex does affect
whether or not a port is permitted to aggregate, but that's entirely
separate logic (the AD_PORT_LACP_ENABLED flag).

	Would it be better to call bond_3ad_handle_link_change() here,
instead of manually testing duplex and setting is_enabled?

	-J

> 			continue;
> 
> 		case BOND_LINK_UP:
>-- 
>1.8.3.1
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
