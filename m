Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D8EC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E06420856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558324418;
	bh=Yz0Aeiw37vema5jJjkdVNLbZ9t3CHLf6Ybmrg9HRaa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JqydDBez2vipDhCUsQdPcmUYtwmBs84/dlVIRyueM1QfKjvP1bLZafbPNrrdw1r29
	 5Y7wbv3mtA28oMpo2ufbxdCPbqhVt8CStzGCulH8Q6Gvix9N/3yO+AxwPbxrg+dfwG
	 tHJwqwET5gJWqumBYxTYpatdH55ZmVcFKIamD2N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbfETDxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:53:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38607 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfETDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:53:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so6034824plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 20:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eom6C+0aXRglfnsINAswRs1OeG+39R7hMy87CNGrDQ=;
        b=XG5I+EPz86QA3OhsQLafnFpAan9eaChflXFWy43qaxMLemrkVaXoKjqy7PxZqkUxkP
         O0Pi6kyy6arJRnGcyGSp5wdYWbuXmnvmMU9TLW9lQqedL13pwu5ot2YxbHHnH5JDECz2
         5s7ZSy68dQ3tlt3cl5NMx33/pwti9RfeGoJWKiUEMCQZqpnPep50Djr8xxL6STY36Ujw
         beVq6BNhkOiPzbrCyDh5fI53flkYcWi5NjAVWwKl/1j+lPu5r1E1UxZcQv/nYdEAVufF
         I5AElncQaFNYUw4EOAGcoZbjZ6MvPKbdF3qRi76J+cqbdAOTOvWbZZqXTrDpaKJYoBkJ
         Nunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6eom6C+0aXRglfnsINAswRs1OeG+39R7hMy87CNGrDQ=;
        b=f6yTiEemTxMgPMJqqiwSxFVsSgLPr6I/hnCgzH/+NMfASfJMVl+c7A9LMkiXf14FdZ
         aotz3MLG2+EZrTwk6O8oKwVH6wWd1Gw2BZeICV7XF2RqdifMYwBOR5UDCI3dQ5LLNbia
         v85fKVV6ujCI7XgReFK4Ykbe3svFwV6/v5JU8IlyhER/n0PZferORnotuNXbywX7aXNF
         QmIG03hYnpKs3F2/33Y2focz0g/w5cfIZpSnKLWbnZJC2X1Tp+k1lS9fS5YV+hdQJCO6
         brIbjhXueo5xNodgFrLiE9SP5pvmgdBR09IhLWNIAHkZ3y2XFr1HcY+tXpoTP3ytijwr
         MSuw==
X-Gm-Message-State: APjAAAU9p7MIlnj+AGXTCheliqSM5kcxo3BMGXN6ZS6/lTne6hIj4kmU
        tDUAyZ7cjlH0zwHrenv74Ck=
X-Google-Smtp-Source: APXvYqzawjhmQskMTjHPygEFAgYiL4Q/o65j0xjkMqI2OU3MhBsEo2mDN7heff7G2XFlEjOFBY9bKg==
X-Received: by 2002:a17:902:bc42:: with SMTP id t2mr21860026plz.55.1558324415659;
        Sun, 19 May 2019 20:53:35 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x66sm3312779pfx.139.2019.05.19.20.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 20:53:34 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER
Date:   Mon, 20 May 2019 12:52:54 +0900
Message-Id: <20190520035254.57579-8-minchan@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520035254.57579-1-minchan@kernel.org>
References: <20190520035254.57579-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System could have much faster swap device like zRAM. In that case, swapping
is extremely cheaper than file-IO on the low-end storage.
In this configuration, userspace could handle different strategy for each
kinds of vma. IOW, they want to reclaim anonymous pages by MADV_COLD
while it keeps file-backed pages in inactive LRU by MADV_COOL because
file IO is more expensive in this case so want to keep them in memory
until memory pressure happens.

To support such strategy easier, this patch introduces
MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER options in madvise(2) like
that /proc/<pid>/clear_refs already has supported same filters.
They are filters could be Ored with other existing hints using top two bits
of (int behavior).

Once either of them is set, the hint could affect only the interested vma
either anonymous or file-backed.

With that, user could call a process_madvise syscall simply with a entire
range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
MADV_FILE_FILTER so there is no need to call the syscall range by range.

* from v1r2
  * use consistent check with clear_refs to identify anon/file vma - surenb

* from v1r1
  * use naming "filter" for new madvise option - dancol

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/uapi/asm-generic/mman-common.h |  5 +++++
 mm/madvise.c                           | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index b8e230de84a6..be59a1b90284 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -66,6 +66,11 @@
 #define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
 #define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
 
+#define MADV_BEHAVIOR_MASK (~(MADV_ANONYMOUS_FILTER|MADV_FILE_FILTER))
+
+#define MADV_ANONYMOUS_FILTER	(1<<31)	/* works for only anonymous vma */
+#define MADV_FILE_FILTER	(1<<30)	/* works for only file-backed vma */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index f4f569dac2bd..116131243540 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1002,7 +1002,15 @@ static int madvise_core(struct task_struct *tsk, unsigned long start,
 	int write;
 	size_t len;
 	struct blk_plug plug;
+	bool anon_only, file_only;
 
+	anon_only = behavior & MADV_ANONYMOUS_FILTER;
+	file_only = behavior & MADV_FILE_FILTER;
+
+	if (anon_only && file_only)
+		return error;
+
+	behavior = behavior & MADV_BEHAVIOR_MASK;
 	if (!madvise_behavior_valid(behavior))
 		return error;
 
@@ -1067,12 +1075,18 @@ static int madvise_core(struct task_struct *tsk, unsigned long start,
 		if (end < tmp)
 			tmp = end;
 
+		if (anon_only && vma->vm_file)
+			goto next;
+		if (file_only && !vma->vm_file)
+			goto next;
+
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
 		error = madvise_vma(tsk, vma, &prev, start, tmp,
 					behavior, &pages);
 		if (error)
 			goto out;
 		*nr_pages += pages;
+next:
 		start = tmp;
 		if (prev && start < prev->vm_end)
 			start = prev->vm_end;
-- 
2.21.0.1020.gf2820cf01a-goog

