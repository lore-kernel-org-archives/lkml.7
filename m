Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB18C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75372464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJuwZ9C5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfLESy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:54:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46933 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfLESy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:54:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so1597541pll.13;
        Thu, 05 Dec 2019 10:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WN8ERINy6PXUGcWY7m9MoPwmPVqxaKRp2RAYWnDloq4=;
        b=YJuwZ9C5x9gP/4dhKBFCfhkq+pDYAjYcl10yYW0hgcWgTz3pG4ORfl5iAzoThLRWZC
         2uPWnUdI2s6YnkL+puMXun/cNGR9tT8YX/DLIw2CzXA+wy70ln6mSGkai9+EHU9mw0+9
         eKhiKH9w+t/Dj4b8L+a0PQ+rjGi7q5V46LzUKrLz2VHTEjJ+nXK5It8gRRDR8KD5tQTI
         xEl7F90XB98VydSe82zxNn2DaLwPSA5SAHNsPt6dueTBl9vmlbaVVwPKvtPmrFw7I/Wv
         Gn5jIuYbzKI7I1TTijHskJivYyKGLQenmM9y4MSl27IoH/u7Kj6nOnchzyiMBioxmIz6
         NZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WN8ERINy6PXUGcWY7m9MoPwmPVqxaKRp2RAYWnDloq4=;
        b=mmmvu5hhS/vVciV/cxsROVRuFFozMJVcZbBv316wrwLIhd+vwvvVUlr8eNqWbTpKBr
         SvkAQJC6RnXHJ5KpYoictJA655YwLcMYPY7d2PjQU7dQ2thPY9VdDE8HSy+B+wB1qX0W
         REd7Q4TsvRygYPXqia3YP0gA4rbBoteDC83EqWd2qbuLrHzFPZUKfk/GoaoKoD/izinn
         4VlJz9OTF/2JFc/DcURUbgSZzBi6g/r13oJ74ybguNfEhX5phjdf7WMqToVbYOfb3pdt
         n3HvlbFxjHWpAgnbTglZ/DIvKB4byF/MDUeUMwS7Xdkm7smVLadFaYtSbFvPCSoQa6+g
         38gw==
X-Gm-Message-State: APjAAAWrOPY0qMgBOKeuB1W/yRqefxTR/fLdsHzbR9kLa48IXZjM7n7W
        bSXpMRO1tC1KjVKPBXo1n2w=
X-Google-Smtp-Source: APXvYqzh8EYHVNRpV4wFsffi47Ko9oBUP66rlZ+yK5qxrXBj3EBpf5iASprcZ8zOukIdAWSERYqTtA==
X-Received: by 2002:a17:902:860a:: with SMTP id f10mr10632648plo.326.1575572064915;
        Thu, 05 Dec 2019 10:54:24 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:cf3:351e:3984:ab1:9b44:803])
        by smtp.gmail.com with ESMTPSA id 73sm12114203pgc.13.2019.12.05.10.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:54:24 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, josh@joshtriplett.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] include: linux: rculist_nulls: Change docbook comment headers
Date:   Fri,  6 Dec 2019 00:23:52 +0530
Message-Id: <20191205185352.1957-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch changes the docbook comment "head for your list"
to "head of the list".

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 517a06f36c7a..bea311c884b3 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -104,7 +104,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
- * @head:	the head for your list.
+ * @head:	the head of the list.
  * @member:	the name of the hlist_nulls_node within the struct.
  *
  * The barrier() is needed to make sure compiler doesn't cache first element [1],
@@ -124,7 +124,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
  *   iterate over list of given type safe against removal of list entry
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
- * @head:	the head for your list.
+ * @head:	the head of the list.
  * @member:	the name of the hlist_nulls_node within the struct.
  */
 #define hlist_nulls_for_each_entry_safe(tpos, pos, head, member)		\
-- 
2.17.1

