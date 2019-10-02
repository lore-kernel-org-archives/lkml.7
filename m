Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BDC4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B74020679
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570053973;
	bh=RmgX8aL9vo8pxfI5Hp4MluZDmjBsRMT9siVEl8JNJQQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IjxXpMizhTCCfxDf/BoXZG2IMZh/LUp+z9H0W+GyW75LVnW1chGsMF4HvkFL2H07q
	 gOCGI7jMPjBDXb14/f+nWiNwgFYGf2XZ1ywhNHqlSsWK0S3aicwsOgZKwHWh5+8dq3
	 UylS/Fbmx6CTqXNBJUY3YkvijrNM/G4l2Hu7UEak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfJBWGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:06:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34557 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:06:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so714945wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v9iuptnnUOlfZIKtoRVol0WLFbhWhAfQcHLiRlGRpj8=;
        b=LU61PCOfi0shoHgFTjV82V5wg35oPjeLifLaBsYOpIakHdfUR3AQvXgPieKRgbNj2Z
         SGxIOFXqFhW5jmhOatV8vCYuvWq0s1Zoc6a1sVT0lBokoi3Y0a0vZrl4sONdlhkFAOAZ
         8N57k/vfkvGkBoMx9GN74vlbHYccO5wH8wHtJ7j4V8GdC1LS58vkFXejs6RtXgPpHApz
         FD9iXoefC1FSsPwzaKMrCOtrUcF4CfyeP32q2ppBD0mJgGh4UQGEiwVESZ6je6kr976H
         mVp3KNssAhkVVQJK0HkAlERoTgUGt9E+Ov4NwzRaix/cp9O4rRnIVrgPG7bMGmOiweqm
         Q53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=v9iuptnnUOlfZIKtoRVol0WLFbhWhAfQcHLiRlGRpj8=;
        b=fWoQPnsG3pjAE/cIEUdPD60FCIvW2NCUGr4Vzs5bVPxeSg4vT3GKNHdFYypl4cLmdS
         tzPkpI/ak2SMFr+hq1os8buAv9ksgG5qLflB0C6KqWY9x6anJFpf092iP8MTccQRAa1f
         H6305CMw0XK90C3PjNFwRnjfE2FA8pG1xMEq71Xqrrh2W7rZoruMxXo2D612Qsgl1zkf
         a7ZTf0d3xszRqi3zTg3RgF0SBswAVPlbEBILhx4mtveCiy00ByPkL9NSW13e9rPAAPiF
         M/SqwJZU/RqVas1TbZSBu1dHAJUuNPl1IqGTVwMyMob7/QJp1OIeVPIl4HgxJCOFx9ab
         ZieA==
X-Gm-Message-State: APjAAAXaINABINlhw7Y/OqzspmmYozO+UzmUJ2W7xzidT8P0LEDIdXJw
        8wLR75gtrwPwTjEwoxIQOQHyL7+N
X-Google-Smtp-Source: APXvYqyePkXDJ+O0IyJwjoek1SnQrX1NMnqSvdnVQIf0VoUOqd8qwAuTfKugWhqRdcKv1qa88muj1g==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr4406403wru.63.1570053969940;
        Wed, 02 Oct 2019 15:06:09 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y13sm1238644wrg.8.2019.10.02.15.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 15:06:09 -0700 (PDT)
Date:   Thu, 3 Oct 2019 00:06:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20191002220607.GA50607@gmail.com>
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

   # HEAD: b9023b91dd020ad7e093baa5122b6968c48cc9e0 tick: broadcast-hrtimer: Fix a race in bc_set_next

Fix a broadcast-timer handling race that can result in spuriously and 
indefinitely delayed hrtimers and even RCU stalls if the system is 
otherwise quiet.

 Thanks,

	Ingo

------------------>
Balasubramani Vivekanandan (1):
      tick: broadcast-hrtimer: Fix a race in bc_set_next


 kernel/time/tick-broadcast-hrtimer.c | 62 +++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/kernel/time/tick-broadcast-hrtimer.c b/kernel/time/tick-broadcast-hrtimer.c
index c1f5bb590b5e..b5a65e212df2 100644
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -42,39 +42,39 @@ static int bc_shutdown(struct clock_event_device *evt)
  */
 static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 {
-	int bc_moved;
 	/*
-	 * We try to cancel the timer first. If the callback is on
-	 * flight on some other cpu then we let it handle it. If we
-	 * were able to cancel the timer nothing can rearm it as we
-	 * own broadcast_lock.
+	 * This is called either from enter/exit idle code or from the
+	 * broadcast handler. In all cases tick_broadcast_lock is held.
 	 *
-	 * However we can also be called from the event handler of
-	 * ce_broadcast_hrtimer itself when it expires. We cannot
-	 * restart the timer because we are in the callback, but we
-	 * can set the expiry time and let the callback return
-	 * HRTIMER_RESTART.
+	 * hrtimer_cancel() cannot be called here neither from the
+	 * broadcast handler nor from the enter/exit idle code. The idle
+	 * code can run into the problem described in bc_shutdown() and the
+	 * broadcast handler cannot wait for itself to complete for obvious
+	 * reasons.
 	 *
-	 * Since we are in the idle loop at this point and because
-	 * hrtimer_{start/cancel} functions call into tracing,
-	 * calls to these functions must be bound within RCU_NONIDLE.
+	 * Each caller tries to arm the hrtimer on its own CPU, but if the
+	 * hrtimer callbback function is currently running, then
+	 * hrtimer_start() cannot move it and the timer stays on the CPU on
+	 * which it is assigned at the moment.
+	 *
+	 * As this can be called from idle code, the hrtimer_start()
+	 * invocation has to be wrapped with RCU_NONIDLE() as
+	 * hrtimer_start() can call into tracing.
 	 */
-	RCU_NONIDLE(
-		{
-			bc_moved = hrtimer_try_to_cancel(&bctimer) >= 0;
-			if (bc_moved) {
-				hrtimer_start(&bctimer, expires,
-					      HRTIMER_MODE_ABS_PINNED_HARD);
-			}
-		}
-	);
-
-	if (bc_moved) {
-		/* Bind the "device" to the cpu */
-		bc->bound_on = smp_processor_id();
-	} else if (bc->bound_on == smp_processor_id()) {
-		hrtimer_set_expires(&bctimer, expires);
-	}
+	RCU_NONIDLE( {
+		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
+		/*
+		 * The core tick broadcast mode expects bc->bound_on to be set
+		 * correctly to prevent a CPU which has the broadcast hrtimer
+		 * armed from going deep idle.
+		 *
+		 * As tick_broadcast_lock is held, nothing can change the cpu
+		 * base which was just established in hrtimer_start() above. So
+		 * the below access is safe even without holding the hrtimer
+		 * base lock.
+		 */
+		bc->bound_on = bctimer.base->cpu_base->cpu;
+	} );
 	return 0;
 }
 
@@ -100,10 +100,6 @@ static enum hrtimer_restart bc_handler(struct hrtimer *t)
 {
 	ce_broadcast_hrtimer.event_handler(&ce_broadcast_hrtimer);
 
-	if (clockevent_state_oneshot(&ce_broadcast_hrtimer))
-		if (ce_broadcast_hrtimer.next_event != KTIME_MAX)
-			return HRTIMER_RESTART;
-
 	return HRTIMER_NORESTART;
 }
 
