Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B121C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37BE20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560140848;
	bh=tA1+3smQwTzjwh9yhYxr9Itqii0L4RjezQ0aPtZsHxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WMAwS1VXHEwhIwSIT7XbV4PGnWWEMmLhH8bPMAezJPhPYCOyiNxWXKFeCIoyP/WxH
	 mOrs/gG78dRciGsOD+L5sO5PkZ9oHIO3g2B6mfFgkSD0JSYWkGfgWog51xpSWavHZD
	 j00QbL6ZvrGmPiX7n73SDUJCDLUAGLl+BDL9OFjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfFJE12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfFJE11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:27:27 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF9820868
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 04:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560140846;
        bh=tA1+3smQwTzjwh9yhYxr9Itqii0L4RjezQ0aPtZsHxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fsmGVeOcNQVEsoAkJYx0YyCOp/vqwY9SYE1CNQrcQR8KHZ19gSLRhEYB9Ov7Xkr/v
         DwqQNewwQD++JiO30/6jPCRR1izcohp5Z25MRYOITuHWdK4esvSgNuHfxovMruIHkj
         P/XAEvvK6O4CECn9UiUy//b6PHK7k3J+klKIfKLQ=
Received: by mail-wm1-f48.google.com with SMTP id x15so7074318wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 21:27:26 -0700 (PDT)
X-Gm-Message-State: APjAAAVlYKJVYEjndLibIhAoAvjViSBnC9e2GZWsb3QAYb64xawjMYQY
        0v+5H8k3PXUMIEkc6K1LCUpmEZUCJMxpFeKH0mO+DQ==
X-Google-Smtp-Source: APXvYqzbSQWT+Boo6y+cesOVaPs00CCouqeXDUTsgfhIuT4h/yvcmIvcnt0bYdw8+MA9eYxBjfUF1iOhaPiuXQ9ltbI=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr12037650wmj.79.1560140845308;
 Sun, 09 Jun 2019 21:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-3-git-send-email-fenghua.yu@intel.com> <CALCETrWtmrwqjThkMKU9YpTDK4o95V4HBb2_yQF2tvx5JZ9Ukw@mail.gmail.com>
 <20190610041343.GC162238@romley-ivt3.sc.intel.com>
In-Reply-To: <20190610041343.GC162238@romley-ivt3.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 9 Jun 2019 21:27:13 -0700
X-Gmail-Original-Message-ID: <CALCETrVKMx+0E6y5-rJsaDD6Z0Kj_f6XWXprJxHVq+YR9zex3g@mail.gmail.com>
Message-ID: <CALCETrVKMx+0E6y5-rJsaDD6Z0Kj_f6XWXprJxHVq+YR9zex3g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
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

On Sun, Jun 9, 2019 at 9:23 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Sat, Jun 08, 2019 at 03:52:42PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> > >
> > > umwait or tpause allows processor to enter a light-weight
> > > power/performance optimized state (C0.1 state) or an improved
> > > power/performance optimized state (C0.2 state) for a period
> > > specified by the instruction or until the system time limit or until
> > > a store to the monitored address range in umwait.
> > >
> > > IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> > > on the processor and set maximum time the processor can reside in
> > > C0.1 or C0.2.
> > >
> > > By default C0.2 is enabled so the user wait instructions can enter the
> > > C0.2 state to save more power with slower wakeup time.
> >
> > Sounds good, but:
> >
> > > +#define MSR_IA32_UMWAIT_CONTROL_C02            BIT(0)
> >
> > > +static u32 umwait_control_cached = 100000;
> >
> > The code seems to disagree.
>
> The definition of bit[0] is: C0.2 is disabled when bit[0]=1. So
> 100000 means C0.2 is enabled (and max time is 100000).
>
> Would it be better to change
> +#define MSR_IA32_UMWAIT_CONTROL_C02            BIT(0)
> to
> +#define MSR_IA32_UMWAIT_CONTROL_C02_DISABLED            BIT(0)

Sounds like a good improvement.

Thanks,
Andy

> ?
>
> Thanks.
>
> -Fenghua
