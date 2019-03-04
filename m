Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B2C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F99E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfCDIOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:14:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:46680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfCDIOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:14:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50B62AE5E;
        Mon,  4 Mar 2019 08:14:46 +0000 (UTC)
Subject: Re: [BUG linux-4.9.x] xen hotplug cpu leads to 100% steal usage
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        tglx@linutronix.de, joe.jin@oracle.com,
        Herbert Van Den Bergh <herbert.van.den.bergh@oracle.com>,
        sboyd@kernel.org, john.stultz@linaro.org
References: <841bb9a9-1cba-483f-a353-1209684f7c74@default>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5bd0923f-29f6-0ad0-a1e9-92019a515b11@suse.com>
Date:   Mon, 4 Mar 2019 09:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <841bb9a9-1cba-483f-a353-1209684f7c74@default>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 03:35, Dongli Zhang wrote:
> This issue is only for stable 4.9.x (e.g., 4.9.160), while the root cause is
> still in the lasted mainline kernel.
> 
> This is obviated by new feature patch set ended with b672592f0221
> ("sched/cputime: Remove generic asm headers").
> 
> After xen guest is up for long time, once we hotplug new vcpu, the corresponding
> steal usage might become 100% and the steal time from /proc/stat would increase
> abnormally.
> 
> As we cannot wait for long time to reproduce the issue, here is how I reproduce
> it on purpose by accounting a large initial steal clock for new vcpu 2 and 3.
> 
> 1. Apply the below patch to guest 4.9.160 to account large initial steal clock
> for new vcpu 2 and 3:
> 
> diff --git a/drivers/xen/time.c b/drivers/xen/time.c
> index ac5f23f..3cf629e 100644
> --- a/drivers/xen/time.c
> +++ b/drivers/xen/time.c
> @@ -85,7 +85,14 @@ u64 xen_steal_clock(int cpu)
>         struct vcpu_runstate_info state;
>  
>         xen_get_runstate_snapshot_cpu(&state, cpu);
> -       return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline];
> +
> +       if (cpu == 2 || cpu == 3)
> +               return state.time[RUNSTATE_runnable]
> +                      + state.time[RUNSTATE_offline]
> +                      + 0x00071e87e677aa12;
> +       else
> +               return state.time[RUNSTATE_runnable]
> +                      + state.time[RUNSTATE_offline];
>  }
>  
>  void xen_setup_runstate_info(int cpu)
> 
> 
> 2. Boot hvm guest with "vcpus=2" and "maxvcpus=4". By default, VM boot with
> vcpu 0 and 1.
> 
> 3. Hotplug vcpu 2 and 3 via "xl vcpu-set <domid> 4" on dom0.
> 
> In my env, the steal becomes 100% within 10s after the "xl vcpu-set" command on
> dom0.
> 
> I can reproduce on kvm with similar method. However, as the initial steal clock
> on kvm guest is always 0, I do not think it is easy to hit this issue on kvm.
> 
> --------------------------------------------------------
> 
> The root cause is that the return type of jiffies_to_usecs() is 'unsigned int',
> but not 'unsigned long'. As a result, the leading 32 bits are discarded.
> 
> jiffies_to_usecs() is indirectly triggered by cputime_to_nsecs() at line 264.
> If guest is already up for long time, the initial steal time for new vcpu might
> be large and the leading 32 bits of jiffies_to_usecs() would be discarded.
> 
> As a result, the steal at line 259 is always large and the
> this_rq()->prev_steal_time at line 264 is always small. The difference at line
> 260 is always large during each time steal_account_process_time() is involved.
> Finally, the steal time in /proc/stat would increase abnormally.
> 
> 252 static __always_inline cputime_t steal_account_process_time(cputime_t maxtime)
> 253 {
> 254 #ifdef CONFIG_PARAVIRT
> 255         if (static_key_false(&paravirt_steal_enabled)) {
> 256                 cputime_t steal_cputime;
> 257                 u64 steal;
> 258 
> 259                 steal = paravirt_steal_clock(smp_processor_id());
> 260                 steal -= this_rq()->prev_steal_time;
> 261 
> 262                 steal_cputime = min(nsecs_to_cputime(steal), maxtime);
> 263                 account_steal_time(steal_cputime);
> 264                 this_rq()->prev_steal_time += cputime_to_nsecs(steal_cputime);
> 265 
> 266                 return steal_cputime;
> 267         }
> 268 #endif
> 269         return 0;
> 270 }
> 
> --------------------------------------------------------
> 
> I have emailed the kernel mailing list about the return type of
> jiffies_to_usecs() and jiffies_to_msecs():
> 
> https://lkml.org/lkml/2019/2/26/899
> 
> 
> So far, I have two solutions:
> 
> 1. Change the return type from 'unsigned int' to 'unsigned long' as in above
> link and I am afraid it would bring side effect. The return type in latest
> mainline kernel is still 'unsigned int'.
> 
> 2. Something like below based on stable 4.9.160:

3. use jiffies64_to_nsecs() instead of trying to open code it.


Juergen
