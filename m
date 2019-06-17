Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E21AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B672085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XXCcsuXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfFQWVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:21:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44503 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfFQWUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so18390138edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USll/BQoEMD9h/5s/gE0+mUmlLpHN4EGkzRtmNYNT3A=;
        b=XXCcsuXdBLEAzoW4Q0iFd/MXLh5QWWfm78sqt3zu2fHUonh0V8LavMmoN01/z5QdJx
         /ed5/IyPxtpljecFaqRxB1Q3YdFaUgv4b/Y11K02MMu4S7luK9GzzAhiGD9bBrppB/s1
         G1orGY3AX26Go/+3eRWO0azz4qITQUxmGOZKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USll/BQoEMD9h/5s/gE0+mUmlLpHN4EGkzRtmNYNT3A=;
        b=aH62UZxWnBADq/LkPQAw3KNL+JBvfmmBzOy7fZRhGISJK2dQ/rFYIGMV2zeEdE61gF
         7wL9/wCBSs3T+nFrHaMUqVwy4ck1TV/tJxWrPW2AwSeTorQ8IczZzlKcgFQlwQlKQ4xo
         Qdma7zGAj7czcxHIJxT8rFSNQ2jC0RqRna11q+fIDQJutVcZUqorH0Ljgf0aIxj0zJLu
         LNKSCQnJ3+cEwJZQWwoUE9pyiFoaneKoe7a5k3Hf6owZjCKnzdbPe4q7dLv2x+wXjC6l
         7fr9DPkumD+7/gt0HB54tIy0vsfYK7238JJNW2nHBgFm3IoVxkua+LtxqIv6jti5iqFa
         D1gw==
X-Gm-Message-State: APjAAAXggDWRIrTWAbzEG35yXIVyKqwvFzSYyL2YWFmS7sLcmqcjk+Zo
        33sxxWMrNf1pRfVGESznCaOfvg==
X-Google-Smtp-Source: APXvYqxILhC7W+hcTx2f5lyVXRTW0CzNQaSIZVhNA5PQLCCOyRUjqKrrJhYzf/q6cehRDbaouKMMTw==
X-Received: by 2002:a05:6402:1557:: with SMTP id p23mr45110600edx.207.1560810044811;
        Mon, 17 Jun 2019 15:20:44 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v6 2/8] linux/net.h: use unique identifier for each struct _ddebug
Date:   Tue, 18 Jun 2019 00:20:28 +0200
Message-Id: <20190617222034.10799-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for net_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Cc: netdev@vger.kernel.org
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index f7d672cf25b5..a080ede95b47 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -264,7 +264,7 @@ do {								\
 #define net_info_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_info, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
-#define net_dbg_ratelimited(fmt, ...)					\
+#define _net_dbg_ratelimited(descriptor, fmt, ...)			\
 do {									\
 	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
 	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
@@ -272,6 +272,8 @@ do {									\
 		__dynamic_pr_debug(&descriptor, pr_fmt(fmt),		\
 		                   ##__VA_ARGS__);			\
 } while (0)
+#define net_dbg_ratelimited(fmt, ...)					\
+	_net_dbg_ratelimited(__UNIQUE_ID(ddebug), fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define net_dbg_ratelimited(fmt, ...)				\
 	net_ratelimited_function(pr_debug, fmt, ##__VA_ARGS__)
-- 
2.20.1

