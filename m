Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA24C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57ED2054F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLhhUeCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfEHM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:27:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40746 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfEHM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:27:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so7700898wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsFu/Mm6Udal+8o4/TOk1rUCznPeeCBmK6DAhapLdzw=;
        b=MLhhUeCSVNu68m0NzceQB4PRNKhghF221rjGgfftcCufUwDZ7+sOCcwB+elcxHhui/
         Ve10CoV4GZxpn1gTDLuVAxYOp90IIBTpr0solK4Qsk5zsmxRevhON+CzyHkWRlj701md
         Qq2d5kJz/Ik3pn8Si9mvcg2jNyKMAmomjn9Djy5cpTWJtNF7R9TTctQ5NWcUJpK4wYX4
         WW02p7VcuYmmtKnycb1CHf4nCtN55gLYAmcC2Y0NzRk1TxTbcJIYllSS0ZnAnOGesZR9
         CFo/erkNd8DorZvEfT7p+0NfIHdxdKbrhvUcIHijc/ZsA736l15yYnC8kYeKM8KvKouL
         AZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsFu/Mm6Udal+8o4/TOk1rUCznPeeCBmK6DAhapLdzw=;
        b=jwGVQS4cqArx9hFZ1TFNBZ1lwQLaAPcL9TmeVjQZDkjIPYD/OJqIvUC04DtqAtUN+C
         MMT46Et6SxgLxkgn14Zf4A8WS7LcEG9Oalf8TJS7S/+KP6EGuwLt6EnhoHk/yKCp4ebH
         SxXbWdKI0+hM9czxRFwwxXkXD3V7+WrmGzp+51VhVQ2UjUt5I5CDzB5uqUI32P8iAJpk
         3Lo2rot+zjvBJvOyNthWRZAXAbmEbsW88o4vMz871xlY8DW6nJ/xRCOpnP9HhlUJ9C5C
         WTGXoEOrN2jYRqE4l60mYEUlsb7BvNy92MTGg07q6KOgDf2c8chuqFWBcTs3G3Je01pW
         NYrQ==
X-Gm-Message-State: APjAAAWVDCw3FmrYWPG1vaLNxGN/zIh2fFSNsjhTUOvAmj2lr+EYaafD
        KymCFpTP58KUwqiHdlmJOic=
X-Google-Smtp-Source: APXvYqxYoF/SIlt6Ukz2suLOZ8tisqy3KjQfM59ackvtCmqJ87DSS1eR25b4WbfB37VMfbD7WIuvbA==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr25817105wrw.313.1557318455658;
        Wed, 08 May 2019 05:27:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:edb8:72e0:1074:1d8f:2a88:25e6])
        by smtp.gmail.com with ESMTPSA id s124sm3217737wmf.42.2019.05.08.05.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 05:27:34 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] checkpatch: add --fix for warning LINE_CONTINUATIONS
Date:   Wed,  8 May 2019 14:27:19 +0200
Message-Id: <20190508122721.7513-2-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508122721.7513-1-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning LINE_CONTINUATIONS does not offer a --fix.

Add the trivial --fix.
In case of consecutive lines with the same issue, this will
fix only the first line.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f40d4bb2fbb9..9a247183b65c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5207,8 +5207,11 @@ sub process {
 			    $line !~ /^\+\s*\#.*\\$/ &&		# preprocessor
 			    $line !~ /^\+.*\b(__asm__|asm)\b.*\\$/ &&	# asm
 			    $line =~ /^\+.*\\$/) {
-				WARN("LINE_CONTINUATIONS",
-				     "Avoid unnecessary line continuations\n" . $herecurr);
+				if (WARN("LINE_CONTINUATIONS",
+					 "Avoid unnecessary line continuations\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\s*\\$//;
+				}
 			}
 		}
 
-- 
2.21.0

