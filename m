Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AEEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C80208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U50ffSmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfIDPZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:25:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34446 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbfIDPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:25:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so20078935ljh.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrNhw/iowpmbOaLlqyXNSras8anFLQSSvH4rAhv7fR4=;
        b=U50ffSmmibfLZ9j6cVS9hlziiLG1lp8+oPxYZ1b3QYdpp1l7ruEchx0P4xmH1aNaDb
         2xJNm055kXNXKwtB9qP6hUtLt7Kjw++9MBCEqkoBgUfXIe0GbTUmQAe1VR7/CUGNggOf
         /kzaTketn4Z/ThKyl/yNaHQ2j3rgG1e68wnK62kmhS7+OB/mFzDfU8exkU94ua6wXA8u
         LciFWXtjMMblWHqWAcB9H161K2lUxhQMxKiLhBsp64sbJexUjY/0IjvAbhc14+rlWtDi
         CRQZdMDG+sutg9WvMQg/+gG1UiC9IwBvCqYv4vy0zHlmSsd2Pc0aDRJ2imvzpJSDVQn5
         K7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrNhw/iowpmbOaLlqyXNSras8anFLQSSvH4rAhv7fR4=;
        b=bh7TiyS0fwRjf6EgExIq18drawxu01W0PtwqwbrIdGTFPzSs9HKm8Ls4fNVL4iQY/5
         Y7DE1ej8eH/JGIwAoUWPKYlytMJrrY8zv6onQBUsA2EN9cDuLeHjLYgX8M0Ob70M39wN
         k3/C8ajLNv8sYH1hP+Z6us5QGNE9gIOcNfzoOf7xrmnfOddmk7eNh6onCEPEe2Y2KJCO
         eVK8FguZcupxUVEpU05EQTBY3iySlHFKOVr3/3OIuiLyuC64U62UShvzOZP4KvSLdMoo
         Qn50elkF/5+2C4Xb9t/nTYInDc6rF4cAEEoj/0Fo/qTSdv+woUm55FtgwaBMaDf02mWO
         7Hdw==
X-Gm-Message-State: APjAAAWk1T5xFPxBOqhQsyDkSaeGKlTqV+Ik0s3mizfB5yNPtZvsC1c2
        zUSVeFh0GuhScNTdklQHU/KNy/xjRaxBe/bSUns=
X-Google-Smtp-Source: APXvYqwUxrxvDHJXB5uRSP+Ast4+YOgT2iBSgkOon+bdcDZSG23DJ3i6SyDGMQnbHQr1yKGPEpiFrF/5BaApe3pc5CM=
X-Received: by 2002:a2e:4489:: with SMTP id b9mr1707860ljf.17.1567610739718;
 Wed, 04 Sep 2019 08:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190903154340.860299-1-rkrcmar@redhat.com> <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com> <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com> <20190904130628.GE144846@google.com>
In-Reply-To: <20190904130628.GE144846@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Sep 2019 08:25:27 -0700
Message-ID: <CAADnVQJzgTRWUAaH+L6qwJvHk0vsLPX3eWdZNUr5X77TuEgvPw@mail.gmail.com>
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

On Wed, Sep 4, 2019 at 6:10 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> I wonder if this distinction of "tracepoint" being non-ABI can be documented
> somewhere. I would be happy to do that if there is a place for the same. I
> really want some general "policy" in the kernel on where we draw a line in
> the sand with respect to tracepoints and ABI :).

It's been discussed millions times. tracepoints are not abi.
Example: android folks started abusing tracepoints inside bpf core
and we _deleted_ them.
Same thing can be done with _any_ tracepoint.
Do not abuse them and stop the fud about abi.
