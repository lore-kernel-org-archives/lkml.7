Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B713C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F9225CAE
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191775;
	bh=2r2AVMBcDo2NVf7ZljylpUx4Chpoy5HgvQ9SSUgJUCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dqEqFxa7POwgiUbjk+JnT/s1JN7XKBKjA9Ja5YLtO3YIYYgHvDT7bhvTCjr+OHo7n
	 c1BvpWbRl6BQurhr2owcd1snWWaQUctKGIYeRIDcfpnYPtObWNxpckD+x7WQlDvri0
	 It06YhkYHDgIOG91NmEFmlUdRsX3Y7hQQ6j0SdaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbfE3Et3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbfE3DLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:12 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2D5244D2;
        Thu, 30 May 2019 03:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185872;
        bh=2r2AVMBcDo2NVf7ZljylpUx4Chpoy5HgvQ9SSUgJUCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMVk1343aHB/e9ZQIKPUr8FcnFnGj6uFvpTeaJHmJwMDm/lYNPD9gqabLNc004t9B
         HP0AxX/+46d8kFkdc0mHtIEM9Cw5nmroPvOG75tHYzzR+6BiihTqss86VCR0dRbjK2
         XrJQm2uEKBts1dxEAx+z0Pl1A6iT13A4hL5LbinM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 215/405] s390: zcrypt: initialize variables before_use
Date:   Wed, 29 May 2019 20:03:33 -0700
Message-Id: <20190530030551.968108708@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 913140e221567b3ecd21b4242257a7e3fa279026 ]

The 'func_code' variable gets printed in debug statements without
a prior initialization in multiple functions, as reported when building
with clang:

drivers/s390/crypto/zcrypt_api.c:659:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true
      [-Wsometimes-uninitialized]
        if (mex->outputdatalength < mex->inputdatalength) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:725:29: note: uninitialized use occurs here
        trace_s390_zcrypt_rep(mex, func_code, rc,
                                   ^~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:659:2: note: remove the 'if' if its condition is always false
        if (mex->outputdatalength < mex->inputdatalength) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/s390/crypto/zcrypt_api.c:654:24: note: initialize the variable 'func_code' to silence this warning
        unsigned int func_code;
                              ^

Add initializations to all affected code paths to shut up the warning
and make the warning output consistent.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/zcrypt_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 689c2af7026a3..c31b2d31cd832 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -659,6 +659,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
 	if (mex->outputdatalength < mex->inputdatalength) {
+		func_code = 0;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -742,6 +743,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
 	if (crt->outputdatalength < crt->inputdatalength) {
+		func_code = 0;
 		rc = -EINVAL;
 		goto out;
 	}
@@ -951,6 +953,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
 
 		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
 		if (!targets) {
+			func_code = 0;
 			rc = -ENOMEM;
 			goto out;
 		}
@@ -958,6 +961,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
 		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
 		if (copy_from_user(targets, uptr,
 				   target_num * sizeof(*targets))) {
+			func_code = 0;
 			rc = -EFAULT;
 			goto out_free;
 		}
-- 
2.20.1



