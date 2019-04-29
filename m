Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96111C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528BC216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556563415;
	bh=TYbYR6xdiAT33fFeBDJqUP8mpRliL4fUyIr32o3R6Ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rRyf22E2JqunQqBwfItzbslu7KXDSlEXy9sR9ZMyfrdhmWfI8bYFBXIvEjUPyneaD
	 T+Jr1h/XgrakYF6BLn+ObTSj3qMzteRMxpue2J+RyMxh1VdE7uoUD6SPiYOZx7EkSi
	 KYUahgEQinBgmWnLQzJXZERhfWi9Rebg6sXHYnJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfD2Sne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbfD2Snd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:43:33 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104832182B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556563413;
        bh=TYbYR6xdiAT33fFeBDJqUP8mpRliL4fUyIr32o3R6Ao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ild4RLQx9rtlOvTMTH/a2NOZwv2KhSkHHDSs0/ztbX9IjEWNeAvPTIQTDmmrTUpaP
         P/Jlymb7EAxnHAX7dIW4dLamRL85KAqgyYJcADejzz0al8WIhPxUz7QWocmNVaz1IN
         d+Gx835qgvYw2xFHS1KphzxoLeAN69ShA+e9NJA0=
Received: by mail-wm1-f49.google.com with SMTP id y197so601104wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 11:43:33 -0700 (PDT)
X-Gm-Message-State: APjAAAWafbqGynmchb9oIYlAwPfic9MepRIUdq5ttSAUPO4oBgr481/p
        kH3FYCDNRzuKfdASlrTeOxPUsQzsCxAmWGgKjHeQAg==
X-Google-Smtp-Source: APXvYqwXpPlusyb3Pkf6NhTuJxrB50rMCwVMOgK5uUwclcgN2qAcz9570f515mL5RGC1hGTQHUSXomHSXsEL/JsKib8=
X-Received: by 2002:a7b:c844:: with SMTP id c4mr331867wml.108.1556563411667;
 Mon, 29 Apr 2019 11:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com> <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com> <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com> <20190427104615.GA55518@gmail.com> <alpine.LRH.2.21.1904300425200.20645@namei.org>
In-Reply-To: <alpine.LRH.2.21.1904300425200.20645@namei.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Apr 2019 11:43:20 -0700
X-Gmail-Original-Message-ID: <CALCETrX0T0_Cn8UivmRwtRZ8N3joT_MfQom+TKLZ2aqxqm7dYA@mail.gmail.com>
Message-ID: <CALCETrX0T0_Cn8UivmRwtRZ8N3joT_MfQom+TKLZ2aqxqm7dYA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call isolation
To:     James Morris <jmorris@namei.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:27 AM James Morris <jmorris@namei.org> wrote:
>
> On Sat, 27 Apr 2019, Ingo Molnar wrote:
>
> >  - A C language runtime that is a subset of current C syntax and
> >    semantics used in the kernel, and which doesn't allow access outside
> >    of existing objects and thus creates a strictly enforced separation
> >    between memory used for data, and memory used for code and control
> >    flow.
>
> Might be better to start with Rust.
>

I think that Rust would be the clear winner as measured by how fun it sounds :)
