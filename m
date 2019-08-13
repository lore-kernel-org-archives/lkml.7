Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCBDC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F18120844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jl3oAbI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfHMNXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:23:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45851 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfHMNXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:23:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so6341057pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OimHuLZ+hHOhfUejEMlGFM0cbw0bW0viYw6V8eRjvg=;
        b=jl3oAbI8nXaJN8u9zrckaYcQN83teECbAHKgeFCY7YXAbWo5QSGAmC7AX83Kg81jrR
         wHIfECyD17DuOQN1q+8WpBA0Y7Azud+nPsri/AfhlU88cVcwXD0i8Lv6x8UFbF/l/ro4
         jIcYE6GK8r0fh6Du7FtRXatWz0q5hIF91UiKU6t+CQOI0AjDBqmWZgDB+/wH8LmmU1Rn
         LJ0z2UW5KbZrsxYA0r/Ujs4nyuUB9h4MLLYGZecGHgF4443X9mNo0fvVPaYLZuSOQPKd
         RRRHtjIdfKwqBDwiOeS9PtHuw1eYRhIgU2u8dFfFYg7ZmCq+FQnO1XAX+mrZJIUHS8H6
         cSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OimHuLZ+hHOhfUejEMlGFM0cbw0bW0viYw6V8eRjvg=;
        b=hJcVycjgpv/T1124FuZDjcQFZC4aZycmLEJlnqi1NMObW2oEsJJHwUV/8NIeWI6J38
         kBYYht6ZO1I0NiD1pxQpk5wl8uHOdHVSLBKOlATYWLG6gba4421sW47PsVIRdWHVunah
         s9V4QbrfCCkfkZpnV1HYycF0U6qEsr3dKSr3+vX5UepBGnmjTQrTJJp3n5B/IqSAfPdr
         IUUSLyoXcZ/oRYXoaokJgcVYDXRssSW89yYtNLlMb/n66X3skL1PpnKnJebv++LMnQZA
         w+kvTw9gWfpsPXv4zfdhXmYzslL15mdEfEotinu7FjFdvKHPUjj768meDEXahlPFdKpL
         SPHQ==
X-Gm-Message-State: APjAAAXtR2m+eqt/hgMP4HEN0dhWS8niS18TIOr8JXalLnyZVXWUtfhx
        vKB9bNt0NpEW+FSBZB7WK1KcyqsRLsHGfV99GgdoJA==
X-Google-Smtp-Source: APXvYqwpT7K5eeL/AsaPFi5DSDv8bbucf1KzbZhnGHmNuw6OMjnJDLCL+9deXz0+3L8EuMYCkEMcejLnCOAp6T2m+zs=
X-Received: by 2002:a63:c442:: with SMTP id m2mr35234947pgg.286.1565702580714;
 Tue, 13 Aug 2019 06:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+zPDgvDr_Bao9dz_7hGEg+Ud6-tj7pZaihKeYHJ8M386Q@mail.gmail.com>
 <00000000000054f8bd058ddfa341@google.com>
In-Reply-To: <00000000000054f8bd058ddfa341@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 15:22:49 +0200
Message-ID: <CAAeHK+xZRH9-ue0QyEdiWmbFJF6P3RXMud+tE6t3x6Orcxnbkg@mail.gmail.com>
Subject: Re: KASAN: global-out-of-bounds Read in dvb_pll_attach
To:     syzbot <syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com>,
        bnvandana@gmail.com
Cc:     allison@lohutok.net, hverkuil-cisco@xs4all.nl,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        rfontana@redhat.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tskd08@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 2:29 PM syzbot
<syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d90745bdf884fc0a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1454f4d0600000
>
> Note: testing is done by a robot and is best-effort only.

Hi bnvandana,

Could you submit this patch? Syzbot testing shows that is fixes the issue.

Thanks!
