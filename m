Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE2F21928
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+KQK1yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfJXU3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:29:16 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56768 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfJXU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:29:14 -0400
Received: by mail-qt1-f201.google.com with SMTP id j18so18763875qtp.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OTTgP/4rSMZq1YQryUiCckFA0Or1XPmBCQJjGhG/4Xo=;
        b=k+KQK1yVgr8ftCY21WnHwRy8s7u2DAecuwJppewUUySA6SAvk6D0TqMKRNnRAQIxAe
         koa/CpSG/tMqlcpF0TwQT3hvEfx3jFSpMcNrp8mXRKclZVYizJldrdCOqmRKc5wHnIMY
         WDceg4mifhX2pxAPYV++HQnr/zH4VGfVOaZQNy/dvkawRHLD4jRCpG5aIwT5NBxX5D7F
         SCJxRdQwJdpTwP0ZJUUedSNcOAMRAsRTUO9yko1ejSRBbrwa5zZteMMvixSReRioOhPB
         1B70iyeoARY9KcnjukFGO5frbxtkbCJo0W/vyGeQNZSatoWWipT8f1b6/BTh9PQkxnlF
         LeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OTTgP/4rSMZq1YQryUiCckFA0Or1XPmBCQJjGhG/4Xo=;
        b=n3PHRtosfqBot3eflwelunDvxOHUBN1PGnQWeXNkGfMxehnoBydIpJLw8aiCLJ9n2s
         duX/vww1mPeaiggz1qjo6Sk9OKwnuGvaZl/2t2rR+Ho6xdZtXX71W9U+NzfsKLk1mN8k
         F4nY1FXv3s/d8e+cxILIkz1MfWbjBWbaIVagJZ6c9BCjWCXGAlMsPG0k71Fl2n163RaA
         HU/CEjjtM764YUYCM40zgvE8JvLyInSqm64JplXw9rk3F43TJdr73V8P49BU9eFRnUDP
         h/fNIK/1GS6JoR023rZ7FhOtc/Tq9AyoIIIyU1VFnVOsPvjP4ENkTojX7QwDjfiohQUD
         7sLA==
X-Gm-Message-State: APjAAAXvoysHII6gH1d8t8aVKIrLe9ZURVeOSNT+PVzolBW+3GY2FBXK
        R19wANloyV5899rik8NQVUCB8krSrtBMHQ+hJA==
X-Google-Smtp-Source: APXvYqykmweDy/QLQPkGWizAYNIBL+BlX3Ygpu2mWSwRIj83jVjwajIZ8NVAcpVzBNG7dhIbfZW7dElSf1O2aNJ7vA==
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr4095977qvx.83.1571948953537;
 Thu, 24 Oct 2019 13:29:13 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:52 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 3/9] hugetlb_cgroup: add cgroup-v2 support
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.24.0.rc0.303.g954a862665-goog
