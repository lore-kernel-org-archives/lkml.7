Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD0EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13963206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfDCFBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:01:39 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:11914
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728699AbfDCFBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:01:37 -0400
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id EEA1320B46;
        Wed,  3 Apr 2019 05:01:34 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     andrew.hendry@gmail.com, davem@davemloft.net, khc@pm.waw.pl,
        isdn@linux-pingi.de
Cc:     edumazet@google.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 4/4] isdn/i4l: Call notifiers before and after changing device type
Date:   Wed,  3 Apr 2019 07:01:18 +0200
Message-Id: <20190403050118.12785-4-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190403050118.12785-1-ms@dev.tdt.de>
References: <20190403050118.12785-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/isdn/i4l/isdn_net.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_net.c b/drivers/isdn/i4l/isdn_net.c
index c138f66f2659..3016cbcc719a 100644
--- a/drivers/isdn/i4l/isdn_net.c
+++ b/drivers/isdn/i4l/isdn_net.c
@@ -2692,8 +2692,12 @@ isdn_net_setcfg(isdn_net_ioctl_cfg *cfg)
 			       p->dev->name);
 			return -EINVAL;
 #else
+			rtnl_lock();
+			call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE, p->dev);
 			p->dev->type = ARPHRD_PPP;	/* change ARP type */
+			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, p->dev);
 			p->dev->addr_len = 0;
+			rtnl_unlock();
 #endif
 			break;
 		case ISDN_NET_ENCAP_X25IFACE:
@@ -2702,16 +2706,27 @@ isdn_net_setcfg(isdn_net_ioctl_cfg *cfg)
 			       p->dev->name);
 			return -EINVAL;
 #else
+			rtnl_lock();
+			call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE, p->dev);
 			p->dev->type = ARPHRD_X25;	/* change ARP type */
+			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, p->dev);
 			p->dev->addr_len = 0;
+			rtnl_unlock();
 #endif
 			break;
 		case ISDN_NET_ENCAP_CISCOHDLCK:
 			break;
 		default:
 			if (cfg->p_encap >= 0 &&
-			    cfg->p_encap <= ISDN_NET_ENCAP_MAX_ENCAP)
+			    cfg->p_encap <= ISDN_NET_ENCAP_MAX_ENCAP) {
+				rtnl_lock();
+				call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE, p->dev);
+				p->dev->type = ARPHRD_ETHER;	/* change ARP type */
+				call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, p->dev);
+				p->dev->addr_len = ETH_ALEN;
+				rtnl_unlock();
 				break;
+			}
 			printk(KERN_WARNING
 			       "%s: encapsulation protocol %d not supported\n",
 			       p->dev->name, cfg->p_encap);
-- 
2.11.0

