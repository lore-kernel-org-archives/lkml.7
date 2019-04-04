Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DBAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369221;
	bh=ytLtpcReY4S64uU+tYvNBdmffJ6O+5DUoiQd4IAE3ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zL/AHOPZm9kKUZ6f+cJsng6iY7vQ08E1jOPOzQQeKdoTp/h6YaP6/aTtiehnMlHVf
	 DWPZGVEki0T6/ngAU06M6UQ2tXbqmV+5su15rfWs2umx8BLOCrPdURwLn+OzghKkmK
	 3EoJhnmDXsieNYHptWutnhgyWTfuMfecWYo5hOLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfDDJNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387580AbfDDJNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9A92075E;
        Thu,  4 Apr 2019 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369213;
        bh=ytLtpcReY4S64uU+tYvNBdmffJ6O+5DUoiQd4IAE3ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmAMYldvmarQpviNLP/ofeMXj5Z9XK3B/LKUMhZOHE4xICHGwyVUtgUXOxJrZyO5T
         lYqKNKA+cFX++XtPAy4pABxDqC/e7uPf5s9WiOh4bZVaFck8QQQFV46TgeeaofPUw8
         xMIIwgmqjAKqmUc2P5SB74bgyQeuuFRFybWq7vyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Sean Young <sean@mess.org>, Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?=5BPATCH=205=2E0=20139/246=5D=20=3D=3FUTF-8=3Fq=3Fselftests=3A=3D20ir=3A=3D20fix=3D20warning=3A=3D20=22=25s=22=3D20directive=3D20=3F=3D=20=3D=3FUTF-8=3Fq=3Foutput=3D20may=3D20be=3D20truncated=3D20=3DE2=3D80=3D99=3D20directive=3D20output=3F=3D=20=3D=3FUTF-8=3Fq=3F=3D20may=3D20be=3D20truncated=3F=3D?=
Date:   Thu,  4 Apr 2019 10:47:19 +0200
Message-Id: <20190404084624.033038495@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



