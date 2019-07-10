Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D856C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E19208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGJXT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:19:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGJXT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:19:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so4150422wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 16:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pfkm16ESPrwdyy5eXbeiSaul1UHucvhtw70mTCVOEgk=;
        b=kVImacjCrtS1G9sF5N/BeWyb7M30NxM4UaMg4cWMQWXr+jnbbLPt5b1ehm8Bwf6K/W
         3YSG8tVOUUKglr6ALJOOKS+vyOO4XlC1ZmfRimXCB4cRCcgwjNMUAJJEZwFnGEBu47rS
         qwXEsVoEV7pjWlRqj3Fe0LdsgmiThZ+W38Oi80dZg9Nb4b3DKuGiO9nL0VTC8/+1jUiQ
         qVJLDDWwSi0Vou7giHH2XlOvdL8OYPRGwt/FG3YWrCXzD1fOqjAmDGULw+ngDAIJWsaN
         JIVGWEGLmjorN4zpRPnMHRnl25r/Y0rNBk9F/0ly///Q1y0ugTPKagtPHBxgw2+wK/ap
         xKQQ==
X-Gm-Message-State: APjAAAVPQi0+9CHAUsKBwM7ndr12Bgy9ipZJ9uGGzoHT4vo/gL/W1nPD
        0+md2xe+NeBG3Tx7d53VkRDNLZepJvs=
X-Google-Smtp-Source: APXvYqxD3s5EnapYwXSTuWQDfaOYQ0xzit9ZEAxj2NwGYPmKlhSHBkBQEkrwpJUkUh/OLbBuXa7OFg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr146662wrm.235.1562800765131;
        Wed, 10 Jul 2019 16:19:25 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-105-184.cust.vodafonedsl.it. [47.53.105.184])
        by smtp.gmail.com with ESMTPSA id c9sm2586667wml.41.2019.07.10.16.19.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 16:19:24 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch.pl: warn on invalid commit hash
Date:   Thu, 11 Jul 2019 01:19:19 +0200
Message-Id: <20190710231919.9631-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can happen that a commit message refers to an invalid hash, because
the referenced hash changed following a rebase, or simply by mistake.
Add a check in checkpatch.pl which checks that an hash referenced by a Fixes
tag or just cited in the commit message is a valid commit hash.

    $ scripts/checkpatch.pl <<'EOF'
    Subject: [PATCH] test commit

    Sample test commit to test checkpatch.pl
    Commit 1da177e4c3f4 ("Linux-2.6.12-rc2") really exists,
    commit 0bba044c4ce7 ("tree") is valid but not a commit,
    while commit b4cc0b1c0cca ("unknown") is invalid.

    Fixes: f0cacc14cade ("unknown")
    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
    EOF
    WARNING: Invalid hash 0bba044c4ce7
    WARNING: Invalid hash b4cc0b1c0cca
    WARNING: Invalid hash f0cacc14cade
    total: 0 errors, 3 warnings, 4 lines checked

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a6d436809bf5..6fe15fbe876f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2898,6 +2898,13 @@ sub process {
 			}
 		}
 
+# check for invalid hashes
+		if ($in_commit_log && $line =~ /(^fixes:|commit)\s+([0-9a-f]{6,40})\b/i) {
+			if (`git cat-file -t $2 2>/dev/null` ne "commit\n") {
+				WARN('INVALID_COMMIT_HASH', "Invalid commit hash $2");
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
2.21.0

