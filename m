Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC843C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA19520578
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XYH6+dMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEBTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:42:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:42:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so3205949edq.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoRE5RxGdcJ/j2NKUSmbpYt6P0xbPbnk+3Byqv7+QCE=;
        b=XYH6+dMNdqqzcAYMbnxGkrrVxDlhk1OGmZTatSGhN2szFWSDJuXFi8HhJewATHybzp
         DmHzlqf/ffCNEz0G/g7pKox3oJRpYqrk09K7Nq0yTJ85nt+cqPDbTmQJ3q9hWqLpVxKA
         h37OdzE0lkbHYKHuFkJgiM+ViKEZ7pcZuVhXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoRE5RxGdcJ/j2NKUSmbpYt6P0xbPbnk+3Byqv7+QCE=;
        b=nOfKVil4Zqdpw+SgtCRuArIDpioVoyrSQKVqlFvOEUdrvqQu595gjyLsVjmmUDDtZL
         SQrLSqr1G2NBFLGq8E5TR7U/d6psbDRSEuA3lMAKweJCC4zGYaNQ8v31qcHFxrc5Gngb
         gwgI7VbldKw8+A4arE38tNnqmYyiqr/INAAPPDHIci//Bka6e9F3vWsFp22scMajgNZa
         d6VLYt+yxlljN9MK26eob9mTuoojdmfDNaCYbMq25Ukg+lF319Bt/yrIDiFkvjXzLA3F
         ipqazjHmuWsa68SNRH1itq6RAZ5nHhWfipxTyaXIJWDrak7tJCTyhsNbMzt/ApuZWY4T
         TnPg==
X-Gm-Message-State: APjAAAW5RczzFbZNJe9mQtsYKeb95cXbOdcUap28CueinLdF6Hi01/EV
        FbPxR9KOhC8v5V9pmHJ9JWxh9Q==
X-Google-Smtp-Source: APXvYqy073gm6HmHNVt7tAJ8sLeJMv/VRSw6Vi3mMyoIOXfdo8zGvj1YxQ0GRzDYDsb79wMgoSh6gw==
X-Received: by 2002:a17:906:6446:: with SMTP id l6mr2758312ejn.30.1556826137644;
        Thu, 02 May 2019 12:42:17 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l43sm718924eda.70.2019.05.02.12.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 12:42:16 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Don Zickus <dzickus@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH 2/2] RFC: soft/hardlookup: taint kernel
Date:   Thu,  2 May 2019 21:42:08 +0200
Message-Id: <20190502194208.3535-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
References: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's the soft/hardlookup_panic sysctls, but that's a bit an extreme
measure. As a fallback taint at least the machine.

Our CI uses this to decide when a reboot is necessary, plus to figure
out whether the kernel is still happy.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sinan Kaya <okaya@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 kernel/watchdog.c     | 2 ++
 kernel/watchdog_hld.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 6a5787233113..de7a60503517 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -469,6 +469,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
+		else
+			add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 		__this_cpu_write(soft_watchdog_warn, true);
 	} else
 		__this_cpu_write(soft_watchdog_warn, false);
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..cce46cf75d76 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -154,6 +154,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
+		else
+			add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
 
 		__this_cpu_write(hard_watchdog_warn, true);
 		return;
-- 
2.20.1

