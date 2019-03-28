Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D26C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938CC20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfC1GgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:36:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54194 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1GgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:36:03 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1h9Odu-0005iL-P7
        for linux-kernel@vger.kernel.org; Thu, 28 Mar 2019 06:36:02 +0000
Received: by mail-wr1-f72.google.com with SMTP id p13so10237698wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZCbQcu+6lIkxzNPMoAuRGk0babrO/Mj266g8UlT9E/s=;
        b=Zt7sqK8SG/taUHkJnHHkS6PVCcwT16LYKeeylrKaa/kWrTZxw1fkOvcQiEAU7pW0qz
         HbB9v1e2GFIZX3wSGtPHIt4md7ezFBTBkM6Iceqw4TD3PPVZSQQLw20AWCSULoeWxeLf
         g9NdtdBADKas5NIWZEZQRqUwPOp/Y/4/guHW5P0k3XCeLEkZsd7daib00W/iZwQS3V9a
         kffgpk2r/Mz3oFbT9AmuIbNmMQYYBEMQTh6pUv3rTmvxZZYwKQPosW0V4iRE/6wzqOTX
         zYkCJPUNOr9pxziqrl6pMbf0fPp4/Tvrnkf2FLvQedjaKU46w9W4w6BYFaUcxIwA6Wou
         y8Eg==
X-Gm-Message-State: APjAAAWsLk84RLOo5WYOXO5xzhZAZzVdhxA4CoMOi14a60GXOw35/j7h
        6FhXWZ/NiLKMLDXJqelVCTKoGnnqOnLfA3lX3e9cifACW85jdjmGjTOGxUqG4X1cRsIbGMAwtFH
        HQxzKTD6CTz7tMjYvoT3PxyZdlZFP0oGvnu0NUUiJxw==
X-Received: by 2002:a05:600c:24f:: with SMTP id 15mr5543191wmj.48.1553754962485;
        Wed, 27 Mar 2019 23:36:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9yTibCKgdZfHvIIBRmSNoR53M8eZ1Wxeg46iykn+/YqtPZxGEax3FM1QAzG9fQH7dGL/NDQ==
X-Received: by 2002:a05:600c:24f:: with SMTP id 15mr5543181wmj.48.1553754962259;
        Wed, 27 Mar 2019 23:36:02 -0700 (PDT)
Received: from localhost (host141-127-dynamic.17-87-r.retail.telecomitalia.it. [87.17.127.141])
        by smtp.gmail.com with ESMTPSA id c10sm31539295wrt.65.2019.03.27.23.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 23:36:01 -0700 (PDT)
Date:   Thu, 28 Mar 2019 07:36:00 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Pravin B Shelar <pshelar@ovn.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] openvswitch: fix flow actions reallocation
Message-ID: <20190328063600.GC16096@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flow action buffer can be resized if it's not big enough to contain
all the requested flow actions. However, this resize doesn't take into
account the new requested size, the buffer is only increased by a factor
of 2x. This might be not enough to contain the new data, causing a
buffer overflow, for example:

[   42.044472] =============================================================================
[   42.045608] BUG kmalloc-96 (Not tainted): Redzone overwritten
[   42.046415] -----------------------------------------------------------------------------

[   42.047715] Disabling lock debugging due to kernel taint
[   42.047716] INFO: 0x8bf2c4a5-0x720c0928. First byte 0x0 instead of 0xcc
[   42.048677] INFO: Slab 0xbc6d2040 objects=29 used=18 fp=0xdc07dec4 flags=0x2808101
[   42.049743] INFO: Object 0xd53a3464 @offset=2528 fp=0xccdcdebb

[   42.050747] Redzone 76f1b237: cc cc cc cc cc cc cc cc                          ........
[   42.051839] Object d53a3464: 6b 6b 6b 6b 6b 6b 6b 6b 0c 00 00 00 6c 00 00 00  kkkkkkkk....l...
[   42.053015] Object f49a30cc: 6c 00 0c 00 00 00 00 00 00 00 00 03 78 a3 15 f6  l...........x...
[   42.054203] Object acfe4220: 20 00 02 00 ff ff ff ff 00 00 00 00 00 00 00 00   ...............
[   42.055370] Object 21024e91: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   42.056541] Object 070e04c3: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   42.057797] Object 948a777a: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   42.059061] Redzone 8bf2c4a5: 00 00 00 00                                      ....
[   42.060189] Padding a681b46e: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ

Fix by making sure the new buffer is properly resized to contain all the
requested data.

BugLink: https://bugs.launchpad.net/bugs/1813244
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
Changes in v2:
 - correctly resize to current_size+req_size (thanks to Pravin)

 net/openvswitch/flow_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 691da853bef5..4bdf5e3ac208 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2306,14 +2306,14 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
 
 	struct sw_flow_actions *acts;
 	int new_acts_size;
-	int req_size = NLA_ALIGN(attr_len);
+	size_t req_size = NLA_ALIGN(attr_len);
 	int next_offset = offsetof(struct sw_flow_actions, actions) +
 					(*sfa)->actions_len;
 
 	if (req_size <= (ksize(*sfa) - next_offset))
 		goto out;
 
-	new_acts_size = ksize(*sfa) * 2;
+	new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
 
 	if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
 		if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size) {
-- 
2.19.1

