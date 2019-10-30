Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C63DCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD912086A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jd1r6Jia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfJ3BhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:37:12 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53273 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfJ3BhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:37:11 -0400
Received: by mail-pl1-f202.google.com with SMTP id c16so562755plo.20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1GwmRjPs7u0T+r1yllJwr/PMM5pTo/W+dyBkrzs0XUw=;
        b=jd1r6Jia7s590891AgR3YYy9CElt7HWAUKHltf6wi81ngafwOYcF4N8Uwe/4zvW4MC
         IMk4k0LW1lf0/UGSclUObeuq/p3apoMtj4dOo8LZ3krCjiaET5tiZ+YTnO+UGNjAvSOU
         3uPmacYgwbx/u60ZQlS4vRPN7KP3sK5/3zhAaRK4S6ZiIGEaO386M6CIjj7hD/z+xln8
         HF2EafhhgD6PSHLKNb79leD5RoJeH0xD4HAkHOC0Jqf/o5pz89syAuvF2WHT8Rl719BR
         FB8AjMvuGbVf+5f9/Il7sZ4FoNHE4N3M8imjilODvpfBX+iUx1KthnL6nANbputXXdpz
         jDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1GwmRjPs7u0T+r1yllJwr/PMM5pTo/W+dyBkrzs0XUw=;
        b=BPzgmpFyCgC3A2qMRlYwJs8qkUEWDGkrxILmk7unLtwaUqK9LHyp12UcgDlgoycTzz
         lrLfEP6jLlflinwPRZCq2px73DLZi5YzmcFTSAYSd1m6VNFdYe1HxGTLelidLS1mTZX3
         d4adCxvAQUa6b3R4eMy+LCLw21agvUc9MzJVG0foXu16qGjsSFYvNbPPS65LIfV8hFT5
         z3+Sk+NqEQ/7oI2sVG7bDOkEKDzHrMc+XvgaQ0bl8fCjNG2j7wzA/xt28sTCj7kMLio3
         xCq046p7Gej/5E1dcAhnm0V5Jvv+DZ6YXaSuUSWOaCGwQG9/ino2q4mqHP8hJRvaZeiJ
         Aayw==
X-Gm-Message-State: APjAAAVMEhljHo9zLR7Rnb7NSFgYdABKMeti6cZBbNlH2i7WEVhLqhCC
        G7OgCcZdkufmGB/95ZPvTWpei4YXDjwJrytLkg==
X-Google-Smtp-Source: APXvYqy5iRRg5lqLW+5p9To2eAmeb2Xf7UHuM6BnVVpJsLYBnHW/AKwKhjiHnjRbKz471jGpAgMaW5gqHyyKSSazNQ==
X-Received: by 2002:a63:f48:: with SMTP id 8mr8383246pgp.329.1572399430538;
 Tue, 29 Oct 2019 18:37:10 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:36:55 -0700
In-Reply-To: <20191030013701.39647-1-almasrymina@google.com>
Message-Id: <20191030013701.39647-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v8 3/9] hugetlb_cgroup: add cgroup-v2 support
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 mm/hugetlb_cgroup.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 854117513979b..ac1500205faf7 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -503,8 +503,13 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	cft = &h->cgroup_files[HUGETLB_RES_NULL];
 	memset(cft, 0, sizeof(*cft));

-	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
-					  h->cgroup_files));
+	if (cgroup_subsys_on_dfl(hugetlb_cgrp_subsys)) {
+		WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
+					       h->cgroup_files));
+	} else {
+		WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
+						  h->cgroup_files));
+	}
 }

 void __init hugetlb_cgroup_file_init(void)
@@ -548,8 +553,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	return;
 }

+static struct cftype hugetlb_files[] = {
+	{} /* terminate */
+};
+
 struct cgroup_subsys hugetlb_cgrp_subsys = {
 	.css_alloc	= hugetlb_cgroup_css_alloc,
 	.css_offline	= hugetlb_cgroup_css_offline,
 	.css_free	= hugetlb_cgroup_css_free,
+	.dfl_cftypes = hugetlb_files,
+	.legacy_cftypes = hugetlb_files,
 };
--
2.24.0.rc1.363.gb1bccd3e3d-goog
