Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FCFC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF8D2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kTVhIKSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfK0B5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:57:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54452 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfK0B5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:57:04 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id DD9E72010BBA;
        Tue, 26 Nov 2019 17:57:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD9E72010BBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574819823;
        bh=Hygomg0IkjBeTUP6XSMjFJvucT6fovHpF5/8RvY72oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTVhIKSDlOcFNc/XBtP9aJ8tCmW3I8IChJt2RT+1KN90MLAgzsHAR7HKowdHi8sqw
         hCP9zg/rl2IWcbGlvdKrFcRTii3XZiz7JRx+VgWC06WeBp5UEQUIkRHsciVHIqHI9V
         Xn7LrrNeffb6hG8zdX2bCVE7EYaUR03JQBHBgReE=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v9 1/6] IMA: Check IMA policy flag
Date:   Tue, 26 Nov 2019 17:56:49 -0800
Message-Id: <20191127015654.3744-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127015654.3744-1-nramas@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return immediately from process_buffer_measurement()
if the IMA policy flag is set to zero. Not doing this
can result in kernel panic when process_buffer_measurement()
is called before IMA is initialized (for instance, when
the IMA hook is called when a key is added to
the .builtin_trusted_keys keyring).

This change adds the check in process_buffer_measurement()
to return immediately if ima_policy_flag is set to zero.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..9b35db2fc777 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -655,6 +655,9 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	if (!ima_policy_flag)
+		return;
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
-- 
2.17.1

