Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76098C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4001A20733
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 21:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573940341;
	bh=JyAwyJPTPO03aP9dwaHrjssKC9abejQDpjqBtHma5lg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hCRYjC7xy6/qZkQZ0yZfF+pjjSnukHaCGRkgHeaIhVbZImm09zGlqOBzTnupXCXXN
	 688/UrtOrhSHg0qJtA31Ta7NcZGcx8W37DqC3BDI54tCW5TFpwU5//xe1YBn+BFWgI
	 WSKBuDxM87tDcWIB76QlEgYS+Kd6PX55Qgy4RPxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfKPVi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 16:38:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39884 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfKPVi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 16:38:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so14628318wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JzUot8vgSZCfMaJ2DX77MGNIpxRyFjJBs6ItmmuQi5g=;
        b=REcCnG2m26YYddQkTpS+zKoTmCcAMFYLg9/+3PgXmA/FDjR2H60dhDLlofn/d9nfav
         chb2s7Lfa9V1p7bx7g0FcOVdDjCuHOvwiaGe9vnuZTSSWbeaBxlCcO7cUs/Wp5cdQ5hu
         9WEhvcpgvmIqPG0pTj1UYzc7XjgsYjyemK3dtMIWTSYJUY74LHGRwOvVhL3Cj6v5ZahU
         NfSIzZt50lD8Hi4L7vUcWStITrC2T6mRKcfbQAJ/YfAeCfDJtwPdR0dBqOILu3kMhkkM
         hbOZVBhYbd3DtnmBiu67iOmyz1u/t3WKyaTNpWmDIzqW5/8XNgS/EcOvLmGNm2x+QQ7L
         oECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=JzUot8vgSZCfMaJ2DX77MGNIpxRyFjJBs6ItmmuQi5g=;
        b=roZmkSJJcr/2S2JwCux4iKYaR/8Z8+s6K/WpPY0OMe0yz6AaGvd/DR53cNxYXw7/+Z
         X9Sax0kxn96fJpBt5/NwhqDQj9TnVsoV1dUs7SN+Aad5ZMAgz6DhWfj6QJjSnET4owcl
         TQ3Kdoz7JCI6H1kuisUlynvzKSKjwp+b9VfFKLNsMh/UZlVZEDXwzta9hfrpjbumww7h
         tcaeSFjVcHbwLY1BooIM+/zvwCq0Jn/ht5Fd0Ke4NmYxPgoU5dp21mIURhDIP3q34mD5
         XAZ8ICh0+Dumh3EJJC8oXKnCcp7FkfY/208gtnYsy6p2wvAa9hNbo+cpumc7NZ/H9E5c
         mZlA==
X-Gm-Message-State: APjAAAVUuIXvvr2QCRHrIi9WVpNmswvVGtku20tPKlegsROTpzeWj6Ti
        ePUYjAQYITJZ/IzFB5bHCcQ=
X-Google-Smtp-Source: APXvYqztUiT3ciqNH+h4Dbh/bL0PWuOdjo2pGJFl9WIZ9GX4HMpziXL0QOWpd+i95PlyQXEDPcND1g==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr17305451wme.30.1573940336439;
        Sat, 16 Nov 2019 13:38:56 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w19sm14482933wmk.36.2019.11.16.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 13:38:55 -0800 (PST)
Date:   Sat, 16 Nov 2019 22:38:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20191116213854.GA48947@gmail.com>
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

   # HEAD: 2f5841349df281ecf8f81cc82d869b8476f0db0b ntp/y2038: Remove incorrect time_t truncation

Fix integer truncation bug in __do_adjtimex().

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      ntp/y2038: Remove incorrect time_t truncation


 kernel/time/ntp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 65eb796610dc..069ca78fb0bf 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -771,7 +771,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	/* fill PPS status fields */
 	pps_fill_timex(txc);
 
-	txc->time.tv_sec = (time_t)ts->tv_sec;
+	txc->time.tv_sec = ts->tv_sec;
 	txc->time.tv_usec = ts->tv_nsec;
 	if (!(time_status & STA_NANO))
 		txc->time.tv_usec = ts->tv_nsec / NSEC_PER_USEC;
