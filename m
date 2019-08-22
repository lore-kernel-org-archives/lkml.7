Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E54BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67825206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbfHVQFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:05:04 -0400
Received: from foss.arm.com ([217.140.110.172]:48466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388178AbfHVQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:05:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8CD1337;
        Thu, 22 Aug 2019 09:05:02 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92B913F718;
        Thu, 22 Aug 2019 09:05:01 -0700 (PDT)
Subject: Re: [PATCH] timekeeping/vsyscall: Prevent math overflow in BOOTTIME
 update
To:     Chris Clayton <chris2553@googlemail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
 <alpine.DEB.2.21.1908221047250.1983@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908221059370.1983@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908221134110.1983@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de>
 <652e3ca3-38ed-7969-fcc5-3d128879fb38@googlemail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <dd0ee9d7-d275-d33b-8fd4-a7a170681a00@arm.com>
Date:   Thu, 22 Aug 2019 17:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <652e3ca3-38ed-7969-fcc5-3d128879fb38@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 22/08/2019 13:52, Chris Clayton wrote:
> Thanks Thomas.
> 
> On 22/08/2019 12:00, Thomas Gleixner wrote:
>> The VDSO update for CLOCK_BOOTTIME has a overflow issue as it shifts the
>> nanoseconds based boot time offset left by the clocksource shift. That
>> overflows once the boot time offset becomes large enough. As a consequence
>> CLOCK_BOOTTIME in the VDSO becomes a random number causing applications to
>> misbehave.
>>
>> Fix it by storing a timespec64 representation of the offset when boot time
>> is adjusted and add that to the MONOTONIC base time value in the vdso data
>> page. Using the timespec64 representation avoids a 64bit division in the
>> update code.
>>
> 
> I've tested resume from both suspend and hibernate and this patch fixes the problem I reported.
> 
> Tested-by: Chris Clayton <chris2553@googlemail.com>
> 

I can confirm what reported by Chris. Please see below the scissors.

With this:

Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

--->8---

Clock test start
clk_id: CLOCK_BOOTTIME
clock_getres: 0 1
clock_gettime:2697 489679147
2019-08-22 16:21:57.911
Clock test end

<...Suspend/Resume...>

Clock test start
clk_id: CLOCK_BOOTTIME
clock_getres: 0 1
clock_gettime:4489 684341925
2019-08-22 16:51:50.106
Clock test end


>> Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
>> Reported-by: Chris Clayton <chris2553@googlemail.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  include/linux/timekeeper_internal.h |    5 +++++
>>  kernel/time/timekeeping.c           |    5 +++++
>>  kernel/time/vsyscall.c              |   22 +++++++++++++---------
>>  3 files changed, 23 insertions(+), 9 deletions(-)
>>
>> --- a/include/linux/timekeeper_internal.h
>> +++ b/include/linux/timekeeper_internal.h
>> @@ -57,6 +57,7 @@ struct tk_read_base {
>>   * @cs_was_changed_seq:	The sequence number of clocksource change events
>>   * @next_leap_ktime:	CLOCK_MONOTONIC time value of a pending leap-second
>>   * @raw_sec:		CLOCK_MONOTONIC_RAW  time in seconds
>> + * @monotonic_to_boot:	CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
>>   * @cycle_interval:	Number of clock cycles in one NTP interval
>>   * @xtime_interval:	Number of clock shifted nano seconds in one NTP
>>   *			interval.
>> @@ -84,6 +85,9 @@ struct tk_read_base {
>>   *
>>   * wall_to_monotonic is no longer the boot time, getboottime must be
>>   * used instead.
>> + *
>> + * @monotonic_to_boottime is a timespec64 representation of @offs_boot to
>> + * accelerate the VDSO update for CLOCK_BOOTTIME.
>>   */
>>  struct timekeeper {
>>  	struct tk_read_base	tkr_mono;
>> @@ -99,6 +103,7 @@ struct timekeeper {
>>  	u8			cs_was_changed_seq;
>>  	ktime_t			next_leap_ktime;
>>  	u64			raw_sec;
>> +	struct timespec64	monotonic_to_boot;
>>  
>>  	/* The following members are for timekeeping internal use */
>>  	u64			cycle_interval;
>> --- a/kernel/time/timekeeping.c
>> +++ b/kernel/time/timekeeping.c
>> @@ -146,6 +146,11 @@ static void tk_set_wall_to_mono(struct t
>>  static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
>>  {
>>  	tk->offs_boot = ktime_add(tk->offs_boot, delta);
>> +	/*
>> +	 * Timespec representation for VDSO update to avoid 64bit division
>> +	 * on every update.
>> +	 */
>> +	tk->monotonic_to_boot = ktime_to_timespec64(tk->offs_boot);
>>  }
>>  
>>  /*
>> --- a/kernel/time/vsyscall.c
>> +++ b/kernel/time/vsyscall.c
>> @@ -17,7 +17,7 @@ static inline void update_vdso_data(stru
>>  				    struct timekeeper *tk)
>>  {
>>  	struct vdso_timestamp *vdso_ts;
>> -	u64 nsec;
>> +	u64 nsec, sec;
>>  
>>  	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
>>  	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
>> @@ -45,23 +45,27 @@ static inline void update_vdso_data(stru
>>  	}
>>  	vdso_ts->nsec	= nsec;
>>  
>> -	/* CLOCK_MONOTONIC_RAW */
>> -	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
>> -	vdso_ts->sec	= tk->raw_sec;
>> -	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
>> +	/* Copy MONOTONIC time for BOOTTIME */
>> +	sec	= vdso_ts->sec;
>> +	/* Add the boot offset */
>> +	sec	+= tk->monotonic_to_boot.tv_sec;
>> +	nsec	+= (u64)tk->monotonic_to_boot.tv_nsec << tk->tkr_mono.shift;
>>  
>>  	/* CLOCK_BOOTTIME */
>>  	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
>> -	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
>> -	nsec = tk->tkr_mono.xtime_nsec;
>> -	nsec += ((u64)(tk->wall_to_monotonic.tv_nsec +
>> -		       ktime_to_ns(tk->offs_boot)) << tk->tkr_mono.shift);
>> +	vdso_ts->sec	= sec;
>> +
>>  	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
>>  		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
>>  		vdso_ts->sec++;
>>  	}
>>  	vdso_ts->nsec	= nsec;
>>  
>> +	/* CLOCK_MONOTONIC_RAW */
>> +	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
>> +	vdso_ts->sec	= tk->raw_sec;
>> +	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
>> +
>>  	/* CLOCK_TAI */
>>  	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
>>  	vdso_ts->sec	= tk->xtime_sec + (s64)tk->tai_offset;
>>

-- 
Regards,
Vincenzo
