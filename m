Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38FDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E662173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfC1Rac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:30:32 -0400
Received: from gateway36.websitewelcome.com ([192.185.195.25]:15347 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfC1Rac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:30:32 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id C1012400C6F33
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 11:47:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 9YrHhmxo12qH79YrHhCS3J; Thu, 28 Mar 2019 12:30:31 -0500
X-Authority-Reason: nr=8
Received: from [189.250.117.246] (port=37512 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h9YrG-0033kW-O4; Thu, 28 Mar 2019 12:30:30 -0500
Date:   Thu, 28 Mar 2019 12:30:29 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] Bluetooth: Use struct_size() helper
Message-ID: <20190328173029.GA13869@embeddedor>
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
X-Source-IP: 189.250.117.246
X-Source-L: No
X-Exim-ID: 1h9YrG-0033kW-O4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.117.246]:37512
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

size = struct_size(instance, entry, count);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/bluetooth/mgmt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2457f408d17d..150114e33b20 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2301,8 +2301,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
-	expected_len = sizeof(*cp) + key_count *
-					sizeof(struct mgmt_link_key_info);
+	expected_len = struct_size(cp, keys, key_count);
 	if (expected_len != len) {
 		bt_dev_err(hdev, "load_link_keys: expected %u bytes, got %u bytes",
 			   expected_len, len);
@@ -5030,7 +5029,7 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
-	expected_len = sizeof(*cp) + irk_count * sizeof(struct mgmt_irk_info);
+	expected_len = struct_size(cp, irks, irk_count);
 	if (expected_len != len) {
 		bt_dev_err(hdev, "load_irks: expected %u bytes, got %u bytes",
 			   expected_len, len);
@@ -5112,8 +5111,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
-	expected_len = sizeof(*cp) + key_count *
-					sizeof(struct mgmt_ltk_info);
+	expected_len = struct_size(cp, keys, key_count);
 	if (expected_len != len) {
 		bt_dev_err(hdev, "load_keys: expected %u bytes, got %u bytes",
 			   expected_len, len);
@@ -5847,8 +5845,7 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 				       MGMT_STATUS_INVALID_PARAMS);
 	}
 
-	expected_len = sizeof(*cp) + param_count *
-					sizeof(struct mgmt_conn_param);
+	expected_len = struct_size(cp, params, param_count);
 	if (expected_len != len) {
 		bt_dev_err(hdev, "load_conn_param: expected %u bytes, got %u bytes",
 			   expected_len, len);
-- 
2.21.0

