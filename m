Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AEEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3267020850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555074566;
	bh=gWtMKwpfxvNP8OUloBTzYW/sU8I8z24kwa/AYQaP9Js=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=LNBmdinq4Nv/EGe8llt8HlzKQ2H/FkFdR4l5t+zbAHfmGvL22erZT6sKTAzZWI8WW
	 p/xr9ZzliWDWd1Cxu2kuNzgghG+8YwBo8+W0rq/IPQ4oDgdpL6GtlOHGy4pAnFNBGk
	 t3l7lW1MxGPAM+xoApfujIDaKwJI1YruBvfv2tNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfDLNJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:09:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52138 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfDLNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:09:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so11171844wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Tr0Bzh8nCG1Azw8FHoM3PVuFJuATU6IBqKGmgowsUtM=;
        b=cizIEBbKhV38ryZTRUGOYObJaQKdhIfKP6TSfP0M/Fdt16H4lTO8inq4T8SmOFCWaL
         4V7z2MXkUrxOdaSzL4D5Jf9F5dkP3uIquF/+nsYp7tv1B4zigBpAykBWli4ro1a0yU3t
         t4Vd0LZUSP+qwAd1GDuZlgZEAsPU594TiLzUCUP9JSzCRfcQmrNkUbCgLzm3HCtqxicl
         dcpismfqJebPxrvJdPZuQiXRIoM5v1qc3RqlMlG/FK8uXKKe1uPZusbVcmaaHK4VYnRg
         tC6nwbHbKp+91UqDLfjHPhHgRtOvwM9SEwaPyVnGRaIh+4/AVRWC1d1XEP2+AOE//8C4
         Afrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Tr0Bzh8nCG1Azw8FHoM3PVuFJuATU6IBqKGmgowsUtM=;
        b=m7L3wCrHoAiy6rfbTwi+H5nWF2DEsPaeU+ABlGow5ZPv+tVNvW1fhwB2SMO0ekrrKx
         fKNHZ8Baw5VMF45djCeOyAJ52QsjeaskoDtMV/frHvsNQhDqhSwG/vSsTdBwKoA1Otks
         LA4A9Qhc6LExeFiubGaMyju5OBmBUva/TwbgULJ3VHqvOQQdXqi1B4SiO6Hz8XCij90E
         iIUU2xkyLNqDg44wuZ94A1xySxyIAXC5li78J4hArzjMt7MN+FIOIwSCouJ7dShOy5sx
         8qQFlJODUfsjIRpe4hS3AQmpNIxT2ge7kfqxmINq1/nuKlWkSI/suVucPnqBNMbERk74
         xbTg==
X-Gm-Message-State: APjAAAX7vzQOLbitRWQwxL3uF15CbAXiEKhZgk4g/eLsJ6CMP7Qg89WO
        hYy6S2XzcN9k1gF+SIGCUMleIk0u
X-Google-Smtp-Source: APXvYqyYgDtHezcNonl38437b5/AhkFxp0Q+GgFcY645n/kWJ04/m5A9ByxsDuDhVy0nVkKRr0tpPg==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr11434994wmj.121.1555074562384;
        Fri, 12 Apr 2019 06:09:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v14sm51922624wrr.20.2019.04.12.06.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 06:09:21 -0700 (PDT)
Date:   Fri, 12 Apr 2019 15:09:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20190412130919.GA23112@gmail.com>
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

   # HEAD: 07d7e12091f4ab869cc6a4bb276399057e73b0b3 alarmtimer: Return correct remaining time

Fix the alarm_timer_remaining() return value.

 Thanks,

	Ingo

------------------>
Andrei Vagin (1):
      alarmtimer: Return correct remaining time


 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 2c97e8c2d29f..0519a8805aab 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -594,7 +594,7 @@ static ktime_t alarm_timer_remaining(struct k_itimer *timr, ktime_t now)
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
 
-	return ktime_sub(now, alarm->node.expires);
+	return ktime_sub(alarm->node.expires, now);
 }
 
 /**
