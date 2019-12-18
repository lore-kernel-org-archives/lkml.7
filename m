Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90F224650
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699374;
	bh=TehJMniNbmnJpFHgVlyeC0fD3fJKdPDhq2AyEC4N6c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sOsM+JYuWZHejHoNcKOxeoPZMwZFieKfDDurOS8e/PmNaS2/gIWhIBhtF9XnmqMt2
	 /rqMN8CvM6EFznPHWlt4yYqfz9d9qC81YAcE2zulTY5LqHsdaJfXigRamYsW/IhDRu
	 vmeSZb2GYTGNBhEz9CPAZAT3y5LzW1kDyaF2OnZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfLRUCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:02:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35548 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfLRUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:02:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so3545311lja.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5MHuR+Dfrg48Y42Cv+YWOTLJx7dFcX68zXwZq7HNVE=;
        b=PRynXANEkijzYdjvzq7/KxT6QPnEdAJQ01vTFcBAkcxcPCOUchyYmi1fc4GRmhY+FN
         BswAgZG4tc+rRLi/QGsOpnyK/w0DQjALeHSoI/EhuA9pD+fPXboSdkw5AdB5wGESSwQp
         L3nlaywm1L+/BTVj6LHIGuPQGS+EIAgavYgvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5MHuR+Dfrg48Y42Cv+YWOTLJx7dFcX68zXwZq7HNVE=;
        b=dTYn4/3KlbTlTowGR/oyz0+mDdDXUQ9m5mfmf9DSPBhi4CZYT55pa6DxQlp26/XfOC
         HA0n9wedoD+jCH2gL38GE7rBjvfBzp88blQSIWQAYk4wa2t93/5eF9T7k5AUqTl2WSob
         HYAlPf05U0TgOtVk4tgBDDK1k9RtWdYySl550KStSWG5x3KvkwGFG3FpVJxJteYQY4w7
         HDDSJXe4DTL379KjTIyK82oyrTfLbSRWNTF64U6qMNdApQmaLj/cwzWAfVCRoOoGp9YD
         Zo9EBFCI0TBKgcLMZ7KTvZeMSsnPRS0nueGO4fDV8guQDPhNxZBKuA8vSQPg/Gh5ouvo
         rUgQ==
X-Gm-Message-State: APjAAAWnr6fGvJtHmpTyI3Ped+slTce2sNe9sePTtFBQp0SoyjLcTx7X
        nNHVCmfb7sFEjMAvq72QyCB4zAAr1us=
X-Google-Smtp-Source: APXvYqxOhjxVezbR5n55uh7MRBuzXNtUGWxXVCAWWZAR94yGbsOkIGL16M2Y4IF4NlNnjZTcBSpq8A==
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr3155579ljc.39.1576699370009;
        Wed, 18 Dec 2019 12:02:50 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u7sm1604533lfn.31.2019.12.18.12.02.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 12:02:49 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id i23so2594851lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:02:48 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr2943402lfi.170.1576699368241;
 Wed, 18 Dec 2019 12:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20191126110659.GA14042@redhat.com> <20191203141239.GA30688@redhat.com>
 <20191218151904.GA3127@redhat.com>
In-Reply-To: <20191218151904.GA3127@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Dec 2019 12:02:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNhwFigBDSnyrfJYxr-uAe6PHiWTcHcZzPW+vZ3eWAXw@mail.gmail.com>
Message-ID: <CAHk-=whNhwFigBDSnyrfJYxr-uAe6PHiWTcHcZzPW+vZ3eWAXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86: fix get_nr_restart_syscall()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 7:19 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Andy, Linus, do you have any objections?

It's ok by me, no objections. I still don't love your "hide the bit in
thread flags over return to user space", and would still prefer it in
the restart block, but I don't care _that_ deeply.

            Linus
