Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB21C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6C620665
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="a+ZyqbSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbfHAPYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:24:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46655 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfHAPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:24:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so70566204qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O8sp7Ivz1alrz3xXygPalicyjdu3OPu+GkykS7h2DZg=;
        b=a+ZyqbSBLkROpB7/yFWxbV2nj0nJ9hDxmgh4mRALQnnKBGnNtH8T0nQUrv8UkRBg/i
         4WX88zAuhNmFQq77+4y9mbgKsQZx5e9p3+RTf3BDWqFUkEYmwTQiOs5gYkKye9q+UvGm
         rrW5X8jWdRpvHieYaQYWoZO7jd7RenFKNBqyDhphJmxbDqSMnHn0S9ugABAV4ojKAMrt
         WMN9dfleQMPrUVx/sM+TkzfX29W6VxjDfELNF5QfxwUOSuvm2EHT5TT4TGH3P1ovyQfC
         Tun6cAtooJ8I/i3nI/74KesTqVzHXq8LFMEI+AszpJeoxYJQBZnZJq8ze4JJS7mFJy2d
         N/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O8sp7Ivz1alrz3xXygPalicyjdu3OPu+GkykS7h2DZg=;
        b=EdflShActSuoOYT/YFxibhk6SDQaU1ZLnWeVSTfoCy8Fqdxk+6IhaJFPUfrfymUJYV
         t4rqrFk+IS/I2O/FKvYQ2XVou7SZkDib5HV5901cSTj3o1FAdWgBLGpYX9VidG4jib6C
         1a+0TLrQvTkq2J2kBeRn8nqJVVSUrg+wy5UZAHDmfOE+1MaZnykQWJ2MtRnMmcqK7w5k
         ba17a66sRK4DXqZr7hC8GN/pXzPSzUCsNUMkn1cM5JFlcNIABW15KhjNuSgZZ4B79Xm0
         f4kjlgRhw6bnlYsgDFVkwnInurlDnhPUlFFDUNEac3J3Lp65lg9CvKNed4IAg2gSN6WG
         x5Fw==
X-Gm-Message-State: APjAAAUP8FCVUJ7vMnP8EK06WTIA5wZIItONyoBkYroQxI5W3HtQ4XzU
        qYuXySHUtDx8hvNek5jRmkI=
X-Google-Smtp-Source: APXvYqwsbycuknfqaOcSU+c+nk0JiA4YbLBMUrdb658pVMpdB83rdKhorAeSqVY6ZrvSIKM3oMvfcA==
X-Received: by 2002:aed:355d:: with SMTP id b29mr90861643qte.12.1564673083294;
        Thu, 01 Aug 2019 08:24:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o5sm30899952qkf.10.2019.08.01.08.24.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:24:42 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v1 1/8] kexec: quiet down kexec reboot
Date:   Thu,  1 Aug 2019 11:24:32 -0400
Message-Id: <20190801152439.11363-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801152439.11363-1-pasha.tatashin@soleen.com>
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
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

