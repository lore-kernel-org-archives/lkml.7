Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C1AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4382215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aFtV8t1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfFLT0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:26:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37938 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfFLT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so7690087wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rK/lNTew08hzz7HVO7HvkTGvRJb6fOU+pbsMF8QlYRY=;
        b=aFtV8t1b278IHm3Tle4YnOGl7ZnK+s1pPy/zaNTpl/YFd+aL6V1fYPPIyDUVhWY926
         4ksmAVHcMULbDG00EA3OWsI2r6GnIPIsrNBZtQMauBSeHdm9lGomOuHjQTja9q+4zxMM
         iHhS2KQcTy75D9DPSp/E354oiiAPJADqm8D5x8NrRHmGKGmJLtJ92U80BkWc8dfYFZIv
         9G9YeMXBTcwNOwr9rGVMO489UssFOusGfOvD6CJzGMl5WJk52RC1FHcuHvgYsO+jCnuB
         HnxJjsRiXRVERfxu+EosyhbRZyBw9UAaJDNQwAIry2AORYsKXdq47vc0P06BWmqP6h0q
         IlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rK/lNTew08hzz7HVO7HvkTGvRJb6fOU+pbsMF8QlYRY=;
        b=K9Ctd3V79IQikI6sEk6qki7hBM5Pm/vZpOPLJdb67y0EBWNA7l9YcMSBjktuH/9lV2
         rDOCnHxH7B7CoBrdbUwKO9uCzJyPB/J+KU0NPhgCPsWKQJIoCBRdReql9eAu1PXBT10/
         Sr83IUcGvAsRjxSvEG1WjbDHbbzHTRgMv5rtH93FNODjqCOS5Okvb7m9BhmdapUya59k
         AF1WI6b+9if1SiwutSA2tMBr+6tCDxRZAuHLlg4cjIa2v03zHlnedelqEmPNpOLgHOka
         UN/wMMqB4c7x5v/Fx2gP63QdZKsYMYTd+Etcy281juRdPDzbRswOphWlocj7unbIA/qP
         wu3Q==
X-Gm-Message-State: APjAAAVzi/U7Vzo1/a9GkGTlHKP22HBgh1EZDdT8wIBzMpXGNRFD4Ctc
        nJTBWC1mslWEwJ/lFv89PXpPQxA/jLI=
X-Google-Smtp-Source: APXvYqzMfQUFZfq6v52zu5p5+HWuQccYeU0xiKemwObMzGtIL/qvtSAsDP2TF2j5l7+IuCaOaBCqFg==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192mr531803wmb.152.1560367600141;
        Wed, 12 Jun 2019 12:26:40 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:39 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 07/28] posix-timers/timens: Take into account clock offsets
Date:   Wed, 12 Jun 2019 20:26:06 +0100
Message-Id: <20190612192628.23797-8-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire timer_settime() syscall into time namespace virtualization.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 573942ae2629..dba77ee48e74 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -857,6 +857,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-- 
2.22.0

