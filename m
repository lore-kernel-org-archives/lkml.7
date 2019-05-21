Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC00FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0D2081C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfEULIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:08:22 -0400
Received: from david.siemens.de ([192.35.17.14]:55994 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfEULIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:08:21 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 May 2019 07:08:20 EDT
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x4LAr51R025424
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 12:53:05 +0200
Received: from pluscontrol-debian-server.ppmd.SIEMENS.NET (pluscontrol-debian-server.ppmd.siemens.net [146.254.63.6])
        by mail2.siemens.de (8.15.2/8.15.2) with ESMTP id x4LAr2dW031303;
        Tue, 21 May 2019 12:53:02 +0200
From:   Andreas Oetken <andreas.oetken@siemens.com>
Cc:     andreas@oetken.name, Andreas Oetken <andreas.oetken@siemens.com>,
        Arvid Brodin <arvid.brodin@alten.se>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hsr: fix don't prune the master node from the node_db
Date:   Tue, 21 May 2019 12:52:41 +0200
Message-Id: <20190521105241.16234-1-andreas.oetken@siemens.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't prune master node in the hsr_prune_nodes function.
Neither time_in[HSR_PT_SLAVE_A], nor time_in[HSR_PT_SLAVE_B],
will ever be updated by hsr_register_frame_in for the master port.
Thus the master node will be repeatedly pruned leading to
repeated packet loss.
This bug never appeared because the hsr_prune_nodes function
was only called once. Since commit 5150b45fd355
("net: hsr: Fix node prune function for forget time expiry") this issue
is fixed unvealing the issue described above.

Signed-off-by: Andreas Oetken <andreas.oetken@siemens.com>
---
 net/hsr/hsr_framereg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 9af16cb68f76..317cddda494e 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -387,6 +387,14 @@ void hsr_prune_nodes(struct timer_list *t)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(node, &hsr->node_db, mac_list) {
+		/* Don't prune own node. Neither time_in[HSR_PT_SLAVE_A]
+		 * nor time_in[HSR_PT_SLAVE_B], will ever be updated for
+		 * the master port. Thus the master node will be repeatedly
+		 * pruned leading to packet loss.
+		 */
+		if (hsr_addr_is_self(hsr, node->MacAddressA))
+			continue;
+
 		/* Shorthand */
 		time_a = node->time_in[HSR_PT_SLAVE_A];
 		time_b = node->time_in[HSR_PT_SLAVE_B];
-- 
2.20.1

