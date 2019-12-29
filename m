Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C12C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E0E208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642668;
	bh=d1zhQ0bJrAaQZU96gc9FAq8wWKwEGSO7en0jwZ5FAjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zqVdlUoyPsxEm/Wx5BaRjyu9IMuFamg/olhiw7BevMFyMU7bkHx9cr0Q90T3h23FR
	 p04tOkSu+DUCU7n9oDKCyqANAd212fZhvjxMXHaKOgUq6QAikCdoQHen8lWtTn+6jH
	 L1cr7aAeXFZbYc6J116xjMT70YmBG6ABiJueA4sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfL2RwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732222AbfL2RwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:52:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31979222C2;
        Sun, 29 Dec 2019 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641930;
        bh=d1zhQ0bJrAaQZU96gc9FAq8wWKwEGSO7en0jwZ5FAjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwJLfBF2vABMM8IQfroKq55OB/rbMWKI/CF9+f7uGMQUg4RkE+oafWek8AhwAvFFa
         gMz7aYQty1vqL9x/GTwQK6ticcfIaxnF5ZGBxjuYVdkfpa6rNb0VOcpooczZTGW1Md
         brbyAGD0iN9MXmWQVqUriWjHwSJ7CDbhPCb5nykM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 270/434] selftests: proc: Make va_max 1MB
Date:   Sun, 29 Dec 2019 18:25:23 +0100
Message-Id: <20191229172719.872667697@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 2f3571ea71311bbb2cbb9c3bbefc9c1969a3e889 ]

Currently proc-self-map-files-002.c sets va_max (max test address
of user virtual address) to 4GB, but it is too big for 32bit
arch and 1UL << 32 is overflow on 32bit long.
Also since this value should be enough bigger than vm.mmap_min_addr
(64KB or 32KB by default), 1MB should be enough.

Make va_max 1MB unconditionally.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/proc/proc-self-map-files-002.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-self-map-files-002.c b/tools/testing/selftests/proc/proc-self-map-files-002.c
index 47b7473dedef..e6aa00a183bc 100644
--- a/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -47,7 +47,11 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
 int main(void)
 {
 	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
-	const unsigned long va_max = 1UL << 32;
+	/*
+	 * va_max must be enough bigger than vm.mmap_min_addr, which is
+	 * 64KB/32KB by default. (depends on CONFIG_LSM_MMAP_MIN_ADDR)
+	 */
+	const unsigned long va_max = 1UL << 20;
 	unsigned long va;
 	void *p;
 	int fd;
-- 
2.20.1



