Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF51FC73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C110620838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562735743;
	bh=KEC88i/FUtxpM6Y+GA9pbexnODI9X6lRmkfMT/XmVoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1JE8CVTJX6PR7cX7S8jWv1C4/c6Straz7uj+RDzVvDYDEdmmxmAtD/qdNbQFCmP00
	 TEQJzsFAlaKmMOYabVPLGlLn5SZhikKRti+k4O61m+OeCGbdGV66TBZM8tbrPflrdj
	 oHEp+vvWZFgZa2cKvNMnA4gRN9CiOChCUYl5cKEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfGJFPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:15:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39135 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfGJFPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:15:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so710406ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEEWxjogIjagUSE0wT1794hee4gozRf3g4wNl67AVvM=;
        b=MFHP3CRcb82VU8dcOPC5KNF1Ff1KK45QYq+TleimZizV0PBS6ZLAjZWM5HM1rMVAtm
         2RzwCGQd08KgNnpPGYpYeljZQpjFqXBsZiAYzFUx/HnFahocaKtHCEs3TNUmK9xSMw0S
         6X6FEndJyM7WHnV8FiqGWE7jPr85i6RYS6LXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEEWxjogIjagUSE0wT1794hee4gozRf3g4wNl67AVvM=;
        b=hG7kP6PmR4JU2hFzldBHy51wunLRcuxkYfiIJT7SzG+gKKFEj54uMghWhWUmM9G9e0
         tkxyBOJDv6n07b8PSfKdjReWqJNZtK6f0ZRdnZQ2mW6OaLeF2tkte6BHZ+Neixctc7Np
         7h1pha0exRGtHtAU4KiPw89Z6ck9J5mC8fLX3PY0Xij35lV6jEkPkJ2ohUlmdCHeYobG
         ChLvRJvBfTBrzox61G1anAGhkBkicNyE1SCtGtDQfKObdqRH7iozb2YUwXLZTjC6Jz8X
         At4CPv/+tm9TFI9xnu0VDGth14X93YfReSYBjJTMWLGc3rXWQTuhOiK1fA6oelTlee6D
         mPLw==
X-Gm-Message-State: APjAAAWo2BK+wZgMAhBI5QIdU87FOUYVGCQRLaBGRvhF4ZVKYD5H/jL3
        cM77iFuxS5iSgiMA7mh382RiqhC2ssM=
X-Google-Smtp-Source: APXvYqzbieBb/LgSIOH543g5xcNgLpEKF7zerQxEGaCb0S8LnFXdV668c8JLqTHWuOUdOq/TcFdpLA==
X-Received: by 2002:a2e:b047:: with SMTP id d7mr16369339ljl.8.1562735739193;
        Tue, 09 Jul 2019 22:15:39 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u15sm244156lji.61.2019.07.09.22.15.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 22:15:38 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id i21so725233ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:15:37 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr16028496ljm.180.1562735737612;
 Tue, 09 Jul 2019 22:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
 <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <CAHk-=wj5E=WTz3jfNFnupCPoLXDyFZdW1xgKvuuU-M1_7MEqaw@mail.gmail.com>
 <CAHk-=wghD6CzP7NxHzG4_-bAqOiad_aAohdETDTpUpyci55kfg@mail.gmail.com> <CAHk-=wgqVLVeBZi8t+2GpTxGdFpD2FsdkL81irF8tc=qqG0t_w@mail.gmail.com>
In-Reply-To: <CAHk-=wgqVLVeBZi8t+2GpTxGdFpD2FsdkL81irF8tc=qqG0t_w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jul 2019 22:15:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjh+h_-fd-gJz=wor42ZNmqq46QnB90jyfzqmKLsLFWOg@mail.gmail.com>
Message-ID: <CAHk-=wjh+h_-fd-gJz=wor42ZNmqq46QnB90jyfzqmKLsLFWOg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 8:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Whee. It looks like it's bisecting to the same thing. Only partway
> done, but it feels very much like my desktop.

Confirmed.

With that config, I get this

  c21ac93288f0 (refs/bisect/bad) Merge tag 'v5.2-rc6' into x86/asm, to
refresh the branch
  8dbec27a242c (HEAD) x86/asm: Pin sensitive CR0 bits
  873d50d58f67 x86/asm: Pin sensitive CR4 bits

ie those "pin sensitive bits" merge is bad, but before the commits is good.

I think there is _another_ problem too, and maybe it's the APCI one,
but this one triggers some issue before the other issue even gets to
play..

                 Linus
