Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F323C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4624525DDD
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEaBMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:12:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46913 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfEaBMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:12:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so112376wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 18:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GSo3L74CrMpk122PH7s5v0Pukl/A/+yXOFEsEd3WHE=;
        b=te0MxJEPuSMhpBf69/2zxKm2J5xaCbNn9/ppxI9Pf88ZmEzX2QjanU/f4XE8GpjWto
         wD4w5A/wAnIwBD5jv2BZDQoBtPpBEUxQ8iv79aNPSEbKGYWtYKI0dBri0njQkgkZSso6
         KJQ8E/zMnUXL1hPtXR++jb+LbY5XIGF9BXPOCF0TecQVk11HFYu6hn3BZF/BjiqQXNcq
         FstuqMuN58xtLQKUXao65xanWHa84ZeZy7lPBaSAZEo6jXTjQVz4RXKXrCR3xuMbcje6
         s2h5DbHf4M5551SKayVQDGwz1vV2fbJSB+AV2PuDEcLOe72LG6AUTNqmxsIqFqYQV/+S
         IYng==
X-Gm-Message-State: APjAAAU0oU/QnW5oKTlg/JpdsOuVmYPB4tvYdIKomqKF1iW1M4FEKmeF
        pIZF/0CSslDpJiKgkVKhoW0ZCQoU0ic=
X-Google-Smtp-Source: APXvYqwwxBNVwaiIzc1qdo0mml6o65B68WiMndCOzOOCyaAFd5OAOefc0KmfgW4dl/4cuu4okYJ9QQ==
X-Received: by 2002:a5d:5542:: with SMTP id g2mr4277947wrw.232.1559265148873;
        Thu, 30 May 2019 18:12:28 -0700 (PDT)
Received: from raver.teknoraver.net (net-93-144-152-91.cust.vodafonedsl.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id p2sm2936448wmp.40.2019.05.30.18.12.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 18:12:27 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] checkpatch.pl: Warn on duplicate sysctl local variable
Date:   Fri, 31 May 2019 03:12:27 +0200
Message-Id: <20190531011227.21181-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6a33853c5773 ("proc/sysctl: add shared variables for range check")
adds some shared const variables to be used instead of a local copy in
each source file.
Warn when a chunk duplicates one of these values in a ctl_table struct:

    $ scripts/checkpatch.pl 0001-test-commit.patch
    WARNING: duplicated sysctl range checking value 'zero', consider using the shared one in include/linux/sysctl.h
    #27: FILE: arch/arm/kernel/isa.c:48:
    +               .extra1         = &zero,

    WARNING: duplicated sysctl range checking value 'int_max', consider using the shared one in include/linux/sysctl.h
    #28: FILE: arch/arm/kernel/isa.c:49:
    +               .extra2         = &int_max,

    total: 0 errors, 2 warnings, 14 lines checked

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 342c7c781ba5..629c31435487 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6639,6 +6639,12 @@ sub process {
 				     "unknown module license " . $extracted_string . "\n" . $herecurr);
 			}
 		}
+
+# check for sysctl duplicate constants
+		if ($line =~ /\.extra[12]\s*=\s*&(zero|one|int_max|max_int)\b/) {
+			WARN("DUPLICATED_SYSCTL_CONST",
+				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
+		}
 	}
 
 	# If we have no input at all, then there is nothing to report on
-- 
2.21.0

