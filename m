Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1288BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D181E2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 05:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NgmsSQj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfD2Fut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 01:50:49 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:36024 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfD2Fut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 01:50:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 03B825F5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1556517047; x=1558331448; bh=rAiXQROA0q
        qkRb+JUBU+22E2nMTl//fAAwh/KSgRBlQ=; b=NgmsSQj+NDhdaOeDwfN96qrtGO
        YgmzIlwoFF35mGb6MBjCKYwkfMZ49Pf/Yk/JCmc3YcwCdtm25xeFtay/z+8+PWsz
        iz7oxFStTR9fFBRP7lXpSbFC2mLsTVkwpyKWepmqFuavdW1rWsJerc4/ghwWyQVp
        zkKC7FKGKlvW4vj6QdTwS7kl83JqhLZLqyDKbp1hlMNNf1lehJq47T9EZ0Medck+
        yT+TMAju6ReW8iQmIhu/DGI2EkR+X65HQBo0PDnxpx6hQlY5jNiAbg6DMtnW/3ET
        6WXmwlqU+8jmVLe4Ld+bMp2eVcK7P1t9xMpFc4o7kEgJsXSHPrrHfBHDD2qA==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wiRI6Fw9LwLy for <linux-kernel@vger.kernel.org>;
        Mon, 29 Apr 2019 00:50:47 -0500 (CDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id B90345D6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:50:47 -0500 (CDT)
Received: by mail-io1-f42.google.com with SMTP id d19so7940932ioc.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 22:50:47 -0700 (PDT)
X-Gm-Message-State: APjAAAVPTtGeferHiJNx++CQKEg6zHU7N1MDCZPX6Z/R5aKvDlJI3K/3
        z+nnvGjo5dQXMgWNzEUoSDDlM5Tm9nYy/KnJFH8=
X-Google-Smtp-Source: APXvYqyGbeX3BfGfzYsg21H9PDy1g9Qv2pUeTPCGSDB5UiuPmgC3SmOBbda0HPNa+qP9I+TOhA+jcfhIY+b0A+J6ugI=
X-Received: by 2002:a6b:720b:: with SMTP id n11mr8328414ioc.281.1556517047489;
 Sun, 28 Apr 2019 22:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <1556433754-3291-1-git-send-email-wang6495@umn.edu>
 <s5hd0l6mwbz.wl-tiwai@suse.de> <s5ha7g9l6ea.wl-tiwai@suse.de>
In-Reply-To: <s5ha7g9l6ea.wl-tiwai@suse.de>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Apr 2019 00:50:11 -0500
X-Gmail-Original-Message-ID: <CAAa=b7f7MMJ=2PBxz8yYM6u2SX7T2-YnC37gbapc1f9HOPQdeA@mail.gmail.com>
Message-ID: <CAAa=b7f7MMJ=2PBxz8yYM6u2SX7T2-YnC37gbapc1f9HOPQdeA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usx2y: fix a memory leak bug
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kees Cook <keescook@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:36 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sun, 28 Apr 2019 09:18:40 +0200,
> Takashi Iwai wrote:
> >
> > On Sun, 28 Apr 2019 08:42:32 +0200,
> > Wenwen Wang wrote:
> > >
> > > In usX2Y_In04_init(), a new urb is firstly created through usb_alloc_urb()
> > > and saved to 'usX2Y->In04urb'. Then, a buffer is allocated through
> > > kmalloc() and saved to 'usX2Y->In04Buf'. After the urb is initialized, a
> > > sanity check is performed for the endpoint in the urb by invoking
> > > usb_urb_ep_type_check(). If the check fails, the error code EINVAL will be
> > > returned. In that case, however, the created urb and the allocated buffer
> > > are not freed, leading to memory leaks.
> > >
> > > To fix the above issue, free the urb and the buffer if the check fails.
> > >
> > > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> >
> > Applied now, thanks.
>
> ... and looking at the code again, this patch turned out to be wrong.
> The in04 urb and transfer buffer are freed at card->private_free
> callback (snd_usX2Y_card_private_free()) later, so this patch would
> lead to double-free.

Thanks for your comment! Does that mean we should remove
usb_free_urb() in the if statement of allocating 'usX2Y->In04Buf',
because it may also lead to double free?

Wenwen
