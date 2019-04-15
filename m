Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D984EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B150B20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfDOU50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:57:26 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.100]:43940 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbfDOU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:57:25 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id F3C806D7A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:57:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id G8fMhfwOp90onG8fMhrGGr; Mon, 15 Apr 2019 15:57:24 -0500
X-Authority-Reason: nr=8
Received: from [189.250.55.242] (port=52932 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hG8fM-0011A0-A2; Mon, 15 Apr 2019 15:57:24 -0500
Date:   Mon, 15 Apr 2019 15:57:23 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: atm: Fix potential Spectre v1 vulnerabilities
Message-ID: <20190415205723.GA31452@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.55.242
X-Source-L: No
X-Exim-ID: 1hG8fM-0011A0-A2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.55.242]:52932
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arg is controlled by user-space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/atm/lec.c:715 lec_mcast_attach() warn: potential spectre issue 'dev_lec' [r] (local cap)

Fix this by sanitizing arg before using it to index dev_lec.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/atm/lec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index d7f5cf5b7594..ad4f829193f0 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -710,7 +710,10 @@ static int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg)
 
 static int lec_mcast_attach(struct atm_vcc *vcc, int arg)
 {
-	if (arg < 0 || arg >= MAX_LEC_ITF || !dev_lec[arg])
+	if (arg < 0 || arg >= MAX_LEC_ITF)
+		return -EINVAL;
+	arg = array_index_nospec(arg, MAX_LEC_ITF);
+	if (!dev_lec[arg])
 		return -EINVAL;
 	vcc->proto_data = dev_lec[arg];
 	return lec_mcast_make(netdev_priv(dev_lec[arg]), vcc);
@@ -728,6 +731,7 @@ static int lecd_attach(struct atm_vcc *vcc, int arg)
 		i = arg;
 	if (arg >= MAX_LEC_ITF)
 		return -EINVAL;
+	i = array_index_nospec(arg, MAX_LEC_ITF);
 	if (!dev_lec[i]) {
 		int size;
 
-- 
2.21.0

