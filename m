Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DD6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2D21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 07:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="bqKMN056"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLSHry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:47:54 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:16132 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726303AbfLSHry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 02:47:54 -0500
X-AuditID: 0a650161-773ff700000078a3-c9-5dfb431dee13
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id EC.D3.30883.D134BFD5; Thu, 19 Dec 2019 17:30:05 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1576741680; h=from:subject:to:date:message-id;
        bh=SYrGLDyN3dpzQRtSVb9vXc6ckWRJVZMSiyKIrEiz//Y=;
        b=bqKMN056NK87USGUQZu4IwTpb3d90ek8ISKfuQVLJ0jjCvT7VPYP7VZwa5nB7Z1MCjoyGNF3pF4
        adXNAOTZUORlTIllXCfi3K+uu6eOXjO14MAh7Zrzz3TzdTqe5NxTchc7fiz4a5V3JdEjEhpkM2wyn
        w3Hz6LRun8XVMONX37w=
Received: from hsj-OptiPlex-5060.iluvatar.local (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 19 Dec 2019 15:47:57 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <jbaron@akamai.com>
CC:     <linux-kernel@vger.kernel.org>, <1537577747@qq.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH v5] lib/dynamic_debug: make better dynamic log output
Date:   Thu, 19 Dec 2019 15:47:35 +0800
Message-ID: <20191219074735.31640-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209094437.14866-1-sjhuang@iluvatar.ai>
References: <20191209094437.14866-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsXClcqYpivr/DvWYMpPAYvJVw+wWcxYfJzV
        4vKuOWwOzB6Tjyxg9rj1bC2rx+dNcgHMUVw2Kak5mWWpRfp2CVwZh77tZS1oFKho/7KKqYHx
        F08XIweHhICJxI/tnl2MXBxCAicYJY4da2HtYuTkYBaQkDj44gUzSIJF4C2TxKzrb5ggqlqZ
        JE7cu8cGUsUmoCEx98RdZpBJIgLiEu/nu0I0x0rM7doHFhYWcJU490oPxGQRUJV4eM8HpIJX
        wEJiya57jCC2hIC8xOoNB5hBbE4BS4lDV0E2cQJtspC4MO8SM0S9oMTJmU9YQMYICShIvFip
        BdGqJLFk7ywmCLtQ4vvLuywTGIVmIXlgFpLuBYxMqxj5i3PT9TJzSssSSxKL9BIzNzFCwjVx
        B+ONzpd6hxgFOBiVeHgzYn/FCrEmlhVX5h5ilOBgVhLhvd3xM1aINyWxsiq1KD++qDQntfgQ
        ozQHi5I4r9C/pzFCAumJJanZqakFqUUwWSYOTqkGpkm+L1eGbLNhOv7NlbV7u3TtjTTmudcF
        52k5cO1lqGtaUM3k3HND5kHIQ/O4zwpMdxfq83y9yP5un+ry2bP05syUz1HepNZtW2V5Ovf0
        9pj9qd83Ntspfl3zlOHq4cYiJdWdYSu97G8rXU1SZrOIiHnEGXNB8dIlw7ct0xg051Tks1S8
        Wdnf9+ejvEbZrY29Lx676e4v+7N4iz2bCfNSo/g3S87JGB1eKHvlQvqM+7/czFIrP7P/fbVR
        6AbPnVxW/ahr+i9znY87O0U4RK086RAuwGl6JbV78sP43Jmef/YvcRC0DDoZtevMpxTZS9+q
        Vk/1PTbxooHCSV3dqYKPIkzvqTlP01L2f2po5zIjT4mlOCPRUIu5qDgRAHJA5iTUAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver strings, device name and net device name are not changed for
the driver's dynamic log output. But the dynamic_emit_prefix() which contains
the function names may change when the function names are changed.

So the patch makes the better dynamic log output.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
v4 --> v5:
	remove the redundant whitespce in the tail.
---
 lib/dynamic_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c60409138e13..bfc3b386d603 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -589,9 +589,9 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 	} else {
 		char buf[PREFIX_SIZE];
 
-		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s %s %s%pV",
 				dev_driver_string(dev), dev_name(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	}
 
@@ -619,11 +619,11 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
-				"%s%s %s %s%s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+				"%s %s %s %s %s%pV",
 				dev_driver_string(dev->dev.parent),
 				dev_name(dev->dev.parent),
 				netdev_name(dev), netdev_reg_state(dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	} else if (dev) {
 		printk(KERN_DEBUG "%s%s: %pV", netdev_name(dev),
@@ -655,11 +655,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		char buf[PREFIX_SIZE];
 
 		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
-				"%s%s %s %s: %pV",
-				dynamic_emit_prefix(descriptor, buf),
+				"%s %s %s %s%pV",
 				dev_driver_string(ibdev->dev.parent),
 				dev_name(ibdev->dev.parent),
 				dev_name(&ibdev->dev),
+				dynamic_emit_prefix(descriptor, buf),
 				&vaf);
 	} else if (ibdev) {
 		printk(KERN_DEBUG "%s: %pV", dev_name(&ibdev->dev), &vaf);
-- 
2.17.1

