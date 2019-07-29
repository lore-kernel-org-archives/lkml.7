Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC31C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4B720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DZBkV0+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfG2V7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:59:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36873 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730491AbfG2V7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:59:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so38384419wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=DZBkV0+s+TtseOsPpPa66AkmOte80A27CebUVQt23cgBLUj7apYI4zrxp0Sbug2gif
         //MRIfm5sL0j/FVbTC7rbgIa4R5I0+HRzrGzxh+DlbxNmUchfE60lw4t6gqEGnqcVc4R
         4LUf3FsO7RlZaLTJvl77VMV9P3+NiVy/1IRwfv+YobIhNuD+B+AeoAv0G3sYLaWu153g
         dbu+oVWssTYH9Riqhgwyg0U2jc4jNf5hapgaMVGBT7AU1HLrm0Ataq7zxDKyGh00YXw0
         LkJ5P5Top9pCmw7+MGyB9RqocGV5mVG3bayONdLdgFvKwx8+IIIcFBkKdGxtJ27DXiDp
         9xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=O8ZivOtD8MpblDw2SFG++6BRhyp8Vutv45Tk3LkUccQfnP3Ix9BJu5gF4S8tnxKiEv
         XYQUEse3rlvG1tjI9wLEEFyxSKwx53ewujR+3iN9ROl5fm26MARMaEEiOuNN86j5b9B1
         84UX1B3aOb131AZQ6bgOAz9mL7guQxY+gHgrUoXUl1CrAKE7JN1cPBJ76bUT55IBfRyB
         NZsZzJadMQaLhk+52FpWvomih+J7PdHYccPo9CCCmQYXuThHgBiOkP1RMiGDiq15PcQS
         HiA0I1dEe+8gDHgP6yUW+8pOuvjrIPUsjZYInhw8BErDVeHP4cRW5bJYso9v06VKpPgg
         NrFA==
X-Gm-Message-State: APjAAAUOU3+8s4JoxgUrYdTYRagev6mHeiy2rof84xiPsMmq6yeqMQyd
        WJTloHEbT5qqFGvCgOaQ2ULoWU3nU3jZ0JTeUP/P9hSOAqgpNzIVz9Kv8dVEDpX6lwZbyxrwlnZ
        b07Icl1e9VAkyZRSI2FItMkGgUFpZI0Ayei8niWfETF4CL3BmL4eO4toArHYCAy4jwFeXK+q60J
        pnBT/o7WniBGzzoTau70kM+Zb6Dpm70AGV/+tKw/A=
X-Google-Smtp-Source: APXvYqxP9V4UaBxfz++Yj6H9Zuz5qnwSOuUggElyn8aw0CKHIw611jJNheWFqH4OjW0SEHoD8FiQIw==
X-Received: by 2002:adf:cf02:: with SMTP id o2mr103004551wrj.352.1564437544418;
        Mon, 29 Jul 2019 14:59:04 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:03 -0700 (PDT)
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
Subject: [PATCHv5 08/37] posix-timers: Use clock_get_ktime() in common_timer_get()
Date:   Mon, 29 Jul 2019 22:57:28 +0100
Message-Id: <20190729215758.28405-47-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Now, when the clock_get_ktime() callback exists, the suboptimal
timespec64-based conversion can be removed from common_timer_get().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index fb1848c84241..aae7ab53790d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -666,7 +666,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 	const struct k_clock *kc = timr->kclock;
 	ktime_t now, remaining, iv;
-	struct timespec64 ts64;
 	bool sig_none;
 
 	sig_none = timr->it_sigev_notify == SIGEV_NONE;
@@ -684,12 +683,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 			return;
 	}
 
-	/*
-	 * The timespec64 based conversion is suboptimal, but it's not
-	 * worth to implement yet another callback.
-	 */
-	kc->clock_get_timespec(timr->it_clock, &ts64);
-	now = timespec64_to_ktime(ts64);
+	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer move the
-- 
2.22.0

