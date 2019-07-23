Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED66CC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24C621911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL/ErOlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfGWDYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:24:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40343 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfGWDYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:24:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so18656066pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TpVTXaHLn7m7J0FQHFzM1Fub0sOMg6NTyD2nDH4uCLg=;
        b=qL/ErOlYdmf5RkJ3WXd7bccdT0QuGccfi+7pdGY8Nifogb00zuak2ZPK0Psluqnmy5
         D+/Ad2RUBO3tJe9fFRzOajN/NVL/f88099Agcg/1Sy+Vy2rV7PsVbm+kbaLHlmXhCuqA
         X6YAXKdJfM793tkYxO/CjjvD+PGJi/K7XfXcrwMIIQM2NhbMGlKYodOyiGY1EQdrsYph
         vWt+i5p3bdcQBGbmDk2Ypx+z3xvtiM3vA0e3bAs+LpT4Q9KDHdpgmz5UsC0s3GbYC+cv
         dV5chPpYaA8E6/msIiJEIkCp7TJbtxLFfR3TlQdSic1t1pApGaqmjK54FwNIMZo7Fasb
         j3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TpVTXaHLn7m7J0FQHFzM1Fub0sOMg6NTyD2nDH4uCLg=;
        b=FrJJ+uwYFTshJccLx8tHI8gkebVKVVR9+AfSPj6SwobbkukUxuWg33DkMNQIyW+IsA
         sNEEuTEhTcfhq8GKe/bn0iFB7QQxW0Qpk+WCsES2jR9gll+mzgOt8s0tZzUYhSD7icda
         y5Q20ombOvU+fN1JJK+Py0KZdcK8ypYfiBsf0wgGFoTi83JNlkV/T+qPq//OHmuWNuEO
         4Dau3Ta+EsQn2mwT05VTZhSY3XdZ9mA2wR8EksBODHKZiQmIfICpnh/u/t7OuvAZg9mD
         iXmAX+nS7JdW8V0v26cdKc+TpF+YXUYd2r34gmzweheZ5R1dydpRqG1CbgQMpIFIhmgL
         udtw==
X-Gm-Message-State: APjAAAUaUoTgaIc02yKqOzB3S272/sMd7ZHPl1WnpvoTI2lAHcxd2iQj
        2lAJGXBq7b4FOLT68XYwEGU=
X-Google-Smtp-Source: APXvYqw5ISr/O5JpdkiLH7gQoGCP2769YpRjBxWlAQnkIZuCzTZw/wpvFMktIX3btpbv/cctqJJpAA==
X-Received: by 2002:a17:90a:9301:: with SMTP id p1mr80066278pjo.22.1563852292248;
        Mon, 22 Jul 2019 20:24:52 -0700 (PDT)
Received: from masabert (150-66-88-81m5.mineo.jp. [150.66.88.81])
        by smtp.gmail.com with ESMTPSA id p68sm51664527pfb.80.2019.07.22.20.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:24:51 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 2121E201372; Tue, 23 Jul 2019 12:24:47 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ktest: Fix some typos in config-bisect.pl
Date:   Tue, 23 Jul 2019 12:24:45 +0900
Message-Id: <20190723032445.14220-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.22.0.545.g9c9b961d7eb1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos in config-bisect.pl

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/testing/ktest/config-bisect.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/config-bisect.pl b/tools/testing/ktest/config-bisect.pl
index 72525426654b..6fd864935319 100755
--- a/tools/testing/ktest/config-bisect.pl
+++ b/tools/testing/ktest/config-bisect.pl
@@ -663,7 +663,7 @@ while ($#ARGV >= 0) {
     }
 
     else {
-	die "Unknow option $opt\n";
+	die "Unknown option $opt\n";
     }
 }
 
@@ -732,7 +732,7 @@ if ($start) {
 	}
     }
     run_command "cp $good_start $good" or die "failed to copy to $good\n";
-    run_command "cp $bad_start $bad" or die "faield to copy to $bad\n";
+    run_command "cp $bad_start $bad" or die "failed to copy to $bad\n";
 } else {
     if ( ! -f $good ) {
 	die "Can not find file $good\n";
-- 
2.22.0.545.g9c9b961d7eb1

