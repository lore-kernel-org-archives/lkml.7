Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EFBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4780206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="g44yxhTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfLKSRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:17:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38251 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:17:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so8045656wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gdbdOJGDr6s2TB3vkGkLojy6hKiZ0+eS72V/GX35qQM=;
        b=g44yxhTp8JdnuxE9OcIrpnMwYX/4KkBpg/3xgew18mzg4Xaqb7jyrdjlRCxZRniDTM
         i8C0/tzDKBo7wRNB/6DaNihgzh2GJ0IFWEJHOTseCRdDOwFl/UEb9aznheriv/ZzzhH8
         0EPPEOZmsFEbFt5ZeiRyUmi7eaOj4GSrbaVNgqaipJp4WfJ4RBOSSWVBs1Uy2SS0bi4h
         KpgGZYQCUQdXw3gb2TvgFU027R8KuKh40IeQbYrhfbU50FstnGdaUC2zaTa/mSMdbR15
         QKWEB3uvbYV2YeUEKO6GHbtov+vhkhmA2Nwfi5sgH3JRjarkHI1DZt0+GaWb/IBdrM0T
         AKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gdbdOJGDr6s2TB3vkGkLojy6hKiZ0+eS72V/GX35qQM=;
        b=BQ2asSWVZDFDjFct4tjZz/FHLxbaF21jdChv2BEov9qstlO9QaJaMlA8mmbPuodp5p
         KCEJredJJ1eQz4iKeao0o0jZ82qztDXb1iwu/wLdl0isJCEHU9yBHiG/BXASPw/vnfFL
         6tzJDcFa5jUsVqTB/W2qPJscDgHXrpN2cDPj085i4fWv8zJBLM40VPlumT65i6SyJwSK
         Jb4V5NwTBQbkoa2scIH2ds0vyXEdoTC1p504VVLX5WWj1CB2Kg5ygGLR25IjJm15U0cK
         xMBLM9KEccBvVnHTqCINWNNt4mTkqMHm5REBLFmG5rjaSHiIrSdvVpObas8zVCN4VG7B
         e6BQ==
X-Gm-Message-State: APjAAAUjmyFrYyEVNOOqmP5ZALjvPdIahn5c7em77sAkXk3RoZsB8/fC
        jip1yxzeiq0maB2Gw5hdxHagO+VavB4UvbRUfE2O2A==
X-Google-Smtp-Source: APXvYqziD3eVTLC2Yu/hIEeHVWWceML2RIHpK3CmqYNaiptFEscdd0Np5Zqo+EY0L9JVk59rH8xnwSL0WzgLNv2sMmc=
X-Received: by 2002:a1c:2083:: with SMTP id g125mr1260281wmg.89.1576088256672;
 Wed, 11 Dec 2019 10:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20191211170632.GD14821@zn.tnic> <BC48F4AD-8330-4ED6-8BE8-254C835506A5@amacapital.net>
 <20191211172945.GE14821@zn.tnic>
In-Reply-To: <20191211172945.GE14821@zn.tnic>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 11 Dec 2019 10:17:25 -0800
Message-ID: <CALCETrXuJMBawUy3DTQfE4qLb822d9491er9-hd971BtBsPFNw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] x86/traps: Print address on #GP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:29 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Dec 11, 2019 at 09:22:30AM -0800, Andy Lutomirski wrote:
> > Could we spare a few extra bytes to make this more readable?  I can nev=
er keep track of which number is the oops count, which is the cpu, and whic=
h is the error code.  How about:
> >
> > OOPS 1: general protection blah blah blah (CPU 0)
> >
> > and put in the next couple lines =E2=80=9C#GP(0)=E2=80=9D.
>
> Well, right now it is:
>
> [    2.470492] general protection fault, probably for non-canonical addre=
ss 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> [    2.471615] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1+ #6
>
> and the CPU is on the second line, the error code is before the number -
> [#1] - in that case.
>
> If we pull the number in front, we can do:
>
> [    2.470492] [#1] general protection fault, probably for non-canonical =
address 0xdfff000000000001: 0000 PREEMPT SMP
> [    2.471615] [#1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1+ =
#6
>
> and this way you know that the error code is there, after the first
> line's description.

Hmm, I like that.

>
> I guess we can do:
>
> [    2.470492] [#1] general protection fault, probably for non-canonical =
address 0xdfff000000000001 Error Code: 0000 PREEMPT SMP
>
> to make it even more explicit...

I like this too.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



--=20
Andy Lutomirski
AMA Capital Management, LLC
