Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC5C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B38216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="b2heVtMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfIQUao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:30:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43568 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfIQUao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:30:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so5459150qke.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FapF/w8V6L5P4RP46nAQFrAdDN4jwAlxC54JDkAvfWE=;
        b=b2heVtMaAE//iiVUcKsZr0w7awdslPkqyQbYNyjGPHEL5W+LgsLzJdHgLusSCvcjFf
         YvSE5Y384otm0G5eZOgbTalFDAnlo01PRpnbLoB2ayOgzzTvNYCOnP4IGWEDYDbQ4qVD
         dLFolbhNPH4v6x1Pps+vdpjxTD8MKBvF9f5WuyV4U/4gF4NrkK8t59Lk1P6YK3FtQTW5
         hkfqNyCR2qrlhcy5XdsCerD3vDypFmfHqqZDSITyUW3Bpfw6Pwbmq7Wfcg/fHMOiKMxO
         PypYyKoxR5XSuCydNmltfumpdY8vQfvEYwhwI+VzGz4AnmdtC70mTm1ttcp//WcrmOwp
         Cytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FapF/w8V6L5P4RP46nAQFrAdDN4jwAlxC54JDkAvfWE=;
        b=H2BVl81DZ+X6WTFpuKdzFBkj10EPes0dwqBz3sHbAmETDgjwSaOpbPRPYyGpJQMe6D
         xYmw3hhCEb/VbuXdKS7U2x0BE6ycNxHlXKOWVcrgAYvGtmNEHr8e4JIouZ++xeeOFUK/
         gSWpjjA7SuOsTu38bUs3am5kEoXaePaaSNyTj36CL+4JhKcP3XKoGjY0KjQuPUuqozNT
         GjfbXpPbEpV4i8NCgMMIMbD0CM/cvmIfiXqRQb1uXamf+sM5hiWAQPnHkNnaykbc/pRZ
         YW6MM0MllaZ98my08ZdTZCX56ZrIJhHA12xjhrvZQHBzOVBgaN9u55+VCR8u4pyhRVBF
         K6pg==
X-Gm-Message-State: APjAAAX8piPZLSwzhowggub8NS2v7ULvonlNv/jghMNaI69wwD03t7pJ
        0tCrn8CM9ft868o13v6A1mYKsL8Tx3w=
X-Google-Smtp-Source: APXvYqxAmisQfB6dzZqw466gLLRXufi21otNJ/5du7EZOaLPbhdALpCQOrklxXZW9Tlgu7tiOQD7Gg==
X-Received: by 2002:a37:9d93:: with SMTP id g141mr427405qke.188.1568752243366;
        Tue, 17 Sep 2019 13:30:43 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 139sm1822874qkf.14.2019.09.17.13.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 13:30:42 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     rientjes@google.com, cl@linux.com, penberg@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/slub: fix -Wunused-function compiler warnings
Date:   Tue, 17 Sep 2019 16:30:32 -0400
Message-Id: <1568752232-5094-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tid_to_cpu() and tid_to_event() are only used in note_cmpxchg_failure()
when SLUB_DEBUG_CMPXCHG=y, so when SLUB_DEBUG_CMPXCHG=n by default,
Clang will complain that those unused functions.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 8834563cdb4b..49739f005b4f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2004,6 +2004,7 @@ static inline unsigned long next_tid(unsigned long tid)
 	return tid + TID_STEP;
 }
 
+#ifdef SLUB_DEBUG_CMPXCHG
 static inline unsigned int tid_to_cpu(unsigned long tid)
 {
 	return tid % TID_STEP;
@@ -2013,6 +2014,7 @@ static inline unsigned long tid_to_event(unsigned long tid)
 {
 	return tid / TID_STEP;
 }
+#endif
 
 static inline unsigned int init_tid(int cpu)
 {
-- 
1.8.3.1

