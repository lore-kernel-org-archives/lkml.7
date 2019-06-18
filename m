Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354DCC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04970204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+YmXflR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfFRVOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:14:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45552 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbfFRVOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:14:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id s21so8330760pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FS2xe3EqWjVa2osnhJcZdNg83PN4WkVvVWlHL7l/qqk=;
        b=Y+YmXflRcgQfURiuGJArsK6o25FGeuUUOwK3W1AuGqsrOnUiyasENIxuR4JhNsKkED
         4mCaNhDAap9VjNHruD4pZhaK1UdTznr8A/O1td3EepAB4lLWkN/jhwn6QbokpmvkAYMe
         eFwVw/QB1uhc/MjklhcZpgppWojGGLihJy92c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FS2xe3EqWjVa2osnhJcZdNg83PN4WkVvVWlHL7l/qqk=;
        b=jW+wAxz8YrEq/qn4OercavyNvxgTNpVbxGETD+obLbZh6YG2CN5vQH6QwC07YLqkvH
         LHn8G+yssIqeptclPgCTud7YDhO7fKvqV5vQT+3vsGfXy2r5htbka5QwNREH0vIx0cHN
         JjuojKAmN+PD7gLrCpST49CXckETssghBokaVy0UnPl02NVVsAw6WLgKiv0r5NXgqjh/
         UOKJ947KQDhycicODc3+oiqnWWEc9AyIq5WQaTx3nclR9c9Fdy2gzLp5Nzi5T1vXOjPy
         BgWXqnP6a14I3ZNuGRLSgvBGj3iiFBD9sheA51A7MH7SarVlBl0DhbeRFtFimhNu7aFq
         E/5A==
X-Gm-Message-State: APjAAAUxWv56nQMTNBUYsPWn3uIZ+AZfDFCPFtusjEyQqI2PmtQCVrWP
        H8/voNwSajc/Gr4Ma4FaBKDYmQ==
X-Google-Smtp-Source: APXvYqyf9L4vnVsrhqP4UkUwW/isWrJmFSn/+x+Z9ZC4m0lvANqoqpOnMKhw7IbwN4Gl6KS1bXKNmA==
X-Received: by 2002:a17:90a:7146:: with SMTP id g6mr7275143pjs.45.1560892484762;
        Tue, 18 Jun 2019 14:14:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c10sm3168946pjq.14.2019.06.18.14.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 14:14:44 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] net/ipv4: fib_trie: Avoid cryptic ternary expressions
Date:   Tue, 18 Jun 2019 14:14:40 -0700
Message-Id: <20190618211440.54179-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

empty_child_inc/dec() use the ternary operator for conditional
operations. The conditions involve the post/pre in/decrement
operator and the operation is only performed when the condition
is *not* true. This is hard to parse for humans, use a regular
'if' construct instead and perform the in/decrement separately.

This also fixes two warnings that are emitted about the value
of the ternary expression being unused, when building the kernel
with clang + "kbuild: Remove unnecessary -Wno-unused-value"
(https://lore.kernel.org/patchwork/patch/1089869/):

CC      net/ipv4/fib_trie.o
net/ipv4/fib_trie.c:351:2: error: expression result unused [-Werror,-Wunused-value]
        ++tn_info(n)->empty_children ? : ++tn_info(n)->full_children;

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
I have no good understanding of the fib_trie code, but the
disentangled code looks wrong, and it should be equivalent to the
cryptic version, unless I messed it up. In empty_child_inc()
'full_children' is only incremented when 'empty_children' is -1. I
suspect a bug in the cryptic code, but am surprised why it hasn't
blown up yet. Or is it intended behavior that is just
super-counterintuitive?

For now I'm leaving it at disentangling the cryptic expressions,
if there is a bug we can discuss what action to take.
---
 net/ipv4/fib_trie.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 868c74771fa9..cf7788e336b7 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -338,12 +338,18 @@ static struct tnode *tnode_alloc(int bits)
 
 static inline void empty_child_inc(struct key_vector *n)
 {
-	++tn_info(n)->empty_children ? : ++tn_info(n)->full_children;
+	tn_info(n)->empty_children++;
+
+	if (!tn_info(n)->empty_children)
+		tn_info(n)->full_children++;
 }
 
 static inline void empty_child_dec(struct key_vector *n)
 {
-	tn_info(n)->empty_children-- ? : tn_info(n)->full_children--;
+	if (!tn_info(n)->empty_children)
+		tn_info(n)->full_children--;
+
+	tn_info(n)->empty_children--;
 }
 
 static struct key_vector *leaf_new(t_key key, struct fib_alias *fa)
-- 
2.22.0.410.gd8fdbe21b5-goog

