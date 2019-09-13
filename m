Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC11C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F79208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380353;
	bh=KnXDJsZCUg2eD3eV3JjLK4fuOPM14ALc9W/9hOtIhHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VpLOg5xIxsqnN2NKBD9okb4WTR99onWx40TxOOJR/eP8xUcZ4HcQrmxXJiWbTK3Ni
	 bYt+n3LmYh2G5WZszmSechmQgjwRsKGioQsoJ2QUw5W9M4TJFdqmDPBFE7CCBHqnHv
	 9mqFV4XsMCMvNQtIA0QfNKpsDObET8RvlobXysf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbfIMNMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388555AbfIMNM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:28 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43863214AF;
        Fri, 13 Sep 2019 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380347;
        bh=KnXDJsZCUg2eD3eV3JjLK4fuOPM14ALc9W/9hOtIhHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMptOj9TWD4XHJuiWEOqOwB1E13ogjQCK5p4Y7vxUhqCk9hYHEPlc31Xz/tKbtwdw
         T2a1MY1zT4bW3HvRQdFWtfp+Cgv8K90FYrhBBCJLZLWPe8/bHzDAVdnhGHWV7ciBs5
         GdrpRG5er+0hKZ6AQMhwMUkk7lCfWABBpsgKHNJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/190] Drivers: hv: kvp: Fix two "this statement may fall through" warnings
Date:   Fri, 13 Sep 2019 14:04:50 +0100
Message-Id: <20190913130602.472720481@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fc62c3b1977d62e6374fd6e28d371bb42dfa5c9d ]

We don't need to call process_ib_ipinfo() if message->kvp_hdr.operation is
KVP_OP_GET_IP_INFO in kvp_send_key(), because here we just need to pass on
the op code from the host to the userspace; when the userspace returns
the info requested by the host, we pass the info on to the host in
kvp_respond_to_host() -> process_ob_ipinfo(). BTW, the current buggy code
actually doesn't cause any harm, because only message->kvp_hdr.operation
is used by the userspace, in the case of KVP_OP_GET_IP_INFO.

The patch also adds a missing "break;" in kvp_send_key(). BTW, the current
buggy code actually doesn't cause any harm, because in the case of
KVP_OP_SET, the unexpected fall-through corrupts
message->body.kvp_set.data.key_size, but that is not really used: see
the definition of struct hv_kvp_exchg_msg_value.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/hv_kvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 5eed1e7da15c4..57715a0c81202 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,7 +353,6 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
 
-	default:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
 				UTF16_LITTLE_ENDIAN,
@@ -406,7 +405,7 @@ kvp_send_key(struct work_struct *dummy)
 		process_ib_ipinfo(in_msg, message, KVP_OP_SET_IP_INFO);
 		break;
 	case KVP_OP_GET_IP_INFO:
-		process_ib_ipinfo(in_msg, message, KVP_OP_GET_IP_INFO);
+		/* We only need to pass on message->kvp_hdr.operation.  */
 		break;
 	case KVP_OP_SET:
 		switch (in_msg->body.kvp_set.data.value_type) {
@@ -446,6 +445,9 @@ kvp_send_key(struct work_struct *dummy)
 			break;
 
 		}
+
+		break;
+
 	case KVP_OP_GET:
 		message->body.kvp_set.data.key_size =
 			utf16s_to_utf8s(
-- 
2.20.1



