Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C7BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDEC218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCUV1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:27:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43110 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCUV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:27:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so136567wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Rqm7ac/x/Lallc3QWbJp9N4x7jU0ErblacsYj2QBmhI=;
        b=UL9LkoanOsIBJliTIkyhLLRxxnSFvPueBTZMay2ZxiAmMLDJ8LxXm0ZxeM4WtfeFmb
         pNA01aBlttnJijJKTwX84W1e2WWkaUnplm8HGG1RlFSKVvaDR9DV6Lg/lcZqP9c30M/v
         AbLrxR4XO/1WP93FpUCa2Bwr/nJpcLy37O1e9T3plRp8NxIkvaMri4bSDkj6nhYMv+La
         4rQCr+zPXW2uY8Xo0KO5OBbOtMR7EzyZQ8yqMaGWM0AuYp/rDHgiiVDAPtyQf6qVKi3t
         4qcIoAFN3asHODxXq6E3PnHK0t5JjkasTsrtZjhby2IQCwlSLNv8myQnxV/VlVdl3ype
         RmOg==
X-Gm-Message-State: APjAAAW8Q+bhDwfyvYuP5rWAQztUmT+M5JAQmefQJtOAK0eICbU9yVPR
        qt+TRIahTKvBll+x6sNEnWpGYuhfz+U=
X-Google-Smtp-Source: APXvYqwiWg6Iohg5BJo5XEifNmfI7HEZWCT9HVcJ/VU7ZChAbCcY8XWR89jPnl1QoBc5sXOkBUhsQQ==
X-Received: by 2002:a5d:63c4:: with SMTP id c4mr3862294wrw.307.1553203651906;
        Thu, 21 Mar 2019 14:27:31 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host42-239-dynamic.117-80-r.retail.telecomitalia.it. [80.117.239.42])
        by smtp.gmail.com with ESMTPSA id w10sm7539967wrn.32.2019.03.21.14.27.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 14:27:31 -0700 (PDT)
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        =?UTF-8?Q?R=c3=b4mulo_Silva_de_Oliveira?= 
        <romulo.deoliveira@ufsc.br>, LKML <linux-kernel@vger.kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: BUG-RT: scheduling while in atomic in the watchdog's hrtimer
Message-ID: <d2eb047a-6c07-e176-aa2a-68a425efd0ae@redhat.com>
Date:   Thu, 21 Mar 2019 22:27:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the 4.19/5.0-rt configured !SMP, the following chain of events can
take place:

------------------------------ %< -------------------------------------
smp_apic_timer_interrupt(){
	hrtimer_interrupt() {
		__hrtimer_run_queues() {
			watchdog_timer_fn() {
				stop_one_cpu_nowait() {
					#ifdef !CONFIG_SMP
						schedule_work() {
							queue_work() {
								queue_work_on() {
								/* phew, long, ah!?.... */	
									local_lock_irqsave() {
										__local_lock_irqsave() {
											__local_lock_irq() {
												spin_lock_irqsave() {
													rt_spin_lock()...
														/* from here on you already know...*/
														/* a lot of } */
------------------------------ >% -------------------------------------

And this can cause a scheduling while in atomic.

Tracking down, the commit that introduced the stop_one_cpu_nowait()->
queue_work_on() to the path was:

------------------------------ %< -------------------------------------
commit 9cf57731b63e37ed995b46690adc604891a9a28f
Author: Peter Zijlstra 
Date:   Thu Jun 7 10:52:03 2018 +0200

    watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work
    
    Oleg suggested to replace the "watchdog/%u" threads with
    cpu_stop_work. That removes one thread per CPU while at the same time
    fixes softlockup vs SCHED_DEADLINE.
    
    But more importantly, it does away with the single
    smpboot_update_cpumask_percpu_thread() user, which allows
    cleanups/shrinkage of the smpboot interface.
    
    Suggested-by: Oleg Nesterov 
    Signed-off-by: Peter Zijlstra (Intel) 
    Cc: Linus Torvalds 
    Cc: Peter Zijlstra 
    Cc: Thomas Gleixner 
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Ingo Molnar 
------------------------------ >% -------------------------------------

Later modified by:

------------------------------ %< -------------------------------------
commit be45bf5395e0886a93fc816bbe41a008ec2e42e2
Author: Peter Zijlstra 
Date:   Fri Jul 13 12:42:08 2018 +0200

    watchdog/softlockup: Fix cpu_stop_queue_work() double-queue bug
    
    When scheduling is delayed for longer than the softlockup interrupt
    period it is possible to double-queue the cpu_stop_work, causing list
    corruption.
    
    Cure this by adding a completion to track the cpu_stop_work's
    progress.
    
    Reported-by: kernel test robot 
    Tested-by: Rong Chen 
    Signed-off-by: Peter Zijlstra (Intel) 
    Cc: Linus Torvalds 
    Cc: Peter Zijlstra 
    Cc: Thomas Gleixner 
    Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
    Link: http://lkml.kernel.org/r/20180713104208.GW2494@hirez.programming.kicks-ass.net
    Signed-off-by: Ingo Molnar 
------------------------------ >% -------------------------------------

I hit it while trying the automata model against the 4.19-rt/5.0-rt 
kernels.

You can find more about it here:
http://bristot.me/another-bug-found-with-the-model/

Thanks
-- Daniel
