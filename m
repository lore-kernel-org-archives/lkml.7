Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B44621721
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 02:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfGCC5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:57:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbfGCC5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 22:57:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01DDCA6008E8F9D1AD22;
        Wed,  3 Jul 2019 10:48:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 3 Jul 2019 10:48:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Thiago Jung Bauermann" <bauerman@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Eric Biggers" <ebiggers@google.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] integrity: Remove set but not used variable 'acl'
Date:   Wed, 3 Jul 2019 02:55:18 +0000
Message-ID: <20190703025518.6379-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

security/integrity/digsig.c: In function 'integrity_init_keyring':
security/integrity/digsig.c:99:18: warning:
 variable 'acl' set but not used [-Wunused-but-set-variable]

It seems 'acl' is needed in __integrity_init_keyring

Fixes: 6100ac53909d ("keys: Replace uid/gid/perm permissions checking with an ACL")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 security/integrity/digsig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 1f2c43f62047..f9f3c8ffe786 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -114,7 +114,7 @@ int __init integrity_init_keyring(const unsigned int id)
 	acl = &internal_writable_keyring_acl;
 
 out:
-	return __integrity_init_keyring(id, &internal_keyring_acl, restriction);
+	return __integrity_init_keyring(id, acl, restriction);
 }
 
 static int __init integrity_add_key(const unsigned int id, const void *data,



