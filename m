Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF821C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874020675
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slwC1m8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfLEWj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:39:28 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49817 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfLEWj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:39:28 -0500
Received: by mail-pl1-f202.google.com with SMTP id y8so2390296plk.16
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 14:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kGHV6wWHuR85r8JUVhZxWZLnGRhOsKtFOqh8044dUiY=;
        b=slwC1m8pMy3CmZ2Rmyejy/2oozQ0iVHpXII02F/rtTyqOBzv3xgogwpPqHDQtMdtmR
         NpRHBcfjGdSKwuQ9FR5ybbmGuPZ010y+jjBQWWgvpMwt5JRr6YX3C3L0Pz1N3fJfB6rT
         3u8tDZAcToNIzsyinGyh22g18lwiMnbk/QS+6xwzvl5vlBHfNX3qYsSC0R/5v7Ez9ZKv
         x1dtRLFrYHDk7vCGBYEb0yK6nIJGyZ9L8FbEwzcEtDuEqHE2Sz492L1sTgODQFy+V5cc
         ejenTr1sN//W7JtpSZ6aF4FZ6/ErbCKlbY0UV9cfW5WChHmAH9bCSKrkOGulQ8MLVae9
         G6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kGHV6wWHuR85r8JUVhZxWZLnGRhOsKtFOqh8044dUiY=;
        b=f+9wq1Nvh3zDHPCw8qvJ7c5b1xiOJst7uaM9G82a7uZ1kfGHVB0g3N2K1JyWyqoN7U
         DGgTTXQHEOCWs99HYPd5KVfy3MIkP56MTokp/kNG4bKQy5Gdwy2Xl1+WBzrlQ037ehsx
         k4oxp6rjd8bIHbV0Ag+e7kbRSrMltTWr+vHFPDtdjUqMXh+7DsNuLTRQvkoTPWRrP4QH
         dGwq5zs+z9AiiCdsc6P+9BrfpvTe7SB7JGFF9OlIov5amqguczAgvYqlTOSq/NmbtNXg
         ZtdVJf7mjjPiApwcG0nAUWVt3DFcCuHC2u7xsPUJMkgUxWkdALk+cy4I8RL+2QqRtFq/
         9DWw==
X-Gm-Message-State: APjAAAWt2KuPb1sVaCr1qV+BxS8W549cLbvxIYMBN+YIGiqJKEDAbPN6
        chFb6xPdboMXPl8tCtzfwgG6WihIir/h6A==
X-Google-Smtp-Source: APXvYqwe4CwGsiUN2fTj1I/3OuD/q3NkVnY6avpKVZED0zX+q/YWlF8hdegcNwN7w8/e+OsExNr2SJOakyob1g==
X-Received: by 2002:a63:8eca:: with SMTP id k193mr11745136pge.293.1575585567543;
 Thu, 05 Dec 2019 14:39:27 -0800 (PST)
Date:   Thu,  5 Dec 2019 14:37:21 -0800
Message-Id: <20191205223721.40034-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] memcg: account security cred as well to kmemcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cred_jar kmem_cache is already memcg accounted in the current
kernel but cred->security is not. Account cred->security to kmemcg.

Recently we saw high root slab usage on our production and on further
inspection, we found a buggy application leaking processes. Though that
buggy application was contained within its memcg but we observe much
more system memory overhead, couple of GiBs, during that period. This
overhead can adversely impact the isolation on the system. One of source
of high overhead, we found was cred->secuity objects.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cred.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..9ed51b70ed80 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -223,7 +223,7 @@ struct cred *cred_alloc_blank(void)
 	new->magic = CRED_MAGIC;
 #endif
 
-	if (security_cred_alloc_blank(new, GFP_KERNEL) < 0)
+	if (security_cred_alloc_blank(new, GFP_KERNEL_ACCOUNT) < 0)
 		goto error;
 
 	return new;
@@ -282,7 +282,7 @@ struct cred *prepare_creds(void)
 	new->security = NULL;
 #endif
 
-	if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
+	if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
 		goto error;
 	validate_creds(new);
 	return new;
@@ -715,7 +715,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
 #ifdef CONFIG_SECURITY
 	new->security = NULL;
 #endif
-	if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
+	if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
 		goto error;
 
 	put_cred(old);
-- 
2.24.0.393.g34dc348eaf-goog

