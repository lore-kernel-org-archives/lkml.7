Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF94C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453C92087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M0OtEsjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfCNVtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:49:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35435 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfCNVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:49:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id z13so4340282qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4IczZcemQJBUyUO4U++jGJlzY5GklZ2NZ3zCflWwn8=;
        b=M0OtEsjLT3o1G8Q3cafkdUpSCoPUJkTZfiitOqIY/qB0DzM1YqY3uqhLBbfA9+V0Oa
         EN/oUeiAwOzo95ZkqAk9F9sAPhvGCeZSf2mLcS/e3Ycm7ncrL5R/vin/2ADy6Dd53hCM
         xxmbtuIFYjnvYBEdGJrtGL6CVVbx1a/UH0lXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4IczZcemQJBUyUO4U++jGJlzY5GklZ2NZ3zCflWwn8=;
        b=GDvYo13C06SX4GrwoJw7CBLHfbxiLvG0ggPxXR9bOnjSitaisLKl1CadiJYcU4gdWk
         7P7VUO4CI+4uRriqmtYDVV2zpat2rxqX0uQpn0S5l8iCbYN7HBBAdvAaOJT362VVoWQT
         eT6NqrsdLW9d1f8dF8uwd+N6z/HU+U3PNxzkGY+zEUvlKF6nM6PKL7EQB9XGZ4Jv0sEL
         P6DVyIWA3BsuW+C2SZ1mumCEQVW7LhjbezhzzR/YGGExdxYvUJGumJkc/DYxDWQdeO88
         5mFQiBi9oEK9nXgdo8OAjsEOKOQZubhznv52NT2+i/TxM4t6ClryyBIMhSOOQCKrOPex
         Q3aQ==
X-Gm-Message-State: APjAAAX+FHvvahjAoGLqy6uabHxx/woaGfZQJjgveYTtSm9FAmVcT+EM
        SaaE7Yg63RFuqv8r5mZ+PG34Ai1lwLc=
X-Google-Smtp-Source: APXvYqxzcuUnWSzeDwWPdHSSmi1kpNflcGQvZsrcJZqSXfwdL86aFq6BWRW0Kgb3udVE8q2hNgpkyQ==
X-Received: by 2002:ae9:f101:: with SMTP id k1mr387571qkg.111.1552600139578;
        Thu, 14 Mar 2019 14:48:59 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id o19sm96827qkl.65.2019.03.14.14.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:48:58 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, mtk.manpages@gmail.com
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, dancol@google.com,
        Jann Horn <jannh@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -manpage 2/2] memfd_create.2: Update manpage with new memfd F_SEAL_FUTURE_WRITE seal
Date:   Thu, 14 Mar 2019 17:48:44 -0400
Message-Id: <20190314214844.207430-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190314214844.207430-1-joel@joelfernandes.org>
References: <20190314214844.207430-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More details of the seal can be found in the LKML patch:
https://lore.kernel.org/lkml/20181120052137.74317-1-joel@joelfernandes.org/T/#t

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 man2/memfd_create.2 | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/man2/memfd_create.2 b/man2/memfd_create.2
index 15b1362f5525..3b7f032407ed 100644
--- a/man2/memfd_create.2
+++ b/man2/memfd_create.2
@@ -280,7 +280,15 @@ in order to restrict further modifications on the file.
 (If placing the seal
 .BR F_SEAL_WRITE ,
 then it will be necessary to first unmap the shared writable mapping
-created in the previous step.)
+created in the previous step. Otherwise, behavior similar to
+.BR F_SEAL_WRITE
+can be achieved, by using
+.BR F_SEAL_FUTURE_WRITE
+which will prevent future writes via
+.BR mmap (2)
+and
+.BR write (2)
+from succeeding, while keeping existing shared writable mappings).
 .IP 4.
 A second process obtains a file descriptor for the
 .BR tmpfs (5)
@@ -425,6 +433,7 @@ main(int argc, char *argv[])
         fprintf(stderr, "\et\etg \- F_SEAL_GROW\en");
         fprintf(stderr, "\et\ets \- F_SEAL_SHRINK\en");
         fprintf(stderr, "\et\etw \- F_SEAL_WRITE\en");
+        fprintf(stderr, "\et\etW \- F_SEAL_FUTURE_WRITE\en");
         fprintf(stderr, "\et\etS \- F_SEAL_SEAL\en");
         exit(EXIT_FAILURE);
     }
@@ -463,6 +472,8 @@ main(int argc, char *argv[])
             seals |= F_SEAL_SHRINK;
         if (strchr(seals_arg, \(aqw\(aq) != NULL)
             seals |= F_SEAL_WRITE;
+        if (strchr(seals_arg, \(aqW\(aq) != NULL)
+            seals |= F_SEAL_FUTURE_WRITE;
         if (strchr(seals_arg, \(aqS\(aq) != NULL)
             seals |= F_SEAL_SEAL;
 
@@ -518,6 +529,8 @@ main(int argc, char *argv[])
         printf(" GROW");
     if (seals & F_SEAL_WRITE)
         printf(" WRITE");
+    if (seals & F_SEAL_FUTURE_WRITE)
+        printf(" FUTURE_WRITE");
     if (seals & F_SEAL_SHRINK)
         printf(" SHRINK");
     printf("\en");
-- 
2.21.0.360.g471c308f928-goog

