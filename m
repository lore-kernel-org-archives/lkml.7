Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932EEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738B121881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfH0QzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:55:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43661 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfH0QzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:55:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so19516778wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nJ6Yhnmx0Z0m7upWdz8dDf2ghGkiqwiluwv7s0RuRzw=;
        b=r/1/FW9K/xvuA1EMuhXiOewETkY57LpLS0iNzP2MBWFvZaZGgakmL3A0ibspVZjUfj
         lCqhLhprFwz9oPl5SQrIH5jTABPpvu08gW32+JOnjOfN+yWz0Sr02qjSjrgMfDjsl2Kt
         YXLCqSjTmy1E9gwIyqStd+/NdVIbnWtBBZ2F6z2HLhvEhV+KFy3DL9cdbhyMSQiZvqww
         CGd2A03GLxXqEWnzeHhkaCeyIT6TLTX35LUy129/cmnoYJe6YSCzKsBw66gt/KAdwBf+
         kNBQySxpywFBr9HY6o4uaEal2gXF+Oq252cmS5PiFt9w0YtDYoweQm3guGFTiI8sUlLE
         yZUQ==
X-Gm-Message-State: APjAAAXwM8MmhYSdK5QcLHq8I5MZVPONwRXTLhY96biUv2GQ+nbDUw7K
        T50lvqg3/S/mmNro+IJQhTA=
X-Google-Smtp-Source: APXvYqzmGy6ajJC6nrDUd+QNoqJqocuS2o207FH1VdgkNulgd++bQf8a5fXl9c/wEjWvyq21q9XK7A==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr31711139wrx.17.1566924922812;
        Tue, 27 Aug 2019 09:55:22 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id n14sm54925295wra.75.2019.08.27.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:55:22 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: check for nested (un)?likely calls
Date:   Tue, 27 Aug 2019 19:55:15 +0300
Message-Id: <20190827165515.21668-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ERR, IS_ERR_OR_NULL, IS_ERR_VALUE already contain unlikely optimization
internally. Thus, there is no point in calling these functions under
likely/unlikely.

This check is based on the coccinelle rule developed by Enrico Weigelt
https://lore.kernel.org/lkml/1559767582-11081-1-git-send-email-info@metux.net/

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..81dace5ceea5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6480,6 +6480,13 @@ sub process {
 			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
 		}
 
+# nested likely/unlikely calls
+		if ($perl_version_ok &&
+		    $line =~ /\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)\s*${balanced_parens}\s*\)/) {
+			WARN("LIKELY_MISUSE",
+			     "nested (un)?likely calls, unlikely already used in $1 internally\n" . $herecurr);
+		}
+
 # whine mightly about in_atomic
 		if ($line =~ /\bin_atomic\s*\(/) {
 			if ($realfile =~ m@^drivers/@) {
-- 
2.21.0

