Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D48420857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfDHV3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:29:19 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfDHV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:29:18 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhlbM-1gienQ0MDI-00dleu; Mon, 08 Apr 2019 23:29:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] s390: make chkbss work with clang
Date:   Mon,  8 Apr 2019 23:26:24 +0200
Message-Id: <20190408212648.2407234-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JevfzJx4fIfYNJndOqX74ucOpNeZfT8bjeYo5HS8OguBpS5HM4Q
 lyBN26av2aV+Y032TVD73BQWRbk9hnvQwMa4Jf2ZpVPNupY/TXvU6rI1v2dRr0sYkGGZCru
 3es5GqfvB7EHqLkummqS/jeGE56n3erGUb8uixlCZtZpZ9o+l9HB1GvnjJVAI2DYgiD1e8u
 ii45TNq1A0gnoXuZV6ODw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NHnlcFH3UL0=:jq37TD68eL5xTfi7Mz4t5m
 4deZJoNaTPB49+2OT7RV0L9dldCu7loL0KZG9WCOfyMbSflQMbzV85tgozSbLa9GMQgHC7wB0
 GUq/429HeqT5fuudkGhccso7HNLWoU5wgIjU4GuHdpS4ktcVmw0hCxNo1IxKVG8mTm/vKwYVj
 XfzqaUEYY69ESM9QopLdi9ylljX+lqzFainXrsoG29gft6jL5EEBxugr5t40kdf2tCzD9RXI5
 YHbqr/VhZbgQIC1zn8bjt8TGm0RaS3kHhcGi9k3sfsFJxxaSWWcFat9RJM7AovQILSjG0E8pC
 n65s9WSZifQKdwhedcq8k5yHDyj79l5YYsGMSKgVjpzUutOhhQArc8SEgU/D+HyRjgyxJcGzK
 Uaqp8lOHotvZjFtdyxOAMbqdfXURuhqLSZNpwb6/vV7E+itIE3+FOC6I5QEXMI+ue9RU3JLNi
 xx4oFCF3+60ZvR0tG8c3Kyre5+8D3TbI2RQnQ1nb9Oa0aj8VvbiqlvaXvN+5FiB6w7lZ5RPMY
 9QG2ajlz3iht5CJDhdF/4oVSmYVaA6kFiMkyW9eMbpbVoZDsBvj1XlgrYvwv2wFiWxYvXecZ5
 V/I7NOY2bYqazhMGstyXhrDbXMbTTDqHtYQ1MK3SJ+DuO4l/3VGtn75+qrVhRWEdwkGcgMRI6
 0RQw2hU8Qc0rjk/7Y3rtR0eZV3noFBfPLzlNa+qqlz1IOvKSbdKoR3fkMEKWSE/vujgNzK3ui
 lc+zJr4AWX7m7pmLwaQi+ZKSGG6boo/mHmBvHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llvm skips an empty .bss section entirely, which makes
the check fail with an unexpected error:

/tmp/binutils-multi-test/bin/s390x-linux-gnu-objdump: section '.bss' mentioned in a -j option, but not found in any input file
error: arch/s390/boot/compressed/decompressor.o .bss section is not empty
../arch/s390/scripts/Makefile.chkbss:20: recipe for target 'arch/s390/boot/compressed/decompressor.o.chkbss' failed

Change the check so we first see if a .bss section exists
before trying to read its size.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/scripts/Makefile.chkbss | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/scripts/Makefile.chkbss b/arch/s390/scripts/Makefile.chkbss
index cd7e8f4419f5..884a9caff5fb 100644
--- a/arch/s390/scripts/Makefile.chkbss
+++ b/arch/s390/scripts/Makefile.chkbss
@@ -11,7 +11,8 @@ chkbss: $(addprefix $(obj)/, $(chkbss-files))
 
 quiet_cmd_chkbss = CHKBSS  $<
       cmd_chkbss = \
-	if ! $(OBJDUMP) -j .bss -w -h $< | awk 'END { if ($$3) exit 1 }'; then \
+	if $(OBJDUMP) -h $< | grep -q "\.bss" && \
+	   ! $(OBJDUMP) -j .bss -w -h $< | awk 'END { if ($$3) exit 1 }'; then \
 		echo "error: $< .bss section is not empty" >&2; exit 1; \
 	fi; \
 	touch $@;
-- 
2.20.0

