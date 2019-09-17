Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB8CC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3868D21E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404062AbfIQHS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:18:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44648 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbfIQHS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:18:57 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iA7lI-0000Pt-10
        for linux-kernel@vger.kernel.org; Tue, 17 Sep 2019 07:18:56 +0000
Received: by mail-wr1-f72.google.com with SMTP id w8so960884wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8HovDR5WHRAd4Op80qPws3Nnj2bhSDO25JV1CPB1Zk=;
        b=kTD1ERog8yBS2B8Cm8sMkvbXslA6PnARdBYlA5l8/YCSCs+rRDO1sMJIdMpfyymL/0
         c8zeQUa8oJzhzl+u+WIzXVr6m+zFGF25zbKnGbzoGX6LPIh6xeVNiaFwYR/0olVmSG7n
         8JWtJ+qcmQ+rb3uZIfVIp0sAphFcS/QhoT9+P/oxytlZhIQ06SuQPU6QPnNaTlCRpFid
         EsmCyj/WlIpf+UiWQyO4GXgiwYurU7uI/fze9Sk4RolI30N9WvYbRe444r9I1hV1tkAd
         QOiAQUFku9Z1L+YunCAOcvbFKOR1WXGvNCv21fQXDvzentNQcqG4WfUo0MKwei0K4dRH
         eaWw==
X-Gm-Message-State: APjAAAVll7t0di4khT65+HQNETo67ZKyUTMAR40KXIWDDpdPVoAlVmO3
        vRD2RpIRjULlrHoC8QYPk+8CPrvVhMrBQ587wwiTnsEW7vr9Pgd9GitowuqV12PigHdI/Eu3A7R
        x8tVDaW4cK6ebVwZXQBnDeNL1kq82lO1zLhdQk+3zvA==
X-Received: by 2002:adf:f303:: with SMTP id i3mr1804362wro.242.1568704735426;
        Tue, 17 Sep 2019 00:18:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGMCgVONsFMew/xjBJLNSLcgNn1GslBv0KaaX3RNQKrKX9IhD90tI5zVWcG1JzN1cmeivXAQ==
X-Received: by 2002:adf:f303:: with SMTP id i3mr1804347wro.242.1568704735207;
        Tue, 17 Sep 2019 00:18:55 -0700 (PDT)
Received: from localhost (static-dcd-cqq-121001.business.bouyguestelecom.com. [212.194.121.1])
        by smtp.gmail.com with ESMTPSA id u68sm1950780wmu.12.2019.09.17.00.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:18:54 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Add __ASSEMBLY__ guards around struct clone_args
Date:   Tue, 17 Sep 2019 09:18:53 +0200
Message-Id: <20190917071853.12385-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of struct clone_args to uapi/linux/sched.h is not
protected by __ASSEMBLY__ guards, causing a FTBFS for glibc on
RISC-V. Add the guards to fix this.

Fixes: 7f192e3cd316 ("fork: add clone3")
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 include/uapi/linux/sched.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index b3105ac1381a..851ff1feadd5 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -33,6 +33,7 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+#ifndef __ASSEMBLY__
 /*
  * Arguments for the clone3 syscall
  */
@@ -46,6 +47,7 @@ struct clone_args {
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
 };
+#endif
 
 /*
  * Scheduling policies
-- 
2.20.1

