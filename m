Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D47C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24455218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2uPrXiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbfCaGmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40325 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbfCaGmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id b11so2924040plr.7;
        Sat, 30 Mar 2019 23:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TfiF5XnESs3rd2LTH3SlV6CzghcxJZ6+t1a6r0fB5X4=;
        b=O2uPrXiB40QJIQvIj0PMtJfoc4MWpLva8CplaNmebtV0G8XBt2p7inVFXNo1uQYoxH
         /PlebslAzd/Gy4uc8aleNnyPTCBImE8qc98Y3ejl0gKfN3tjN31DLfhfMdhUkhqrC2h7
         w07oLdzgzCvXk78vUdQGRnRVd+gwJiQUaVItzJcKK8QDEUSBdbFw94XE+sxgFywamcpR
         JDWYqWcnCFYsIImJeHHp6cWJKTHdPaftrXO7XA+5rVOYbLD2f6EfcReW8JHH3YQ/Zdr3
         Qqdy8DQlzj9HtNAuuEzyX+lK68OXiMHBrbVgZEmf8sHYAq1CtTPxpmIOacDi7+JkgRFj
         UQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TfiF5XnESs3rd2LTH3SlV6CzghcxJZ6+t1a6r0fB5X4=;
        b=BWUU3R8Wxk30iB8Z4wbFmyDckzav7tUjl+8qIhfo6Rrj9+zuTlDBJwq9SR5i10Uxk7
         lXze66NFc/JFLjlvUWRGGkfKHtCEs+cH2bDvxqdS2VDdpXLW5qTCqFlDvRm3fSylZxwB
         Nm9hBPw0CRASyOX+pJZl8vFFnPr5MSrP0T6d2h/I3sdp3qhKqSroS/5V6x4RMDgb4uZO
         SmUq4O72F51tFyy1S1nsxtznaNBYE5D4JIS9cM4m6ZV1fGzzeTLyZYBk9q//X44/1cOY
         tHyxTJpmXgVY4n3ybFESGZNK+iTYky3SaHw/XmXoc+z76RMbvRoCaPEHZHwZ8O45qE5d
         Vflw==
X-Gm-Message-State: APjAAAVvVAAyc55RV6u42K+N9s1w4Azyem3vOw19IdGXqyijlFiCVQ5P
        zb6bA9hJpHotQ3BTsh3UjnQ=
X-Google-Smtp-Source: APXvYqxV3xaU/1oEMCCoazXRAqjbwWbhVK3DGoK3LeIxDd5cl5lJRJwiXYjjf3jebPBbgUHu8hN+Dg==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1mr17867671plb.129.1554014524195;
        Sat, 30 Mar 2019 23:42:04 -0700 (PDT)
Received: from brianvv.svl.corp.google.com ([2620:15c:2c4:201:c1c8:2119:1010:59e0])
        by smtp.gmail.com with ESMTPSA id p88sm10653281pfa.80.2019.03.30.23.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 23:42:03 -0700 (PDT)
From:   Brian Vazquez <brianvv.kernel@gmail.com>
To:     Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] bpf: do not start from first bucket if elem is not found on a htab
Date:   Sat, 30 Mar 2019 23:41:29 -0700
Message-Id: <20190331064129.31702-1-brianvv.kernel@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Vazquez <brianvv@google.com>

When you want to traverse an entire map using BPF_MAP_GET_NEXT_KEY and
key provided is not present due to a deletion you will start iterating the
map from the beginning without noticing it. This patch changes the
starting bucket in those situations to the bucket where key was
suppossed to be.

Note that you can still get stuck in the same bucket but it is less
likely than getting stuck in a loop restarting from the beginning of
the entire map.

Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
---
 kernel/bpf/hashtab.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index fed15cf94dca6..eea046d269f51 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -611,11 +611,14 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 	hash = htab_map_hash(key, key_size, htab->hashrnd);
 
-	head = select_bucket(htab, hash);
+	/* keep track of current bucket */
+	i = hash & (htab->n_buckets - 1);
+	head = select_bucket(htab, i);
 
 	/* lookup the key */
 	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
 
+	/* this will start looking from bucket i */
 	if (!l)
 		goto find_first_elem;
 
@@ -630,7 +633,6 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	}
 
 	/* no more elements in this hash list, go to the next bucket */
-	i = hash & (htab->n_buckets - 1);
 	i++;
 
 find_first_elem:
-- 
2.21.0.392.gf8f6787159e-goog

