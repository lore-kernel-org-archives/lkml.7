Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72D0C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD996217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfGHSTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:19:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfGHSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:19:50 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1hkYEu-0008Ga-FG; Mon, 08 Jul 2019 18:19:48 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: [PATCH] selftests/ftrace: avoid failure when trying to probe a notrace function
Date:   Mon,  8 Jul 2019 15:19:33 -0300
Message-Id: <20190708181933.10286-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the function is on available_filter_functions. If it's not,
mark the test as unresolved, instead of failing it.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 3fb70e01b1fe..e4dff034da12 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -26,6 +26,7 @@ test -d events/kprobes2/event2 || exit_failure
 
 FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
 [ "x" != "x$FUNC" ] || exit_unresolved
+grep -n "$FUNC" available_filter_functions || exit_unresolved
 echo "p $FUNC" > kprobe_events
 EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`
 [ "x" != "x$EVENT" ] || exit_failure
-- 
2.20.1

