Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F231DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E1E233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EAK9aWCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfHUSdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:33:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46497 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbfHUScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id p13so2695853qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KZlSM1+HYlx5AabYJySSHWoh4S6JQNg+E/eloF1WuIo=;
        b=EAK9aWCollpH9xmdUtaiVBS6Ul8Grpce2v4a96pxnxYp2IBX8da/99b/wGOvABGtwu
         YGsbf5Rf/sZVH8SNTtDy0XpnvFV5C9IC9WYVDSpYpMbwVzm7ArMz9PW52kFErZTTXCsL
         WTyBvzhkpiiRAQw8xhZCkbesGdEv3+KaY8OAZ6E7bzieO3RZcGtLLT0Pz48c7wl8J3Zh
         tOImm/Vrp/7Gj+QIPxNlt0oaaMZyfLcgYRPH40jynE+MITM4+xI0XYdvt3v88kfQeRO6
         7KdjAnbtkEeJP3UjA9HD358p6hLYn9PO5svHWmEYjnXYtYqKE97d1nQSshP1W53Wo27L
         IM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZlSM1+HYlx5AabYJySSHWoh4S6JQNg+E/eloF1WuIo=;
        b=J/Czn4rb+VhESB69NVZqsX52xmjU48d6t9b64RAbpPCsT2w49DuDy/dIazQJ1Iidxx
         94xwtWiXAH/4gLJvSgK08f8N2GIf5vq0niwgCdTy7Cwwp6TzvKui9AD75HMDeixJVKeO
         QTsR/fzHVW60iL28VEwGYzt+AVzFE+DThJuB9DC0zKNeSRj2SrqczNbGzI2NMhO7IY8F
         0AKafAwP2oMxkaHTLcVnEqU+8SzBhKvXzYdJGj+BCSuOJCTQWgWpTQh//xHZyV/+I5Y6
         XIWyn/0b7g3sF8Ss75AfLkOwtlqA8G4+Noma2q/VrKZIsVfgzeu0WMBmUs3gnzNxD+ZK
         3MxQ==
X-Gm-Message-State: APjAAAUVOr5ZSX+Cvmr1sCFEOvmDvHPDX35RmC2YAduCb5kj8ZxFSBlK
        DyPTeNiMKxQt/tLq4W5qM9+ZS0l7WDs=
X-Google-Smtp-Source: APXvYqxa+1nBillHVTD1wUyey0q2i0nGT/ot1gRBODj0C6eDdzfP5MOz2GYbi9GTD87ibQ+3R7pbkA==
X-Received: by 2002:a05:620a:4d4:: with SMTP id 20mr30837041qks.95.1566412327681;
        Wed, 21 Aug 2019 11:32:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:07 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 01/17] kexec: quiet down kexec reboot
Date:   Wed, 21 Aug 2019 14:31:48 -0400
Message-Id: <20190821183204.23576-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
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
2.23.0

