Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62178C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3287C2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m6OzZEIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfDXXPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42112 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfDXXPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:12 -0400
Received: by mail-ua1-f67.google.com with SMTP id h4so6621603uaj.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=75tUA0eo/5w+mXwlbYz+08Og1h/WmzUp/QNcyGFFlZQ=;
        b=m6OzZEIn4JKG/f4Y8CdIHSWorehy0J1gZObeV0XTKnmQxSa1pJmh80hTa1Z7A8WeqB
         kzt6F7X4EDDWPMuGbahzeMupOFckt758eRhZIwHGBkpvE7CBPoMV+vWkAISa4bS3TJtS
         Pn6cOGXyrHDkOMamHqF2E6VR64J/kvFElosH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=75tUA0eo/5w+mXwlbYz+08Og1h/WmzUp/QNcyGFFlZQ=;
        b=NTaxKm4PxsXr5kBUe5xojZ1EpKdzjQGM/kgIPZ0deAv/vB9wkEvUfwCcEHZqcnY1d/
         jYD+HZi+yN67mL9XKAC1ZecSE+pckaamce5f5gc+VmvSjzFoBH/JQYTIQZL1IEmfffPX
         SGygsTQZm3KnBofJuCXApAqF848B+lvXXWWP3ZQuyEU4hXb1QPllXttGft+zJWgR5arK
         74LUkDAtDDgB7eE7ivQLqahsQp0KVgd8htdupIH+B+3FNCBn9G9hLb/2HlhHVnQvYDfr
         o0nZIIRjvpLAzsjma2iFrY1bMV6Mq7toc9+ET0CrCnMRXZ1tOSeFkjtfAwqFYdVAXeeS
         riwA==
X-Gm-Message-State: APjAAAU5yWR9Xp0ouQ220nyAi3TuzXsMtgLMFbMNy8ERVcwwKkOjTMPS
        WhLG9rS9ZwA3fMfJoX2sQGEqYpsA16o=
X-Google-Smtp-Source: APXvYqynOVj98pmPt6YzyquE8PJI9Zoc4fIX+zdm14Fe7lrKC7CzV7W2QHqdxnm47qgt/iYCx8HtJA==
X-Received: by 2002:ab0:1d82:: with SMTP id l2mr7348009uak.120.1556147710609;
        Wed, 24 Apr 2019 16:15:10 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id n140sm4741439vkd.28.2019.04.24.16.15.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:09 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 195so4436086vkx.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:15:09 -0700 (PDT)
X-Received: by 2002:a1f:7d8e:: with SMTP id y136mr12792324vkc.40.1556147708928;
 Wed, 24 Apr 2019 16:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181011225421.GA21093@beast> <20181012142902.GD2420@thunk.org>
 <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
 <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com>
 <20190416160948.GE3004@mit.edu> <CAGXu5jLexxSyX4cVz=LrvQ-RDVK+JRfyBJuqTn2UDgqyPiwvMA@mail.gmail.com>
 <20190424221036.GA12279@mit.edu>
In-Reply-To: <20190424221036.GA12279@mit.edu>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 16:14:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ8saM5NqSCZpJ6_xmuy6D1dzQOgsJo8Jfm4LtLnN3qJA@mail.gmail.com>
Message-ID: <CAGXu5jJ8saM5NqSCZpJ6_xmuy6D1dzQOgsJo8Jfm4LtLnN3qJA@mail.gmail.com>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
To:     "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 3:10 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Apr 23, 2019 at 03:20:58PM -0700, Kees Cook wrote:
> > > Yeah, sorry, it got lost; my bad.  I'll take it and push it out at the
> > > next merge window.
> >
> > Gentle poke. :) I still don't see this in -next...
>
> Oops, sorry, I pushed it out to the master branch, and I forgot that
> the -next branch was pulling from the dev branch.   Fixed.

Ah-ha! Thanks. :)

-- 
Kees Cook
