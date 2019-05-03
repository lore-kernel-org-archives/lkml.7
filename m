Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7035FC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BC32070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfECAAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:00:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42828 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfECAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:00:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so4818905qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPqKk1Nce9ulB47hrGMNOsWZDkTL1qhAM3SCFqkBmyg=;
        b=iIHP4ripfobNY9t2B9kaUxnPAmRH0HpTLVF6XctyYjvziP6Wqf1eJC5jI9X8n2kETM
         dlryxKTYPX3zzCBIsMQrQgKx09RX6lOBFtRqDtohNQLO2BNOqma+8bRhrGDkbx5EC1eB
         gLnCqa69UsU6bN5ZVUwdoBHNPRx95yppcrt90sjBZmZypK56nqFpsnLQSPUEQcis2qCg
         X4vL0jVmTgugr5Ir17bn9hSc1/7SbeAhh5PeKYcGOpl9aGSi1oz8jvScpdTwsXpGKeuG
         y48r7AV25eLiJoCLSQAL/mMyfx4bTP7yjEQYVXalxaJyWRxSEitYWLHWzRjv9bZdSdZi
         kmFg==
X-Gm-Message-State: APjAAAUDl/IwdLUXxl014Glu3BLStMz7jgw4nm1z8EZ2HsyJ0uAxfzi0
        eWKzJ8TN15tlYAxy3ADuWD8nOA==
X-Google-Smtp-Source: APXvYqzAzN3fqk+Sn0S7PSCnrWs48hQdYqyQUYcdLogPdX2Kvo9EOJ9LoB1Ax20VDtUU5rkOZhdoDQ==
X-Received: by 2002:ac8:1a41:: with SMTP id q1mr5928878qtk.185.1556841644635;
        Thu, 02 May 2019 17:00:44 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-336a-6920-3806-8b87.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-336a-6920-3806-8b87.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:336a:6920:3806:8b87])
        by smtp.gmail.com with ESMTPSA id o55sm553683qtj.14.2019.05.02.17.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 17:00:43 -0700 (PDT)
Message-ID: <f5a96a36e68fcf4e15f902bd3c9257acb77d6e08.camel@redhat.com>
Subject: Re: [PATCH 2/2] RFC: soft/hardlookup: taint kernel
From:   Laurence Oberman <loberman@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Don Zickus <dzickus@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Date:   Thu, 02 May 2019 20:00:42 -0400
In-Reply-To: <20190502194208.3535-2-daniel.vetter@ffwll.ch>
References: <20190502194208.3535-1-daniel.vetter@ffwll.ch>
         <20190502194208.3535-2-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-02 at 21:42 +0200, Daniel Vetter wrote:
> There's the soft/hardlookup_panic sysctls, but that's a bit an
> extreme
> measure. As a fallback taint at least the machine.
> 
> Our CI uses this to decide when a reboot is necessary, plus to figure
> out whether the kernel is still happy.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Cc: Laurence Oberman <loberman@redhat.com>
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Cc: Don Zickus <dzickus@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Sinan Kaya <okaya@kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  kernel/watchdog.c     | 2 ++
>  kernel/watchdog_hld.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 6a5787233113..de7a60503517 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -469,6 +469,8 @@ static enum hrtimer_restart
> watchdog_timer_fn(struct hrtimer *hrtimer)
>  		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
>  		if (softlockup_panic)
>  			panic("softlockup: hung tasks");
> +		else
> +			add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>  		__this_cpu_write(soft_watchdog_warn, true);
>  	} else
>  		__this_cpu_write(soft_watchdog_warn, false);
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index 247bf0b1582c..cce46cf75d76 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -154,6 +154,8 @@ static void watchdog_overflow_callback(struct
> perf_event *event,
>  
>  		if (hardlockup_panic)
>  			nmi_panic(regs, "Hard LOCKUP");
> +		else
> +			add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
>  
>  		__this_cpu_write(hard_watchdog_warn, true);
>  		return;

This looks OK to me, could be useful to know we would have triggered
had the flags been set.

Reviewed-by: Laurence Oberman <loberman@redhat.com>

