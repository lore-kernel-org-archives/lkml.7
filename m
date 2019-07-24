Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F1921951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ricmnZGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfGXIco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:32:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36327 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXIco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:32:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so20571562pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WCVd4lZUKuZfgNGTuLhW2SJHOFDTd7mo4CLEhXod6Ew=;
        b=ricmnZGDz9JfEwgUfDZFDf3pka2I7nCAOOXn/MrqlAskyInBrUbaJmRVzLD1uLXc+S
         LlTtXvfdaYicOwy7l44Qf/5QODHCbnytwgCwfpt7g2vNt5OIoPuv7ie+mrAsI7vTpMwT
         RqLVpBsjiqFMra83a/2L20EIPRrP8zKZ3ae/z6+k/LF1OIUsVsHNLNGiRDU3zoF8tMT7
         RvDMXCtgNy54ELCR2p2nhf6adFZNEvI12OzKdg3LAbDRIy3pWyxjWM7GlE8dcvT77qv2
         8xRnBWCQzfbIu0xb/8AzfZGqUa5vUcv/fN3NYS5yeKa1gvNZP5u9HAZldSwLtNei+zey
         /hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WCVd4lZUKuZfgNGTuLhW2SJHOFDTd7mo4CLEhXod6Ew=;
        b=QJZz74RhmbGBpZaBS0I+D6JpCXSRt+ZnMTYyoSArRXxE6L+KpmxPB7eHQCyKTjKGtT
         6fX3ojX23L8BMhykslD8lp5G/ry1NwUwz0RcIQH2QpQTlCpll996ozJ3RajpG7/o8MEJ
         Qq3Z1rjlF0EgPwm3cBkS1qTIMvtdOOQklbQ7kCMeNyjFcMrTOxznu6WoWrj84M5JNXxI
         oFFmIGnbFfUOS1ODjNyX/kJqQWP872WhVcT/l3l+W1tUv6hMYwbO+J7XSDNMPcrAYUYz
         FtajbYKsEp9/VG0lPA88yxrCIGaMeqsPmipuin3bfTtgEhoLwS0JPBZ3EEGgU3THP0/4
         MzRA==
X-Gm-Message-State: APjAAAUSZtf/4YvWAcIkuiFkI/p0fp9XnFNx9coRcjMV0jNS66TNL38E
        JdSH14dwBB0pRXSwNZJIFUo=
X-Google-Smtp-Source: APXvYqx0dENPrGC4mTXXKi4VugaJiHm6b+V3CtRjrlZQ4KhDbJjEO0bfu6rd0BVxdvGr/bEZUBABEw==
X-Received: by 2002:a63:fd57:: with SMTP id m23mr13942751pgj.204.1563957163390;
        Wed, 24 Jul 2019 01:32:43 -0700 (PDT)
Received: from localhost.localdomain ([110.227.69.93])
        by smtp.gmail.com with ESMTPSA id g4sm58654106pfo.93.2019.07.24.01.32.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 01:32:42 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] regulator: of: Add of_node_put() before return in function
Date:   Wed, 24 Jul 2019 14:02:31 +0530
Message-Id: <20190724083231.10276-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable search in regulator_of_get_init_node takes the value
returned by either of_get_child_by_name or of_node_get, both of which
get a node. If this node is not put before returning, it could cause a
memory leak. Hence put search before a mid-loop return statement.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/regulator/of_regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 397918ebba55..9112faa6a9a0 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -416,8 +416,10 @@ device_node *regulator_of_get_init_node(struct device *dev,
 		if (!name)
 			name = child->name;
 
-		if (!strcmp(desc->of_match, name))
+		if (!strcmp(desc->of_match, name)) {
+			of_node_put(search);
 			return of_node_get(child);
+		}
 	}
 
 	of_node_put(search);
-- 
2.19.1

