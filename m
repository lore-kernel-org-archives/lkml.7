Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C0C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB4D20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gVnr52O9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406300AbfHBTlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:41:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36568 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406258AbfHBTlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:41:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so55705350qkl.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WQAwxez96oUqOKhi5Otfo6AhSFIujCjLEKW9DkJRHyE=;
        b=gVnr52O9krwfQO7y4J7MjYdcZqCTJpMMIUn+Z08zsYXXmEldYmkrxz0coPApUy1ns/
         yAK8FI9kIlFe4gSaS3flfVCu+64pNIpWD8Nr6B9mGDiOGd4T+YruwYAE26ld3JoQYHSB
         WZlQQRQQ5yeCgDnStPHP5ReCPMMrnIx+7Qqs07vRfgEaTCfGaiOPC1jMRWP7/1sTRDL0
         FqWzYJT5bVZmot8Q9K9s8csJZvJE4DU2LHyqq2ddCmefRM0ilTCRJtCJw4bC3AycPHGP
         itefR9moAo171YUlBbl5L1+wChREPsXT4S9LhMGO1fbN5/LdsHuzVoT1iRp7wOD9pYOQ
         TBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WQAwxez96oUqOKhi5Otfo6AhSFIujCjLEKW9DkJRHyE=;
        b=C67tERcdD7ujiKx2R+Qjg9QyLV+tqJM+GqNwCqIbsem82iviL9NGdeE65il829F/dk
         dYiMnxeNRCZjzW9EjpR8iiyYFyrV1QSde4vtv4hBMttM4EBi/q2OnXHy/ndPHAcGzfnQ
         MJTDISQaso1SA/FXy0Ie4Pk5AIHTkbZBprc8pd+K3B4HLvX6nLIHLCBIlUeIVCBXs8WL
         pH3wNEgpIeSmbHoHObgpw83LkwcXKDEydglyQKVW9nX59NazdRP4C6J0+Sfz2H+F6xev
         QAi7bx1SyY5Yn/OBXmZeOcYcClyojFAPTwO+EPCh/uOx1h6i09/v5Q+mdDFa8yBjTg0A
         G/EQ==
X-Gm-Message-State: APjAAAUYfZ3nA59WtwWBPHeJeNoV2rb+sgIlR681+LjwCaK7v3Nv2GHS
        iXJZvDDS6Cqw/okWdsDcoWQRmg==
X-Google-Smtp-Source: APXvYqynXU2mckBK2mwl5pSKz+zstWguPmWFjVj13oC2WPpCvJ7NZTmDSEt0zerfIF1SxvJdKDtbMA==
X-Received: by 2002:a37:48c7:: with SMTP id v190mr93631953qka.350.1564774899382;
        Fri, 02 Aug 2019 12:41:39 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 39sm41877782qts.41.2019.08.02.12.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 12:41:38 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     arnd@arndb.de, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix variable 'p4d' set but not used
Date:   Fri,  2 Aug 2019 15:41:22 -0400
Message-Id: <1564774882-22926-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC throws a warning on an arm64 system since the commit 9849a5697d3d
("arch, mm: convert all architectures to use 5level-fixup.h"),

mm/kasan/init.c: In function 'kasan_free_p4d':
mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
[-Wunused-but-set-variable]
  p4d_t *p4d;
         ^~~

because p4d_none() in "5level-fixup.h" is compiled away while it is a
static inline function in "pgtable-nopud.h". However, if converted
p4d_none() to a static inline there, powerpc would be unhappy as it
reads those in assembler language in
"arch/powerpc/include/asm/book3s/64/pgtable.h",

./include/asm-generic/5level-fixup.h: Assembler messages:
./include/asm-generic/5level-fixup.h:20: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:21: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:22: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:23: Error: junk at end of line,
first unrecognized character is `}'
./include/asm-generic/5level-fixup.h:25: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:26: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:27: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:28: Error: junk at end of line,
first unrecognized character is `}'
./include/asm-generic/5level-fixup.h:30: Error: unrecognized opcode:
`static'
./include/asm-generic/5level-fixup.h:31: Error: junk at end of line,
first unrecognized character is `{'
./include/asm-generic/5level-fixup.h:32: Error: unrecognized opcode:
`return'
./include/asm-generic/5level-fixup.h:33: Error: junk at end of line,
first unrecognized character is `}'
make[2]: *** [scripts/Makefile.build:375:
arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1

Fix it by reference the variable in the macro instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/5level-fixup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index bb6cb347018c..2c3e14c924b6 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -19,7 +19,7 @@
 
 #define p4d_alloc(mm, pgd, address)	(pgd)
 #define p4d_offset(pgd, start)		(pgd)
-#define p4d_none(p4d)			0
+#define p4d_none(p4d)			((void)p4d, 0)
 #define p4d_bad(p4d)			0
 #define p4d_present(p4d)		1
 #define p4d_ERROR(p4d)			do { } while (0)
-- 
1.8.3.1

