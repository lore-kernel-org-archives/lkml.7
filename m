Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4124C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81C5216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="n8BIhwWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405292AbfGHVPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:15:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44122 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405278AbfGHVPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:15:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so15652239qtg.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O8sp7Ivz1alrz3xXygPalicyjdu3OPu+GkykS7h2DZg=;
        b=n8BIhwWJ9zh0jUg2RW2/uYQy7FXCgRGeTdMBO55KXOXgAIespxSPLZq0PYdQHargu4
         8/6ZmX6+n021l86aooEGRSG6OOh9z87P2hsOb//zkA6XSfbnLwX1J6q9EqiRDhiSEkei
         37/LIxbZzFCypM5/mZYla7j/sFWUIrbc8e3qhgO4wFofOmUK0lhXe4tr6tDxWT0nr2tS
         QQ0+d7Qy7D/REmw0t12Dt0EtWx80RzWMBAEUOejhW8CkeW2/+kE8QKMZkyyV8nLai6eQ
         0uWgAgMS4TLYACEQUE8stDXIn7xumtxeI3mjoGdxI0wMvKfmReYsVjRk6sJfFqriuHbY
         Us6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8sp7Ivz1alrz3xXygPalicyjdu3OPu+GkykS7h2DZg=;
        b=AQkDVMoeVRxokIecAwgiMEc7T8SqbBhSakiiVQZ316xdQp7h5V+Kl54DKsSHchcjyE
         HCgBDO65hMet3fbiCvX4dBBAYozGLauXdqQmarsT11TBHb6VpXtSpXkxLlCzg4TP8X/t
         MOF1Q7lJvc+dCjtuBMyPaaKNkObBw75czNB55Jh0KpNUcwOdZbnURtNESl9xaEN85SAV
         klrQOuX3LwAW3IKfKj23BlmFEws02KRvgDlNUJFtHx2+leumF0bxnIQPNKDqDCdXG93j
         e0/OFip07kjLfyEgGmxdh8sBml3Ar8mHfionghyrEcY1mT69mvwD3V5a36KPPf3y8Dhp
         cMPg==
X-Gm-Message-State: APjAAAXkWRd1nzw5hfy7Bik5fRayelhgWDn/fYIdVeyXSgsFfQUvmFf6
        +p+frr4zDPWmQs8knNt9dSi9Mw==
X-Google-Smtp-Source: APXvYqyKqoOHu6EcUgIJIytE2kcvp422ziKgpaW7euQ8lCRv+YnhnmdNGlmL0VXgx8QTvMj1RSZ8nQ==
X-Received: by 2002:a0c:b148:: with SMTP id r8mr16207600qvc.240.1562620532517;
        Mon, 08 Jul 2019 14:15:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id b67sm8335620qkd.82.2019.07.08.14.15.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:15:31 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v1 1/5] kexec: quiet down kexec reboot
Date:   Mon,  8 Jul 2019 17:15:24 -0400
Message-Id: <20190708211528.12392-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708211528.12392-1-pasha.tatashin@soleen.com>
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
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

