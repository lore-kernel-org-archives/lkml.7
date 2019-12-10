Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B914C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34930246B4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012320;
	bh=llxTMyAg9lnxaCEgDxZUDRqHpm9Nbq4qYqfQJrl9Q70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s3BpGJ+kVn7LKG8VuiLKp4+RSFnrO+OjvIjJbMk44aqtrRrehdS+TICsiKLGnKqHM
	 XkVK5VlLKSqX5wbVBsDg4PlmLtkh9A/S8rARjo/K4Pd3IAP+gfzbPQhRoSS6BQzhda
	 6fxM/DBKXkTV+MzGJbD8YRoTxfaRZ9MPC34LTxIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfLJVL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:11:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbfLJVLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:11:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECBD1246A8;
        Tue, 10 Dec 2019 21:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012309;
        bh=llxTMyAg9lnxaCEgDxZUDRqHpm9Nbq4qYqfQJrl9Q70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjFjYIlGkQo9DFdPB1rGuTDS0iBjyHhpVgAadJImn1k8N3daMT/+1RkZ8xD6LTjTw
         6Melnw91DSedruFQC8MJEk9ej+hfr1uGM+UP/XeJa+CY9QD8iTCOJBtZnAzWd36tHo
         vmr2lqXqHkz8ATKtG/KEgtpEoU3MbiM9tFmNBsCI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 245/350] selftests: proc: Make va_max 1MB
Date:   Tue, 10 Dec 2019 16:05:50 -0500
Message-Id: <20191210210735.9077-206-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 47b7473dedef7..e6aa00a183bcd 100644
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

