Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4089C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7044206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfHEQs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:48:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728800AbfHEQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:48:27 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D46F277450129614A781;
        Mon,  5 Aug 2019 17:48:25 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.34) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 5 Aug 2019 17:48:18 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <jarkko.sakkinen@linux.intel.com>, <jejb@linux.ibm.com>,
        <zohar@linux.ibm.com>, <jgg@ziepe.ca>, <tyhicks@canonical.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <crazyt2019+lml@gmail.com>, <nayna@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3] KEYS: trusted: allow module init if TPM is inactive or deactivated
Date:   Mon, 5 Aug 2019 18:44:27 +0200
Message-ID: <20190805164427.17408-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize w/o a
TPM") allows the trusted module to be loaded even if a TPM is not found, to
avoid module dependency problems.

However, trusted module initialization can still fail if the TPM is
inactive or deactivated. tpm_get_random() returns an error.

This patch removes the call to tpm_get_random() and instead extends the PCR
specified by the user with zeros. The security of this alternative is
equivalent to the previous one, as either option prevents with a PCR update
unsealing and misuse of sealed data by a user space process.

Even if a PCR is extended with zeros, instead of random data, it is still
computationally infeasible to find a value as input for a new PCR extend
operation, to obtain again the PCR value that would allow unsealing.

Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/keys/trusted.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index 9a94672e7adc..ade699131065 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -1228,24 +1228,11 @@ static int __init trusted_shash_alloc(void)
 
 static int __init init_digests(void)
 {
-	u8 digest[TPM_MAX_DIGEST_SIZE];
-	int ret;
-	int i;
-
-	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);
-	if (ret < 0)
-		return ret;
-	if (ret < TPM_MAX_DIGEST_SIZE)
-		return -EFAULT;
-
 	digests = kcalloc(chip->nr_allocated_banks, sizeof(*digests),
 			  GFP_KERNEL);
 	if (!digests)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->nr_allocated_banks; i++)
-		memcpy(digests[i].digest, digest, TPM_MAX_DIGEST_SIZE);
-
 	return 0;
 }
 
-- 
2.17.1

