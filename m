Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134F620726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljb8tg7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLJHoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:44:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38866 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfLJHoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:44:20 -0500
Received: by mail-io1-f66.google.com with SMTP id v3so725014ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 23:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIsV7YVqTr9LN39nGbpXBWYNxZYF/API4vjBkMRTnwk=;
        b=Ljb8tg7n90pdawq/mSFektjTKgzTmE7zQum6REv33IhRaHuPe1d9SUFjtSRTKFr2p7
         PQTUukcvGegnkptM1YRmnXr+B556MHA6AdoZWJ0FHHj4E3yCB8dPnHFmQzR/+GjAHB7Q
         fetDW20lj789BZBkb0oUyj8+oxtJXcCXrAap3ooXvVGD1CbQpR64kRfOsPBOui/kWwN6
         uUwh1N9O9JrpixNgeSWkkc2mln9fnCDyU12KpGHykJADPKH0ZRFI0DxSoQpbDlWoydz6
         ouCO9/RAOx+Z4TDLjJmxC8w8PB1XkHf/TGmSWGi4xoWOBEZnaGFISiUnhU4AgOhQlSE3
         yzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIsV7YVqTr9LN39nGbpXBWYNxZYF/API4vjBkMRTnwk=;
        b=iBWo1wm6n7xvexhooTvA5LfjCFpqrZq1uf/8pMiJcnQ/KX4DnWvDL4whcOrPJQLcEn
         +vkAZWBd8N+cUmpwY8Y1mlQsNmaE2rwoO2AfVCcPxfyK+a0fuPPG5mFcIYMP7GCIYnvv
         W1Up+2X6PXqF6jKL7nKTJP15FopSPD8tEoUVjdi1EelBMagm/FH3OjSTvb3u1U0HE0YF
         jiJvBGy9xblFGFmD4RDnmJgZfy64JTYl/lYk4ChzhiH7W97o1YvFGp727RcZ2JS3xUyh
         ahRxcdL6rwt/SLgal/T+gHjLK8rME1rhj/HLBiXaW1EFqEbW3YmRU6DnvALFIP2YkGY0
         O9Fg==
X-Gm-Message-State: APjAAAVdf5KxUqosPVH5nbPTcQaGg6AXi6/KougqThjmopxOUcmTHWFo
        IEyJb7bnJumOW/Q7vhZ8U4BE3sgyJloRmMj5DEE=
X-Google-Smtp-Source: APXvYqx7x52SHGUCnps+unxtCpneRw981NZJH+EbrlRI3ANRLVcL+vm9mUgkduOPsk30MEnyZmF2DaqDKCxWgGbMDhM=
X-Received: by 2002:a6b:770b:: with SMTP id n11mr22526006iom.154.1575963860181;
 Mon, 09 Dec 2019 23:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20191208041318.3702-1-cai@lca.pw>
In-Reply-To: <20191208041318.3702-1-cai@lca.pw>
From:   Ryan Chen <yu.chen.surf@gmail.com>
Date:   Tue, 10 Dec 2019 15:55:57 +0800
Message-ID: <CADjb_WRmyE3rRN2sLAh9ZOqAg0E3WeCkj9SwSM9dorvx4TGC2A@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Tony Luck <tony.luck@intel.com>, tj@kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Sun, Dec 8, 2019 at 12:14 PM Qian Cai <cai@lca.pw> wrote:
>
> domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
> is true where it will initialize d->mbm_over. However,
> domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
> checking r->mon_capable. Hence, it triggers a debugobjects warning when
> offlining CPUs because those timer debugobjects are never initialized.
>
Could you elaborate a little more on the failure symptom?
If I understand correctly, the error you described was  due to
r->mon_capable set to false while is_mbm_enabled() returns true?
Which means on this platform rdt_mon_features is non zero?
And in get_rdt_mon_resources() it will invoke rdt_get_mon_l3_config(),
however the only possible failure to do not set r->mon_capable is that it
 failed in dom_data_init() due to kcalloc() failure?  Then the logic in
get_rdt_resources() is that it will ignore the return error if rdt allocate
feature is supported on this platform?  If this is the case, the r->mon_capable
is not an indicator for whether the overflow thread has been created, right?
Can we simply remove the check of r->mon_capable in domain_add_cpu() and
invoke  domain_setup_mon_state() directly?
> ODEBUG: assert_init not available (active state 0) object type:
> timer_list hint: 0x0
> WARNING: CPU: 143 PID: 789 at lib/debugobjects.c:484
> debug_print_object+0xfe/0x140
> Hardware name: HP Synergy 680 Gen9/Synergy 680 Gen9 Compute Module, BIOS
> I40 05/23/2018
> RIP: 0010:debug_print_object+0xfe/0x140
> Call Trace:
> debug_object_assert_init+0x1f5/0x240
> del_timer+0x6f/0xf0
> try_to_grab_pending+0x42/0x3c0
> cancel_delayed_work+0x7d/0x150
> resctrl_offline_cpu+0x3c0/0x520
> cpuhp_invoke_callback+0x197/0x1120
> cpuhp_thread_fun+0x252/0x2f0
> smpboot_thread_fn+0x255/0x440
> kthread+0x1e6/0x210
> ret_from_fork+0x3a/0x50
>
> Fixes: e33026831bdb ("x86/intel_rdt/mbm: Handle counter overflow")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 03eb90d00af0..89049b343c7a 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -618,7 +618,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>                 if (static_branch_unlikely(&rdt_mon_enable_key))
>                         rmdir_mondata_subdir_allrdtgrp(r, d->id);
>                 list_del(&d->list);
> -               if (is_mbm_enabled())
> +               if (r->mon_capable && is_mbm_enabled())
>                         cancel_delayed_work(&d->mbm_over);
Humm, it looks like there are two places within this function
invoked cancel_delayed_work(&d->mbm_over),
why not adding the check for both of them?

thanks,
Y
