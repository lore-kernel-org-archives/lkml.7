Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD0C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B0721670
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiPslvaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEFIUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so6096459pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0kfhy/vws18rZpDHDaPIfYHeGOwGyfC2bZ5+sCfkbgA=;
        b=aiPslvaWZSe2jEqAf1nS35euQvnz1CFpNDxLJmXCE4CmuJwQvFyYLMJZA2pbQ2pc7s
         9GgOzeYxcdYMYZzOnyIwNUx9PwOSmmRQkwrs9PNoxpY8QXWxYa++RQVYP0C3GbEWTNES
         CSHTdv8gcbW30QvOBTCHkLJ9StxbWDS3kX3FJNnBXOE+ZWh2BwNkDarBV3vXLRksOgKL
         LH7O7d0zpVa0tgEpp2SjnY1fYnUttt0GHWbtfK0OH+JtRVShnkhaNs4A8XVLL0Lfrd29
         lrv233TqUHpCeV7c9uOpjCA9KQrkSanx/EU0JyqeUI+/Gg4Aix6T3s0ZQ709qmtM1ywb
         Zveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kfhy/vws18rZpDHDaPIfYHeGOwGyfC2bZ5+sCfkbgA=;
        b=XlCfaD7ViwH7wfFnTgi4oA8cb0hPJTzB2KGSWoRkLD5qUTJW8FLycDqAuF7bHY9oM8
         nsk3qY6TlbplL/5WJsw/pcOFchhtzvJKIapNCYpp7H5+uzWdrI+0nLtf+Y9d61XZLOpf
         CDaend2MvIwVQwwszxs70O/bxrMc6WtuZPcnSgLNWrFsHS4SjZeSw5hcnxh6l9q5Xr4l
         AYHc8k6lxHt2+abk62H7fbKnpRFUuD3L0jNyMPSZdSS9IlXiQzDvqFk+eww+4G7GmTle
         PEoVIAF7yigDrl0l01FZuAcUBWi94h+taGK2RzsAUt/VK0kNCES6Zn+6YZiJ5Qdtfcuc
         pJgw==
X-Gm-Message-State: APjAAAXTr8kd5P2DaSzl1+cQEEPW9ryymXC2RLLzAhc6WWqgH8h+852p
        i7y201Tcd6Oo00//kxTrCmrdj+yz75yPwA==
X-Google-Smtp-Source: APXvYqzDTXJ43SKrPJ3byOyk8u/WCubl4tKRa79J/PWPJMMb3Zzds/4j9jFCEz5iFERISmjt51LLQQ==
X-Received: by 2002:a63:de11:: with SMTP id f17mr29706720pgg.94.1557130808373;
        Mon, 06 May 2019 01:20:08 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:07 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 06/23] locking/lockdep: Update obsolete struct field description
Date:   Mon,  6 May 2019 16:19:22 +0800
Message-Id: <20190506081939.74287-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_chain struct definition has outdated comment, update it and add
struct member description.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6e2377e..851d44f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -203,11 +203,17 @@ struct lock_list {
 	struct lock_list		*parent;
 };
 
-/*
- * We record lock dependency chains, so that we can cache them:
+/**
+ * struct lock_chain - lock dependency chain record
+ *
+ * @irq_context: the same as irq_context in held_lock below
+ * @depth:       the number of held locks in this chain
+ * @base:        the index in chain_hlocks for this chain
+ * @entry:       the collided lock chains in lock_chain hash list
+ * @chain_key:   the hash key of this lock_chain
  */
 struct lock_chain {
-	/* see BUILD_BUG_ON()s in lookup_chain_cache() */
+	/* see BUILD_BUG_ON()s in add_chain_cache() */
 	unsigned int			irq_context :  2,
 					depth       :  6,
 					base	    : 24;
-- 
1.8.3.1

