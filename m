Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96716C41514
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9C821743
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 02:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="IzkXm55G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHQCqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 22:46:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45686 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQCqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:46:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id k13so8179453qtm.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/W9Ma+c4Rolhy4bvMsvhnDmmj8s4aI4sxvLahrmQOEs=;
        b=IzkXm55G371ze9WVXoK9zad2ACOWDzvok3ySCIMBFTsFQm/1InDzb4H9PlQDZg3B+1
         91fZTR5nLchedpHW5aMPgbel2ZEnY/4Y6d81TwasXQGUoWl3pwGmSACJDbW/T3nKDssv
         +h3dvvD8iyrRdZCJ9mha5885pBDWmcYAqYgiE1seOv1ZfRELrnfuyWjc6lHkfNkB8ktJ
         OywN1d704ZniaPy18rJWm0ZLYmHEL1f2xGaIMRi+uXWwoVQjHADEaYflSmFqXYFC50TK
         COI8DMNyB3sCcIRHgivG4DS6VQAKx7jm3bktmlgmeRCdmQ4puTVFBSpYFVIiLAL++B8O
         rYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/W9Ma+c4Rolhy4bvMsvhnDmmj8s4aI4sxvLahrmQOEs=;
        b=BpU72+eg9WDef/VThs1NKtKpaSEmPIiRFcD8xOHlLq8z1GJj2qRQ9nLllMreUvFH9X
         u+09uFbHhiKYLxINb874klyGmUAPv0pBuuPIfFHys1j2918cyAkcRWe8iziCgvyiu0Ni
         ndkY8KzhVarcNGGV+x8KJ3NoKOwLklVpMW7hIZMMPkraeAycCO+9cz5w+YplFTDmGYMC
         huGqseIhbS5aHfXgZxv9Kw4cH2JYVt94Y6Sa8YdulR3yUo/8Kbyef/cPf839VfhFQutx
         3C5aDP2dPBpEmAUcE4HcJzVosbukYpx5lTxT8WKKKAy/cwIs7lR4M3emtzO8LHFiIvFm
         e48Q==
X-Gm-Message-State: APjAAAUV22g3PstRrBSXeG/sDlc5UjeHO8G7oKxdGeXpDsFm+yNU/s9q
        3tyi2GrKNNyVPpsJ5rs7DTkxMg==
X-Google-Smtp-Source: APXvYqx1YDVIUM4aXrDf+J+vqbqrtMk2KC2J/YfduCmqN0tJGEM/fwsJ5MGyaogor4fl5Zg9qkbq9Q==
X-Received: by 2002:ac8:23cf:: with SMTP id r15mr10955016qtr.97.1566009992864;
        Fri, 16 Aug 2019 19:46:32 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id o9sm3454657qtr.71.2019.08.16.19.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 19:46:32 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org
Subject: [PATCH v2 01/14] kexec: quiet down kexec reboot
Date:   Fri, 16 Aug 2019 22:46:16 -0400
Message-Id: <20190817024629.26611-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817024629.26611-1-pasha.tatashin@soleen.com>
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
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
2.22.1

