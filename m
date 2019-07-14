Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D5FC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAE820838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563099557;
	bh=o5IIZ/FYrkzFekL/G1RMqeaFDKCLS/wA0Uu2e/UwTAc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=G+ZR20VDTaEx4UUKT/oMA3xjE6pqDZhs9ICIUb0gN4YsCli9FoxPFEq3LuKRQ38WO
	 b8d9w2zvNOwVAJDcK8ipw45+HGrOUs/Vo4wocD2TnGeGI49y9xjjIIVV9l7X4sSwJl
	 Ne1kp6mKpL3/wCX9UgcpkZ7rhxHUn+MjjONw/Svk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfGNKTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 06:19:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35213 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfGNKTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 06:19:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so12446405wmg.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6SJe8uGiYtvGTq42kO0HZ2Qh1Mq+kTLFVlkYxWv0M/Y=;
        b=O7c5GEMEbYAf2Se0F4BWN8DfzDbtyW6tWbna2d7u4zW7YCywYEMbGg3+A/S1M9IGHJ
         zv/NE03fc8fxAqgTI5d2serE5T3SrK2KLO9TkqeGZEYaqG68DyaQcBMyuTEW78GTxYHs
         lK/i1sa9q/1STdDQcYaiWzbh/Zfcf667HX6hzaHx9fH/gqqIGAYsBZhmnt2EMlpWrHFM
         ZTusQrpRIIGC/5tlpJJATIrgFCMkPOxpKLCxeavBtpfjKTAZ7uM8P+zaF0iPLNpY/yvn
         D+tKhm/o/d+L6PrziTzQrSXv5ttaLJZCl7RsoHhh2mbjRD9tT+ZRdizUytPGRtisqVvs
         k1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6SJe8uGiYtvGTq42kO0HZ2Qh1Mq+kTLFVlkYxWv0M/Y=;
        b=mMGRlcRPexperADeQKckEFxUTM7re6radmrhpuQl3K8xnaNjF9OmLMYw28YD4iyjAa
         vB14XqZAYVbfxBmUdq1Ij8H6/PsIxhaUNL7zaRr2Gz59iquBZYSQWUfHYHdlIaC8fBpV
         EYMWj+pZoYzknzfirPtnL8NKhERLSfqBjOXvgQXaQTD+ht09/NPgI0+gWTzGi0HUU4nY
         P2I0zpicidYwohoaLFMDOcO58EOOQAiPkTHE7riAhkD4DK3dqvcPStd2NRFU4hEQ9YTH
         Iv/T/LxtQ/QYWs9JoLRbLsmDuyDV9PpGOFwlqM/XqWentehuJx5vrxyDwGVpTk/G7Oh0
         ivRA==
X-Gm-Message-State: APjAAAXD28BOmsLR1iPvhoAC3JaXDw/rxuPLuHwj+LpXedoH+VBD/dDw
        8Rc42SbVPKvlZpB8JxX+WhhO6mK4
X-Google-Smtp-Source: APXvYqzyUgquqWtPgYAm4v0q06GUxF/3EXM36oI+chU2HWyvfg3MEWyMY/eCGB0itBmnpjpCVq3DMg==
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr18922607wmd.131.1563099553569;
        Sun, 14 Jul 2019 03:19:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k17sm11927238wrq.83.2019.07.14.03.19.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 03:19:12 -0700 (PDT)
Date:   Sun, 14 Jul 2019 12:19:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20190714101910.GA127043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: e3d85487fba42206024bc3ed32e4b581c7cb46db sched/core: Fix preempt warning in ttwu

Fix a sched statistics related bug that would trigger a kernel warning on 
certain configs.

 Thanks,

	Ingo

------------------>
Peter Zijlstra (1):
      sched/core: Fix preempt warning in ttwu


 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa43ce3962e7..2b037f195473 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2399,6 +2399,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	unsigned long flags;
 	int cpu, success = 0;
 
+	preempt_disable();
 	if (p == current) {
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
@@ -2412,7 +2413,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
 		if (!(p->state & state))
-			return false;
+			goto out;
 
 		success = 1;
 		cpu = task_cpu(p);
@@ -2526,6 +2527,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 out:
 	if (success)
 		ttwu_stat(p, cpu, wake_flags);
+	preempt_enable();
 
 	return success;
 }
