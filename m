Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBBDC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED77C21530
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994003;
	bh=H1tVuLnPNysLon5VS2w3HimbFqbOZX0S9uOUa3IMepU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t9XtCjdDfjbzOh4Ny8tXwCaumN/M7Fq+r2tiG5Kw2cRZrMwtpin1NUbcfm2h5A6gf
	 K9OV77xJxqJkHA/H0yr0QeNpp238hUbIShxPSO3EWc774Chdr+UD8YjprLPSNuFW5q
	 DqHAOvJuN1WfHP2QGHvMciOI4YYfrMBqkaKYyev8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFHLkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfFHLj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:39:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E1921530;
        Sat,  8 Jun 2019 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559993997;
        bh=H1tVuLnPNysLon5VS2w3HimbFqbOZX0S9uOUa3IMepU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLhNstgdT98NSzjmUABTpFsbF22DIGYAmp+sDKeT7EJfnC1SNuOma297ceQSVLooh
         RYd99kCc4abY2Zxk1OaM/fhO1vwRyQaFAwdf0HOUBIou5CtJmL0/6dQONrP+rYskgW
         IAvD9pmmWQ/tq8ur5KEJDlOpUFC0xUkCsJk+hQIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengguang Xu <cgxu519@gmail.com>, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.1 05/70] staging: erofs: set sb->s_root to NULL when failing from __getname()
Date:   Sat,  8 Jun 2019 07:38:44 -0400
Message-Id: <20190608113950.8033-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@gmail.com>

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

