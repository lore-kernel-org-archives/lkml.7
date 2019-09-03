Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A006DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AB021897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfICSzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:55:46 -0400
Received: from schedar.uberspace.de ([185.26.156.41]:53682 "EHLO
        schedar.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfICSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:55:46 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 14:55:45 EDT
Received: (qmail 12847 invoked from network); 3 Sep 2019 18:49:02 -0000
Received: from localhost (HELO ?192.168.188.41?) (127.0.0.1)
  by schedar.uberspace.de with SMTP; 3 Sep 2019 18:49:02 -0000
Subject: Re: Problem when function alarmtimer_suspend returns 0 if time delta
 is zero
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <S1728511AbfHaSEm/20190831180442Z+580@vger.kernel.org>
 <08fbdf25-faa1-aa13-4f13-d30acbf27dda@mipisi.de>
 <20190902074917.GA21922@piout.net>
 <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
From:   Michael <michael@mipisi.de>
Message-ID: <4fc3a016-ec2f-a15e-5fd1-6794a001e2d9@mipisi.de>
Date:   Tue, 3 Sep 2019 20:48:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

thank you very much for your patch. Unfortunately currently I can only 
test it with a kernel 4.1.52 but i've tried to patch
your new logic into my older kernel version.

There seem to be rare cases where the "delta" value becomes negative. 
Therefore I added

if(unlikely(delta < 0)) {
     delta = 0;
}
before min-check.

Currently I still get returns here in the new code

+	if (min == KTIME_MAX)
  		return 0;

where the board afterwards is not woken up.So I think there is still 
something missing.

I'm doing further tests and keep you informed.

Again Thanks!
Michael



On 02.09.2019 12:57, Thomas Gleixner wrote:
> Michael,
>
> On Mon, 2 Sep 2019, Alexandre Belloni wrote:
>> On 31/08/2019 20:32:06+0200, Michael wrote:
>>> currently I have a problem with the alarmtimer i'm using to cyclically wake
>>> up my i.MX6 ULL board from suspend to RAM.
>>>
>>> The problem is that in principle the timer wake ups work fine but seem to be
>>> not 100% stable. In about 1 percent the wake up alarm from suspend is
>>> missing.
>>> In my error case the alarm wake up always fails if the path "if(min==0)" is
>>> entered. If I understand this code correctly that means that
>>> when ever one of the timers in the list has a remaining tick time of zero,
>>> the function just returns 0 and continues the suspend process until
>>> it reaches suspend mode.
> No. That code is simply broken because it tries to handle the case where a
> alarmtimer nanosleep got woken up by the freezer. That's broken because it
> makes the delta = 0 assumption which leads to the issue you discovered.
>
> That whole cruft can be removed by switching alarmtimer nanosleep to use
> freezable_schedule(). That keeps the timer queued and avoids all the issues.
>
> Completely untested patch below.
>
> Thanks,
>
> 	tglx
>
> 8<----------------------
>
> kernel/time/alarmtimer.c |   57 +++--------------------------------------------
>   1 file changed, 4 insertions(+), 53 deletions(-)
>
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -46,14 +46,6 @@ static struct alarm_base {
>   	clockid_t		base_clockid;
>   } alarm_bases[ALARM_NUMTYPE];
>   
> -#if defined(CONFIG_POSIX_TIMERS) || defined(CONFIG_RTC_CLASS)
> -/* freezer information to handle clock_nanosleep triggered wakeups */
> -static enum alarmtimer_type freezer_alarmtype;
> -static ktime_t freezer_expires;
> -static ktime_t freezer_delta;
> -static DEFINE_SPINLOCK(freezer_delta_lock);
> -#endif
> -
>   #ifdef CONFIG_RTC_CLASS
>   static struct wakeup_source *ws;
>   
> @@ -241,19 +233,12 @@ EXPORT_SYMBOL_GPL(alarm_expires_remainin
>    */
>   static int alarmtimer_suspend(struct device *dev)
>   {
> -	ktime_t min, now, expires;
> +	ktime_t now, expires, min = KTIME_MAX;
>   	int i, ret, type;
>   	struct rtc_device *rtc;
>   	unsigned long flags;
>   	struct rtc_time tm;
>   
> -	spin_lock_irqsave(&freezer_delta_lock, flags);
> -	min = freezer_delta;
> -	expires = freezer_expires;
> -	type = freezer_alarmtype;
> -	freezer_delta = 0;
> -	spin_unlock_irqrestore(&freezer_delta_lock, flags);
> -
>   	rtc = alarmtimer_get_rtcdev();
>   	/* If we have no rtcdev, just return */
>   	if (!rtc)
> @@ -271,13 +256,13 @@ static int alarmtimer_suspend(struct dev
>   		if (!next)
>   			continue;
>   		delta = ktime_sub(next->expires, base->gettime());
> -		if (!min || (delta < min)) {
> +		if (delta < min) {
>   			expires = next->expires;
>   			min = delta;
>   			type = i;
>   		}
>   	}
> -	if (min == 0)
> +	if (min == KTIME_MAX)
>   		return 0;
>   
>   	if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
> @@ -479,38 +464,6 @@ u64 alarm_forward_now(struct alarm *alar
>   EXPORT_SYMBOL_GPL(alarm_forward_now);
>   
>   #ifdef CONFIG_POSIX_TIMERS
> -
> -static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
> -{
> -	struct alarm_base *base;
> -	unsigned long flags;
> -	ktime_t delta;
> -
> -	switch(type) {
> -	case ALARM_REALTIME:
> -		base = &alarm_bases[ALARM_REALTIME];
> -		type = ALARM_REALTIME_FREEZER;
> -		break;
> -	case ALARM_BOOTTIME:
> -		base = &alarm_bases[ALARM_BOOTTIME];
> -		type = ALARM_BOOTTIME_FREEZER;
> -		break;
> -	default:
> -		WARN_ONCE(1, "Invalid alarm type: %d\n", type);
> -		return;
> -	}
> -
> -	delta = ktime_sub(absexp, base->gettime());
> -
> -	spin_lock_irqsave(&freezer_delta_lock, flags);
> -	if (!freezer_delta || (delta < freezer_delta)) {
> -		freezer_delta = delta;
> -		freezer_expires = absexp;
> -		freezer_alarmtype = type;
> -	}
> -	spin_unlock_irqrestore(&freezer_delta_lock, flags);
> -}
> -
>   /**
>    * clock2alarm - helper that converts from clockid to alarmtypes
>    * @clockid: clockid.
> @@ -715,7 +668,7 @@ static int alarmtimer_do_nsleep(struct a
>   		set_current_state(TASK_INTERRUPTIBLE);
>   		alarm_start(alarm, absexp);
>   		if (likely(alarm->data))
> -			schedule();
> +			freezable_schedule();
>   
>   		alarm_cancel(alarm);
>   	} while (alarm->data && !signal_pending(current));
> @@ -727,8 +680,6 @@ static int alarmtimer_do_nsleep(struct a
>   	if (!alarm->data)
>   		return 0;
>   
> -	if (freezing(current))
> -		alarmtimer_freezerset(absexp, type);
>   	restart = &current->restart_block;
>   	if (restart->nanosleep.type != TT_NONE) {
>   		struct timespec64 rmt;


