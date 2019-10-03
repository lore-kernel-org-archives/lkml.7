Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9650C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76972222C4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IRM8y58A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfJCEuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 00:50:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39259 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfJCEuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 00:50:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so1068687qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 21:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tq3iPoJStHKk7jGP0B/Iex5tl8WiUmfhc1UddDd7V3A=;
        b=IRM8y58A551V1u8bCAtcbGuu4XEHP/k6MWT5N7HKvgGaWxn7ht/nFviFpA5rtT401c
         q3wiD5bi+McYxPiDjYJoUqGTFZqwCSBItLwn9yfp1KtWEecRjfdsa6C39VvQaWGGximr
         6BWpFtc/Z12dvxAEYLnkcXYp51Jz+cAHTHZhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tq3iPoJStHKk7jGP0B/Iex5tl8WiUmfhc1UddDd7V3A=;
        b=YmsrBdlbyX6GvRcL0bX8+FbT6SoenAIZZQ/0D8utxRmLWWN2bZVHCRyvmvbJeHLOzm
         KjpyNbdaOvaLhd8/pCZaA9QGPase1+J35WFb//cOo9uvq957WoygMa+HdzjDGyilzEFj
         FB5A6lrLtQwhtLUXQ7C58rCe+ACXmJc1nnO9x9eMbI86KMXGWgeG5zsL2hC3h/Lwtxox
         wekRnATwdDiMEkRzKRF7t71LEeeBJakHNhMReFrE/v1kD2sm17G3L/eViQPwateZH2xK
         D1vQJtTLdN6S39KXovV2Wnz+zrLhYQktvPFrC6PGFULf9zAL3A/r2ALmubTh3VjSUy5g
         k10g==
X-Gm-Message-State: APjAAAUN0k/AYGIB9T2XK2Zr0Jk9eLpi1hrvHLBOTyi7qOUdm75RNA70
        G9iz/A7LWNrgsBiyk4fnX2RHJT95zLpo+GUPOGswhw==
X-Google-Smtp-Source: APXvYqw77ybqyKto0A/sQnxehJBP5gwUvR8WRc/5zurF0jnDKfeSzQwHUFFYum9SB381hpEHz2xXTUpe0A88wxwaQFY=
X-Received: by 2002:a37:9b0e:: with SMTP id d14mr2375280qke.315.1570078223915;
 Wed, 02 Oct 2019 21:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191003024101.57700-1-hsinyi@chromium.org>
In-Reply-To: <20191003024101.57700-1-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 2 Oct 2019 21:49:58 -0700
Message-ID: <CAJMQK-ihDtFr1qKhVy78nGYzH9Jz+PR+hkwLTYGR4=jinFBmmw@mail.gmail.com>
Subject: Re: [PATCH RFC] reboot: hotplug cpus in migrate_to_reboot_cpu()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 7:41 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Currently system reboots use arch specific codes (eg. smp_send_stop) to
> offline non reboot cpus. Some arch like arm64, arm, and x86... set offline
> masks to cpu without really offlining them. Thus it causes some race
> condition and kernel warning comes out sometimes when system reboots. We
> can do cpu hotplug in migrate_to_reboot_cpu() to avoid this issue.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> kernel warnings at reboot:
> [1] https://lore.kernel.org/lkml/20190820100843.3028-1-hsinyi@chromium.org/
> [2] https://lore.kernel.org/lkml/20190727164450.GA11726@roeck-us.net/
> ---
>  kernel/cpu.c    | 35 +++++++++++++++++++++++++++++++++++
>  kernel/reboot.c | 18 ------------------
>  2 files changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index fc28e17940e0..2f4d51fe91e3 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -31,6 +31,7 @@
>  #include <linux/relay.h>
>  #include <linux/slab.h>
>  #include <linux/percpu-rwsem.h>
> +#include <linux/reboot.h>
>
>  #include <trace/events/power.h>
>  #define CREATE_TRACE_POINTS
> @@ -1366,6 +1367,40 @@ int __boot_cpu_id;
>
>  #endif /* CONFIG_SMP */
>
> +void migrate_to_reboot_cpu(void)
> +{
> +       /* The boot cpu is always logical cpu 0 */
> +       int cpu = reboot_cpu;
> +
> +       /* Make certain the cpu I'm about to reboot on is online */
> +       if (!cpu_online(cpu))
> +               cpu = cpumask_first(cpu_online_mask);
> +
> +       /* Prevent races with other tasks migrating this task */
> +       current->flags |= PF_NO_SETAFFINITY;
> +
> +       /* Make certain I only run on the appropriate processor */
> +       set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +
> +       /* Hotplug other cpus if possible */
> +       if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {

Should use #ifdef CONFIG_HOTPLUG_CPU here. Will fix in the next
version if this patch is reasonable.
(Reported-by: kbuild test robot <lkp@intel.com>)
> +               int i, err;
> +
> +               cpu_maps_update_begin();
> +
> +               for_each_online_cpu(i) {
> +                       if (i == cpu)
> +                               continue;
> +                       err = _cpu_down(i, 0, CPUHP_OFFLINE);
> +                       if (err)
> +                               pr_info("Failed to offline cpu %d\n", i);
> +               }
> +               cpu_hotplug_disabled++;
> +
> +               cpu_maps_update_done();
> +       }
> +}
> +
>  /* Boot processor state steps */
>  static struct cpuhp_step cpuhp_hp_states[] = {
>         [CPUHP_OFFLINE] = {
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b7f1b4..f0046be34a60 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -215,24 +215,6 @@ void do_kernel_restart(char *cmd)
>         atomic_notifier_call_chain(&restart_handler_list, reboot_mode, cmd);
>  }
>
> -void migrate_to_reboot_cpu(void)
> -{
> -       /* The boot cpu is always logical cpu 0 */
> -       int cpu = reboot_cpu;
> -
> -       cpu_hotplug_disable();
> -
> -       /* Make certain the cpu I'm about to reboot on is online */
> -       if (!cpu_online(cpu))
> -               cpu = cpumask_first(cpu_online_mask);
> -
> -       /* Prevent races with other tasks migrating this task */
> -       current->flags |= PF_NO_SETAFFINITY;
> -
> -       /* Make certain I only run on the appropriate processor */
> -       set_cpus_allowed_ptr(current, cpumask_of(cpu));
> -}
> -
>  /**
>   *     kernel_restart - reboot the system
>   *     @cmd: pointer to buffer containing command to execute for restart
> --
> 2.23.0.444.g18eeb5a265-goog
>
