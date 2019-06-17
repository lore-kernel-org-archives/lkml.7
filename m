Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F0C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691E420B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560812388;
	bh=yyHCPQUb4n948ybNrizyuEo+sw5dnPT3EY4ArDk9vEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rmtqHKlI0JQT+v1WbApuKO4LR4vQjsnMFZD1ja8E+cfrSwU+uyX/VBMVKtxGsI5p9
	 Ii7vOI0ztGiiwHgBtLF6wKDqoyKqfkw5h3rQ3qGrK5uHj/hkTsMPesqGSiBgVglHrw
	 57Nmevsw8PBhnEyeDAAFmFSgJBd5PJL3voRnFLBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbfFQW7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfFQW7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:59:42 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196F0208CB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 22:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560812381;
        bh=yyHCPQUb4n948ybNrizyuEo+sw5dnPT3EY4ArDk9vEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=utoXW3e+tA/DtyJyMs+sgAuWtOHWNZvdzVE9o+BGFeSIPuXnAsF82zR61O6m0PQT5
         CSjNDt5xw7ZRgDIzXUP9YGWphEDXyUc2covZDKOoRFYZm9dqTx8F93ssXnxPeVCgYk
         YNkyyTpYbo+Terhf4zrO+euPAAUIYHeD9Oaq29FA=
Received: by mail-wm1-f43.google.com with SMTP id h19so977133wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:59:41 -0700 (PDT)
X-Gm-Message-State: APjAAAWy1FBvLuq2osN6wCCFdro+GtY297qbrUexjBMiqjwVkIasF2KO
        v2Kj0upJCCG+E8cNH1Ws56joWPx2tru9/7HfQVEBnQ==
X-Google-Smtp-Source: APXvYqyCbjGFMiVDWjPJgWQxeMwlY5BW+RYp7xLuz0pGbBxHQnoR8iH2qPoJkz0M9BHmQDkEWMO67b0AN0RcQnu+U50=
X-Received: by 2002:a7b:c450:: with SMTP id l16mr673665wmi.0.1560812379691;
 Mon, 17 Jun 2019 15:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com> <CALCETrWi+uM5Rch6vaXOwHsHas928CDY5VJoBYaudD+3VFTrNw@mail.gmail.com>
 <20190610040449.GB162238@romley-ivt3.sc.intel.com> <CALCETrWZukWNeiCCwSMPxSHnn6YB_jJeiv4wd2MZAU9pwXf80g@mail.gmail.com>
 <20190617224820.GD217081@romley-ivt3.sc.intel.com>
In-Reply-To: <20190617224820.GD217081@romley-ivt3.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Jun 2019 15:59:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXnOKo3daWp-oSwaVZagQ_iP7SHCbpoB2VioWhRds5gqw@mail.gmail.com>
Message-ID: <CALCETrXnOKo3daWp-oSwaVZagQ_iP7SHCbpoB2VioWhRds5gqw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:57 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Sun, Jun 09, 2019 at 09:26:29PM -0700, Andy Lutomirski wrote:
> > On Sun, Jun 9, 2019 at 9:14 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > >
> > > On Sat, Jun 08, 2019 at 03:52:03PM -0700, Andy Lutomirski wrote:
> > > > On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > > >
> > > > > C0.2 state in umwait and tpause instructions can be enabled or disabled
> > > > > on a processor through IA32_UMWAIT_CONTROL MSR register.
> > > > >
> > > >
> > > > > +static u32 get_umwait_control_c02(void)
> > > > > +{
> > > > > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02;
> > > > > +}
> > > > > +
> > > > > +static u32 get_umwait_control_max_time(void)
> > > > > +{
> > > > > +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> > > > > +}
> > > > > +
> > > >
> > > > I'm not convinced that these helpers make the code any more readable.
> > >
> > > The helpers reduce length of statements that call them. Otherwise, all of
> > > the statements would be easily over 80 characters.
> > >
> > > Plus, each of the helpers is called multiple places in #0003 and #0004.
> > > So the helpers make the patches smaller and cleaner.
> > >
> >
> > I was imagining things like:
> >
> > umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_C02;
> > if (whatever condition)
> >   umwait_control_cached |= MSR_IA32_UMWAIT_CONTROL_C02;
> > umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> > umwait_control_cached |= new_max_time;
>
> How about this statement?
> With the helpers:
>         umwait_control_cached = max_time | get_umwait_control_c02();
> If there is no helpers, the above statement will need two statements:
>         umwait_control_cached &= ~MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
>         umwait_control_cached |= max_time;
>
> Another example:
> With the helpers:
>         if (umwait_control_c02 == get_umwait_control_c02())
> If no helpers, the above statement will be long:
>        if (umwait_control_c02 == (umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02_DISABLED))
>
> There are quite a few places like above examples.
>
> The helpers can reduce the length of those long lines and make code more
> readable and shorter, right?
>
> Can I still keep the helpers?
>

Sure, unless someone else objects.
