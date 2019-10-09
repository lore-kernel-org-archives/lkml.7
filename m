Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89383C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6373220B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kIFj4m7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfJIR4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:56:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44004 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfJIR4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:56:20 -0400
Received: from zn.tnic (p200300EC2F0C2000CC8F9AE7D5DA1569.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2000:cc8f:9ae7:d5da:1569])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A6FE1EC0B4D;
        Wed,  9 Oct 2019 19:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570643775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PMw+kSYqYUuu078V5yDARfkO7aBA1Un8BKx0eEVNnLk=;
        b=kIFj4m7bp3BoISRedv96BVS6x7yG0joePdwsTT368QgfcY9VHQF68tBlidp3zmQFRH4o5N
        zejXObN1Zx4VvsXxUJlNNPDE1o0w+q9x3k8CshF/MgfJoT46LuTtf1fWZMgo6ExA656xS6
        ux2Clqs5YoSIAgZzQsMfu7hXZCTdD8A=
Date:   Wed, 9 Oct 2019 19:56:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Benjamin Berg <bberg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
Message-ID: <20191009175608.GK10395@zn.tnic>
References: <20191009155424.249277-1-bberg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009155424.249277-1-bberg@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 05:54:24PM +0200, Benjamin Berg wrote:
> On modern CPUs it is quite normal that the temperature limits are
> reached and the CPU is throttled. In fact, often the thermal design is
> not sufficient to cool the CPU at full load and limits can quickly be
> reached when a burst in load happens. This will even happen with
> technologies like RAPL limitting the long term power consumption of
> the package.
> 
> So these messages do not usually indicate a hardware issue (e.g.
> insufficient cooling). Log them as warnings to avoid confusion about
> their severity.
> 
> Signed-off-by: Benjamin Berg <bberg@redhat.com>
> Tested-by: Christian Kellner <ckellner@redhat.com>
> ---
>  arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
> index 6e2becf547c5..bc441d68d060 100644
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> @@ -188,7 +188,7 @@ static void therm_throt_process(bool new_event, int event, int level)
>  	/* if we just entered the thermal event */
>  	if (new_event) {
>  		if (event == THERMAL_THROTTLING_EVENT)
> -			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> +			pr_warn("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
>  				this_cpu,
>  				level == CORE_LEVEL ? "Core" : "Package",
>  				state->count);
> -- 

This has carried over since its very first addition in

commit 3867eb75b9279c7b0f6840d2ad9f27694ba6c4e4
Author: Dave Jones <davej@suse.de>
Date:   Tue Apr 2 20:02:27 2002 -0800

    [PATCH] x86 bluesmoke update.
    
    o  Make MCE compile time optional       (Paul Gortmaker)
    o  P4 thermal trip monitoring.          (Zwane Mwaikambo)
    o  Non-fatal MCE logging.               (Me)


It used to be KERN_EMERG back then, though.

And yes, this issue has come up in the past already so I think I'll take
it. I'll just give Intel folks a couple of days to object should there
be anything to object to.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
