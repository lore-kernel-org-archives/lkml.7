Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D13321734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714532;
	bh=Aw51D3dFq+SHYFP4bkygBxYF3FzCG3/YZ0jZlOKBKEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jYy90tVmQnxGYkK8nsLhSXjOvgYL56wzRqMC6izrM4YowqkZREck0k2zH/ZzCpafA
	 XhtaEsi0Wc2D3Nwt0tT4HSWsFTu61i78FCNJ+40WmmRaOCg4w7V7bKPNT/Gh2puCkO
	 h7toaMC9RygyUOz3h8j8AbztINempoVeNGlIg4vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbfC0TWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733214AbfC0SGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FFA2063F;
        Wed, 27 Mar 2019 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709995;
        bh=Aw51D3dFq+SHYFP4bkygBxYF3FzCG3/YZ0jZlOKBKEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGJE040D6aM8xh0/QciPU2Hgq8Uq/6XbaEw2PPsxoujRd7PJ/sMWtHEnbBrLk4Pw6
         mxMz/Du6T603XNMXj7LLbIRQDqtMPmUVyTvO6qwbhHw6YfNRbNtxLF64vyO+k84rJU
         3HEj6Ab01c2bWYI6p2wlYYBOHS3ycHMdxZ8KYmpk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 148/262] =?UTF-8?q?selftests:=20ir:=20fix=20wa?= =?UTF-8?q?rning:=20"%s"=20directive=20output=20may=20be=20truncated=20?= =?UTF-8?q?=E2=80=99=20directive=20output=20may=20be=20truncated?=
Date:   Wed, 27 Mar 2019 14:00:03 -0400
Message-Id: <20190327180158.10245-148-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>

[ Upstream commit ed675ed9da6d951322efd72d739d6b5ce1c18f02 ]

Fix the following warning by sizing the buffer to max. of sysfs
path max. size + d_name max. size.

gcc -Wall -O2 -I../../../include/uapi ir_loopback.c  -o ../tools/testing/selftests/ir/ir_loopback
ir_loopback.c: In function ‘lirc_open’:
ir_loopback.c:71:37: warning: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size 95 [-Wformat-truncation=]
    snprintf(buf, sizeof(buf), "/dev/%s", dent->d_name);
                                     ^~
In file included from /usr/include/stdio.h:862:0,
                 from ir_loopback.c:14:
/usr/include/x86_64-linux-gnu/bits/stdio2.h:64:10: note: ‘__builtin___snprintf_chk’ output between 6 and 261 bytes into a destination of size 100
   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        __bos (__s), __fmt, __va_arg_pack ());
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <shuah@kernel.org>
Acked-by: Sean Young <sean@mess.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ir/ir_loopback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ir/ir_loopback.c b/tools/testing/selftests/ir/ir_loopback.c
index 858c19caf224..8cdf1b89ac9c 100644
--- a/tools/testing/selftests/ir/ir_loopback.c
+++ b/tools/testing/selftests/ir/ir_loopback.c
@@ -27,6 +27,8 @@
 
 #define TEST_SCANCODES	10
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#define SYSFS_PATH_MAX 256
+#define DNAME_PATH_MAX 256
 
 static const struct {
 	enum rc_proto proto;
@@ -56,7 +58,7 @@ static const struct {
 int lirc_open(const char *rc)
 {
 	struct dirent *dent;
-	char buf[100];
+	char buf[SYSFS_PATH_MAX + DNAME_PATH_MAX];
 	DIR *d;
 	int fd;
 
-- 
2.19.1

