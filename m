Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792CDC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4300D20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+grWCdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfDHRNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:13:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45201 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbfDHRNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:13:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so7665044pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 10:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=zFQBbigOTEog9L119nzi8yUiDvvH6RzigfyLgG6e7ew=;
        b=A+grWCdx8z6DrlFCINwSLbdf9vaJ7EjSoWTqNtWAYNMIyN+2qOt3uI4yxc/tXEXyg6
         dQwK6bkrKK1/uoT39PDU+fb7IQYs+t4wnjMD/xTfE5X7xmalBdq0nDqcZfuUb54j9FsH
         J/jFy9SleTnf3cpSJiLA7pg20hVWQx5J9sI3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zFQBbigOTEog9L119nzi8yUiDvvH6RzigfyLgG6e7ew=;
        b=kN55/x4IIw1PonYKYFtSh75/qqbpBx933EHGvGdZkYDJWEDt9d7Hohm3MsqsoSjb+C
         bIVjmMkRvT3vLgmyI16wVZoEfzfiEg85+kiNQa8eVWOyFrhgoS07o2zUWGxAwXvGoWnq
         j+IjQPzVpakYb7sDFnmkdqV+C0V0h/334q0klKjbnio43vQX10gxhPT90W8zycYCOYlo
         V8bUIuIHyYOzV/6ZV8Fxg/eykzMpZnH2DoWz9xvM65dP/CXwQmgz56H7z/9kD/vVCWWs
         5pBHrQWNz1QiWVBqWBAEHLpmBImSl6TiSHZygz6HbYSh7GELS0WOrGnXfu/thC4x16Ic
         PdKA==
X-Gm-Message-State: APjAAAXda0q+HhtCs85DOzkCht7hoAZH3KM9WD/AEf74cS0FIXFGt5jb
        z6GNE+iV2APxCBSulgn93tVSdMFjt1U=
X-Google-Smtp-Source: APXvYqys6hvSOZ9splDIvNZr1em+rB79WhDX7d53/z4j33eJRfaI58bJnejLgDCzio9DPkERc3gyhQ==
X-Received: by 2002:a62:1795:: with SMTP id 143mr31584409pfx.104.1554743626910;
        Mon, 08 Apr 2019 10:13:46 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v43sm17080239pgn.57.2019.04.08.10.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 10:13:46 -0700 (PDT)
Date:   Mon, 8 Apr 2019 10:13:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/ipc: Fix msgque compiler warnings
Message-ID: <20190408171344.GA22803@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the various compiler warnings when building the msgque
selftest. The primary change is using sys/msg.h instead of linux/msg.h
directly to gain the API declarations.

Fixes: 3a665531a3b7 ("selftests: IPC message queue copy feature test")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/ipc/msgque.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index dac927e82336..4c156aeab6b8 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include <linux/msg.h>
+#include <sys/msg.h>
 #include <fcntl.h>
 
 #include "../kselftest.h"
@@ -73,7 +74,7 @@ int restore_queue(struct msgque_data *msgque)
 	return 0;
 
 destroy:
-	if (msgctl(id, IPC_RMID, 0))
+	if (msgctl(id, IPC_RMID, NULL))
 		printf("Failed to destroy queue: %d\n", -errno);
 	return ret;
 }
@@ -120,7 +121,7 @@ int check_and_destroy_queue(struct msgque_data *msgque)
 
 	ret = 0;
 err:
-	if (msgctl(msgque->msq_id, IPC_RMID, 0)) {
+	if (msgctl(msgque->msq_id, IPC_RMID, NULL)) {
 		printf("Failed to destroy queue: %d\n", -errno);
 		return -errno;
 	}
@@ -129,7 +130,7 @@ int check_and_destroy_queue(struct msgque_data *msgque)
 
 int dump_queue(struct msgque_data *msgque)
 {
-	struct msqid64_ds ds;
+	struct msqid_ds ds;
 	int kern_id;
 	int i, ret;
 
@@ -245,7 +246,7 @@ int main(int argc, char **argv)
 	return ksft_exit_pass();
 
 err_destroy:
-	if (msgctl(msgque.msq_id, IPC_RMID, 0)) {
+	if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
 		printf("Failed to destroy queue: %d\n", -errno);
 		return ksft_exit_fail();
 	}
-- 
2.17.1


-- 
Kees Cook
