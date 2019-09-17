Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C97206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfIQSkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:40:51 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45576 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfIQSkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:40:51 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 476A43C0579;
        Tue, 17 Sep 2019 20:40:48 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LawiGxCtawfq; Tue, 17 Sep 2019 20:40:41 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id BD9E23C04C0;
        Tue, 17 Sep 2019 20:40:41 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 20:40:41 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Shuah Khan <shuah@kernel.org>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH v3 1/2] selftests: watchdog: Validate optional file argument
Date:   Tue, 17 Sep 2019 20:40:22 +0200
Message-ID: <20190917184023.16701-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "George G. Davis" <george_davis@mentor.com>

The newly added optional file argument does not validate if the
file is indeed a watchdog, e.g.:

./watchdog-test  -f /dev/zero
Watchdog Ticking Away!

Fix it by confirming that the WDIOC_GETSUPPORT ioctl succeeds.

Fixes: c3f2490d6e9257 ("selftests: watchdog: Add optional file argument")
Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v3:
 - Used v1 as starting point and simplified commit description
 - Added Fixes tag (WARNING: commit id is from linux-next!)
 - No change in the contents
 - Applied cleanly to the same base as used in [v1]
v2:
 - https://patchwork.kernel.org/patch/11147663/
v1:
 - https://patchwork.kernel.org/patch/11136283/
 - Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next
---
 tools/testing/selftests/watchdog/watchdog-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index afff120c7be6..6ed822dc2222 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -97,6 +97,7 @@ int main(int argc, char *argv[])
 	int c;
 	int oneshot = 0;
 	char *file = "/dev/watchdog";
+	struct watchdog_info info;
 
 	setbuf(stdout, NULL);
 
@@ -118,6 +119,16 @@ int main(int argc, char *argv[])
 		exit(-1);
 	}
 
+	/*
+	 * Validate that `file` is a watchdog device
+	 */
+	ret = ioctl(fd, WDIOC_GETSUPPORT, &info);
+	if (ret) {
+		printf("WDIOC_GETSUPPORT error '%s'\n", strerror(errno));
+		close(fd);
+		exit(ret);
+	}
+
 	optind = 0;
 
 	while ((c = getopt_long(argc, argv, sopts, lopts, NULL)) != -1) {
-- 
2.23.0

