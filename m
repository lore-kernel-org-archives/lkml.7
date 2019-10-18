Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA030CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B5320640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437656;
	bh=j4NMKFZCEhXHqiCHNdvO7vjenNr3RiF8my1Dx+JIa0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDxV6j6QpxeVvtCnk9EewPJP8G3zY5J3WFDcdOtUE5afup8lvZmoZIHR8VooPZTnr
	 +TXq3EH75/UroVSdodxmzTX4irJLgKYt/Jj4J0T7f9PdHiDtzsIGTt5oQ80coXeNr9
	 oSz3IUL69EB3KTXB+22ZfFeVGcaFHgFPQMO8+oxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406572AbfJRW1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbfJRWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:03:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73ACD22467;
        Fri, 18 Oct 2019 22:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436237;
        bh=j4NMKFZCEhXHqiCHNdvO7vjenNr3RiF8my1Dx+JIa0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GF21DK0CgQFtCx+W56It068F5uPeCmYzz6UyjsA/XHWrq/jSzo8VXjGPlu/IgR3O8
         sUpMJjo4ertgNz2UrZv+LcPtMd5WhHXcd+EE/EMcEkuLmDDwvhZ70K1Xn7gQVPHZYe
         s4gCeTKiJU04/RQMX/HN8DXETbLtVao0+wDQG2QQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 22/89] kselftest: exclude failed TARGETS from runlist
Date:   Fri, 18 Oct 2019 18:02:17 -0400
Message-Id: <20191018220324.8165-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit 131b30c94fbc0adb15f911609884dd39dada8f00 ]

A TARGET which failed to be built/installed should not be included in the
runlist generated inside the run_kselftest.sh script.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 25b43a8c2b159..1779923d7a7b8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -198,8 +198,12 @@ ifdef INSTALL_PATH
 	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
 
+	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
+	@# they could be the result of a build failure and should NOT be
+	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
-- 
2.20.1

