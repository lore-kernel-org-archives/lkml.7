Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81BCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30FB217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJHYnIJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfHHHSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:18:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39185 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:18:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so43563260pgi.6;
        Thu, 08 Aug 2019 00:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zFoSskzKCZlza0GblOaMNM1s/A9U+UElWzjCW1f3zM=;
        b=oJHYnIJo3jEzpDKrzYDhX1SzasWKocag1r5XRvIt88IMD9VZxELPtyWRZbPrxJbMsr
         cKnNgsMc6MtGX68Me2qsU1DUZPFPnBM5WnPhgQLoMkIfbJlCqWcx1FcVZIWbZg03gXJI
         epDDEBbZLL4rWkLp3dE6HEeytQu12R1V78WnshG96d61iLI6aUOQLdxYrj7syVia/0t0
         8j7x2yRT6xUXeFn47tCFFcf6cDihBHcLpgj/JRPNWWadH4h6W1qsqmNYZ3u1/gpHCLJB
         /F2+JJdA8nQLwYptc8rkmu08739CqCuxpH7aUINSUZsbrtVELL+jjorB+q+VZJjjoH4r
         khdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1zFoSskzKCZlza0GblOaMNM1s/A9U+UElWzjCW1f3zM=;
        b=fMqZiS1LUsn0zJWfQytJip+Sr8wl7RtleodOB2JUb8Dx7gsbexEa5jJv1mg8E4wZqU
         FV9JY/qdyLXBEz5b0F3kBezp+4l0VaDdJcGq3HYw1l7WD7k2txk96/+g4lm600y7esaQ
         /AB+PBLyvMg92psAjLL0oQuH3U1LdnUZUoecZn3Wy5uYEO0Xzu11fRzZMCKPKjFgy4kD
         yUFrZhRgxDi7+UniJrcyRDd7T6RmNMaov/5YXWlGpYZRTKfX+8LJf5Ct84CNff/FLUC2
         1kb5UP6TqjC/xBwFo7BbZvqnbUfSKieFQ4VpR9OswkU7zcOuCVK7JSA/k5VmZ7LLl1gl
         u9Kg==
X-Gm-Message-State: APjAAAV3MERy+Y3UHEV/RCvi0f4DCIZ9bx3A3GG4GUnNliZoL3nPjP9D
        e3WVvU/frDuyY9JonyOez51UBCPspXojOQ==
X-Google-Smtp-Source: APXvYqxspEyMhp6Wqic4ECgzonGUU/A8WSGQNX2aRqJR6x+ORW1V8Yy4MmE67cC0eXKr+SZTN3JQ6w==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr2520806pjb.51.1565248702541;
        Thu, 08 Aug 2019 00:18:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id s20sm105514644pfe.169.2019.08.08.00.18.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:18:21 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/2] s390/extmem: Use refcount_t for refcount
Date:   Thu,  8 Aug 2019 15:18:17 +0800
Message-Id: <20190808071817.6595-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/s390/mm/extmem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 0b5622714c12..78e801287c72 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/ctype.h>
 #include <linux/ioport.h>
+#include <linux/refcount.h>
 #include <asm/diag.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -64,7 +65,7 @@ struct dcss_segment {
 	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	int do_nonshared;
 	unsigned int vm_segtype;
 	struct qrange range[6];
@@ -362,7 +363,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 	seg->start_addr = start_addr;
 	seg->end = end_addr;
 	seg->do_nonshared = do_nonshared;
-	atomic_set(&seg->ref_count, 1);
+	refcount_set(&seg->ref_count, 1);
 	list_add(&seg->list, &dcss_list);
 	*addr = seg->start_addr;
 	*end  = seg->end;
@@ -422,7 +423,7 @@ segment_load (char *name, int do_nonshared, unsigned long *addr,
 		rc = __segment_load (name, do_nonshared, addr, end);
 	else {
 		if (do_nonshared == seg->do_nonshared) {
-			atomic_inc(&seg->ref_count);
+			refcount_inc(&seg->ref_count);
 			*addr = seg->start_addr;
 			*end  = seg->end;
 			rc    = seg->vm_segtype;
@@ -468,7 +469,7 @@ segment_modify_shared (char *name, int do_nonshared)
 		rc = 0;
 		goto out_unlock;
 	}
-	if (atomic_read (&seg->ref_count) != 1) {
+	if (refcount_read(&seg->ref_count) != 1) {
 		pr_warn("DCSS %s is in use and cannot be reloaded\n", name);
 		rc = -EAGAIN;
 		goto out_unlock;
@@ -544,7 +545,7 @@ segment_unload(char *name)
 		pr_err("Unloading unknown DCSS %s failed\n", name);
 		goto out_unlock;
 	}
-	if (atomic_dec_return(&seg->ref_count) != 0)
+	if (!refcount_dec_and_test(&seg->ref_count))
 		goto out_unlock;
 	release_resource(seg->res);
 	kfree(seg->res);
-- 
2.20.1

