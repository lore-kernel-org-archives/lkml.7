Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E59AC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641E520862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558503184;
	bh=aZpltjtpVGMxf4FvaPVhkzN6db1sSnJUGRlPiKfWfKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3rEaaVuwdEZG0nQQZz0iRWFRSOyuzFdNCXn2dguU4VGS4O5mH5XYRFY5BDammoHf
	 +JYmkBYkxmMOfPGDP+agdgbpczunPCn3HdIu1qYpT2DvyOpQYG5NWjne6d2aGp+aBc
	 +zezNp/Dzm8e0GDczZVJaKebcIycGgf7gDzaB9KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfEVFdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:33:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVFc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:32:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id n27so713420pgm.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtXiSOcyBaDWGDSyuTY7Nc/WWMgnDAllxXSDJE3RyjQ=;
        b=OTGcM1VddRP8GMQ42jCFs5P0b/VELcfY7MBf7hrfPA3ixHuqPhfaioGDLMNT4TwTlV
         2n7Gx949SPi6rKEFWKF8G5qc75gX2CDBrnJrnzBi9IQg7lU5vzXVhqETBKcwW2mBrZuo
         BenrlNhO3gfsSYN1aiZFxvY+9zbC0lfgaocu9K84JFZw+8dOoLDdlelt4cDl9jjNCXTg
         WoD1RsDqNMmoMDtnm4i8Hcp6jQC3fwQf8cGUwINnJtjl5Fse+4IKzKw8WPzUT1gjZ63p
         QSrCYg59rBXMVsuf8TLXTsKVh676BAn8lFPszsKHdRc35QM6LJFuhOjdpTrhNk2jxEa8
         EIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WtXiSOcyBaDWGDSyuTY7Nc/WWMgnDAllxXSDJE3RyjQ=;
        b=CJur2/jsSBI4Udb5fzaoY3uReD19YLjTnnaDjzmEtxxnd7X3XKPL1ACrDgE4X8JwQi
         9cGRpbh01iE5Jb5gk6f8YKsdad3CLwQMNzN+DtN3pi7jm1QA+jGAvVFSz3/VBBxEfRT/
         ynDL4N86o/4ex4+M0wjMI2vWIJj8zxg+TMILgk6NqvgLG20Pp8iP4tgJ6nu7rvPFbCd8
         GqFFcCCuOKtbTwkRua0KL4BpaA9BcLNW77XwXjAPLJAftx0VzlLnGwGWfQ20yHdbY4Bq
         YP9xVrgFtFafxoJK2VtYWE3Fs+hbm5ioy2LJa63R3uiBg5SBPwCMbHV9roxWczB51z9w
         4hBQ==
X-Gm-Message-State: APjAAAW0J2zfEIdj0gji1hP/msGb/kZ6fvtkZvPCzTce0tclWbYpVkf4
        LSwdpdJM7wEE5m6YbCpd4aQ=
X-Google-Smtp-Source: APXvYqwidwg0ft02y7EHjhylkaMGNeaRTFWMTocr/touSnMcV0EgynlQHPbqhSoYRUABrxmIy+EcDQ==
X-Received: by 2002:aa7:8243:: with SMTP id e3mr93764869pfn.213.1558503179139;
        Tue, 21 May 2019 22:32:59 -0700 (PDT)
Received: from namhyung.seo.corp.google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id p7sm25027927pgb.92.2019.05.21.22.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 22:32:58 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCH 1/3] perf tools: Protect reading thread's namespace
Date:   Wed, 22 May 2019 14:32:48 +0900
Message-Id: <20190522053250.207156-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190522053250.207156-1-namhyung@kernel.org>
References: <20190522053250.207156-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the current code lacks holding the namespace lock in
thread__namespaces().  Otherwise it can see inconsistent results.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/thread.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 403045a2bbea..b413ba5b9835 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -133,7 +133,7 @@ void thread__put(struct thread *thread)
 	}
 }
 
-struct namespaces *thread__namespaces(const struct thread *thread)
+static struct namespaces *__thread__namespaces(const struct thread *thread)
 {
 	if (list_empty(&thread->namespaces_list))
 		return NULL;
@@ -141,10 +141,21 @@ struct namespaces *thread__namespaces(const struct thread *thread)
 	return list_first_entry(&thread->namespaces_list, struct namespaces, list);
 }
 
+struct namespaces *thread__namespaces(const struct thread *thread)
+{
+	struct namespaces *ns;
+
+	down_read((struct rw_semaphore *)&thread->namespaces_lock);
+	ns = __thread__namespaces(thread);
+	up_read((struct rw_semaphore *)&thread->namespaces_lock);
+
+	return ns;
+}
+
 static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 				    struct namespaces_event *event)
 {
-	struct namespaces *new, *curr = thread__namespaces(thread);
+	struct namespaces *new, *curr = __thread__namespaces(thread);
 
 	new = namespaces__new(event);
 	if (!new)
-- 
2.21.0.1020.gf2820cf01a-goog

