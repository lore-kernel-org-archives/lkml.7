Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB51C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A222133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QEFYliYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfHNSdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:33:10 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35037 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNSdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:33:10 -0400
Received: by mail-qt1-f176.google.com with SMTP id u34so11921133qte.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a7VsLFWMqOK5QBGftp4DGOIRVxFfDzWSvXbi6s9WXSY=;
        b=QEFYliYmrCuKePZfglkjulUgR6y+rScw4FXOVaQO6wi+jp/Ip4hmRTbR9lmogQKKFO
         AY4NToD66LZNT0QxOwsKFhoxVtBglCZF3VdZPlROqs+MlnSsq+i3ZDOq7TbtzNT9yYzw
         yknOdkrphpep7i7E1MLD15yEiRbNiq5owflBseNX4oBf0RKk0I9hJAufGdBEoqDa22Lo
         qa4vayt60S0tEd2Gji4vY/tdWDsF2HuVxATy4tEOkFzYv7DngjLaQpEZDJbcjN2rVP0p
         hDtheDGN10dnOgqHRJU+DIQGwCawqIDZXRyz6sLvbtFxfljjNHuFOgCvc59lBWK61jdu
         P8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a7VsLFWMqOK5QBGftp4DGOIRVxFfDzWSvXbi6s9WXSY=;
        b=bK65F5L+y7m9sige3usmRBWMZD7LMQJ1S27KhH1m/JT2SoV4iTZBctU8L3jpLs6eSu
         Z4DKTs4lVXhamhB+9LW7lDMgVKZgmS2D1tkZmjadFSBlNhr75j6hDiIVrXdNscC/S6so
         MzFE5ke14reGT79e5KBexxNbqUxkt/MbfROP3WxF+FZg9xQ3Z4j4xS8Va5URyOU/gZL1
         DtAJnVL9GLc3Hm1No8zbJJ+rUYyhT5Xd0VKD0mFcZLZXXuBHB53u+5otU0N2+jNehEq0
         MphunQUp0u/5OvF8d6k1D1sQK3xet18wiFOeo8u9uf2HsbdCTYB27WHbm/75VHCeF590
         L5bw==
X-Gm-Message-State: APjAAAX6kfOgcls0LOu2W2Pu3ynuygMT/toYNoelHtZ9S4suXTU5m5VL
        SPHbYORi7T4LUofRnuEtbMhWaw==
X-Google-Smtp-Source: APXvYqwMuwKyYCpL2+otD6j1gk/bschN93ksmfQMvwSAUNE6ackQhWxes3MQ8TV5Ong8ZOe1hAjGVQ==
X-Received: by 2002:a0c:d981:: with SMTP id y1mr867094qvj.104.1565807588862;
        Wed, 14 Aug 2019 11:33:08 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w1sm226000qte.36.2019.08.14.11.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 11:33:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/kmemleak: increase the max mem pool to 1M
Date:   Wed, 14 Aug 2019 14:32:52 -0400
Message-Id: <1565807572-26041-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some machines with slow disk and fast CPUs. When they are
under memory pressure, it could take a long time to swap before the OOM
kicks in to free up some memory. As the results, it needs a large
mem pool for kmemleak or suffering from higher chance of a kmemleak
metadata allocation failure. 524288 proves to be the good number for all
architectures here. Increase the upper bound to 1M to leave some room
for the future.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e80a745a11e2..d962c72a8bb5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -595,7 +595,7 @@ config DEBUG_KMEMLEAK
 config DEBUG_KMEMLEAK_MEM_POOL_SIZE
 	int "Kmemleak memory pool size"
 	depends on DEBUG_KMEMLEAK
-	range 200 40000
+	range 200 1000000
 	default 16000
 	help
 	  Kmemleak must track all the memory allocations to avoid
-- 
1.8.3.1

