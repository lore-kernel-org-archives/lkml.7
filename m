Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA2EC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED89F2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557614737;
	bh=j5Kq1wmV0e3QZ7WAehUGWtMqpUFvp6XaSKwsh6VOCjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ne2xCyyO872imvV2vQdDya9ro5n6sWYpJt+Cwt3yRxKqvQuIvK1fxxM6brzwMmJR/
	 kmeQrAnNjjx1/eOeHFDGpZW22xb6tA9tj9W6lFI3TtjtfKVcmb9v5yfrkA/P4XVDdK
	 Wu1yRLdPh+Wwwv8gbTKanK5ZcwVGClUrIEm4Ojxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfEKWpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 18:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfEKWpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:45:35 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F5021871
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 22:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557614734;
        bh=j5Kq1wmV0e3QZ7WAehUGWtMqpUFvp6XaSKwsh6VOCjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SakiPGZtPWXJrGkvIOjG/+dAQZv0SyWGj/x7tPcqMxGlssIjAcpTsj2sJJU0QC+yG
         s0Bu4kaLFHLR+6dLkQjZl7c3I7tbmfKN1DDplJLW2TtD4FRx+NwqKSDiuYcE/PA3Mp
         0uhMjWGct/8pSWTU7eOWf3DT/HziOO/3RbwcwzY8=
Received: by mail-wr1-f48.google.com with SMTP id h4so11332044wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 15:45:33 -0700 (PDT)
X-Gm-Message-State: APjAAAXiwt8pCvYvKWzpJ5mGy5v25q2isswOCsIKDEjhHJEr1wsQQy8N
        YM46CtisLjduF+R4kmeOoDY+HRifUxROlrvlFyo1Yg==
X-Google-Smtp-Source: APXvYqyudQF5m9LmMFyks+mdUQhng+fQg9MZdPlooGt6iLzqLCV6n8y+WWz7gXDkPGmSuAJoY27rzjrI06QrDLsFYUc=
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr12879839wro.330.1557614732557;
 Sat, 11 May 2019 15:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190502150853.GA16779@gmail.com> <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com> <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
In-Reply-To: <20190509084352.GA96236@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 11 May 2019 15:45:19 -0700
X-Gmail-Original-Message-ID: <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
Message-ID: <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 1:43 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Reshetova, Elena <elena.reshetova@intel.com> wrote:
>
> > > I find it ridiculous that even with 4K blocked get_random_bytes(),
> > > which gives us 32k bits, which with 5 bits should amortize the RNG
> > > call to something like "once per 6553 calls", we still see 17%
> > > overhead? It's either a measurement artifact, or something doesn't
> > > compute.
> >
> > If you check what happens underneath of get_random_bytes(), there is a
> > fair amount of stuff that is going on, including reseeding CRNG if
> > reseeding interval has passed (see _extract_crng()). It also even
> > attempts to stir in more entropy from rdrand if avalaible:
> >
> > I will look into this whole construction slowly now to investigate. I
> > did't optimize anything yet also (I take 8 bits at the time for
> > offset), but these small optimization won't make performance impact
> > from 17% --> 2%, so pointless for now, need a more radical shift.
>
> So assuming that the 17% overhead primarily comes from get_random_bytes()
> (does it? I don't know), that's incredibly slow for something like the
> system call entry path, even if it's batched.
>

ISTM maybe a better first step would be to make get_random_bytes() be
much faster? :)

--Andy
