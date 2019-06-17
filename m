Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4CB208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560784502;
	bh=b1+p3mYa5dcNTWiscCTfox6sPzLm0XFFNEeLduQHIzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h5ZvrxQooQ3SSsgvvkpMRlMm/YoL2+4ifnH02b+6U64znGSROTjV8CiFlFrXuLh3o
	 j0orK0knjaEK3ho7/FPJGC3nW1ULfazF7fpZe3mRPs67Idd/bdXn/ZSaLI9YfqSbjf
	 ByrVmIAUBueRgMnDnUvMwwwhcmNC73gbi389MF3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfFQPPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfFQPPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:15:00 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8522166E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560784499;
        bh=b1+p3mYa5dcNTWiscCTfox6sPzLm0XFFNEeLduQHIzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UEnJRIvQrSzZK1hbeKKJPljnWI19XRtBxLD4asFVxhyPBmZL4ZO0dRJZUpR/xlHOj
         sQ769iEQPPX7MqxWPdj66bkFn6GA4Kv9Oabba64HecEYnP/2SouFzlp++8Oj88XwUA
         v0gwZQppcg5h1B+Nk3LQhQxYiTOgjF8yPAupMIPA=
Received: by mail-wr1-f49.google.com with SMTP id k11so10412432wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:14:59 -0700 (PDT)
X-Gm-Message-State: APjAAAWkdFMmB6cwwycJPaQr8WaavOoFAuMJLsfxeBXYmT5kWzdYyLoI
        nMbgOZtfPWQr1u/c6RHoZzk6HSuiUd0jzk6kgOLj4Q==
X-Google-Smtp-Source: APXvYqw93YqgLomG8HFC+IpQDpfWEXBd7oTNFWLblW2pxicOuPdaajD6m0UMw5rFGbzuCkLeFVCBMw07AReqhQQzYnE=
X-Received: by 2002:a5d:6a42:: with SMTP id t2mr12160574wrw.352.1560784497814;
 Mon, 17 Jun 2019 08:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com>
 <1559944837-149589-4-git-send-email-fenghua.yu@intel.com> <20190611085410.GT3436@hirez.programming.kicks-ass.net>
 <0D67CEAC-9710-4ECB-9248-75B48542FF82@amacapital.net> <20190611172717.GC3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190611172717.GC3436@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 17 Jun 2019 08:14:44 -0700
X-Gmail-Original-Message-ID: <CALCETrW9gWtdHC3-b-VuWms5RRsSFuhhP1RsGrPDm0_bHZXK_A@mail.gmail.com>
Message-ID: <CALCETrW9gWtdHC3-b-VuWms5RRsSFuhhP1RsGrPDm0_bHZXK_A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:27 AM Peter Zijlstra <peterz@infradead.org> wrot=
e:
>
>
> (can you, perchance, look at a MUA that isn't 'broken' ?)
>
> On Tue, Jun 11, 2019 at 09:04:30AM -0700, Andy Lutomirski wrote:
> >
> >
> > > On Jun 11, 2019, at 1:54 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
> > >
> > >> On Fri, Jun 07, 2019 at 03:00:35PM -0700, Fenghua Yu wrote:
> > >> C0.2 state in umwait and tpause instructions can be enabled or disab=
led
> > >> on a processor through IA32_UMWAIT_CONTROL MSR register.
> > >>
> > >> By default, C0.2 is enabled and the user wait instructions result in
> > >> lower power consumption with slower wakeup time.
> > >>
> > >> But in real time systems which require faster wakeup time although p=
ower
> > >> savings could be smaller, the administrator needs to disable C0.2 an=
d all
> > >> C0.2 requests from user applications revert to C0.1.
> > >>
> > >> A sysfs interface "/sys/devices/system/cpu/umwait_control/enable_c02=
" is
> > >> created to allow the administrator to control C0.2 state during run =
time.
> > >
> > > We already have an interface for applications to convey their latency
> > > requirements (pm-qos). We do not need another magic sys variable.
> >
> > I=E2=80=99m not sure I agree.  This isn=E2=80=99t an overall latency re=
quest, and
> > setting an absurdly low pm_qos will badly hurt idle power and turbo
> > performance.  Also, pm_qos isn=E2=80=99t exactly beautiful.
> >
> > (I speak from some experience. I may be literally the only person to
> > write a driver that listens to dev_pm_qos latency requests. And, in my
> > production box, I directly disable c states instead of messing with
> > pm_qos.)
> >
> > I do wonder whether anyone will ever use this particular control, thoug=
h.
>
> I agree that pm-qos is pretty terrible; but that doesn't mean we should
> just add random control files all over the place.

I don't think pm-qos is expressive enough.  It seems entirely
reasonable to want to do a C0.1 wait for lower latency *while waiting*
but still want full power-saving idle when not waiting.

Do we even know what the C0.2 and C0.1 latencies are?  And why is this
thing an MSR instead of a flag passed to UMWAIT?

--Andy
