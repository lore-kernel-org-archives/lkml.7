Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183D8C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10E821743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HH1g71BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfD3Vra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:47:30 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:36410 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3Vr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:47:29 -0400
Received: by mail-ua1-f73.google.com with SMTP id u7so1329440uae.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f5tP4i9oo8ss2ldojh86/XKSddC2xJw6xj+Nunlyeqc=;
        b=HH1g71BDh0kd5On6O+cgQEFGbxHeePhHvZv+uUiQh904NfitGz2iyJidBX2oomrgYh
         Zn6BKmWc5/aX0jsauNQMpRzitKmF0UbktdM0c1zlLj1gJFYOn8X231TuoiC97SgYkQi/
         Dh0CLjxYzHFcFWgxS+e8MHyIZIzs/9JMJU0rWba4MUfPP8jRb3i0g9fe0NadEP2fzunT
         Zz9wKSEgora0dnDDqabTYlSbDAi2oIa9TGj6HB/8dIWGQBa1Gf9HXirfdPMOGuJLPHRk
         pnUHNOZI3PmUEEwcI0etxqMSXk0wBGsRTpiY7qGHejXP90JodfiH4513pKL8aICiWJuk
         uSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f5tP4i9oo8ss2ldojh86/XKSddC2xJw6xj+Nunlyeqc=;
        b=hfs2qiTPS8ifRwWwKa8gwyFbHTY93yFzvq0mo1m8JjCjg7+ydxb9zNO4gwe4ezkAiF
         62wbXy+/B7y5zul19/xkaGoWjNhH3g3hQgxV5KhCmc10ENxukEM1xijvj9uX+GbKaR0M
         tdf8k3l5lPuUB2j3jbgnxjoWvjyL+LHakYYdEatXSxTn9UV/xEjZdhtmjCyROJaaCLRi
         5lPq4dOBTmo9TCuF22Rm6NfdkcV+Cs2GQ4e+X3jSaMjL5Ipw1vyOiPKczmheKDz+1C8E
         58OFwBvkbx5GGWqA9p1SHjAl4Kwy2QeiMnXS2kuMY89ae6Nhrf0+sCf/zeFHqDXAS7Ih
         6RKA==
X-Gm-Message-State: APjAAAVksWO7dAmrOwPj3V248CIQljn4hRlHiZBNM6+ul4C/OL7Lnvjg
        msX8NJvKolOsFcSTMeVX24KE57T6ZFTWTO5OMRE=
X-Google-Smtp-Source: APXvYqxcE2wG3pImcrXpXqIXxtFPTmq690IFhm0p2DArgi2jwzSLTlMzp6g2awj0Ibx6ZE4IberuF7eONksJhkocJZ0=
X-Received: by 2002:a67:ad03:: with SMTP id t3mr6155852vsl.159.1556660848948;
 Tue, 30 Apr 2019 14:47:28 -0700 (PDT)
Date:   Tue, 30 Apr 2019 14:47:24 -0700
Message-Id: <20190430214724.66699-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH] mm: fix filler_t callback type mismatch with readpage
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casting mapping->a_ops->readpage to filler_t causes an indirect call
type mismatch with Control-Flow Integrity checking. This change fixes
the mismatch in read_cache_page_gfp and read_mapping_page by adding a
stub callback function with the correct type.

As the kernel only has a couple of instances of read_cache_page(s)
being called with a callback function that doesn't accept struct file*
as the first parameter, Android kernels have previously fixed this by
changing filler_t to int (*filler_t)(struct file *, struct page *):

  https://android-review.googlesource.com/c/kernel/common/+/671260

While this approach did fix most of the issues, the few remaining
cases where unrelated private data are passed to the callback become
rather awkward. Keeping filler_t unchanged and using a stub function
for readpage instead solves this problem.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/pagemap.h | 22 +++++++++++++++++++---
 mm/filemap.c            |  7 +++++--
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf909d0de5f8..e5652a5ba1584 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -383,11 +383,27 @@ extern struct page * read_cache_page_gfp(struct address_space *mapping,
 extern int read_cache_pages(struct address_space *mapping,
 		struct list_head *pages, filler_t *filler, void *data);
 
+struct file_filler_data {
+	int (*filler)(struct file *, struct page *);
+	struct file *filp;
+};
+
+static inline int __file_filler(void *data, struct page *page)
+{
+	struct file_filler_data *ffd = (struct file_filler_data *)data;
+
+	return ffd->filler(ffd->filp, page);
+}
+
 static inline struct page *read_mapping_page(struct address_space *mapping,
-				pgoff_t index, void *data)
+				pgoff_t index, struct file *filp)
 {
-	filler_t *filler = (filler_t *)mapping->a_ops->readpage;
-	return read_cache_page(mapping, index, filler, data);
+	struct file_filler_data data = {
+		.filler = mapping->a_ops->readpage,
+		.filp   = filp
+	};
+
+	return read_cache_page(mapping, index, __file_filler, &data);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index d78f577baef2a..6cc41c25ca3bf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2977,9 +2977,12 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index,
 				gfp_t gfp)
 {
-	filler_t *filler = (filler_t *)mapping->a_ops->readpage;
+	struct file_filler_data data = {
+		.filler = mapping->a_ops->readpage,
+		.filp	= NULL
+	};
 
-	return do_read_cache_page(mapping, index, filler, NULL, gfp);
+	return do_read_cache_page(mapping, index, __file_filler, &data, gfp);
 }
 EXPORT_SYMBOL(read_cache_page_gfp);
 
-- 
2.21.0.593.g511ec345e18-goog

