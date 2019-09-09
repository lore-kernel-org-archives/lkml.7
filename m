Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22929C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0E321924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEqQBjJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405403AbfIIRIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:08:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44211 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405382AbfIIRIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:08:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so8146279pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=po3z9vVT8yU9vPmX7PJ6RtAkWylGnCZpE16E0o8CVfM=;
        b=tEqQBjJ3ODXxSMvYG+vcVbfl2luxsciSY2E+CsqLqrqbVjCNyZKwHecdfEmyUpgt3I
         uha/ukETxtto5BMjuu0dtOR0bYwM3A1N2k9GAforKbjH3v39Y5ea/j9ZpYQ3OCBTtK2j
         uwwuuHbyjZlL+Bx7dXXGCY658Q/G9QSrYzDYKb3Ns/Sw9adFXQ9rX8iGQvxXsa1RsP88
         g7wSH3FezbdWKoyybVGvKS9N5w3eDSsmPRcg5IznZHJC25aPpJlNTgg0dvd5BXWv71qP
         MdpLYxk3Aa1LfwYDJdCMXY7pgZS9dvze3XMZ/8A4hJesCTjq+iB8TYQ/DG3DsyNNxxEH
         CB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=po3z9vVT8yU9vPmX7PJ6RtAkWylGnCZpE16E0o8CVfM=;
        b=mD5vjbPGN2BR57tIJz5b+cuS1K//ZwolR6H814gXytujXVePtgBmQd90kGlZlHAqyE
         1dfGE7TSyH7rBH3E9hSdnOKvywWUrcEi3Vl6gCoX93IViE8zFA//qPAN+EfzEOrQBl1v
         HOSMVo//Td2a8125HOUeuenk3bJP7ePZyAuRC7bDcUfXiuL9idNGVU3LKQAxR8yXlPX2
         w/ykk7KbUNkI3Tae1545GJzeq5QtuKZFhvrXA+Ctx/iRQuBgM7Fh6mRe29uhTQvPMmeh
         7nMXSiF//g+m8U5PCoaGCs60k6jeWj5a6Hq1SgU5mD2uekX6WW+L952XTqH1BJCDBoXZ
         Mi5A==
X-Gm-Message-State: APjAAAVjxm4g5BPAIAZI3A5enEG0nA8NNIHxiOIgrEkPfMA2XlosH/0s
        ywPHjGZAnI76M//NTBEUG7w=
X-Google-Smtp-Source: APXvYqw8nmtXQB0qB1NLHmAWDmBgZi64O1gEri+HPL1E/k/r0gZ67FyRjZJKK83eJQ2o5MKUrDATJA==
X-Received: by 2002:aa7:8d8e:: with SMTP id i14mr3798050pfr.262.1568048915686;
        Mon, 09 Sep 2019 10:08:35 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id b18sm107015pju.16.2019.09.09.10.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 10:08:35 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 4/4] mm, slab_common: Make initializing KMALLOC_DMA start from 1
Date:   Tue, 10 Sep 2019 01:07:15 +0800
Message-Id: <20190909170715.32545-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909170715.32545-1-lpf.vector@gmail.com>
References: <20190909170715.32545-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc_caches[KMALLOC_NORMAL][0] will never be initialized,
so the loop should start at 1 instead of 0

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d64a64660f86..6b3e526934d9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1236,7 +1236,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 	slab_state = UP;
 
 #ifdef CONFIG_ZONE_DMA
-	for (i = 0; i <= KMALLOC_SHIFT_HIGH; i++) {
+	for (i = 1; i <= KMALLOC_SHIFT_HIGH; i++) {
 		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
 
 		if (s) {
-- 
2.21.0

