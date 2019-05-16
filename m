Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E915C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD41206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558022972;
	bh=/jeEdhqq4/af+gMjDmWJh7vuXi4a38JsUBKz4GpDhAY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lQNkgM1bR7A7gXbdSPHulpK32cqGL4T7BuXAUn9tbx9k0T8DPQQmXxS6i3clJ4fO4
	 wsnvk6ks+GyaNbtJmCtfFAHWxkh0lfBd+HonDhif2sQGs+UaB2FOz1Y0KUKPzXLCKJ
	 oLm1ZID061QWUSp9lv98juiTmj/UGk0kbDzOMhb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfEPQJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:09:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55741 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEPQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:09:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so4212522wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eSAuT4yWDGwd60DxlAYtEEKGYksK3LIfdzrbrsSiK7U=;
        b=DZQPhQichGv6w0zvYNtUgA2mnIl1GWVrH44VOX1xLZ+Dtm7XKvUHhHOCAxwrdSvXVk
         FjQhR5wr/puQHHethqwpv3ZK166Zr0R04KYRctffMYX0uAfS7PpTEv1sZdVTwXO65p1Z
         02w3jFgJgOJcU8ssHs+BijB7snmPlAO2+ZCVoithIcYhVC6drHaSQQS0IW9N/A6dEDxw
         Ssr1ty65nfTgkN5prIym04CYOwxzYNsbo8HFRsISM2K9nOJOacjKyZe6fM1d1uP6W8bQ
         OIxvZjo9C0zg6lQCUaGvMJ5F3gtLA6Ez9uAM+OGz6x7vwvXqRFHB7UFF0gzNKWfBGSb4
         yF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=eSAuT4yWDGwd60DxlAYtEEKGYksK3LIfdzrbrsSiK7U=;
        b=HPxO8ihSX1WcsJH+7XLmr4tLucRpgHu8iEyBzWGLAEP00ORuOWtIkXT/rjL+bM0Z9R
         InnVtVeKGv952dfDCslKxttZjED5geroDX5gUO9DnWZoeVeNMtf26iGD2lkE+7N/CuE1
         HzoYenUWbsCyABy6JRpeIePuxrphVgHwNr0LLoCAlEK0xHQL1TIiyJExR+zl4cIUz01f
         LhokNySRap8rqwbNlj3zX83WeM7xeUVUfXvrsDR0uEr0EF1dHfi+YlytSzFk7KLoXpd2
         1h2INf4MyOetNsbyZsF+s0mfeKxbdI6GyPp2/JH/Myv37Ddb6Hv916do6tT+5Xj7Yrkx
         r4Zw==
X-Gm-Message-State: APjAAAW10KLuQDkbmFHoo9e3gyAcSMUlZtl40wJQI/U9qCyBcm1PXGUt
        JHM1YOPwznoCBuiikiQsaOaUhWrv
X-Google-Smtp-Source: APXvYqwm2Mq9BU0nCLDrPA38f/q0iRvzk10yQJ59EGK4WfbxH8LZXl0Yn6y4frMiTNBiHY3Sj8xVSw==
X-Received: by 2002:a1c:8004:: with SMTP id b4mr27336809wmd.79.1558022968781;
        Thu, 16 May 2019 09:09:28 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x6sm7905180wru.36.2019.05.16.09.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:09:27 -0700 (PDT)
Date:   Thu, 16 May 2019 18:09:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fixes
Message-ID: <20190516160925.GA97788@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: fdc6bae940ee9eb869e493990540098b8c0fd6ab ntp: Allow TAI-UTC offset to be set to zero

A TIA adjtimex interface extension, and a POSIX compliance ABI fix for 
timespec64 users.

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      y2038: Make CONFIG_64BIT_TIME unconditional

Miroslav Lichvar (1):
      ntp: Allow TAI-UTC offset to be set to zero


 arch/Kconfig      | 2 +-
 kernel/time/ntp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 33687dddd86a..9092e0ffe4d3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -764,7 +764,7 @@ config COMPAT_OLD_SIGACTION
 	bool
 
 config 64BIT_TIME
-	def_bool ARCH_HAS_64BIT_TIME
+	def_bool y
 	help
 	  This should be selected by all architectures that need to support
 	  new system calls with a 64-bit time_t. This is relevant on all 32-bit
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 92a90014a925..f43d47c8c3b6 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -690,7 +690,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant > 0)
+	if (txc->modes & ADJ_TAI && txc->constant >= 0)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
