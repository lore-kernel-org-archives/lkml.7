Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89914C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F17208CB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559690742;
	bh=EJnq8IEeTg02jxtr0X79PQyChSZhrYq4oMizD6LZy2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sE0ODZm7fm3iO4lVailxZmVVOv/fapQ1UG6envh1RicoQCm8NLbyi+qB9ZqEyUmBb
	 LfbbxeiyZLABbThrntXPGQT/IaLgKfLH4oXDZD3kAn0TYiZH4HZ2Uc8KcAhr5T2dXW
	 nt0rzRBJdB4cqqW0WeYQnaq126Kpcpe5awKknAsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfFDXZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfFDXZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:25:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF0E20866;
        Tue,  4 Jun 2019 23:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690736;
        bh=EJnq8IEeTg02jxtr0X79PQyChSZhrYq4oMizD6LZy2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D47jP8Ph35zNQC5kOTjIU1iSg0nRKHPXulfC5Y8MhAuNdhSLgvANVhJa2M+1OoeOv
         4ZVsSdQW2RObjD+eexyCuIZE2BhdIDl4Q6kW+8JdZWoTpTMewaULDHQn/kDAbGScgo
         9RTs+OwXcefoGOz7uqK/sBagEK+Mb/y75YsrDeQ4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 03/10] Drivers: misc: fix out-of-bounds access in function param_set_kgdbts_var
Date:   Tue,  4 Jun 2019 19:25:24 -0400
Message-Id: <20190604232532.7953-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232532.7953-1-sashal@kernel.org>
References: <20190604232532.7953-1-sashal@kernel.org>
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
index 99635dd9dbac..bb3a76ad80da 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1132,7 +1132,7 @@ static void kgdbts_put_char(u8 chr)
 
 static int param_set_kgdbts_var(const char *kmessage, struct kernel_param *kp)
 {
-	int len = strlen(kmessage);
+	size_t len = strlen(kmessage);
 
 	if (len >= MAX_CONFIG_LEN) {
 		printk(KERN_ERR "kgdbts: config string too long\n");
@@ -1152,7 +1152,7 @@ static int param_set_kgdbts_var(const char *kmessage, struct kernel_param *kp)
 
 	strcpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
-	if (config[len - 1] == '\n')
+	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
 
 	/* Go and configure with the new params. */
-- 
2.20.1

