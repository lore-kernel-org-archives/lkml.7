Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A87C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF48920833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 05:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfDOFow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:44:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19077 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbfDOFow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 01:44:52 -0400
X-UUID: abe40107d18848b5afdce674cbe32720-20190415
X-UUID: abe40107d18848b5afdce674cbe32720-20190415
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chang-an.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1448580266; Mon, 15 Apr 2019 13:44:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 15 Apr 2019 13:44:41 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 15 Apr 2019 13:44:41 +0800
Message-ID: <1555307081.12121.2.camel@mtkswgap22>
Subject: Re: [PATCH v2] sched/clock: Prevent generic sched_clock wrap caused
 by tick_freeze()
From:   Chang-An Chen <chang-an.chen@mediatek.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Kuohong Wang =?UTF-8?Q?=28=E7=8E=8B=E5=9C=8B=E9=B4=BB=29?= 
        <kuohong.wang@mediatek.com>,
        Freddy Hsin =?UTF-8?Q?=28=E8=BE=9B=E6=81=92=E8=B1=90=29?= 
        <Freddy.Hsin@mediatek.com>
Date:   Mon, 15 Apr 2019 13:44:41 +0800
In-Reply-To: <1553828349-8914-1-git-send-email-chang-an.chen@mediatek.com>
References: <1553828349-8914-1-git-send-email-chang-an.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is just a gentle ping for this patch.

On Fri, 2019-03-29 at 10:59 +0800, Chang-An Chen wrote:
> tick_freeze() introduced by suspend-to-idle in commit 124cf9117c5f
> ("PM / sleep: Make it possible to quiesce timers during suspend-to-idle")
> will use timekeeping_suspend() instead of syscore_suspend() during
> suspend-to-idle. It means that generic sched_clock will keep going because
> sched_clock_suspend() and sched_clock_resume() are not taken during
> suspend-to-idle. This will lead to generic sched_clock wrap.
> 
> For example:
> In my arm system with suspend-to-idle enabled, sched_clock is registered
> as "56 bits at 13MHz, resolution 76ns, wraps every 4398046511101ns", which
> means the real wrapping duration is 8796093022202ns.
> 
> [  134.551779] suspend-to-idle suspend (timekeeping_suspend())
> [ 1204.912239] suspend-to-idle resume (timekeeping_resume())
> ......
> [ 1206.912239] suspend-to-idle suspend (timekeeping_suspend())
> [ 5880.502807] suspend-to-idle resume (timekeeping_resume())
> ......
> [ 6000.403724] suspend-to-idle suspend (timekeeping_suspend())
> [ 8035.753167] suspend-to-idle resume  (timekeeping_resume())
> ......
> [ 8795.786684] (2)[321:charger_thread]......
> [ 8795.788387] (2)[321:charger_thread]......
> [    0.057226] (0)[0:swapper/0]......
> [    0.061447] (2)[0:swapper/2]......
> 
> Sched_clock was not stopped during suspend-to-idle, and sched_clock_poll
> hrtimer was not expired because timekeeping_suspend() is taken during
> suspend-to-idle. It makes sched_clock wrap at kernel time 8796s.
> 
> To fix this issue, we add sched_clock_suspend() and sched_clock_resume() in
> tick_freeze() together with timekeeping_suspend() and timekeeping_resume()
> to make sure generic sched_clock wrapping will not happen.
> 
> Signed-off-by: Chang-An Chen <chang-an.chen@mediatek.com>
> Fixes: 124cf9117c5f (PM / sleep: Make it possible to quiesce timers during suspend-to-idle)
> ---
>  kernel/time/sched_clock.c |    4 ++--
>  kernel/time/tick-common.c |    2 ++
>  kernel/time/timekeeping.h |    7 +++++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index 094b82c..930113b 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -272,7 +272,7 @@ static u64 notrace suspended_sched_clock_read(void)
>  	return cd.read_data[seq & 1].epoch_cyc;
>  }
>  
> -static int sched_clock_suspend(void)
> +int sched_clock_suspend(void)
>  {
>  	struct clock_read_data *rd = &cd.read_data[0];
>  
> @@ -283,7 +283,7 @@ static int sched_clock_suspend(void)
>  	return 0;
>  }
>  
> -static void sched_clock_resume(void)
> +void sched_clock_resume(void)
>  {
>  	struct clock_read_data *rd = &cd.read_data[0];
>  
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 529143b..df40146 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -487,6 +487,7 @@ void tick_freeze(void)
>  		trace_suspend_resume(TPS("timekeeping_freeze"),
>  				     smp_processor_id(), true);
>  		system_state = SYSTEM_SUSPEND;
> +		sched_clock_suspend();
>  		timekeeping_suspend();
>  	} else {
>  		tick_suspend_local();
> @@ -510,6 +511,7 @@ void tick_unfreeze(void)
>  
>  	if (tick_freeze_depth == num_online_cpus()) {
>  		timekeeping_resume();
> +		sched_clock_resume();
>  		system_state = SYSTEM_RUNNING;
>  		trace_suspend_resume(TPS("timekeeping_freeze"),
>  				     smp_processor_id(), false);
> diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
> index 7a9b4eb..141ab3a 100644
> --- a/kernel/time/timekeeping.h
> +++ b/kernel/time/timekeeping.h
> @@ -14,6 +14,13 @@ extern ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq,
>  extern void timekeeping_warp_clock(void);
>  extern int timekeeping_suspend(void);
>  extern void timekeeping_resume(void);
> +#ifdef CONFIG_GENERIC_SCHED_CLOCK
> +extern int sched_clock_suspend(void);
> +extern void sched_clock_resume(void);
> +#else
> +static inline int sched_clock_suspend(void) { return 0; }
> +static inline void sched_clock_resume(void) { }
> +#endif
>  
>  extern void do_timer(unsigned long ticks);
>  extern void update_wall_time(void);


