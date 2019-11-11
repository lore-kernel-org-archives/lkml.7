Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E13C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1912173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573492355;
	bh=kerXYxeDIBHmkYka0SMkH0DKg+eoWx8r5fvRMuswJS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HCQo6pRH4KS9QJtpHA1OkiS8Wl6P1rYWNebCK6R4B4CReAfDxvwJ0/mBCf4ydg8WG
	 p4kzQdr7ekd7Yf2qBkayveEGnTaJq3y2q34KpbaW38kdz9bjKBgsl2/PQTOoahC6Id
	 KNrc211AM32YNlFVe0yYiURMCu4TOZd7JtsAVT2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKKRMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:12:33 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40677 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:12:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id j26so3369799lfh.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4XtlInCmRKYd6+DapNPQj3u6xWBPubmz/FVdnARJVA=;
        b=IPjx2VrwvjSkOT+YUGpuc+toQRDdsHieYerWOA/nPZo4bOsq/gcm5VmWMQdJXjZfiE
         m9ZrzYc8pIsMaHhRb2pLA4r1ivLb3FUPYMFaOy3UvB2jzMEKaJVCh5mI0h7C2QyF9L9h
         gMUXdq15aJWq94AjstVZFiI2jynHO+BrIROmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4XtlInCmRKYd6+DapNPQj3u6xWBPubmz/FVdnARJVA=;
        b=cQp4bwa29gwdV31eEpzU2OxN+wjvZhnmCUu49VVFBHxKiy3IOWAsyPHPgeJOC/TPF2
         CrSS+/6MGo5x9CTqC9QLU1iXIOt6UXZM/8iALRut91y7I181ZuI3MuxGRfme5mpT4nMI
         4IJ8BeaCJrlxkpwLs61ccmCf4jhlPyu0GJcvWLeTWL0Wru/M7MtCMVr/o8Qz9djk3uVD
         cy383RPdrllrj35XvNpA5ubLbnKyhd1p4x0CeGropkg7hBOial0ptCwy/T1zWOBqWbN6
         6IJGAuIuF9L0QMVozCuE/F6x0QxbvMEv5Y87TbJpLPUfEpvyz81+mYzpPBg90B/SZNx9
         FllQ==
X-Gm-Message-State: APjAAAXlUiuRpAi+xzaQ/gJ36u7d6QOiPFRcQdvkCW3EzcjtHubXaIFJ
        iKQtfKvc0oC5Nw1w9ajfECi/naYUov4=
X-Google-Smtp-Source: APXvYqxS4IBrJ17COWHKyjo/EFGGaucCVRcCJfe9/fH90NtBZJ5etCbt+TG9AcClSKcDQheRg4XvJg==
X-Received: by 2002:ac2:4a8a:: with SMTP id l10mr16235394lfp.185.1573492351035;
        Mon, 11 Nov 2019 09:12:31 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id n133sm6571628lfd.88.2019.11.11.09.12.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 09:12:29 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id g3so14610052ljl.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:12:29 -0800 (PST)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr17197122ljp.133.1573492349231;
 Mon, 11 Nov 2019 09:12:29 -0800 (PST)
MIME-Version: 1.0
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
 <698b03300532f80dfbd30fa35446a33e58ae0c89.camel@perches.com>
 <CAHk-=wiwhMFo6GFUAg3CZJMix4TJo59NBaSDciQxW23RHR8Zbg@mail.gmail.com> <56f05dfb50dfc506a9cab539e522e8f80c738a4b.camel@perches.com>
In-Reply-To: <56f05dfb50dfc506a9cab539e522e8f80c738a4b.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 09:12:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmeR6nJqYFZAUOxBkUTfySE_dEV7HOB0wwzQ0e-_y4dA@mail.gmail.com>
Message-ID: <CAHk-=wgmeR6nJqYFZAUOxBkUTfySE_dEV7HOB0wwzQ0e-_y4dA@mail.gmail.com>
Subject: Re: [GIT pull] core/urgent for v5.4-rc7
To:     Joe Perches <joe@perches.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 5:50 PM Joe Perches <joe@perches.com> wrote:
>
> The !! logical usage is not particularly common in the kernel.
> There seems to be only a couple/few dozen.

Your grep pattern is for the explicitly silly "turn a boolean to a
boolean". That should certainly be rare.

But I meant it in a more general way - there's a lot of common use of
"!!" for "turn this expression into a boolean". A trivial grep for
that (didn't check how correct it was - there might be comments that
are very excited too) implies that we have a fair amount of this
pattern:

    $ git grep '[^!]!![^!]' -- '*.[ch]' | wc -l
    7007

so the '!!' pattern itself isn't rare.

It's so common that the fact that people then occasionally get
confused and over-use it a bit in contexts where it's already boolean
isn't so surprising.

Personally, I still find that pattern non-intuitive, even when used
correctly. Double negatives aren't considered good in English, I don't
find it all that natural in C either.

But it's a pattern, it's idiomatic, and it's certainly not worth
forcing my own personal quirk on other people, so I won't accept
scripted patches to change it.

The one pattern I _really_ hate is the thing that some people are
taught to do: using "5 == x" instead of "x == 5" because it really
reads completely bogusly to me. Some people are taught that pattern
because it minimizes the risk of confusion between "==" and "=", and I
think that's completely wrong-headed.

Trying to teach people to write illegible code just to catch a syntax
error is crazy. You're "fixing" the wrong thing.

Oh well. We have a couple of those in the kernel too.  And I'm not
going to enforce my personal quirks there either, even if I'm
ClearlyRight(tm) and hold the OnlyCorrectOpinion(tm) in this matter.

                   Linus
