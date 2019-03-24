Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251DBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5EE20870
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KLVoSo0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfCXW6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:58:03 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:40394 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbfCXW6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:58:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B7535C77
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 22:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O0tK4NVSm4wH for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 17:58:01 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 8E7A4BFA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 17:58:01 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id i1so6567009ioq.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N5Xc0X8190RthhFnvPTImsEVQQ4kjWId+VrRLGu7m+k=;
        b=KLVoSo0qZNoLy5LsFtKe2UJTWfhfNLIcVB6fwC1Jt7IWvj4hUHeO01QJVYbz37iaks
         UdxEqPpZ+gIYXl4SC8MnWBJRkmEXJkncIAE/kwZRWW8v9mv8U9DI2cE0j2q3Sq6s7edc
         +bfZYPvDoH3+ZI1bEQ2GxCaol/qWnfDArZBk9cAFW4Y7ae1YUBF5O7BFi03TDkDRbOvl
         dZ42yZcEK7hgpzycPgP3Q3CphihNsCcbQ3RSAF24upqe6LxtZCKmpXMqs4M6+Y/YavBi
         XTv66MsMnV4JJ0ZHMKSNZDbu8SEEqN22uWV5qJ7Ucw99TjTmWWqBBiPWMkuwvhiuejCS
         DBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N5Xc0X8190RthhFnvPTImsEVQQ4kjWId+VrRLGu7m+k=;
        b=pO+8XqIaUOdFSeC5DXlTOGy5ctIy2cLTQj7gS4z7wK7w1YvGbAMG/pab4pEM5g0sYW
         fBJMqr77HhyG47dy6OE4gv9L1dwo/cu6jVMzcAQJD6gnztqiukU4ZymhWiW/pOVubELm
         qeYVw6A3ctByMa1xo5wEk2C/egCnDgj1jxh9MX7eB6H2UWcyaEPWm+XCC4yfKVtIzxjn
         +F7G7cYx84MYA5lTWD9ZmYPo8yiOMfALVBWCMlHzDjc4YxAMFEZyhvgd89p8y6vf0OPL
         G8BUd60xHzVAsBi1n1iKOunReqvF8EA5T1jL2cMN05Bq+lgJthAr3gsnLNkPGMt1lAPJ
         bMJg==
X-Gm-Message-State: APjAAAX3djfkbd2w7P1T9n7LCVyvxCC5isaFfJup6btt7SndS8+G5v7E
        wiE1KeXNoQDqculArKg26Teu354bKEppHOgzCnbsVK6hCRpyc72xJD64z2iL2heusyDbwFWA2fc
        hOMgty+tGQG0/5WAYuEfQwq+XZVMw
X-Received: by 2002:a5e:aa07:: with SMTP id s7mr14068334ioe.139.1553468281235;
        Sun, 24 Mar 2019 15:58:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTa3c7ighqF5HZSchRcfjFTiy1hnLJxjqBrzQN5jFrEzZ2xwmaH4VfW2t9YYl4V5rX2+3NpA==
X-Received: by 2002:a5e:aa07:: with SMTP id s7mr14068322ioe.139.1553468281069;
        Sun, 24 Mar 2019 15:58:01 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id b102sm4766058itd.13.2019.03.24.15.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 15:58:00 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Varsha Rao <rvarsha016@gmail.com>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Banman <abanman@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform: uv: fix missing checks for kcalloc
Date:   Sun, 24 Mar 2019 17:57:53 -0500
Message-Id: <20190324225755.1702-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kcalloc fails, the patch return an error to avoid
potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 arch/x86/platform/uv/tlb_uv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 2c53b0f19329..1ac777f14846 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2140,7 +2140,13 @@ static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 		timeout_us = calculate_destination_timeout();
 
 	uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
+	if (!uvhub_descs)
+		return 1;
 	uvhub_mask = kzalloc((nuvhubs+7)/8, GFP_KERNEL);
+	if (!uvhub_mask) {
+		kfree(uvhub_descs);
+		return 1;
+	}
 
 	if (get_cpu_topology(base_part_pnode, uvhub_descs, uvhub_mask))
 		goto fail;
-- 
2.17.1

