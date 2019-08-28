Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF448C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC39922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfH1Nd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:33:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34168 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1Nd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:33:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id s18so2560135wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/iwyChIHaytlF3nBMrrV8GH07zAorOvTXTDzjkWMC4=;
        b=mhLHONtENkVUYEfUmrEnjk8JxVjeeql6Q3rk8lvSJI42jqOuwHk6HVWtVUrR1oPYPy
         0Lv5/g/tNMVPshdsnGZyjQZscUuFco1h+DQMCXGoxKrmXka9LxhWFwD4N0FrKGOVrhsp
         EAXqUVMs1e7LZeyc4U8xNGkTybqM+4M92IbWLVuW4q4ZFrEuMJbEtKOz3ZNgfEIO230u
         pEcAKnzNimPCrV5y/iSbULy2VYCLKhLwHpyyP5hx1iaEQlvXxsQ53xpOyisfdYBSornw
         gMJJ+jS/EiTD5dINcJZTx4ZaXb8cYRTNuQi+tfM06TjJ8x+qjL0HyLawPzg/Kk6C+0OB
         chOg==
X-Gm-Message-State: APjAAAWUijSxB5cv/56HYoN5hJ+HySjJb74VracMoN5l1TK/ezUQAE7N
        rsZaAGv3ffHcwk+x80s+3Cs7G54I1Gc=
X-Google-Smtp-Source: APXvYqz6NHrdtNukj5LtnpopGp/HDaj6j8Jqnf4sC0lzsqXu3EnDKYIjf7AtZ9r8d2aX1xdF1JdtcQ==
X-Received: by 2002:adf:facc:: with SMTP id a12mr4728967wrs.205.1566999205347;
        Wed, 28 Aug 2019 06:33:25 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id l62sm4848942wml.13.2019.08.28.06.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:33:24 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: check for nested unlikely calls
Date:   Wed, 28 Aug 2019 16:32:56 +0300
Message-Id: <20190828133256.13630-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827165515.21668-1-efremov@linux.com>
References: <20190827165515.21668-1-efremov@linux.com>
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
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..55b90e1334d2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6480,6 +6480,12 @@ sub process {
 			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
 		}
 
+# nested likely/unlikely calls
+		if ($line =~ /\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)/) {
+			WARN("LIKELY_MISUSE",
+			     "nested (un)?likely calls, unlikely already used in $1 internally\n" . $herecurr);
+		}
+
 # whine mightly about in_atomic
 		if ($line =~ /\bin_atomic\s*\(/) {
 			if ($realfile =~ m@^drivers/@) {
-- 
2.21.0

