Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7576C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7FA20880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752182;
	bh=T29yJ8snlNAdkwvQv7BaxsTHlI9gtx7BlKGKUKsLvY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dNfpwF7ww5+lIubtRt0Jw827MyeyD94Cvr/+rbgkzRIUE295yxO0GyirVVJBct3wR
	 ldML2093W9NIV+w0M6YRjC3xkg4Jzthdj2IJOaEAuNlOnd+8s+tQpVd080MA61DYrW
	 acHbCg5U3XNDMmipAsHmN9MCsuZZRjAjy+UyxDTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393895AbfHBNXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393864AbfHBNW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:22:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C362182B;
        Fri,  2 Aug 2019 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752177;
        bh=T29yJ8snlNAdkwvQv7BaxsTHlI9gtx7BlKGKUKsLvY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmi/aQuxCo4CoMB/VsCoUKlW6tiUX6hDYrCbGqVdmpRA12PrAB9FctmRn6D+Ah0u/
         QW3pBih6qWUJkn5Xdjdlm/s8hIUlYCzfotiCKs4pCV7Pst2BquJUirASqnNxe7Fszz
         xTrgYJxJToqjfF3lZUsSSf8lvhqWQtseF3ag09nQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 76/76] gen_compile_commands: lower the entry count threshold
Date:   Fri,  2 Aug 2019 09:19:50 -0400
Message-Id: <20190802131951.11600-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit cb36955a5569f1ff17a42ae93264ef391c013a97 ]

Running gen_compile_commands.py after building the kernel with
allnoconfig gave this:

$ ./scripts/gen_compile_commands.py
WARNING: Found 449 entries. Have you compiled the kernel?

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gen_compile_commands.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 7915823b92a5e..c458696ef3a79 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -21,9 +21,9 @@ _LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c)$'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 
 # A kernel build generally has over 2000 entries in its compile_commands.json
-# database. If this code finds 500 or fewer, then warn the user that they might
+# database. If this code finds 300 or fewer, then warn the user that they might
 # not have all the .cmd files, and they might need to compile the kernel.
-_LOW_COUNT_THRESHOLD = 500
+_LOW_COUNT_THRESHOLD = 300
 
 
 def parse_arguments():
-- 
2.20.1

