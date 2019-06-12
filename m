Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF65DC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CF120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9UzUN4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfFLToX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:44:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45966 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfFLToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:44:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id j19so19811286qtr.12;
        Wed, 12 Jun 2019 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EQNm8uL0go3b8Bxj6w0oMavlHo0z6dLALS5bDmoD9/4=;
        b=g9UzUN4zq8DBrEcBqzUqYAKqkoLzuAR07saSKkI16jE8m1SNjDHLana+Pn5/558AJT
         nnbD2YkzFpWIbhlAyVvpfpc/K5hUGU+QeDyTKggdx37lXdwepR2RlkfsOoJh6T6C3wsp
         PiIbpqgvAuuSPf8gh14YfCxGfcRGs+RpZFHzGUycchex/uOWIorXVt/KyPWK6laOV0cf
         hm9Mc8DdG23HrEocajvIQqdL4pa3nE1834qeyCdN2OA2V8czop9f/M3PNeska134OX3L
         RHMxkojlpGbmcIKqdFjhTRwVL1en7Up8UszvyzFhiI6lZTvYBQQ7VAVrB+2xDXzDY/vW
         ymGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EQNm8uL0go3b8Bxj6w0oMavlHo0z6dLALS5bDmoD9/4=;
        b=O+boH1oShnmJZf88BoH3vTtQZlQClWm/QuVkaitqLTOCvQklQjp9FkI79Bg/GCfMFX
         qLbq3EzpOxgLXEnE2JOAUVTGWHMpz4I6qwY6C9wLbEJgUopv0cvxLBvMggPUKdAlUJ5E
         0YKT6jvNPAR9Z2g6vt8MBtDVhABfzLz2H5mDsHV3n/y2idCrqGxTOM+95Q3Ss552j+VR
         11VyLC6Q/7rtUFIZVLRYr0o0STbudVPJfMyVs9hEnxWnTA/hWqsyk2jeZq3w7v1P72Zg
         1xSG8FmTgslzqssWFhaB+2qZnN+YkPTQm2H/rlzD3epaiOAPfUqpTIZzgS6/h2QnoOS1
         JGgQ==
X-Gm-Message-State: APjAAAV0AhqOjqgem8Jf57ngWxtEazUhOc/xH43vu9og0mK11/sIpmGI
        B23BvoLCB95Av+rCEOmRszfXhlep
X-Google-Smtp-Source: APXvYqzxnjx9+oK8YDCDGfy/ycUOk2BXRdFvFRzofd6E/WETjLfPT0eyTkrFzFwJFpQsbrTk+UJMQQ==
X-Received: by 2002:ac8:275a:: with SMTP id h26mr53009993qth.345.1560368662354;
        Wed, 12 Jun 2019 12:44:22 -0700 (PDT)
Received: from willemb1.nyc.corp.google.com ([2620:0:1003:315:3fa1:a34c:1128:1d39])
        by smtp.gmail.com with ESMTPSA id r5sm327581qkc.42.2019.06.12.12.44.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:44:21 -0700 (PDT)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     jakub.kicinski@netronome.com, peterz@infradead.org
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: [PATCH] locking/static_key: always define static_branch_deferred_inc
Date:   Wed, 12 Jun 2019 15:44:09 -0400
Message-Id: <20190612194409.197461-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

This interface is currently only defined if CONFIG_JUMP_LABEL. Make it
available also when jump labels are disabled.

Fixes: ad282a8117d50 ("locking/static_key: Add support for deferred static branches")
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

The original patch went into 5.2-rc1, but this interface is not yet
used, so this could target either 5.2 or 5.3.

---
 include/linux/jump_label_ratelimit.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/jump_label_ratelimit.h b/include/linux/jump_label_ratelimit.h
index 42710d5949ba..8c3ee291b2d8 100644
--- a/include/linux/jump_label_ratelimit.h
+++ b/include/linux/jump_label_ratelimit.h
@@ -60,8 +60,6 @@ extern void jump_label_update_timeout(struct work_struct *work);
 						   0),			\
 	}
 
-#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
-
 #else	/* !CONFIG_JUMP_LABEL */
 struct static_key_deferred {
 	struct static_key  key;
@@ -95,4 +93,7 @@ jump_label_rate_limit(struct static_key_deferred *key,
 	STATIC_KEY_CHECK_USE(key);
 }
 #endif	/* CONFIG_JUMP_LABEL */
+
+#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
+
 #endif	/* _LINUX_JUMP_LABEL_RATELIMIT_H */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

