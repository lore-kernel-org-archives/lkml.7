Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4206BC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0559022DCC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308972;
	bh=MFo+k+TzaMIfQQkCZLWtKAnqHh5WvGmVmCxuZT5250E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tmfzC4OMReffg0r3m2E/X4I8sNp7j/jf1Kr5/yGlbK52AUJQLf2F9z1W7ifeFf//c
	 RMy4b87wvYBTvcDHJ/iMa8phNqSFfOS618I/x5znaRZ3juuL9cOPhWq5CvuKIM0s3O
	 urkmIodU3eAuz3viFSir3xmwKrj7xMJmYI5mBSXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfHTNtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfHTNta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:49:30 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1277A2087E;
        Tue, 20 Aug 2019 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308969;
        bh=MFo+k+TzaMIfQQkCZLWtKAnqHh5WvGmVmCxuZT5250E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ztSOtI5QNUTNIDiC1gtlhym3Dw6Rq7kdt55d1EmEZABfaeZDwF2E68U/2uDvemj7G
         g+/jEyiHA1SDig4LM39U4t58oqhRkJ46XPM72GpVkFu/bJmCuBdveoCXzN6G2Y3XAm
         cmpw79KFH918FUCpLXXw5Hu8NNPwN3EzHwvbaLeE=
Date:   Tue, 20 Aug 2019 15:49:27 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 02/44] alarmtimers: Avoid rtc.h include
Message-ID: <20190820134926.GE2093@lenoir>
References: <20190819143141.221906747@linutronix.de>
 <20190819143801.565389536@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819143801.565389536@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:31:43PM +0200, Thomas Gleixner wrote:
> rtc.h is not needed in alarmtimers when a forward declaration of struct
> rtc_device is provided. That allows to include posix-timers.h without
> adding more includes to alarmtimer.h or creating circular include
> dependencies.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> ---
>  include/linux/alarmtimer.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/alarmtimer.h
> +++ b/include/linux/alarmtimer.h
> @@ -5,7 +5,8 @@
>  #include <linux/time.h>
>  #include <linux/hrtimer.h>
>  #include <linux/timerqueue.h>
> -#include <linux/rtc.h>
> +
> +struct rtc_device;
>  
>  enum alarmtimer_type {
>  	ALARM_REALTIME,
> 
> 
