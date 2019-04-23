Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB9C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C59218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OAvmLjbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfDWUl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:41:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43165 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfDWUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:41:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id p19so7153467qkm.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXCOK0+YLB8893v34rc6z+X8llj1wav4kD2YYl4xewQ=;
        b=OAvmLjbR6ThU/uCM7ZuRhoHCgV+i1uyOJW8WjLVzy68xAD5qfSQjMMkBYgh9a6KXZj
         aFiOvXCFIe4ZL8c3AX8Bx5eOLvQjgJrmAl6mVdSrYmMOrC1qYx/BJy+Nryo2QnN1QwZX
         eqfLnn3E/ydcX4qSW1j4MGXI8E0k65lul5My49nRYdhhw+/NkFmn9oqpm8P6XEd2n92z
         spyateWrWWisFNXXGeiBgK0uraUYfZylL24qrlxYJGHIPyjZN9g+Y0x3Eobyfdc7Mvbb
         ioDg6ldywz41I86b9I7Mp0bk2c+N2WT8jKQ5AWAr2tNblLw1fpuIlUcLIIj39fmxtWeZ
         eKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXCOK0+YLB8893v34rc6z+X8llj1wav4kD2YYl4xewQ=;
        b=mBgnNyfuZv1eOxfnqitkdE6z1SzfAW+PHdqgAW/wJVGEjlyARS+bB9fmZCRGg6LXrl
         sbHfBFa+RaS2aDhuqochChKWokqyniepGX4v9bGrJCkAS7hvjXVHQ3ErfmaAvJ+aCaWM
         B1uUriay3N9SFl/eDRZBwohQxuyn5GgR4r2fTyhAfNasseq7WNSxrfS9pgvkIcV23bhU
         k0gM8Fny6114qI+G65Ryeuqw+IJGK817y8x67WDw2PebuDYDeOJBCCdzEGSTJNewFRpd
         S5ewqZhs7YUJ71Xte1KI6S6O0acbvL8q/MakzB+otx7slVyx71vW8O88XuXiOh1lD0E6
         bg2g==
X-Gm-Message-State: APjAAAXUn3qzLi0FnzijmTN1jEt0P2NRQKsIed2nwlp/fr72j4ZjoQkz
        mLk2NS7qQquv8wjff1HebnXa3g==
X-Google-Smtp-Source: APXvYqztca1CAhv3yKFxu+FzB1M5akGvt/AqEi9o55LwvVgdzNEHVb/0ByzHvk316IoM8m6O3G4PvQ==
X-Received: by 2002:a37:4948:: with SMTP id w69mr22013599qka.122.1556052116143;
        Tue, 23 Apr 2019 13:41:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m189sm9220549qkf.2.2019.04.23.13.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:41:55 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: quiet down kexec reboot
Date:   Tue, 23 Apr 2019 16:41:54 -0400
Message-Id: <20190423204154.3085-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
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

This message has  KERN_EMERG level, but there is no emergency, it is
a normal kexec operation, so quiet it down to appropriate KERN_NOTICE.

Machines that have slow console baud rate benefit from less output.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d7140447be75..fe13e86984ec 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1171,7 +1171,7 @@ int kernel_kexec(void)
 		 * CPU hotplug again; so re-enable it here.
 		 */
 		cpu_hotplug_enable();
-		pr_emerg("Starting new kernel\n");
+		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
 
-- 
2.21.0

