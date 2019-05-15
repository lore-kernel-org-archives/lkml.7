Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51241C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A2620644
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919063;
	bh=0CRSbPVHSTBZ/tLKfwVcY83xksxgRDA92AhKSmHzAGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1uOabGGXNhXsoAoFbCLaf/MewwppyXbgn+fUXBF3Gpbd75M6Rl6oYj9jGpTYrQvhM
	 Sjh4uisyEo+LZOty3c8WE7bDEeoCioJidEfLgY6hOp8/bIUEEFkw9bMoqFLS6uMTLn
	 Fvh79Xbl+ODF/7IcAepix3N3v9AcXB01KtLW9MNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfEOLRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730686AbfEOLRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:17:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5172F20644;
        Wed, 15 May 2019 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919058;
        bh=0CRSbPVHSTBZ/tLKfwVcY83xksxgRDA92AhKSmHzAGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTEtgz6VKVhzjHjiiiLXeQTPls56E+CN+OdemNm2H69RNvJsLPWCFmH24VmXWg0Yd
         +ConjWWbCJapFRa1pvvqTASftza+lZ+RBioJEAV1kW63JstztGXwodQUwSAbEr2Ay9
         L46yIKQKJQT/9uOrspoP+BLl5DKitmrjHPYqY0DA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 049/115] media: cec: integrate cec_validate_phys_addr() in cec-api.c
Date:   Wed, 15 May 2019 12:55:29 +0200
Message-Id: <20190515090703.160609815@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e81bff39489a06384822bb38ce7a59f9e365bbe9 ]

The cec_phys_addr_validate() function will be moved to V4L2,
so use a simplified variant of that function in cec-api.c.
cec now no longer calls cec_phys_addr_validate() and it can
be safely moved to V4L2.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.17 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/cec/cec-api.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/cec/cec-api.c b/drivers/media/cec/cec-api.c
index a079f7fe018c4..21a5f45e0259e 100644
--- a/drivers/media/cec/cec-api.c
+++ b/drivers/media/cec/cec-api.c
@@ -113,6 +113,23 @@ static long cec_adap_g_phys_addr(struct cec_adapter *adap,
 	return 0;
 }
 
+static int cec_validate_phys_addr(u16 phys_addr)
+{
+	int i;
+
+	if (phys_addr == CEC_PHYS_ADDR_INVALID)
+		return 0;
+	for (i = 0; i < 16; i += 4)
+		if (phys_addr & (0xf << i))
+			break;
+	if (i == 16)
+		return 0;
+	for (i += 4; i < 16; i += 4)
+		if ((phys_addr & (0xf << i)) == 0)
+			return -EINVAL;
+	return 0;
+}
+
 static long cec_adap_s_phys_addr(struct cec_adapter *adap, struct cec_fh *fh,
 				 bool block, __u16 __user *parg)
 {
@@ -124,7 +141,7 @@ static long cec_adap_s_phys_addr(struct cec_adapter *adap, struct cec_fh *fh,
 	if (copy_from_user(&phys_addr, parg, sizeof(phys_addr)))
 		return -EFAULT;
 
-	err = cec_phys_addr_validate(phys_addr, NULL, NULL);
+	err = cec_validate_phys_addr(phys_addr);
 	if (err)
 		return err;
 	mutex_lock(&adap->lock);
-- 
2.20.1



