Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6B2C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD8B218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpi16Um+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGCQ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:26:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38026 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfGCQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:26:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so1531452pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3g1NPTpHubI6UBPHHSrwuj9B0Mvaq5SdPi446COAutU=;
        b=Lpi16Um+2HDw6EpOFzaDh/ha6DuFnuLiVnpC8jYCkBevu+vjkQmNLCCJ8/V8DQmPGp
         Yt2mlOjTTDjFZ6UjUlpchFY4NnB3yYafzbQbeFYPTvpQZUX9iNggf8uyIRWFiv83jal1
         LuvL4576Ej8K7yjZ5CW/5iobwwU4BVbBRfPOTvpMFzvQbhYxoyQRIneVyFjGxKgmUKiR
         lRH9Dardl2+lQGPfYEpg32k3GrHeFcSi1YanaSzTChwzWXIifwq2VV8tvUz0cVIzHnHW
         C69abrB+WXiJi0YZMOy+jYF6Bqn6OBbVJEq71kdA+7G3Ksw2OGiOA3Iwik0HyR9B/qLD
         Lcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3g1NPTpHubI6UBPHHSrwuj9B0Mvaq5SdPi446COAutU=;
        b=X1GH/79MtpBaPILRdL3lRH06+kn6/HUYNL/maYVoUrvsVkAqmMxNQOMEGtZFBiFPZ4
         2lKvIKUqBeUNHXNIxVcCeYzoSIPsTODlPFTCHmVcjoQ5qTcgbgfMTf1Cf+bH7ft6ZVhS
         Ey0I3WVY5AYZMXTJUESx+qlWVRV6byMHeT7FbV8nwVOPjrnS0uaz/O+1blw0Ua74zsYD
         2UGr3tcpVHKb9bTtzgrCweOs4HZHJkRXKLgzslJpKUrYeCLY/njVUI4FUSWUuAt8569c
         TvYyAIDnGNrBQLGxRIyBbOYKdN1YCnKXTyzNIF/2mFAbnAhfL5Fo5jWGK3wWvCzL7CpM
         JFRw==
X-Gm-Message-State: APjAAAWOnl5Nr8FNysY/HKtH23Jv0vV0voOWN73iSEBKjx2PPL9ojDfe
        aQvB8Bg1IowSZk48ZoIF+cX/ZNGpQCg=
X-Google-Smtp-Source: APXvYqwW9eDsp+QIoqr176fiv+07AjcIW+bAxLt0Lkz5UIac14TsIJnr4/CokE6zq7nSHAMynY800w==
X-Received: by 2002:a63:1f1f:: with SMTP id f31mr8416587pgf.353.1562171202147;
        Wed, 03 Jul 2019 09:26:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id e11sm6585890pfm.35.2019.07.03.09.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:26:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 02/35] powerpc: Add an allocation failure check
Date:   Thu,  4 Jul 2019 00:26:34 +0800
Message-Id: <20190703162634.31953-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an allocation failure check.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Split into two patches

 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 437a74173db2..7488e40f5e47 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -385,6 +385,8 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog)
 
 	hp_errlog_copy = kmalloc(sizeof(struct pseries_hp_errorlog),
 				 GFP_KERNEL);
+	if (!hp_errlog_copy)
+	      return;
 	memcpy(hp_errlog_copy, hp_errlog, sizeof(struct pseries_hp_errorlog));
 
 	work = kmalloc(sizeof(struct pseries_hp_work), GFP_KERNEL);
-- 
2.11.0

