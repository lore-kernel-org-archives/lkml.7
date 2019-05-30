Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E2E261B4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559250648;
	bh=okauBBBot9anABfmPFdr4rWFEOCmX0raomeZLAf4qB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QeCljp5duda+LLelRuSuJ/Xj8//VRtAiLSVAohENs98cyqmUeZBQNH9LoSZ8v+EVk
	 aHV2Y5IQS452a1Sd/dODIsrIivqQiDDmjE5/udDj2f/wholVDZwPyMyn4v4wm45AU+
	 37vewND7LoKHgqASX19tZSRClex/87X3monxYjqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfE3VKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3VKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:10:47 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA367261C7
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 21:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559250646;
        bh=okauBBBot9anABfmPFdr4rWFEOCmX0raomeZLAf4qB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2A/oBsNmQWr1JUxHV3nudCr9jVBs3FBGqCe5D9F8ChSzSfkKa2eiD05WyxFn3HG1p
         fRrcN1aCwivvHlpn1jnZRT8pIU36wuey0WuBI8duDH1odquXzGtBmeJa2QlpJbwtqx
         ZgcgGRMcMYnOZodhN7CNxOSPMS4FPMNjUKTl880g=
Received: by mail-wm1-f47.google.com with SMTP id 16so347499wmg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:10:45 -0700 (PDT)
X-Gm-Message-State: APjAAAVD7+QiNG6mrOm69IutdUXqiNo7tw7Kqh5b4InfJJ8zxlft4XdU
        9LNfLG2Zf4B6oYNQOlTKlgaMVOztIxm737r92qsnQw==
X-Google-Smtp-Source: APXvYqzK7Lktu7tFOSafHnzr7V0hnhW+nTkcDu2Qt7eP6RrtuL/seds8xu5sTbU82uwKnMBxeiQ87Er5RQmwZt+Jwoo=
X-Received: by 2002:a1c:d10e:: with SMTP id i14mr3553366wmg.161.1559250644401;
 Thu, 30 May 2019 14:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com> <1558742162-73402-4-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1558742162-73402-4-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 30 May 2019 14:10:32 -0700
X-Gmail-Original-Message-ID: <CALCETrUByHERw5ZB7q-3ka71a_4uxVi-uthTjf7JtDPEgLPjRg@mail.gmail.com>
Message-ID: <CALCETrUByHERw5ZB7q-3ka71a_4uxVi-uthTjf7JtDPEgLPjRg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 5:05 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> C0.2 state in umwait and tpause instructions can be enabled or disabled
> on a processor through IA32_UMWAIT_CONTROL MSR register.
>
> By default, C0.2 is enabled and the user wait instructions result in
> lower power consumption with slower wakeup time.
>
> But in real time systems which requrie faster wakeup time although power
> savings could be smaller, the administrator needs to disable C0.2 and all
> C0.2 requests from user applications revert to C0.1.
>
> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c0_2" is
> created to allow the administrator to control C0.2 state during run time.
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/power/umwait.c | 75 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/power/umwait.c b/arch/x86/power/umwait.c
> index 80cc53a9c2d0..cf5de7e1cc24 100644
> --- a/arch/x86/power/umwait.c
> +++ b/arch/x86/power/umwait.c
> @@ -7,6 +7,7 @@
>  static bool umwait_c0_2_enabled = true;
>  /* Umwait max time is in TSC-quanta. Bits[1:0] are zero. */
>  static u32 umwait_max_time = 100000;
> +static DEFINE_MUTEX(umwait_lock);
>
>  /* Return value that will be used to set IA32_UMWAIT_CONTROL MSR */
>  static u32 umwait_compute_msr_value(void)
> @@ -22,7 +23,7 @@ static u32 umwait_compute_msr_value(void)
>                (umwait_max_time & MSR_IA32_UMWAIT_CONTROL_MAX_TIME);
>  }
>
> -static void umwait_control_msr_update(void)
> +static void umwait_control_msr_update(void *unused)
>  {
>         u32 msr_val;
>
> @@ -33,7 +34,9 @@ static void umwait_control_msr_update(void)
>  /* Set up IA32_UMWAIT_CONTROL MSR on CPU using the current global setting. */
>  static int umwait_cpu_online(unsigned int cpu)
>  {
> -       umwait_control_msr_update();
> +       mutex_lock(&umwait_lock);
> +       umwait_control_msr_update(NULL);
> +       mutex_unlock(&umwait_lock);

What's the mutex for?  Can't you just use READ_ONCE?

> +static void umwait_control_msr_update_all_cpus(void)
> +{
> +       u32 msr_val;
> +
> +       msr_val = umwait_compute_msr_value();
> +       /* All CPUs have same umwait control setting */
> +       on_each_cpu(umwait_control_msr_update, NULL, 1);

Why are you calling umwait_compute_msr_value()?
