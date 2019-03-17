Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D70C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BCA2184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="JJWKmdRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCQMXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:23:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44854 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:23:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id w2so13994610wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iu8zACNqwVL3RzfLP4GSCN55keWiZIgLTauefxAFOhM=;
        b=JJWKmdRCkykVgM/jXaA3oEF/1ZElQGMSD+GfPdkVd2U90WuD4EyMs0+iUduQvrc9mm
         qTCkFeh9ljYzFRzqCrVHR/qpOmodToTEV1iIjDNl4Q0wbQ7U3dq0wCMw+9Aw+KARHNHR
         SKcnuyzYAJwKUCp4Kp1YmEZUe5LUCuipt7iJG6Nko1bM0CydCoVZUjbXYoKkufseAqOQ
         4YmfD0HpzB6uM3MNF05qENBjS5vsCkdS/BCf126CXWkbwxsEz6aROUf9X12N+KnF56r2
         eDyLdskpVeNm/9aDGVWC3zEjzlXRkXWMqGDoMJhmzO8fynpFO6uadA9IHzdTMb45BJdD
         qIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iu8zACNqwVL3RzfLP4GSCN55keWiZIgLTauefxAFOhM=;
        b=WyGy+6cC2dZ+VfMCKEkiixTScsRa2tTz7Fs8hrxzHAnkOIWdeIw6Q09sNiLgmRo5c4
         NUiuNLxxl8Cp3sN6LLuxkV/3nJcE7xyqAE3IxaLQzY8hIepZoc2YB1xM6EqrtAhBFmaV
         XMqdvQGCFddafJICAqeIg/7YIFZowBEHeCvMoUwW6ZXtHSwfMQRyaTA3jBwZkVPlFni6
         STKdbfDE/JqwGOjIEUC8PDbCkZf60sVY+6+7iyOEbDGgGKVhrtXSpQq8odztUE39CQso
         JtBac3AMiVe/QUHrDzujEVKoXStnKlSuXEgicCLl7dSakXcQD8Rq38OkwtjW9ab3GEqC
         LpyQ==
X-Gm-Message-State: APjAAAWzM7WmROoRfU32iz5OgVUP087RoOfroMVrRLck29q+vPugYl28
        0ZlodmHgY8tphGOaQLWgoToLhg==
X-Google-Smtp-Source: APXvYqxlJGEqLxjdgrdesqG1k9LazBikB3nxnf2SJMKlwW8k2xdgqHO3JGIWymPDTpQoTSy3yqnkyg==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr8529193wrq.148.1552825382202;
        Sun, 17 Mar 2019 05:23:02 -0700 (PDT)
Received: from snf-864.vm.snf.arr ([31.177.62.212])
        by smtp.gmail.com with ESMTPSA id z10sm5453292wrs.11.2019.03.17.05.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:23:01 -0700 (PDT)
From:   Nikos Tsironis <ntsironis@arrikto.com>
To:     snitzer@redhat.com, agk@redhat.com, dm-devel@redhat.com
Cc:     mpatocka@redhat.com, paulmck@linux.ibm.com, hch@infradead.org,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] list: Don't use WRITE_ONCE() in hlist_add_behind()
Date:   Sun, 17 Mar 2019 14:22:53 +0200
Message-Id: <20190317122258.21760-2-ntsironis@arrikto.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190317122258.21760-1-ntsironis@arrikto.com>
References: <20190317122258.21760-1-ntsironis@arrikto.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c97be677f72b3 ("list: Use WRITE_ONCE() when adding to lists and
hlists") introduced the use of WRITE_ONCE() to atomically write the list
head's ->next pointer.

hlist_add_behind() doesn't touch the hlist head's ->first pointer so
there is no reason to use WRITE_ONCE() in this case.

Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index edb7628e46ed..b68d2a85859b 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -743,7 +743,7 @@ static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
 	n->next = prev->next;
-	WRITE_ONCE(prev->next, n);
+	prev->next = n;
 	n->pprev = &prev->next;
 
 	if (n->next)
-- 
2.11.0

