Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC340C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D8922CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdrzFPeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfIDPvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:51:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33423 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbfIDPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:51:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so2997454ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFAvPhoN2SvcycRnus8t/fejSDRA815fnGKeS148qbU=;
        b=tdrzFPeYQb2Z9jy0JbBpPVMKz4nczBWCgxlxrPnZLrrUKo1fe4CqyQALwV/cQP61dK
         dqpjtg2g/C3DS1xO2/oUgIV7CjsS+hDZ9mxDpQYzSpKQZPc7T5DKMlCTM10pqkrPo7Ri
         A6x4ysxckn8cuy7ASQK3K5OUDu+yyCreA2cfEFwiHwJIjAsaZa822LDPkCPF+G7S+njv
         5ID/+iUKXiSfoeTgPg1o/s6epVqvpCGJqOTgs5KlsukY+qGfKfeg2734WrxsIqcFWv7H
         VoSOWES6v1RZJHORu0fwXUJwTv4BKSyVOyhoa62SUAVAOM8Nem2UttsFFLhXy1BNY6ew
         1yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFAvPhoN2SvcycRnus8t/fejSDRA815fnGKeS148qbU=;
        b=hi4/GsW6J5VEU1jpwtqUTve2+yNHEWMn8nN1LXoCP/DhiuXieyxNyQDokYPXQ4BjN1
         MLkV3xIR+DSjEzvSqeGQlHV8D5oJrM3xZi4TJgg8UPyWgLjvqgZXEbAZtk553+4aLlMw
         hcyW9GsMFABIJjdCHO7ougrmEKtV3ru0H/fhv2xWrQcGVzTd6WfMEi83umn/WO/7u178
         OKksm/qV20DSGmljb/SMBKaWstRuHvVW16X0XV5nczwZhZ3BtyumBxVHBy/dms9Wbccf
         UKFJf6xPMYfQLS94ElnJzkpZnEVrmhIk3aVu/WyGstiv865xE+625nump4YxKqxyuTQG
         29Jw==
X-Gm-Message-State: APjAAAVdfSj/nfKb02x8wjVlyJD+AJbIk3aWS1ECG7v210d8N6MjDkIc
        aSD0AiUr+tQy6KJnLK8bKJu+/p3S9QsyoRN8aTY=
X-Google-Smtp-Source: APXvYqw69sG7/zWrH8uBBz2uREaQFuHJ3YME+A/L8bbWW6hHMxOpYy3UfDxghTs15adFcj3de9oxpAxHjQ2XHBkL6fs=
X-Received: by 2002:a2e:a40e:: with SMTP id p14mr10160052ljn.29.1567612292650;
 Wed, 04 Sep 2019 08:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190903154340.860299-1-rkrcmar@redhat.com> <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com> <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com> <CAADnVQJzgTRWUAaH+L6qwJvHk0vsLPX3eWdZNUr5X77TuEgvPw@mail.gmail.com>
 <20190904154000.GJ240514@google.com>
In-Reply-To: <20190904154000.GJ240514@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Sep 2019 08:51:21 -0700
Message-ID: <CAADnVQK+bSzFdZmgTnDSgibhJ81pR19P6hFArqmZa_xKA1r1VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jirka_Hladk=C3=BD?= <jhladky@redhat.com>,
        =?UTF-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:40 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Sep 04, 2019 at 08:25:27AM -0700, Alexei Starovoitov wrote:
> > On Wed, Sep 4, 2019 at 6:10 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > I wonder if this distinction of "tracepoint" being non-ABI can be documented
> > > somewhere. I would be happy to do that if there is a place for the same. I
> > > really want some general "policy" in the kernel on where we draw a line in
> > > the sand with respect to tracepoints and ABI :).
> >
> > It's been discussed millions times. tracepoints are not abi.
> > Example: android folks started abusing tracepoints inside bpf core
> > and we _deleted_ them.
>
> This is news to me, which ones?

those that your android teammates abused!

> > Same thing can be done with _any_ tracepoint.
> > Do not abuse them and stop the fud about abi.
>
> I don't know what FUD you are referring to. At least it is not coming from
> me. This thread is dealing with the issue about ABI specifically, I jumped in
> just now. As I was saying earlier, I don't have a strong opinion about this.
> I just want to know what is the agreed upon approach so that we can stick to
> it.
>
> It sounds like the agreement here is tracepoints can be added and used
> without ABI guarantees, however the same is not true with trace events.
> Where's the FUD in that?

Anything in tracing can be deleted.
Tracing is about debugging and introspection.
When underlying kernel code changes the introspection points change as well.
