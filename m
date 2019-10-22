Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE412CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814952084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HidD9NII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbfJVWp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:45:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33827 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbfJVWp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:45:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so11583282pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:message-id:subject
         :in-reply-to:references:to:cc;
        bh=7aR+uSzeMahVa2OPNUR1feGVGkqBz5tWi+pFrnNsLQY=;
        b=HidD9NIIzokyyLiafLDrpYk6/ir9qUK4mM7burZJAZgMgK1Fly7NzNqMBKkKKbhDWN
         qUVPQpYEuK17Jtw1MFP8s7uh4Z08mCuvkN8ZppirqOQdzGEAm1d0Fi3y1SWXO/HhEgZD
         6hlmkjlS6c1tE1+EwnMVW0e+tXRduAvwqHgZmEWj0SIQR+0uRuW14DHeNGs0DGNS6p7B
         lxnZNpQhD7IFwYwb5gULrGBECcpthxARKeAZQe3WdzPdGnICPZ+iIV6R4aql5KRlTarh
         KjamU56iYgeAfEsynCOmj5Wceu2AbMFOvy+BONNCxUOGMxPlr6+w3TLiFaPJlRbGvKvr
         Rbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :message-id:subject:in-reply-to:references:to:cc;
        bh=7aR+uSzeMahVa2OPNUR1feGVGkqBz5tWi+pFrnNsLQY=;
        b=ZmIZqaxfv6b/Sza/GJZaCzAZ6phl7/6hlc5B999OeOROKxoE4IuFutAK/WyvPHhQod
         FdXip9dE1Q1Mjd3Xx39y2Ze/9dFltf/BdT0bU0XcDuqoF7BCL/7TIM/I1A55Pd1z0KM0
         1Q7KDv27Dol4VTs7daTxzwHFWUCayhxFUXBi9FpDmbLNcRCeAaGfKFfabnCFFXXl7UTe
         bhlYICHdbmjv+eWESrEjIjB0TSXooMyCvwq7+wgnai4z51kEX4yEdVujklH+HCiwtNoE
         C/A78EmFpvBu7NV/l0ybUe1IsNJZweptvYpvrXDQKZ98YKz/tN8CVM2HF4ihp5SsopbT
         b51Q==
X-Gm-Message-State: APjAAAXw4IHR6XlpcYvdd7ia/MRa0YyvFDX1Ftw87J4KQEuieXxBo5Yv
        uVY2POtilbaXe8es2nNZzSJUWQ==
X-Google-Smtp-Source: APXvYqwUR6i6zvgFtKulNmjwpxHtvT9uBcaIKeL4bHbbK8eiBP+9G6cCPFLpKx/0EJH1wr2JW1Ac7g==
X-Received: by 2002:a17:90a:1a0d:: with SMTP id 13mr7746464pjk.100.1571784328325;
        Tue, 22 Oct 2019 15:45:28 -0700 (PDT)
Received: from [10.145.97.154] ([12.53.65.170])
        by smtp.gmail.com with ESMTPSA id q26sm17968253pgk.60.2019.10.22.15.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 15:45:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Date:   Tue, 22 Oct 2019 15:45:26 -0700
Message-Id: <7364B113-DD65-423D-BED3-FF90C4DF8334@amacapital.net>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
In-Reply-To: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
References: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> On Oct 22, 2019, at 2:58 PM, Alexei Starovoitov <alexei.starovoitov@gmail=
.com> wrote:
>>=20
>> =EF=BB=BFOn Tue, Oct 22, 2019 at 05:04:30PM -0400, Steven Rostedt wrote:
>> I gave a solution for this. And that is to add another flag to allow
>> for just the minimum to change the ip. And we can even add another flag
>> to allow for changing the stack if needed (to emulate a call with the
>> same parameters).
>=20
> your solution is to reduce the overhead.
> my solution is to remove it competely. See the difference?
>=20
>> By doing this work, live kernel patching will also benefit. Because it
>> is also dealing with the unnecessary overhead of saving regs.
>> And we could possibly even have kprobes benefit from this if a kprobe
>> doesn't need full regs.
>=20
> Neither of two statements are true. The per-function generated trampoline
> I'm talking about is bpf specific. For a function with two arguments it's j=
ust:
> push rbp=20
> mov rbp, rsp
> push rdi
> push rsi
> lea  rdi,[rbp-0x10]
> call jited_bpf_prog
> pop rsi
> pop rdi
> leave
> ret

Why are you saving rsi?  You said upthread that you=E2=80=99re saving the ar=
gs, but rsi is already available in rsi.

Just how custom is this bpf program?  It seems to clobber no regs (except ar=
gs), and it doesn=E2=80=99t return anything. Is it entirely specific to the p=
robed function?  If so, why not just call it directly?

In any event, I think you can=E2=80=99t *just* use text_poke.  Something nee=
ds to coordinate to ensure that, if you bpf trace an already-kprobed functio=
n, the right thing happens.

FWIW, if you are going to use a trampoline like this, consider using r11 for=
 the caller frame instead of rsi.  You won=E2=80=99t need to restore it. But=
 I=E2=80=99m wondering whether the bpf jitted code could just directly acces=
s the frame instead of indirecting through a register. (Or am I entirely mis=
understanding what rdi is for in your example?)=
