Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF7CC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759F62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XSW61kWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfGISUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:20:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38088 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfGISUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:20:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so22598849qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O8sp7Ivz1alrz3xXygPalicyjdu3OPu+GkykS7h2DZg=;
        b=XSW61kWTCXRdscVw0OH+r9e4vwdXvYbKjBz6k2VZ4GjxPw4990pNb4BAwrNmmRtsKa
         WtJJtAVYm0yQyc0gT9qSB2/HJ82+H/MyS3XC9ctMBPbmW7oIgk6eANZnGVKs2HBNiQ31
         /bHZn6IWmWrVDAl4L6vMC+WdnQz/McJp0xLy9cq1x0N7urntIF/8qUhPuZMeitTr6tYj
         seq7y1K4rV+ZnPT/cE9I0rwd7rtanJ3jIDMOql2+Ikg4jcapC2ZEhDEL5dbgh2nC9Yd7
         7VxNW+sDRKWTWxuTciOBY6N/SjEJM6T2DfzfKRi5ZSX4eCt/ImtICLCJ7wV7q6H4hJ/t
         hxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8sp7Ivz1alrz3xXygPalicyjdu3OPu+GkykS7h2DZg=;
        b=hNtlWOSSIuFGuIiyp4y5XE6ikKM9SWqdFouMtHGy2AkwqtJoyvOBhjK1CoDDN5mSmp
         lP000sPH1gxSrSBH/JR9GfecmGsmY6ljaCvF/b6NMhuhIpd04JDWQYKDghNVo0vCotKs
         PxAcMdMnC+wVA+4TDeUIyB8UeysXebBlqxm3OABMaA6A/CVs3AMcHP2pjZxPR6AIwtBv
         3Vvo3XN+RQTo9UrVV27hu7SjxXdJ+zCntI+HYE1UTyQK5V+4scAroRbie/S3g7KGIhJZ
         N8EWVSbe/vkYMQ8Ktd35it9jPbujuCHp4bNCMXOaQYnO0QUnATJS5QO7wjwMm9+FIH3B
         F2CQ==
X-Gm-Message-State: APjAAAVj8075ULG1mqzVq2XDFMA6CwjPRU8a8Mp9XjGMQj8bz8YKyMkU
        uZVMRT/iDEi+oZq9FOZGtljzGw==
X-Google-Smtp-Source: APXvYqwK3sHb+R0eRvj6/WADS1T4iF+JrbGV2Q7udh84kzeXGKKiVV5f5NzGnIT7DBMyye2cxX8F5w==
X-Received: by 2002:ac8:4758:: with SMTP id k24mr19729228qtp.20.1562696417894;
        Tue, 09 Jul 2019 11:20:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id k123sm9113056qkf.13.2019.07.09.11.20.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:20:17 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2 1/5] kexec: quiet down kexec reboot
Date:   Tue,  9 Jul 2019 14:20:10 -0400
Message-Id: <20190709182014.16052-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a regular kexec command sequence and output:
=====
$ kexec --reuse-cmdline -i --load Image
$ kexec -e
[  161.342002] kexec_core: Starting new kernel

Welcome to Buildroot
buildroot login:
=====

Even when "quiet" kernel parameter is specified, "kexec_core: Starting
new kernel" is printed.

This message has  KERN_EMERG level, but there is no emergency, it is a
normal kexec operation, so quiet it down to appropriate KERN_NOTICE.

Machines that have slow console baud rate benefit from less output.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Simon Horman <horms@verge.net.au>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d5870723b8ad..2c5b72863b7b 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1169,7 +1169,7 @@ int kernel_kexec(void)
 		 * CPU hotplug again; so re-enable it here.
 		 */
 		cpu_hotplug_enable();
-		pr_emerg("Starting new kernel\n");
+		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
 
-- 
2.22.0

