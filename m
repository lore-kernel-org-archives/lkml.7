Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA7C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6552089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054455;
	bh=jpoG5OfWr9KUYqixqHKTTx28JxU1Pd3vMM8nuxwZcgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iMekY1nO19koPTOM2XzRhtZUviuUq+lES6Nq8gHqXJpSPo0O9quhAnQf+QrESHJ79
	 37cJaQ9icgRSuirNHjU+x9E7gTfPzEhpxiD9UE6KulNeVfeoGUn1zTgg673ysp7kSi
	 hknsVitS6nCLRxDu3zTKRZOPkKUPSO1wIkKIoL5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfFTSOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfFTSOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:14:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD79205F4;
        Thu, 20 Jun 2019 18:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054452;
        bh=jpoG5OfWr9KUYqixqHKTTx28JxU1Pd3vMM8nuxwZcgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W1EJ6BITwKHwZ0LnQPY2ap5ipEfy6ER7SoLSOalM75Zk6Kr5jV7rHeonDTvZ6GeNO
         q18U18yNcFQlYrWlda4Ja76lQdbmqX4X/L+pLOLJJDiKECvmS/51EeNUnqS1KmyAAx
         stlsVRbRyUoKxU/ucEexeIpuZDptdPVTBT9wBmt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@gmail.com>,
        Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 33/98] staging: erofs: set sb->s_root to NULL when failing from __getname()
Date:   Thu, 20 Jun 2019 19:57:00 +0200
Message-Id: <20190620174350.604609689@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f2dcb8841e6b155da098edae09125859ef7e853d ]

Set sb->s_root to NULL when failing from __getname(),
so that we can avoid double dput and unnecessary operations
in generic_shutdown_super().

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/erofs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 15c784fba879..c8981662a49b 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -459,6 +459,7 @@ static int erofs_read_super(struct super_block *sb,
 	 */
 err_devname:
 	dput(sb->s_root);
+	sb->s_root = NULL;
 err_iget:
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 	iput(sbi->managed_cache);
-- 
2.20.1



