Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58FAC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB902072D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519581;
	bh=S5EzSfr7uz1asgFND7AidBJiY1qcdryqnWh8OXVt/z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H4hu+3UMXrP5X5lTq6pwO/eHhASyahNxKHSywtdaCwTq2KhGqoVOiFz+wn1UyE0FR
	 Rm5om1iWssccWCka3eFEnvXFrH6lEFVuxRXKmMZcOy77B+ofRfpNrD17YunIPEgScu
	 9Qh4q1oa6wWveW0jxD/VLQE/EAB9aPY79zvhfVi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfLPSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:06:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbfLPSGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:06:18 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2072166E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519577;
        bh=S5EzSfr7uz1asgFND7AidBJiY1qcdryqnWh8OXVt/z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TEhdLnktDkneS2U8ScbsupaPjrRyLgXviGmjv8fyXhwceZZdPuBlDvLwgGj1XN2ep
         MqB4YXvCEMCZpAipLQv21MJ7GuyG7fzDDtJa8lYOoycO5iWHrTUWpBooPwnINxpV1U
         pSba1UJsUlpjXkMnIi/z/5TRpZ5CLIuca3hlHI5Q=
Received: by mail-wr1-f54.google.com with SMTP id c9so8443761wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 10:06:17 -0800 (PST)
X-Gm-Message-State: APjAAAWSRo9wmIcudj4QM1jGrSarHvN/Egxm8pHuwgt0RlAXbaNJlZsv
        VngZhXi1A66K9Fox+5ZlwB6Lb91GY/PcfX1zCdl37A==
X-Google-Smtp-Source: APXvYqzNIPecnAEIIuC3AYqmcV/03RxgmHT8yLHLhfcvyzkeze3OiCVXOUVH+z/9oav+2xiJixtULNy2GAZ80uDWYuI=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr33046847wrn.61.1576519575849;
 Mon, 16 Dec 2019 10:06:15 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com> <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net> <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net> <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net> <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
 <20191211223407.GT2844@hirez.programming.kicks-ass.net> <CALCETrUr+LwpQm5caeKgXGhaZ87HmcNn4wTsmkPzTEptp6sC6g@mail.gmail.com>
 <8d880a468c6242b9a951a83716ddeb07@AcuMS.aculab.com> <CALCETrW1LDuzcnvav=MY1bUv4jQ25n30La5m5x8tXfDknfV_cQ@mail.gmail.com>
 <053a199934844aef9745d7398494b5a0@AcuMS.aculab.com>
In-Reply-To: <053a199934844aef9745d7398494b5a0@AcuMS.aculab.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Dec 2019 10:06:03 -0800
X-Gmail-Original-Message-ID: <CALCETrWvq9XMTse=9JTtnVYY+U2pGcF-nP=YHvEFq4htxbfGwA@mail.gmail.com>
Message-ID: <CALCETrWvq9XMTse=9JTtnVYY+U2pGcF-nP=YHvEFq4htxbfGwA@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     David Laight <David.Laight@aculab.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 9:45 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Andy Lutomirski
> > Sent: 16 December 2019 17:23
> ...
> > I'm talking specifically about x86 here, where, for example, "Reads
> > are not reordered with other reads".  So READ_ONCE *does* have
> > sequencing requirements on the CPUs.
> >
> > Feel free to replace READ_ONCE with MOV in your head if you like :)
>
> I got a little confused because I thought your reference to READ_ONCE()
> was relevant.
>
> Sometimes remembering all this gets hard.
> The docs about the effects of LFENCE and MFENCE don't really help
> (they make my brain hurt).
> I'm pretty sure I've decided in the past they are almost never needed.
>

Me too.

This whole discussion is about the fact that PeterZ is sceptical that
actual x86 CPUs have as strong a memory model as the SDM suggests, and
I'm trying to understand the exact concern.  This may or may not be
directly relevant to the kernel. :)

> Usually the ordering of reads doesn't help you.
> IIRC If locations 'a' and 'b' get changed from 0 to 1 it is perfectly possible
> for one cpu to see a==0, b==1 and another a==1, b==0 even
> though both read a then b.
> (On non-alpha this may require different cpus update a and b.)
>

x86 mostly prevents this.
