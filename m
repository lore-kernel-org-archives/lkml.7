Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D4BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB2320721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419278;
	bh=sFmxPLvoOWEfl00tsENoIxTweNEQt91iXnciTX2cmDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2Ujf9NbW9LUMISKSQKtpVk7pQYiLgKofhEtZNaE/bcvHkNC06RKteGKMS6HMTPdH
	 XjkJ5yuak0+K0YuAGad53bZRjfF0zIQTnPeTT5H51YTJT9roia5ye+4mnsZFgB4k9R
	 W7pAkdZK3OC6DWJr90foT1L4LFBpwYO7ajYuPlxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfKVKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfKVKlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:41:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8472071C;
        Fri, 22 Nov 2019 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419273;
        bh=sFmxPLvoOWEfl00tsENoIxTweNEQt91iXnciTX2cmDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tpKd4f6rbOwafNgJVwvjKJcBr9zhAdDliIylGujmo83NBbm2aNZuMQAoNXlL5siH2
         WtW6mlmTIaqUc8114SbWsLALHwOV/XV1fTM4Pul4jL0UmnMzojRDmfcM48e/yBCmh3
         QL4pm1AIltChR3pvmuMCnG9zUODkRZByj2q8OmDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 055/222] f2fs: fix memory leak of percpu counter in fill_super()
Date:   Fri, 22 Nov 2019 11:26:35 +0100
Message-Id: <20191122100856.252357588@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 4a70e255449c9a13eed7a6eeecc85a1ea63cef76 ]

In fill_super -> init_percpu_info, we should destroy percpu counter
in error path, otherwise memory allcoated for percpu counter will
leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9eff18c1f3e46..e0ac676e0a35c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1650,8 +1650,12 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 	if (err)
 		return err;
 
-	return percpu_counter_init(&sbi->total_valid_inode_count, 0,
+	err = percpu_counter_init(&sbi->total_valid_inode_count, 0,
 								GFP_KERNEL);
+	if (err)
+		percpu_counter_destroy(&sbi->alloc_valid_block_count);
+
+	return err;
 }
 
 /*
-- 
2.20.1



