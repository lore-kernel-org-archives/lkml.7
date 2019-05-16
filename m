Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E307C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E540D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEPQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:17:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32945 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfEPQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:17:32 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 15D88A774FA91AD2A6E8;
        Thu, 16 May 2019 17:17:31 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.36) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 16 May 2019 17:17:21 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/4] evm: check hash algorithm passed to init_desc()
Date:   Thu, 16 May 2019 18:12:54 +0200
Message-ID: <20190516161257.6640-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents memory access beyond the evm_tfm array by checking the
validity of the index (hash algorithm) passed to init_desc(). The hash
algorithm can be arbitrarily set if the security.ima xattr type is not
EVM_XATTR_HMAC.

Fixes: 5feeb61183dde ("evm: Allow non-SHA1 digital signatures")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Cc: stable@vger.kernel.org
---
 security/integrity/evm/evm_crypto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index e11564eb645b..82a38e801ee4 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -89,6 +89,9 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
 		tfm = &hmac_tfm;
 		algo = evm_hmac;
 	} else {
+		if (hash_algo >= HASH_ALGO__LAST)
+			return ERR_PTR(-EINVAL);
+
 		tfm = &evm_tfm[hash_algo];
 		algo = hash_algo_name[hash_algo];
 	}
-- 
2.17.1

