Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BF22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xVSv7MOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfF1Okf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:40:35 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46577 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfF1Okf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:40:35 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6715ffe1;
        Fri, 28 Jun 2019 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=AGNG8P6ktfKqFiGbK8g05DgQu8E=; b=xVSv7MOsA+Gxaj2iyrpq
        P6KS+RHc76Q881QkSESn2yuhFNXqW6NBMLdM2d1h8D6BPC/EoPK8zgXijJLFz4TM
        +gADwDq0F7QFUvvNe7zudnAjCJl3D5po9+rvLR2Tk2Eb4LEYRKQfNWJNOwSLVAOy
        VGCGu+lPOrVyxafC3H7kIWiXHAKDplGV3A/+5ebKzI/fqny9ZzbSTFrL7zNl165C
        C8ozmUbydk0mjta4AM4j32jGNVQxHr2eKEsMc9A75i5jAMqJY10LAOIrcOYxpydq
        lydCsKN4JtPFnjsLAhUcundobHVXkjH6LYGdwgvcgSNF3klXZU/G7jn5lot/tKW8
        UA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83477081 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 28 Jun 2019 14:06:14 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] netlink: use 48 byte ctx instead of 6 signed longs for callback
Date:   Fri, 28 Jun 2019 16:40:21 +0200
Message-Id: <20190628144022.31376-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People are inclined to stuff random things into cb->args[n] because it
looks like an array of integers. Sometimes people even put u64s in there
with comments noting that a certain member takes up two slots. The
horror! Really this should mirror the usage of skb->cb, which are just
48 opaque bytes suitable for casting a struct. Then people can create
their usual casting macros for accessing strongly typed members of a
struct.

As a plus, this also gives us the same amount of space on 32bit and 64bit.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 include/linux/netlink.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 593d1b9c33a8..205fa7b1f07a 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -192,7 +192,14 @@ struct netlink_callback {
 	bool			strict_check;
 	u16			answer_flags;
 	unsigned int		prev_seq, seq;
-	long			args[6];
+	union {
+		u8		ctx[48];
+
+		/* args is deprecated. Cast a struct over ctx instead
+		 * for proper type safety.
+		 */
+		long		args[6];
+	};
 };
 
 struct netlink_notify {
-- 
2.21.0

