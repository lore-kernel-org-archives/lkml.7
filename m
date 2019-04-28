Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A5C4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B98C20693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ldr0EOm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfD1RlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:41:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36608 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1RlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:41:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so4058941pgc.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UB/V2OMSTCgHtH1m9OSlkcyNv221wepPJzWI5BJPRJw=;
        b=ldr0EOm6vI6MZ2PQE8kgh6H9SNKmJxqFt1Pi9tEqAWpMKdjkfb/fk8Tmn+EegiVc+Z
         ITJkAnYeXrzl1AKkx1ML42wsj/gQ0YCDG0syaHMZiC1MjALeA20vdg1rQKLamrzJikzW
         6N2Kwd4De7fdxQhkWhy+TJ9bBgeKg83kRjrdnaqnVgtB3hLy3djf03D+fY++FwvaIzAZ
         4z/YgsQzbz7qm14+93uHKRlpwZqH4Aj9Xn5u9V/mHhEy+SX01Y30X9VZqQnefOBSubi9
         CkX8UEBLQmWeMA8E4OjE4bdUAPTNMVTMGxLi5sofNV7JPWN/wu3HhXQv3HxNGwYGrgcI
         i1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UB/V2OMSTCgHtH1m9OSlkcyNv221wepPJzWI5BJPRJw=;
        b=BaUQoSt56a3D6pdRK6IYXpcVpo8g/XYigXNJPxmpgGwoeA0j0kqxyCtGnqLugUvSTp
         ScB0x1TnMCyPR2HHLZUeqyM0xmhpl9TZklCbSzq5Nrj61VXmngB/U05Qby/MQCpiipqc
         FJapOiYXwvtmslLdP8Nj0W+aeMsM0+a1Bd2Yq1B/L2C0jJ+9OzlExtTCbVZzMo0hbYl6
         9DeZ7Ktr8cLWEpM/aO8KaYgxoho3i7MUf6uXr4JiRtD7WKjpc5B10fUMyNKooX+m9/Xy
         XVpljOf6eOCq4H0a82Q7qv8tvyYfEHzbohMl1k0C3t/S3uED1gRTrpYI3ETGAF7j8tsf
         d7RA==
X-Gm-Message-State: APjAAAVWrmcho8QuJI2weNErZnwMVo65l/2OSe7qk25iXvASvtecrnPV
        u8Fb8eggCrIQNzqK9gjeaK333A==
X-Google-Smtp-Source: APXvYqy4Lmyg64r5+JQqQsmUcI2tAyUpENu2hoDKUXLnkSCmi3msSrtAGDbxtfj+O4bJ2lM+5f9Mug==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr4103362pgh.247.1556473273986;
        Sun, 28 Apr 2019 10:41:13 -0700 (PDT)
Received: from ?IPv6:2600:1010:b144:c2ea:2812:6533:d7:28e? ([2600:1010:b144:c2ea:2812:6533:d7:28e])
        by smtp.gmail.com with ESMTPSA id s9sm41284713pfe.183.2019.04.28.10.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 10:41:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] x86/thread_info: introduce ->ftrace_int3_stack member
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190427100639.15074-2-nstange@suse.de>
Date:   Sun, 28 Apr 2019 10:41:10 -0700
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net>
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-2-nstange@suse.de>
To:     Nicolai Stange <nstange@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 27, 2019, at 3:06 AM, Nicolai Stange <nstange@suse.de> wrote:
>=20
> Before actually rewriting an insn, x86' DYNAMIC_FTRACE  implementation
> places an int3 breakpoint on it. Currently, ftrace_int3_handler() simply
> treats the insn in question as nop and advances %rip past it.

How does this not crash all the time?

> An upcoming
> patch will improve this by making the int3 trap handler emulate the call
> insn. To this end, ftrace_int3_handler() will be made to change its iret
> frame's ->ip to some stub which will then mimic the function call in the
> original context.
>=20
> Somehow the trapping ->ip address will have to get communicated from
> ftrace_int3_handler() to these stubs though.

Cute.  But this should get =E2=80=9Cftrace=E2=80=9D removed from the name, s=
ince it=E2=80=99s potentially more generally useful.  Josh wanted something l=
ike this for static_call.

> Note that at any given point
> in time, there can be at most four such call insn emulations pending:
> namely at most one per "process", "irq", "softirq" and "nmi" context.
>=20

That=E2=80=99s quite an assumption. I think your list should also contain ex=
ception, exceptions nested inside that exception, and machine check, at the v=
ery least.  I=E2=80=99m also wondering why irq and softirq are treated separ=
ately.

All this makes me think that one of the other solutions we came up with last=
 time we discussed this might be better.

