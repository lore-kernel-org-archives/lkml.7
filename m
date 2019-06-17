Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F619C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6423E2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560807342;
	bh=W0AM3mZ2w2n/ClyM2senMPvoTAFPrTIAe6at9yE9fyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cQDEB9XCicJOzQdgcxk3ztXsJM4Rfk44MoTeAX5QEqdpN7HjeEagdf8zn2C3rAV0E
	 tLEcX7W4ZS4Gkw/6ROtEeTAjkZYS7Oo4heThEVnhU0pSuOXgHlJHsTqa59WPCGFHKE
	 GmSNFst82Asi66yUhen2oruxYtQLHjhCuuQQdtAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfFQVfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbfFQVWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C125320673;
        Mon, 17 Jun 2019 21:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806551;
        bh=W0AM3mZ2w2n/ClyM2senMPvoTAFPrTIAe6at9yE9fyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RGNqAsozvz4fmVFOMz//X9jC8gIssrJwVcGG7eLwhuTSR2z+Kv8jH190nYRxvzIpS
         NiqXeZrvnWFb00yI0fB7WLZmrNTKzvElr78sfXyeOXEUSK0iPCfg0MBhBCIvGCX/nu
         2My5ulyq1djq0WCPsY1Rbk03SIiGBxz2jw7uyaMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young Xiao <YangX92@hotmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 046/115] Drivers: misc: fix out-of-bounds access in function param_set_kgdbts_var
Date:   Mon, 17 Jun 2019 23:09:06 +0200
Message-Id: <20190617210802.647826725@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



