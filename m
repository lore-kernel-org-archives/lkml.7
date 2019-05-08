Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDFDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2F420850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 04:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSRC3csH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEHEnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 00:43:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37359 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEHEnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 00:43:00 -0400
Received: by mail-io1-f67.google.com with SMTP id u2so12615856ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 21:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WCwzVUAfPRUJz4fPZuWZIqE5cUDRL0qnnun9aptMzE=;
        b=TSRC3csHbrdmnBA++3zFijCDqlgp4NfYnu68g3wIx2wJnZxn0DixJdQMODYpe0a+v0
         dKaYTfe36UDmtBA7d0p+MAS3cQ051S9ZJ3hX056cNqYgr4ANYYbx4HdbLEyqpUJ6IS5d
         wNMwdXyOjh1xNAd+iFWQrHd9HSSVhZyIx7nLdvncmvJClyfPtKv6nI4+5xb62zQBhlcK
         gbX3Vj4iL16OnwROTT8+igQ0+CfFg94HX1guy4SQa6C5M6Q/DK3pyrmbOW/TOeQ/BuSm
         slTGtQwNmhh+A+yjSVJSpPM4Ig9UBDl0guj5EW24eyj2mNBiLDEM2IMo6q2AIh5qDrmI
         uqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WCwzVUAfPRUJz4fPZuWZIqE5cUDRL0qnnun9aptMzE=;
        b=e2cV6kTx8pdBy+Syl2htdYWSJ2xc8y9bZniztTgnzDvIYhtkX0eqLIQ+kBfs1PTByq
         bX0VLfj42gUCYVTwcUKnuFXiKiFm8Zu+ACQ+hTkIJK7eEOjO4kDTp8AZDwdmJAtYaC0r
         oqmn1fV5vYjWguiCFNK/PaT+vU1gaJwb7KFx6eYnu1iBl3gAzT0msDBrlTPJnjsOe3Gm
         VFpvalqqa9XN6BE2tnM8DmMSEfLT3iQORsxjxM1Ay7jR2iLlFnTJT4W5BCVKaJXbUue5
         Z926kUmwHcZIP8++SsTdU2zU+IB6UV1ZL8fxMYXZUv4pf1XCQk3vSdOpr5vTm2fdAPqL
         0FRw==
X-Gm-Message-State: APjAAAU/quyadc3LgFnXg8k9qITfHNADdTsQXHXQD/8VQR2tIPNjOgCq
        r9LF7dHJHv1+IckMTcsj37zm0Sh7wTrXe6fAiw==
X-Google-Smtp-Source: APXvYqxgcAPlK8eAIzaA6Y4YNWlH8aXlOm5ev0pdKSUav1mrAgdnGcQRAOamFpNARCHgCX7/boEvmNQ5MkXyeCqfJW0=
X-Received: by 2002:a6b:7d08:: with SMTP id c8mr14495246ioq.259.1557290579930;
 Tue, 07 May 2019 21:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <1557208860-12846-1-git-send-email-kernelfans@gmail.com> <20190507082808.GB125993@gmail.com>
In-Reply-To: <20190507082808.GB125993@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 8 May 2019 12:42:48 +0800
Message-ID: <CAFgQCTvFawbT0NwKbWe+1R-GP6NxSEhsfejJOPk37B=h0AckBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot: move early_serial_base to .data section
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 4:28 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Pingfan Liu <kernelfans@gmail.com> wrote:
>
> > arch/x86/boot/compressed/head_64.S clears BSS after relocated. If early
> > serial is set up before clearing BSS, the early_serial_base will be reset
> > to 0.
> >
> > Initializing early_serial_base as -1 to push it to .data section.
>
> I'm wondering whether it's wise to clear the BSS after relocation to
> begin with. It already gets cleared once, and an implicit zeroing of all
> fields on kernel relocation sounds dubious to me.
>
After reading the code more closely, I think that the BSS is not fully
initialized to 0, exception the stack and heap.

Furthermore the BSS is not copied to the target address. We just copy [0, _bss).
> Is there a strong reason for that? I.e. is there some uninitialized or
> otherwise important-to-clear data there?
>
I guess the reason may be stack or heap can contain some position
dependent data. (While in practice, there is no such kind of data in
the code now days)

Thanks,
Pingfan
