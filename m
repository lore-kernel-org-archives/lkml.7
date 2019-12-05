Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E965DC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED252464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLVyGXFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfLELfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:35:31 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37767 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLELfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:35:31 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so3224842qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFj7/o8CY27u2EP/Ii6IWyV6V/qKCHo8NGPo9OoyP2o=;
        b=VLVyGXFmunojbceinV2tb/wrcOELq58HBQBO3PG1yIVJE9cJvQrEbuqEZfs1I80KNB
         NpsR6uAqwQ1je6sENpKTPDm/ZPRPYiyWVyhKhz0Gkvv7qxp0qEVtFkBBxA6A80T2TXsl
         X7m1sn9D0K3nhXLdO1yN+hrVDQu5/hiurh8lYBgW2BPj5Yycs6wAmQwzKT1tL8kEMsPy
         K0NR8MTeoPaHhZSlq8XJVOGWI8DaOELPIF19c03IuvUui/HejI8FD0EVyWCqT64GrbmK
         +X5RQyE6wCiiWL0oRAogajCglCRovqnXNNoySkGhPdL0ztR8wC2vD0Gl8PA4lCPMJHcV
         sd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFj7/o8CY27u2EP/Ii6IWyV6V/qKCHo8NGPo9OoyP2o=;
        b=U2kdQkhvF+nsAE3zPL30nKXrRRzChiEFocJNvvA71rzY3HOZ5FVhYf7cUF0CKs74pv
         tl96c9GA0uIjuxKOfYFyppOw4xiJI0uFyNxi22TatqWXUPTv80MoAD33VnL8vuQWGSdz
         q+AuY7xv9jYQrztOwxOEvCO0N/KXJARdRTc5kcl+fbLG6KVchzKEUcQEkKaKGEQdbccD
         1Hl1sl5RupKwKc3XyXF77P6/hmFEj36fTQPHLCUYt5WlW2wpgwvBOM6nx6EDkKHg1TjA
         hOWOu9OTkWwPtKBPVlv+9YE4IlTb2fg8s77CELoiOCg8rGXdWU5D+kCE64ON27ih1tu6
         hIAw==
X-Gm-Message-State: APjAAAXKWUVX7OiEDERRwVdiCWHV8Rb54XEPk+ZtJ51NoXEvFAuNPNrI
        RodZzZ0mNXQH7SYtU190ArdAECVVIQacIRJenPctzg==
X-Google-Smtp-Source: APXvYqywdNT7YtUlcyhBayK1c5G6KgoYnokHv4gbK83yKRI9KmJz2M3nmPsIV9emnEuu9bBpOrULeU5+4XFCmFaRuPs=
X-Received: by 2002:ac8:2489:: with SMTP id s9mr7043538qts.257.1575545729972;
 Thu, 05 Dec 2019 03:35:29 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003e640e0598e7abc3@google.com> <41c082f5-5d22-d398-3bdd-3f4bf69d7ea3@redhat.com>
 <CACT4Y+bCHOCLYF+TW062n8+tqfK9vizaRvyjUXNPdneciq0Ahg@mail.gmail.com>
 <f4db22f2-53a3-68ed-0f85-9f4541530f5d@redhat.com> <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
In-Reply-To: <397ad276-ee2b-3883-9ed4-b5b1a2f8cf67@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 12:35:18 +0100
Message-ID: <CACT4Y+YqNtRdUo4pDX8HeNubOJYWNfsqcQs_XueRNLPozw=g-Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in fbcon_get_font
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+4455ca3b3291de891abc@syzkaller.appspotmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI <dri-devel@lists.freedesktop.org>, ghalat@redhat.com,
        Gleb Natapov <gleb@kernel.org>, gwshan@linux.vnet.ibm.com,
        "H. Peter Anvin" <hpa@zytor.com>, James Morris <jmorris@namei.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, stewart@linux.vnet.ibm.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:41 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/12/05 19:22, Paolo Bonzini wrote:
> > Ah, and because the machine is a KVM guest, kvm_wait appears in a lot of
> > backtrace and I get to share syzkaller's joy every time. :)
> >
> > This bisect result is bogus, though Tetsuo found the bug anyway.
> > Perhaps you can exclude commits that only touch architectures other than
> > x86?
> >
>
> It would be nice if coverage functionality can extract filenames in the source
> code and supply the list of filenames as arguments for bisect operation.

What is the criteria for file name extraction? What will bisect
operation do with the set of files?
If you have a feature/improvement request, please file it at:
https://github.com/google/syzkaller/issues/new
