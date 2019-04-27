Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28ECC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B78C2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556375904;
	bh=fw3zKHEMRFtnyQbJ0leI3x5WQww6pJ0AekfxdNElbo8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=y1mo15w6hAEkjhbrTliMHiNbUSAiOoYwIY8uygD4fSJM77GocXZL15FjvIXPZ33By
	 bjQ7TDNoMdgWwTzXyuXZbsTaMbF+js0NQ6LNUlp7hd2fGZ0uPUcAWprv7Cr2JiJ8E6
	 mtL2rr88uH2cikmQScDcaR9b6h0r4GI/pj56ae/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfD0OiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:38:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39244 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0OiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:38:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id a9so8636342wrp.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3e1YCFDK4S2v4YBFuui624C2VR+UWFZfbLDWGlTkkwo=;
        b=mYumviHKCp4sXse9/qWKilWmcXZktQXVux9lQoyCuka+Dc5MsIvGZWC+jURymopQLK
         fAFgvj2X+rU+qnymq8sentlIT7MoGsOBYK1T45oT24E5aNITaPCivtqz+h+MknRfnVOw
         Wliy/ZxNb2m4pibmG+vxTqJDIeKGpHw+rx+ZbaROGQQ+WtXRQeNEPbjbeP+7Rub4ze3f
         HGMAcIY4fVsAl8Tf+8WGjCa05DLALBFNN43ak6Oc6UgJvzJoIW/iatxcK9tKvPtHhdXD
         DHbZtr1JAWOrMZHFqqM1oT+rdkyQDzrD0x89lM7g06JdJfa/WaQRnadoeKQM0xBcAdfx
         cOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3e1YCFDK4S2v4YBFuui624C2VR+UWFZfbLDWGlTkkwo=;
        b=g/IawQtG+0UydD8Vaduhr9K7rM39VsjuZoR6gADi+L8HI5pHk0cJoplb2L5NjPtgG7
         1cwg2QhgHy9Pg9182U6rYoHnpJ5jBcJmeTTVw3T/CRou0H3I3PLBW/QLqUEsYYX8wqBD
         XG0uG5f17ckw7+31SSghJjTcggAhiNN6N7YmPTOuiMxsYUGSZCGNJ/qN3wfkLZB01ryS
         l+uvSM0tXtpQGUeTlH/PLPllCQ7LkcZauWEORWzkJKXNOJIXM42dA9cmvvWknW48SD/Q
         yR0jtI+aF8R1MCAGOwkmVgLUqaVi6qY9dScqVsQi6K/v6AJM9bKykzLBWIkFSdh7qi4Y
         8/BQ==
X-Gm-Message-State: APjAAAWiJOXmspDAZF/iaTtIB8tvQwlKO39XLvVmrCda3oVYSbvxqrRl
        Xfljke9weoLJR87NBuDp+vQ=
X-Google-Smtp-Source: APXvYqzTTWSJZ2ZAbaUuaiKf3lrdwb/MHkyC76prO4pELa2ZBp8im5mUWVYNtEfNWnGtQaxoS3yjFg==
X-Received: by 2002:a5d:4483:: with SMTP id j3mr5106864wrq.145.1556375901299;
        Sat, 27 Apr 2019 07:38:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e6sm9194731wrc.96.2019.04.27.07.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 07:38:20 -0700 (PDT)
Date:   Sat, 27 Apr 2019 16:38:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] perf fix
Message-ID: <20190427143818.GA8253@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 82c99f7a81f28f8c1be5f701c8377d14c4075b10 perf/x86/intel: Update KBL Package C-state events to also include PC8/PC9/PC10 counters

A cstate event enumeration fix for Kaby/Coffee Lake CPUs.

 Thanks,

	Ingo

------------------>
Harry Pan (1):
      perf/x86/intel: Update KBL Package C-state events to also include PC8/PC9/PC10 counters


 arch/x86/events/intel/cstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 94a4b7fc75d0..d41de9af7a39 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -76,15 +76,15 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,CNL
+ *			       Available model: HSW ULT,KBL,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,CNL
+ *			       Available model: HSW ULT,KBL,CNL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
- *			       Available model: HSW ULT,GLM,CNL
+ *			       Available model: HSW ULT,KBL,GLM,CNL
  *			       Scope: Package (physical package)
  *
  */
@@ -566,8 +566,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_DESKTOP, snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X, snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, hswult_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
 
