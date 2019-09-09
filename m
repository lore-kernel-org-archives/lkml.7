Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72203C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4925D21D79
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GJFu06c6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405417AbfIISMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:12:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35155 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfIISM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so17312866qth.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KZlSM1+HYlx5AabYJySSHWoh4S6JQNg+E/eloF1WuIo=;
        b=GJFu06c6b4ZEhDQxac7Ve4vAwFHNQhisIoJMubb/W8uwe/MrKpZAsrxNQcd4Jt7g5J
         e4MiEhIHIZFc0CSkOjzAFJt5WxtVG7fjoQzEZfBjGiK4PnOzAQqYggmgip0rS3UjFkby
         IEn2kXuW+ZA/7BhqbRDUv0NteV9mBcLQei1106HP4bWY/NH2IzNUdo8DGHHYDUfIiLFz
         8gRB2ZS9V/MExaDThngqFosNAd/W335oiclHxgCS64sgHqkapgnUdv1u/sH0MsWHKKTe
         cC+q7016fokkyS14WHlyKW1VcDfYEHq13tZzXK/nNPIn+Cz4yS65A1M2qPE1C3bOZZf1
         4gFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZlSM1+HYlx5AabYJySSHWoh4S6JQNg+E/eloF1WuIo=;
        b=dSJUutfTUpakgMKIc4YPO4oKCVaqsREIAX7mWrDV1yGUsMH/olb+/Hb9zz8zQhpMen
         8DvCcISQhrAe0T7oTBFUhc7Py13eI+gAiLLw5IB7ICBm962L8E7ZDBCdKKOfSeOxEj+k
         0AsUu4oMvR7GG4cY5Ur6Phfi/g0YQBssBJSWIQsz08Z1avkKXUaYc351kSbvu73oe/xU
         +49/8uLP9mAV5hOPtM5TVuwXIRbeG4/+b4lDVw+hWOjAshrscjnD5QsRtJSSgbkWbwof
         sj9uKxu6oZgVjJwo8OUon58EI4k+AOA2RE+i07+JUj471FWlhUnMU51RXT3jJD8zsM9g
         VyBg==
X-Gm-Message-State: APjAAAURo4bBWYgMhzoOuz38PuFkyjH+0m7z1tZBVpRr9RD3tK2YvKB1
        8r9kChWRvvf8xGYBVmkjgKRoQA==
X-Google-Smtp-Source: APXvYqwsApv+H9SarYLtc162JJu+MtiHP3Mrfk3gX2yiHqY711FHTOWynPIJ6PSuaanROg7YMihraA==
X-Received: by 2002:a0c:c15d:: with SMTP id i29mr15399213qvh.5.1568052745416;
        Mon, 09 Sep 2019 11:12:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:24 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 01/17] kexec: quiet down kexec reboot
Date:   Mon,  9 Sep 2019 14:12:05 -0400
Message-Id: <20190909181221.309510-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
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

