Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FABC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87199206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559691184;
	bh=zyKEHdspF4sm/pAje1aBQEfNbmfLWqPiluwlZ7g5nc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BOt0zgWz+rdoVjTJg4g1el0G/B3e8SS3v0UpAmhwZkdrhnR6GfzXEoFRec/RtPNbN
	 dYwChq4jDYEd3zJP0sMo+JQst8LZPYpLbcQcZQDcZju4d3fUDfAfAVFqnwxalgPCAD
	 fJmZevwhH9w5pTHgwWKNAVfLsJYzucwfX3kirIqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfFDXWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfFDXW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:22:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E0921019;
        Tue,  4 Jun 2019 23:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690547;
        bh=zyKEHdspF4sm/pAje1aBQEfNbmfLWqPiluwlZ7g5nc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ad0ZcocXvOCW9v0jVuVQp2ERlEzEDxHUcm4mXi5mYqMW0wZHVbJHlFWDfprloYxCm
         Avv7zCGsgCOEV9M5gKo9ozhlaErGA/c3pBxkaeyIYmLPRyGQeSGwM8VUs6UvI2bEt/
         1cJjwezZxpRQtbLZzFHvAw6kn0XfAJH+otsBGm0U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.1 07/60] Drivers: misc: fix out-of-bounds access in function param_set_kgdbts_var
Date:   Tue,  4 Jun 2019 19:21:17 -0400
Message-Id: <20190604232212.6753-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232212.6753-1-sashal@kernel.org>
References: <20190604232212.6753-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

[ Upstream commit b281218ad4311a0342a40cb02fb17a363df08b48 ]

There is an out-of-bounds access to "config[len - 1]" array when the
variable "len" is zero.

See commit dada6a43b040 ("kgdboc: fix KASAN global-out-of-bounds bug
in param_set_kgdboc_var()") for details.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/kgdbts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index de20bdaa148d..8b01257783dd 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1135,7 +1135,7 @@ static void kgdbts_put_char(u8 chr)
 static int param_set_kgdbts_var(const char *kmessage,
 				const struct kernel_param *kp)
 {
-	int len = strlen(kmessage);
+	size_t len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdbts: config string too long\n");
@@ -1155,7 +1155,7 @@ static int param_set_kgdbts_var(const char *kmessage,
 
 	strcpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
-	if (config[len - 1] == '\n')
+	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
 
 	/* Go and configure with the new params. */
-- 
2.20.1

