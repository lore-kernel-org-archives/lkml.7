Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E5ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C80218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="Y1HBxO8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733203AbfJVRM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:12:59 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53065 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732552AbfJVRM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:12:58 -0400
Received: by mail-wm1-f43.google.com with SMTP id r19so18207753wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsdgsMcU3HKx96SXZpLXR9PuPe4fAaa7s6eLfWcojk4=;
        b=Y1HBxO8V5Y0iD5fKeN0sXhVG1pO538VxcgM0gQN/f/tb3jMldemzDiw2VyXoMlUOog
         W5H8zhpQqCB47YU39tMe0iF98cF3KJyWYleFX8CKPXMMWQ1GbCVcc+eausOwwkbmbM8X
         WfK5WjScKPTxKjc8Nq+J7eYWmzTM9baIG96WCQxH8U9WX9dKJJMQO8nUZrPvZurbjmwI
         75bQCcPI+/WN5Q9BfB4dVVgV2P/vBF6tzQ2gIQtpSElOn/KBKTEbjOuxBkL8EEBbOtQj
         l/9iB50Ke55wMMpqX48bKv0jBGvyauZ3IyV41yqfxLG1tYr/eSM9AqXAIpMNwjsZ67rE
         NqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsdgsMcU3HKx96SXZpLXR9PuPe4fAaa7s6eLfWcojk4=;
        b=LYNdRp4vIPTP5eTOA9Tj64Xu+vSl/GlmDK2bfo92Z+giSqDs0yD0r/6bJ3i+iuoHdN
         zY9e2rjEstq9swpwzHE73yy3pXEuAmt4r8zCPPTySXov4XDnDro4T87/sCMe5L9oqzIB
         rCn9MnFZ0X+jANJFaDcdAsmHTllwW/NGghTXaLFWJX87DRcNSVW2MvV0Jqkb5nsHBzLI
         YJQw0NGhkT+tTRvZKm+qeuNRp1ZryfS5hVgdHi0SFHwoKjP6/V0KW0P8OT8k0AJ0vkXQ
         xIcaXJIrNfDOnu6n9ZoqYOmnJcXYMJ/AV/gE2pS4eKhdMIERbRECaYmKvz8hwBfPqDvN
         tKvg==
X-Gm-Message-State: APjAAAXIWr/ddrZlLdFoCK+LDkqG4XIPv+xoEhJ7yYb+Gxuf3lrlj4dx
        ebHW0tXGaHHGK/yhvVMlIS93ZQ==
X-Google-Smtp-Source: APXvYqyBjSpq14ScGELyVv252XLFhNfBPEZJpet8FWhwaC7umORhfRibmOExBWNszeZwotRWlmluyA==
X-Received: by 2002:a1c:5458:: with SMTP id p24mr3786077wmi.32.1571764376501;
        Tue, 22 Oct 2019 10:12:56 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id y13sm28309810wrg.8.2019.10.22.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:12:55 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: settings: tests can be in subsubdirs
Date:   Tue, 22 Oct 2019 19:12:20 +0200
Message-Id: <20191022171223.27934-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
timeout per test) adds support for a new per-test-directory "settings"
file. But this only works for tests not in a sub-subdirectories, e.g.

 - tools/testing/selftests/rtc (rtc) is OK,
 - tools/testing/selftests/net/mptcp (net/mptcp) is not.

We have to increase the timeout for net/mptcp tests which are not
upstreamed yet but this fix is valid for other tests if they need to add
a "settings" file, see the full list with:

  tools/testing/selftests/*/*/**/Makefile

Note that this patch changes the text header message printed at the end
of the execution but this text is modified only for the tests that are
in sub-subdirectories, e.g.

  ok 1 selftests: net/mptcp: mptcp_connect.sh

Before we had:

  ok 1 selftests: mptcp: mptcp_connect.sh

But showing the full target name is probably better, just in case a
subsubdir has the same name as another one in another subdirectory.

Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeout per test)
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/kselftest/runner.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 84de7bc74f2c..0d7a89901ef7 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -90,7 +90,7 @@ run_one()
 run_many()
 {
 	echo "TAP version 13"
-	DIR=$(basename "$PWD")
+	DIR="${PWD#${BASE_DIR}/}"
 	test_num=0
 	total=$(echo "$@" | wc -w)
 	echo "1..$total"
-- 
2.20.1

