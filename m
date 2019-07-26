Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F6C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4D22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148443;
	bh=kNoMF9+Fdf7r8iUMfcif+NeJblciIOS13GV/ZPm1khU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=guQG/Lf4N+MZOmMDg71xlslZy+EG6E0mFYpvIvw8U1BUkYjytmA6ddTeKZfzKN5Z1
	 4UuKNW3WggSqgOWFAR5iW3Zaa15Fp8XiPN+/vvnAtIRazwFirPMEQeXZRr7XI9Khk4
	 P37nbEC7mfF9GVHZ4cYUTqs2yhSMZanvbYhZv+sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfGZNkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387512AbfGZNkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF52322BE8;
        Fri, 26 Jul 2019 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148436;
        bh=kNoMF9+Fdf7r8iUMfcif+NeJblciIOS13GV/ZPm1khU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVv1aSsgRlm00f38XptmrQlIObeQTpfyRTCGagu3JxJiuyanmwHVkhydH1T5rxhSt
         Z1FRm4Xtg0/ULhPyN7lyR8mX12vTdwghXUE6SLUv45jKgyfVumC2ibE5mamQ1Kt4OZ
         AGWJ5p0YPCuoEiQeMQFhS5znGBbtNGTMJ30oVwpI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Block <bblock@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 38/85] scsi: zfcp: fix GCC compiler warning emitted with -Wmaybe-uninitialized
Date:   Fri, 26 Jul 2019 09:38:48 -0400
Message-Id: <20190726133936.11177-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Block <bblock@linux.ibm.com>

[ Upstream commit 484647088826f2f651acbda6bcf9536b8a466703 ]

GCC v9 emits this warning:
      CC      drivers/s390/scsi/zfcp_erp.o
    drivers/s390/scsi/zfcp_erp.c: In function 'zfcp_erp_action_enqueue':
    drivers/s390/scsi/zfcp_erp.c:217:26: warning: 'erp_action' may be used uninitialized in this function [-Wmaybe-uninitialized]
      217 |  struct zfcp_erp_action *erp_action;
          |                          ^~~~~~~~~~

This is a possible false positive case, as also documented in the GCC
documentations:
    https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized

The actual code-sequence is like this:
    Various callers can invoke the function below with the argument "want"
    being one of:
    ZFCP_ERP_ACTION_REOPEN_ADAPTER,
    ZFCP_ERP_ACTION_REOPEN_PORT_FORCED,
    ZFCP_ERP_ACTION_REOPEN_PORT, or
    ZFCP_ERP_ACTION_REOPEN_LUN.

    zfcp_erp_action_enqueue(want, ...)
        ...
        need = zfcp_erp_required_act(want, ...)
            need = want
            ...
            maybe: need = ZFCP_ERP_ACTION_REOPEN_PORT
            maybe: need = ZFCP_ERP_ACTION_REOPEN_ADAPTER
            ...
            return need
        ...
        zfcp_erp_setup_act(need, ...)
            struct zfcp_erp_action *erp_action; // <== line 217
            ...
            switch(need) {
            case ZFCP_ERP_ACTION_REOPEN_LUN:
                    ...
                    erp_action = &zfcp_sdev->erp_action;
                    WARN_ON_ONCE(erp_action->port != port); // <== access
                    ...
                    break;
            case ZFCP_ERP_ACTION_REOPEN_PORT:
            case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
                    ...
                    erp_action = &port->erp_action;
                    WARN_ON_ONCE(erp_action->port != port); // <== access
                    ...
                    break;
            case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
                    ...
                    erp_action = &adapter->erp_action;
                    WARN_ON_ONCE(erp_action->port != NULL); // <== access
                    ...
                    break;
            }
            ...
            WARN_ON_ONCE(erp_action->adapter != adapter); // <== access

When zfcp_erp_setup_act() is called, 'need' will never be anything else
than one of the 4 possible enumeration-names that are used in the
switch-case, and 'erp_action' is initialized for every one of them, before
it is used. Thus the warning is a false positive, as documented.

We introduce the extra if{} in the beginning to create an extra code-flow,
so the compiler can be convinced that the switch-case will never see any
other value.

BUG_ON()/BUG() is intentionally not used to not crash anything, should
this ever happen anyway - right now it's impossible, as argued above; and
it doesn't introduce a 'default:' switch-case to retain warnings should
'enum zfcp_erp_act_type' ever be extended and no explicit case be
introduced. See also v5.0 commit 399b6c8bc9f7 ("scsi: zfcp: drop old
default switch case which might paper over missing case").

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/scsi/zfcp_erp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index e8fc28dba8df..96f0d34e9459 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/kthread.h>
+#include <linux/bug.h>
 #include "zfcp_ext.h"
 #include "zfcp_reqlist.h"
 
@@ -217,6 +218,12 @@ static struct zfcp_erp_action *zfcp_erp_setup_act(enum zfcp_erp_act_type need,
 	struct zfcp_erp_action *erp_action;
 	struct zfcp_scsi_dev *zfcp_sdev;
 
+	if (WARN_ON_ONCE(need != ZFCP_ERP_ACTION_REOPEN_LUN &&
+			 need != ZFCP_ERP_ACTION_REOPEN_PORT &&
+			 need != ZFCP_ERP_ACTION_REOPEN_PORT_FORCED &&
+			 need != ZFCP_ERP_ACTION_REOPEN_ADAPTER))
+		return NULL;
+
 	switch (need) {
 	case ZFCP_ERP_ACTION_REOPEN_LUN:
 		zfcp_sdev = sdev_to_zfcp(sdev);
-- 
2.20.1

