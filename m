Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E9C32770
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D394620672
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKme5RRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgADOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:42:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36008 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgADOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:42:57 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so24743468pgc.3;
        Sat, 04 Jan 2020 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2M7YOorv6RwrWVHgY3ejHrhkHuQ38MnpPJ/NxaJYkHo=;
        b=uKme5RRtW2QUsgxM60TcBzlZn3rSeNUUMtdWjlLJS7l03mysWXT9kH5aZvpctX4p8v
         rI6qIfsl+QwV2AC1DvRKx8VQrWeYJUEBTdiU/cU9p96UWpShC0EVFsQL1EiAha1dTJ8k
         XzyMHa/VORUWnW2dMhR4UAYjQ3fx6tVPu+ALVf2SaBnKMksxZi34jrE5Z/PNhFrCD0X4
         gRC8YLFa7MpuPxXOU1elcdcdE0XWbQ1Rd1xWhKIrB5mKtdGW19eMYtwKiQsIynqWqC5A
         nqV1Wink3V2j2XbHRgqRZEHZdq8DGlMOqYsqwrmMyJZY9oc/OnH9cdyZC/z1pqeKyXot
         Zk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2M7YOorv6RwrWVHgY3ejHrhkHuQ38MnpPJ/NxaJYkHo=;
        b=L0j6deQUtYnkROgroT3SyHzZNNuAJ5sKJ5VMX0R0Ih4dry0HY52cC7ERLRTsdBSZGJ
         BSf0AYKR+kPDDZGYlW1UQhKrjT96Y3mXaXvBCM0Rlgj7sS828u2xd+n4i5JvVxoPhYoG
         eUaroMdWQjl4H52h3MIpQHTF3mpAcrJF3TBxmG4y6UK6Hs5wMIJSO8wm+0/GoU2ynPK0
         KtU6Z1V9avxsMvaRkeUwZZN/eCOzWijy6zFUIdhCSnWZCdjYP2MTl0C5Bfm+npMn2mbs
         64umI2G+mfpC3hVwT6ib+82UmJrixdXH6gaTAOOTRZdgQRswQ6Vn/POCn+tH8Rhvfmjc
         XQJw==
X-Gm-Message-State: APjAAAWr0HTPV4xHjwyEQolm6uZml0p1bYUNccXQd67HQ/rLfc7u+59e
        S8pN+ZZQ4djKovWF8JgbiwueCFpIqIw=
X-Google-Smtp-Source: APXvYqzu3vHs/8ZRUpe2NLQSR5KwKW0pTRj52d3eonQ5TWWthYdonYnF4WQCOhezs0e+4EXEt2tUcQ==
X-Received: by 2002:aa7:92c2:: with SMTP id k2mr76230776pfa.93.1578148976837;
        Sat, 04 Jan 2020 06:42:56 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee1:e8a5:200b:101a:37e8:7497])
        by smtp.gmail.com with ESMTPSA id z30sm73490238pff.131.2020.01.04.06.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 06:42:56 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     stefanr@s5r6.in-berlin.de, paulmck@kernel.org,
        joel@joelfernandes.org
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] drivers: firewire: core-transaction: Pass lockdep condition to address_handler_list iterator
Date:   Sat,  4 Jan 2020 20:12:15 +0530
Message-Id: <20200104144215.27590-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

The address_handler_list is traversed with list_for_each_entry_rcu
with address_handler_list_lock held.
list_for_each_entry_rcu has built-in RCU and lock checking.
Use it for address_handler_list traversal.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/firewire/core-transaction.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 404a035f104d..a15e70027932 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -61,6 +61,11 @@
 #define PHY_CONFIG_ROOT_ID(node_id)	((((node_id) & 0x3f) << 24) | (1 << 23))
 #define PHY_IDENTIFIER(id)		((id) << 30)
 
+static DEFINE_SPINLOCK(address_handler_list_lock);
+static LIST_HEAD(address_handler_list);
+
+#define address_handler_list_lock_held() lock_is_held(&(address_handler_list_lock).dep_map)
+
 /* returns 0 if the split timeout handler is already running */
 static int try_cancel_split_timeout(struct fw_transaction *t)
 {
@@ -485,7 +490,7 @@ static struct fw_address_handler *lookup_overlapping_address_handler(
 {
 	struct fw_address_handler *handler;
 
-	list_for_each_entry_rcu(handler, list, link) {
+	list_for_each_entry_rcu(handler, list, link, address_handler_list_lock_held()) {
 		if (handler->offset < offset + length &&
 		    offset < handler->offset + handler->length)
 			return handler;
@@ -514,8 +519,6 @@ static struct fw_address_handler *lookup_enclosing_address_handler(
 	return NULL;
 }
 
-static DEFINE_SPINLOCK(address_handler_list_lock);
-static LIST_HEAD(address_handler_list);
 
 const struct fw_address_region fw_high_memory_region =
 	{ .start = FW_MAX_PHYSICAL_RANGE, .end = 0xffffe0000000ULL, };
-- 
2.17.1

