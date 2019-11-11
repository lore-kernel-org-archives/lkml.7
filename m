Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD3EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4527021E6F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cnwcd4DR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfKKTdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:33:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44854 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfKKTdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:33:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 053DA20B4908;
        Mon, 11 Nov 2019 11:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 053DA20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573500790;
        bh=ePsjQTqjabrtYSzuz3htfRqLy4c1Eqq3aG19Es0tUO0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Cnwcd4DR0Xzj2Wx9JWSq8u6Rw98rxRpzP4lNuxvQsy/4RgDfJMJK2yRPqXGs+U/Gl
         3zx7k/FqCrc5zfS3lA9G5XiG+4MGqi0o055vOMU/Upq1+kkozpymdl5pC5yf1esz+t
         X3RQC8b56SvdK48gFSxc2XA/pAHpQxk0iSxZk1OI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/10] IMA: Added a flag to determine whether IMA hook can process the key now or has to queue for processing later
Date:   Mon, 11 Nov 2019 11:33:01 -0800
Message-Id: <20191111193303.12781-9-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keys should be processed only if custom IMA policies have been
applied. Prior to that the keys should be queued for processing later.

This patch defines a flag namely ima_process_keys_for_measurement
to check if the key should be processed immediately or should be queued.

ima_policy_flag cannot be relied upon because ima_policy_flag will
be set to 0 when either IMA is not initialized or the IMA policy
itself is empty.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 7d6603bfcc06..61c42d06a636 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -15,6 +15,8 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
+bool ima_process_keys_for_measurement;
+
 /**
  * ima_post_key_create_or_update - measure asymmetric keys
  * @keyring: keyring to which the key is linked to
-- 
2.17.1

