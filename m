Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19082C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 06:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C0E20850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 06:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfDNG6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 02:58:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38428 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfDNG6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 02:58:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so17431430wro.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 23:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z54IX/IOP3iQTD3XT3aRxaB0/3WylPqvJxT6dm/Dn5c=;
        b=cHr5YiBvXDu4Bi35POYCt/19M0FdEwDJ2NGfbllvix5oXKmCXlkedNaKste/ifMktf
         503G3LYLABijuefWgI5IAJD7zZB57powvfuAHZwHsew5LQbxL/kMcXxNm/oFKUkieBei
         WumHyL1p6DsGab4nU+QnfJTqJe+/BFrJTsK6cFTVCAnQZQJ42o7B9LT+V8t5ljRNkdEg
         w2CD04njlsH/wJp13Qd4SzWGSnYMtf6YiGvKgbUatzcoKQKbtwxmhz17vQxxrvsveA1D
         SDkWFp2DRWbI3IWr43H/Rsmex4YymULV6shb1gSJcg1YdotP+RjrQL5cR/fwLGqocJ+V
         Gp6g==
X-Gm-Message-State: APjAAAVZXDc5QVsFqDDXBgVTq9g4VLXohjSsYqoLbayBIViLilWq2Dc5
        qQFCUzlbgL+5QJqwmhHovIl2FA==
X-Google-Smtp-Source: APXvYqybIoQZ8wXGiqpDGs8dtXHwgj5AlnTP4DEqJ5OJbosWlii3C99RiqMPx3k7a+HknKD9/VHrnA==
X-Received: by 2002:adf:f051:: with SMTP id t17mr21370413wro.73.1555225089444;
        Sat, 13 Apr 2019 23:58:09 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-213-220-248-130.net.upcbroadband.cz. [213.220.248.130])
        by smtp.gmail.com with ESMTPSA id z140sm33985037wmc.27.2019.04.13.23.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 23:58:08 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,
        "apw\@canonical.com" <apw@canonical.com>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "riel\@surriel.com" <riel@surriel.com>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "luto\@kernel.org" <luto@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] smp: Do not warn if smp_call_function_single() is doing a self call.
In-Reply-To: <20190412235341.29379-1-decui@microsoft.com>
References: <20190412235341.29379-1-decui@microsoft.com>
Date:   Sun, 14 Apr 2019 08:58:10 +0200
Message-ID: <875zrhf4zh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> If smp_call_function_single() is calling the function for itself, it's safe
> to run with irqs_disabled() == true.
>
> I hit the warning because I'm in the below path in the .suspend callback of
> a "syscore_ops" to support hibernation for a VM running on Hyper-V:
>
>   hv_synic_cleanup() ->
>     clockevents_unbind_device() ->
>       clockevents_unbind() ->
>         smp_call_function_single().
>

I'd suggest fixing clockevents_unbind() instead, something like
(completely untested):

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5e77662dd2d9..d14e881a8808 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -418,8 +418,17 @@ static void __clockevents_unbind(void *arg)
 static int clockevents_unbind(struct clock_event_device *ced, int cpu)
 {
        struct ce_unbind cu = { .ce = ced, .res = -ENODEV };
+       int this_cpu;
+
+       this_cpu = get_cpu();
+
+       if (cpu != this_cpu)
+               smp_call_function_single(cpu, __clockevents_unbind, &cu, 1);
+       else
+               __clockevents_unbind(&cu);
+
+       put_cpu();
 
-       smp_call_function_single(cpu, __clockevents_unbind, &cu, 1);
        return cu.res;
 }

> When the .suspend callback runs, only CPU0 is online and irqs_disabled() is
> true.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f4cf1b0bb3b8..4fdf6a378def 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -288,7 +288,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
>  	 * can't happen.
>  	 */
>  	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
> -		     && !oops_in_progress);
> +		     && cpu != smp_processor_id() && !oops_in_progress);

You already have 'this_cpu', no need to call smp_processor_id(). 

>  
>  	csd = &csd_stack;
>  	if (!wait) {

-- 
Vitaly
