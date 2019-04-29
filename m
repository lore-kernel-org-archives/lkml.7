Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDECAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58621655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p1MVMVkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfD2UQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:16:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbfD2UQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:16:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so17875956wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L14+mVgpFPqR6PXB76MX2XZrP0FVM4lLU8EXKkexDzc=;
        b=p1MVMVkZfXD7VH7VAdpMlfn+K25MvJCB8GjUIb8s4KL5vdJXzEIjKrNVO0tWrsp4EY
         rZuXgmobi2BwqIh/efoKP08s8Fj8rjY+cmDs5U30A5ldRLuBCEpDKBlcyLDYNDvdbidK
         kGku/H1isgEG9s7kUlB0YeG0/RT3cCVNqKnS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L14+mVgpFPqR6PXB76MX2XZrP0FVM4lLU8EXKkexDzc=;
        b=BuUDME7HC58tqRqTwnP6wxICa0t6Qkldg9iRi48HJKSglopnygdh3rtB97a+7/JdrO
         2FLMWKuMeaB14aB2UTBIFEkmW7fjGvzsbyCb8w24Nz5zsRJLqaFK+sSatyHdNeOiST13
         j2owb1Viy/FO6DSHkrtkxecg2kKpmwbvyuybQg0oL4nlGhqwH3ypiTyhbYr3AO7kjQ+0
         vqfNTGJ5PrKuQZjL7Ga2vahw0puldK6aZllkYNm3kMB4pzaCz7TUUV0f/k0RqD0OsWgD
         Ci1vnPavMsQe1uCUgsu8PefYQtA1PVwMQkTTgLu9ucA3FRGbT4Sj8pC4Yu+RIcUChuul
         YhIA==
X-Gm-Message-State: APjAAAV9PJ/2iVb1D+WfNIEUmZj2QmwmgxCGffeYdLa+cLicSRWcIPLr
        wSEyCQUqNxSY3QIe50vZWzDvymPZOHM=
X-Google-Smtp-Source: APXvYqy9oJ9vdfCQf7W9AoeXXL5QufvPVwHHMvpf9iVkhWgl6YC0+AZuMexBTegFf+EwHB9f8B8yEw==
X-Received: by 2002:adf:f84e:: with SMTP id d14mr3684795wrq.21.1556568963757;
        Mon, 29 Apr 2019 13:16:03 -0700 (PDT)
Received: from localhost.localdomain (ip-93-97.sn2.clouditalia.com. [83.211.93.97])
        by smtp.gmail.com with ESMTPSA id k6sm22864019wrd.20.2019.04.29.13.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 13:16:03 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org
Subject: [PATCH 4/5] ceph: fix improper use of smp_mb__before_atomic()
Date:   Mon, 29 Apr 2019 22:15:00 +0200
Message-Id: <1556568902-12464-5-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic64_set() primitive.

Replace the barrier with an smp_mb().

Fixes: fdd4e15838e59 ("ceph: rework dcache readdir")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/super.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 16c03188578ea..b5c782e6d62f1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -541,7 +541,7 @@ static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
 					   long long release_count,
 					   long long ordered_count)
 {
-	smp_mb__before_atomic();
+	smp_mb();
 	atomic64_set(&ci->i_complete_seq[0], release_count);
 	atomic64_set(&ci->i_complete_seq[1], ordered_count);
 }
-- 
2.7.4

