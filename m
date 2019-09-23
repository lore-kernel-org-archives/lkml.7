Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA0C11FF5
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8EC20673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="g7DE7rX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502669AbfIWUel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:34:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45932 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502656AbfIWUek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:34:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so9809188pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KZlSM1+HYlx5AabYJySSHWoh4S6JQNg+E/eloF1WuIo=;
        b=g7DE7rX2uCp8tfoUWCXCLl034/utkvLPBdVIKc8+powWUExFWSItdszP8Cm/yR3bQA
         INyWFFWB57bbdD2iHNW1/fZENA+1VBlqYaMxRwKUwsr13wORyC7Njz/SoqYlIMCXWndy
         +2lPVOCdcRmjy3opEnn14+U9nd/vOCxsE7gGnmOczmK8wF6uSKK9ePWHSOSG4IdNhWL4
         i6B0jQ3c/Hc+3IQ4XVvxJF0T0VSgEARneLSQ8kgrBRVlnEy0OVPrm3FAAWvjOBu96um6
         TJyjAuN1XqnAdwdM/bythEqz6HBUc9ctqw1AsAPVwpa9SaVxY5Z1wKyBAHCKwQ0/s4aD
         R+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZlSM1+HYlx5AabYJySSHWoh4S6JQNg+E/eloF1WuIo=;
        b=oi2oyfjtvl7IbosZUc3m6DhXYwR30N+mjjOup9Lkiw1xW3+088MffC7sUn5r5a6M0x
         Z8l8NifzpljN76XVaoklDcbemc0OIrlVJS1ECL8UfYRaQ+2zai5mgtuc7QvjC3aYnm3w
         SiL86SOAQEE3m14yBW+X5IoxOaqpynaM7twaCU59BP8Wd58+BzxdFuZNnfpqaR+yAIiM
         SheSvoLl2Bs6DU5OMXMocYwncHB1yyf5ogqrSLcsUScJCR/9brdVGxbQNglL32u2kunP
         20Rrcl3YyfcZgi5apimRBmBsCE5A6wiyfRkYGniyIm6c5GU4T5xTPBBx3nMw2KGqCXgr
         AX1A==
X-Gm-Message-State: APjAAAVn7cesNV75+KOHR6dFgeNqF7nnm9Pnbv/WtmipMKoet98U7RpN
        gkDCaGzUPhRwOYt2RGTYZ7Atnw==
X-Google-Smtp-Source: APXvYqy145da1OUiQVlRDiBy/OIzvCU32t+7Zhz/DSbXEWYlU+3nmVsNL564Bq6FlkTk3IW8uBpmsA==
X-Received: by 2002:a63:c947:: with SMTP id y7mr1755459pgg.345.1569270879589;
        Mon, 23 Sep 2019 13:34:39 -0700 (PDT)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n29sm12798676pgm.4.2019.09.23.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:34:38 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v5 01/17] kexec: quiet down kexec reboot
Date:   Mon, 23 Sep 2019 16:34:11 -0400
Message-Id: <20190923203427.294286-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923203427.294286-1-pasha.tatashin@soleen.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
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

