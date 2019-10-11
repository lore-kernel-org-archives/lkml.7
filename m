Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11496C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9CF214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ojryX8Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfJKBYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:24:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38654 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfJKBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:24:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so8527632wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHSEhkeZHrF4YnSZBbhjOsPK+/ZOK5PIZldKE1yA3yU=;
        b=ojryX8Tmedwh13u7x6kVjloRS4/c5+zsU/uoxh9RMb5T1eHmaPX0A871xdwpXVMMwh
         kJugIEClpXmF7C+te52g44e97ouqdy9BiImAz2UT1bLch0uuBTk1iN/L/ZTK3cv+46KG
         UnQ9bSSCOxxB0TISAQCoL23zOLgjQXjeXRR3UP+FIQ6R65TUyvV/9MjDqgLC4ENwLr2A
         b0dCU61xgTLHOKXsxraOJD1+t8d3U4kJbdWOrC4VB16hBs1VLebA7583zNDhmcZIVbxd
         uFtKg8l58+eMfdZRXDSsmxL+gFZ0voA2ONabt1vu/zEkBZoVm0pTMqqQx8qceH2nwAfg
         sD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHSEhkeZHrF4YnSZBbhjOsPK+/ZOK5PIZldKE1yA3yU=;
        b=ix6kKwzCt0/HVTJuBqNVCeCscqaDjmojnIr4IQ5RwxpAp/UI5SPfcgCA/fXcro/dSF
         WWpxRZP6Hk5wzAQLVJ3TxtCGYwXZLL2MKtv7v1Px6nyNhuwFtyMiAREMyx9egts+4Gso
         EVa3cHDbqsKb388PUpHdYZqyl0Qz2uOB9fEVBJ8B4qr45YXsz3Rqh1mA1Ve9rRRt6Zi3
         rkY6YHm+28yAokmaSqxQ6d9uiMPI+WbrPaQ3y8NEhOjlBF43eVW2v3eTujfa6Q1pguxV
         Px2bEULtBixR/dUb/SPx5PmUYXuNpN9iwyC4AGsMbNh7HU4frXcGbudF37vWjoDHyFt9
         mKLw==
X-Gm-Message-State: APjAAAUFAxfZTOYbM6IxmZU4q2ob+4pTaUXruMLWW0Fx209IMlkMGAsI
        hKH+aVR3PI6srwz9bZsLTAPDxMn8A0I=
X-Google-Smtp-Source: APXvYqxWJi7fDJSE2gWmNMxPyQep3RDnWZ63fbIYeaBrueIf47smyXLukgcK2ZwNPOOh+XHJuLZP9w==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr954428wme.152.1570757044887;
        Thu, 10 Oct 2019 18:24:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:04 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
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
Subject: [PATCHv7 13/33] alarmtimer: Make nanosleep time namespace aware
Date:   Fri, 11 Oct 2019 02:23:21 +0100
Message-Id: <20191011012341.846266-14-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

clock_nanosleep() accepts absolute values of expiration time when
TIMER_ABSTIME flag is set. This absolute value is inside the task's
time namespace, and has to be converted to the host's time.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index c326427bb4cb..353e46f9acc2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -838,6 +838,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
-- 
2.23.0

