Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD895C04AB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898DC206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+E9n/fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfFGAgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 20:36:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51840 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGAgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:36:03 -0400
Received: by mail-it1-f193.google.com with SMTP id m3so268643itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7A9RUvu0n3Bt4UhAjkzkVndEPIfQbQzuowpA9agMyKM=;
        b=u+E9n/fcYZRBIG6EiOxDT0c67KRaVQVHtGEahegng3IZMA+9yNEYmGnxT6Au5lp3xS
         DUrdtztMxD/Kp/PaZL0jhiAHwzfCX4CZylNl3sf+59X5Wt5gilaY15vcPdysh6h37xys
         C8UWU6W3FTPCoNytPeNsyFFoiu8tHiB3a/NIC3mY01MpIrCmUNMLkRVPTHm9erFOCboE
         Yy0Di1jgzPS4w10Q+UMZb7fwhXF1supmVLVPK76XfAS7HircfVRJ/9ujq6a0/j+HM11E
         /42MHTZ9ImvuQbpJXIuvYvdfKsChLrXiycBJ2hOhrJvQWZVR43eqFGwFLuOP6QJxI3ZU
         bb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7A9RUvu0n3Bt4UhAjkzkVndEPIfQbQzuowpA9agMyKM=;
        b=aOSNg3Ilv1VwkUg6j52NT/EG4MmWoHCRqGV2YNXuAOb3OVp9MvTq7byMosRpEYAO3i
         kkcpeCq0NuCKqVI76h6SPJW5bqsrmVsSw7A/CJrU105KKqcc516HCh8cIrmRdrqoJUdr
         T+5RJQ4+iznkurWvfYeYqZjbgKxOkkhsGIIdEookY3HhAjPyKpeiYDSXuIhDjJSgUO+i
         Is06eXHy/gwAmWa/ZCkZ2t+T/LI/3s4xzB/WDJ2q/aALYnw4W24UEdh/6AqrRpbL2RfW
         m+zzJT7UTgF7vL7QaTKNJnpsMNgHCLigBly8KOtwrRqvLOkQiojyVQOHZgWhQFM/uHC7
         OIpw==
X-Gm-Message-State: APjAAAWecOkAl2GMjUbzG0uv+O8Td5OMOIgHCpjUyv6ujQSGCNCr9oQB
        q9S607Cq8QiKSe3L8seuOXuUVbaVgHzNOXSiFVhspA==
X-Google-Smtp-Source: APXvYqyHqN66GDCIO8XLc++aamWWvQQKrduhAh07DngI3gLNjcuViZej77vdnJNs6dUOjxfZcuoMFMraNXWWbgERJdU=
X-Received: by 2002:a24:6b52:: with SMTP id v79mr2047862itc.20.1559867762475;
 Thu, 06 Jun 2019 17:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1558660583-28561-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <1558660583-28561-18-git-send-email-ricardo.neri-calderon@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 6 Jun 2019 17:35:51 -0700
Message-ID: <CABPqkBQP=JxpiQE7SVuJO3xPWvsFbAPj916RTYUgaMBDG1OdaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 17/21] x86/tsc: Switch to perf-based hardlockup
 detector if TSC become unstable
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,
Thanks for your contribution here. It is very important to move the
watchdog out of the PMU wherever possible.

On Thu, May 23, 2019 at 6:17 PM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The HPET-based hardlockup detector relies on the TSC to determine if an
> observed NMI interrupt was originated by HPET timer. Hence, this detector
> can no longer be used with an unstable TSC.
>
> In such case, permanently stop the HPET-based hardlockup detector and
> start the perf-based detector.
>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  arch/x86/include/asm/hpet.h    | 2 ++
>  arch/x86/kernel/tsc.c          | 2 ++
>  arch/x86/kernel/watchdog_hld.c | 7 +++++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
> index fd99f2390714..a82cbe17479d 100644
> --- a/arch/x86/include/asm/hpet.h
> +++ b/arch/x86/include/asm/hpet.h
> @@ -128,6 +128,7 @@ extern int hardlockup_detector_hpet_init(void);
>  extern void hardlockup_detector_hpet_stop(void);
>  extern void hardlockup_detector_hpet_enable(unsigned int cpu);
>  extern void hardlockup_detector_hpet_disable(unsigned int cpu);
> +extern void hardlockup_detector_switch_to_perf(void);
>  #else
>  static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
>  { return NULL; }
> @@ -136,6 +137,7 @@ static inline int hardlockup_detector_hpet_init(void)
>  static inline void hardlockup_detector_hpet_stop(void) {}
>  static inline void hardlockup_detector_hpet_enable(unsigned int cpu) {}
>  static inline void hardlockup_detector_hpet_disable(unsigned int cpu) {}
> +static void harrdlockup_detector_switch_to_perf(void) {}
>  #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
>
This does not compile for me when CONFIG_X86_HARDLOCKUP_DETECTOR_HPET
is not enabled.
because:
   1- you have a typo on the function name
    2- you are missing the inline keyword


>  #else /* CONFIG_HPET_TIMER */
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 59b57605e66c..b2210728ce3d 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1158,6 +1158,8 @@ void mark_tsc_unstable(char *reason)
>
>         clocksource_mark_unstable(&clocksource_tsc_early);
>         clocksource_mark_unstable(&clocksource_tsc);
> +
> +       hardlockup_detector_switch_to_perf();
>  }
>
>  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hld.c
> index c2512d4c79c5..c8547c227a41 100644
> --- a/arch/x86/kernel/watchdog_hld.c
> +++ b/arch/x86/kernel/watchdog_hld.c
> @@ -76,3 +76,10 @@ void watchdog_nmi_stop(void)
>         if (detector_type == X86_HARDLOCKUP_DETECTOR_HPET)
>                 hardlockup_detector_hpet_stop();
>  }
> +
> +void hardlockup_detector_switch_to_perf(void)
> +{
> +       detector_type = X86_HARDLOCKUP_DETECTOR_PERF;
> +       hardlockup_detector_hpet_stop();
> +       hardlockup_start_all();
> +}
> --
> 2.17.1
>
