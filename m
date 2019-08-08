Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F8C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4F208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfHHNwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:52:18 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45658 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732882AbfHHNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:52:18 -0400
Received: from mr4.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78DqHRt030506
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 09:52:17 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78DqCVi017146
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 09:52:17 -0400
Received: by mail-qt1-f200.google.com with SMTP id k31so85705092qte.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=OqAhJ2Qmga3FQYOdb27zJlOLn7eKSMa4CuCLVRDTvUg=;
        b=CltQeeFskd/zRAfAD+cPWoNy08TwdBSJxurElo+/5NjN/vn0nG0zORDlvglJQP8tVO
         eJQG+1D64x8C8OB3BOt1igh5LsLIum/etfd23Ra9Yjt8aOy6VeeNlQh9atGvao5d/S/H
         5Q3yajlM5ZG3bJgVKCXj4MCPUi2Ba6xeDu5NJ5+zvPqFEIYpupDa+k8UpXjRuenoIvou
         KIpzU05Z2+oAMXSb4XQoeZgC9i76lU0qJ4psGJTBTGUzSVRFwgSM+fQDhVsDRbLPBRCM
         bKc0sN0HoCkqgC+Y0ikrIVVeI+m4lEhAtqtdpamqvNnL8Z2kYmPKEkXYxjPdlHEqPHlw
         bD5Q==
X-Gm-Message-State: APjAAAWK7gVGD4a6VD6EwVVd3Y1HLGF2P//rgZkgadZdtvMcYNvv/3Nb
        VZKhsHdj8eII7h9uK5v5EMzAx+w/E1ghughhQwOhq1REuOW3DkBknSe8PIKC1b8CJcDXOPj6iF7
        70Q84xfrtuMes94rWwymTouLZKP6FrRBfJCc=
X-Received: by 2002:a37:4f4d:: with SMTP id d74mr1809604qkb.177.1565272331925;
        Thu, 08 Aug 2019 06:52:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwqtP09dfMCfdlIIMABIhRjWlpqxDkI38wUWMAolZrN5WGeShJCO7Krvwi6Kvi/ScQG0OCvnQ==
X-Received: by 2002:a37:4f4d:: with SMTP id d74mr1809572qkb.177.1565272331628;
        Thu, 08 Aug 2019 06:52:11 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id v84sm41752501qkb.0.2019.08.08.06.52.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:52:10 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 08 Aug 2019 09:52:09 -0400
Message-ID: <79734.1565272329@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when building with W=1:

  CC      arch/x86/kernel/cpu/umwait.o
arch/x86/kernel/cpu/umwait.c: In function 'umwait_init':
arch/x86/kernel/cpu/umwait.c:183:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
  183 |  int ret;
      |      ^~~

And indeed, we don't do anything with it, so clean it  up.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 6a204e7336c1..3d1d3952774a 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -180,12 +180,11 @@ static struct attribute_group umwait_attr_group = {
 static int __init umwait_init(void)
 {
 	struct device *dev;
-	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_WAITPKG))
 		return -ENODEV;
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "umwait:online",
 				umwait_cpu_online, NULL);
 
 	register_syscore_ops(&umwait_syscore_ops);

