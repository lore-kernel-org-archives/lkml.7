Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF02AECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E262064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfJKHbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfJKHbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:31:55 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 967392D6A0D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:31:54 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 190so3714774wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 00:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kqphp6Y+B6IGsSB+hPHakdS6SePS+FCp5/MTcgoXJa8=;
        b=pz9MGSNd8EaE794HHyNOK80u6jddzfMSR6tjkxV6oFacCRfAW3811jjvnsaLNtLZhj
         HUTiq2oDPip16LaZk2QUNan7PpMK/N6+McSy9FrJc6LobWhn5aZfVy+g6QG4v8ZRT6Mg
         yrnOpYrcipyi26GZBnf6tlAgd8rU/txR+CPisoYn8elhU0zVUVWO7GX3crs1DSQh6EUS
         nFOJGBc4doRAebrHwOVZKO13BJjpojtecgjgxwSHI1qk2dVE8+ggGLha2la3te0+/sXM
         OL1605vU8qL4tsYV0y8hcIuSf10hcZUKITddtW5ihRfPx8fzLqDyjT3SQw/B9rcnbuAv
         QZDw==
X-Gm-Message-State: APjAAAW0rWVcAvPhS4x6V1Y40hJ6P802J3h5/CfAM41af5gUxk8eOdP2
        bEteGnENDeEY/kIhj+2D/xww9YfhTAdnlbLgUe29tHP+4qU+9FDCxmlV7PNqTV9zAgaxVXzaCBz
        ZJospPqhVyI8bw1ZAweN5lSQ9
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr1976324wmh.40.1570779113259;
        Fri, 11 Oct 2019 00:31:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtOWtt1RMKsyIvoidxq5Lwnw6UCeUhgRRWOSU1S5pB5jFMYB6RC6c++btYt5wW/ZGfPrJjHg==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr1976296wmh.40.1570779112965;
        Fri, 11 Oct 2019 00:31:52 -0700 (PDT)
Received: from ben-x1.lan (200116b826baedf00000000000000381.dip.versatel-1u1.de. [2001:16b8:26ba:edf0::381])
        by smtp.gmail.com with ESMTPSA id h17sm11569112wme.6.2019.10.11.00.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 00:31:52 -0700 (PDT)
Message-ID: <d4960717d6aa7c91ba34c00b5724dd2699412f86.camel@redhat.com>
Subject: Re: [PATCH] x86/mce: Lower throttling MCE messages to warnings
From:   Benjamin Berg <bberg@redhat.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
Date:   Fri, 11 Oct 2019 09:31:05 +0200
In-Reply-To: <e41580784d8f5a1806250f4daed528304976cf15.camel@linux.intel.com>
References: <20191009155424.249277-1-bberg@redhat.com>
         <20191009175608.GK10395@zn.tnic>
         <e41580784d8f5a1806250f4daed528304976cf15.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Thu, 2019-10-10 at 14:08 -0700, Srinivas Pandruvada wrote:
> I have a patch to address this. Instead of avoiding any critical
> warnings or wait for 300 seconds for next one, the warning is based on
> how long the system is working on throttled condition. If for example
> the fan broke, then the throttling is extended for a long time. Then we
> better warn.
> I am waiting for internal review, and hope to post by tomorrow.

Nice! I agree that a heuristic seems better than the very simple
approach taken in this patch.

Thanks,
Benjamin

> Thanks
> Srinivas
> 
> > > Signed-off-by: Benjamin Berg <bberg@redhat.com>
> > > Tested-by: Christian Kellner <ckellner@redhat.com>
> > > ---
> > >  arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
> > > b/arch/x86/kernel/cpu/mce/therm_throt.c
> > > index 6e2becf547c5..bc441d68d060 100644
> > > --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> > > +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> > > @@ -188,7 +188,7 @@ static void therm_throt_process(bool
> > > new_event,
> > > int event, int level)
> > >  	/* if we just entered the thermal event */
> > >  	if (new_event) {
> > >  		if (event == THERMAL_THROTTLING_EVENT)
> > > -			pr_crit("CPU%d: %s temperature above threshold,
> > > cpu clock throttled (total events = %lu)\n",
> > > +			pr_warn("CPU%d: %s temperature above threshold,
> > > cpu clock throttled (total events = %lu)\n",
> > >  				this_cpu,
> > >  				level == CORE_LEVEL ? "Core" :
> > > "Package",
> > >  				state->count);
> > > -- 
> > 
> > This has carried over since its very first addition in
> > 
> > commit 3867eb75b9279c7b0f6840d2ad9f27694ba6c4e4
> > Author: Dave Jones <davej@suse.de>
> > Date:   Tue Apr 2 20:02:27 2002 -0800
> > 
> >     [PATCH] x86 bluesmoke update.
> >     
> >     o  Make MCE compile time optional       (Paul Gortmaker)
> >     o  P4 thermal trip monitoring.          (Zwane Mwaikambo)
> >     o  Non-fatal MCE logging.               (Me)
> > 
> > 
> > It used to be KERN_EMERG back then, though.
> > 
> > And yes, this issue has come up in the past already so I think I'll
> > take
> > it. I'll just give Intel folks a couple of days to object should
> > there
> > be anything to object to.
> > 
> > Thx.
> > 

