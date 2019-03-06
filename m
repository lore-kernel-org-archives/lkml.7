Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2131C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E7220684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A++qss5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfCFQYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:24:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38251 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCFQYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:24:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so9001860pfn.5;
        Wed, 06 Mar 2019 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MyKFLm/2BLCCaWU/sf05G8Kv9a8Xcxs8ZJNQvaRnlms=;
        b=A++qss5pqEThQlV+6J7ytLezYboL201/vR42H12GfLpI/ywasP0G3o+X7RHf1AeC+y
         5RVaETFPqgTODv8B1ilt3oxGaGtDsLBf0c43EjTIb38xYrwdr5UDmkP9BZvW0CxKG9eD
         CP29VOidScszO9IYMRIB0T1UyFbpoFYM4Ry8IozavEMKEckEYSUIvKpPIcqUSaEy0uNC
         p2ObzLGTR5u1mfn9o6XtSImqp0uWAu2Bz/CtxuV9sLTEVSaaK7CrkGc8DPqOx5+eUY8j
         sdMG3WkDZmHM+4LhkLeTY0h1cJ2X81BMfG5MNOtsAC8nQ1ut9Jf9BxwzhWS8Qs9XTvUO
         9ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MyKFLm/2BLCCaWU/sf05G8Kv9a8Xcxs8ZJNQvaRnlms=;
        b=mrgiruWzhHZm1P2ffgFR4vIRU6V624+EftRS/lsCs2IA/z9BLWKnybBh8QgFyzytIH
         P9DVBFcE0MUqOn5WgdcnLLiNCeUK54TtxYw9mxNVwQQatUo1rPm1Y8MMyf4RfiLqHKkk
         naEeFwrdGP1BRD0+h1ULH6sLYPjFh4WnAi2JRY9mqQ4pJjU72iOvZWtFq2EI+xfE82T9
         h/J0Q+4hStCcelqDvsjvenj9DhouBFx2hmDRJ4iH9vBjzieRhcUWLjCf+xMU+og8B8Pq
         z5/XXcY5Y95quHVTM7xEA5vfsCQ5CTpwiDhNVRWVtnCgbyZFHwDGCXMJ3IzvAHXA0Ock
         XgZQ==
X-Gm-Message-State: APjAAAXn2CYlFRyO+neU2u6A1T7iv94UMylQ8xBUO8m58ygiDamQvVoC
        RMoceeC5VY2m4k9y0TNdCNk4QoWv
X-Google-Smtp-Source: APXvYqxsHFBTB9Q03jIgpwpOYZABStgvyW5aLFePCouIcm7fDDSS5cB0Ke2wn0MYsxkXvHPDo1EDOw==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr7611988plr.97.1551889476375;
        Wed, 06 Mar 2019 08:24:36 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.50.195])
        by smtp.gmail.com with ESMTPSA id k3sm7270828pfc.59.2019.03.06.08.24.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Mar 2019 08:24:35 -0800 (PST)
Date:   Wed, 6 Mar 2019 21:59:04 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     shuah@kernel.org
Cc:     sabyasachi.linux@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftest/x86/mpx-dig.c: Remove duplicate header
Message-ID: <20190306162904.GA3277@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Corrected format

 tools/testing/selftests/x86/mpx-dig.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/x86/mpx-dig.c b/tools/testing/selftests/x86/mpx-dig.c
index c13607e..880fbf6 100644
--- a/tools/testing/selftests/x86/mpx-dig.c
+++ b/tools/testing/selftests/x86/mpx-dig.c
@@ -8,9 +8,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
-- 
1.9.1

