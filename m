Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B96216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Bzxe9fv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfG2V6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45416 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389201AbfG2V6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so63438796wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=Bzxe9fv+Gz9B6U6SUD29DrXP1PQacwElm6trKex2rmrhyk1ecXwic4zCCCkdnAzAPt
         RijKROc66z96BoZXqqRukc8FohDP7DRbkAkgGcOSCWPMRwWi5CODxc2hciZQxNAByw8v
         JbF7/dC9laMqSlnJChBeNExlDSvj/VJPcC+LF017UUgY16fCbvaPHSH7HV69CPbLZjC7
         Ng6lxt19dY/6UzEdL4UE+OdONBMxN8SFiLhpS69++vrmWmoz/dEog0uddCKVW+3XIH7u
         DnrCaf1A99Xz+36wIhMyqMSbeC4i3g+Ub5Eev8nq3aK21RdkF5huE7347qRtTrOaZriI
         EGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhPhiPaFDmP+L0m96dR9tEY4UhLjSpCkVC6HHYt2zds=;
        b=C4y4tnC2LN/8EFCsicwMHUQPCmWTyq0y0q+0IiT/3XZqpc4RQouCjTIFdXgQNoI0M2
         /KoYW6GkIIZbg1QXKrqQCOBdwGCUs5Du1vVYe0yHltNriRdcO4OASgceShMTWyXi45EV
         2S6h59VM4C9S0C2uTMYqLh210y971LqFlH5d74OhMWEB3kvunGc7i7fFalDLPWxSMmrH
         m1+ZBX79AZ+Ve1XxWNImgVDCeynMmiYYTFfjoKcuwFFFSQZF8VFZ0zy6gpuydPUZn/9w
         xrGEnLVleh+zLYvG3u7hDFKhc+XGOlwrw3Y/OBAjDeP2wVY8Ma5Mx+8rBREANlBzp8cW
         Wb/Q==
X-Gm-Message-State: APjAAAUvktsU17v8F+LxqnErEcwldV77tzbeSTMMX2S8mPUWxs4Eirr2
        eQh/WJ3EVUqbQC9eEYBKJWfEG9/6TY4o5hCvsA2jyeFnAMqOnGLgqMrkfgerHaakAt9Hnq6DWZy
        EN+NoM2Eo8VWYTnA6hsmhz5j60ni0N1SCc42uty/HYXvnYomijLMP4UeDjt+dCy6EoPwQZqHXJ5
        rkaAJ8fpa3N9RlMdoaqzXG046UQsV8r4gJS2qzzCw=
X-Google-Smtp-Source: APXvYqwT7Ntey25cXNcYdTP4MtDlylpRRIJQkyoXQeD7IX6ZyEkezqaNJ64y7V8W26u5fHbiS/ObuQ==
X-Received: by 2002:adf:db46:: with SMTP id f6mr71646636wrj.212.1564437491336;
        Mon, 29 Jul 2019 14:58:11 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:10 -0700 (PDT)
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
Date:   Mon, 29 Jul 2019 22:56:50 +0100
Message-Id: <20190729215758.28405-9-dima@arista.com>
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

