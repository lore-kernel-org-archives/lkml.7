Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD3CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D837205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fHaCcoEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfD2GpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:45:06 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:47414 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2GpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:45:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id 48EE367E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1556520304; x=1558334705; bh=HR/VsmL+Sl
        Q9LEfLNg0cZiRdW29pIMsOScEdB/7Npfs=; b=fHaCcoEZcOn9WXjsUKLGQ6E6JI
        F+D6woSg4zHjjqUYhRQyDVDzUSZYxRyHFdA96ELWnwxKB6C1maxT9Nr2ypWJaFK9
        DHBMOEKnubKVxfA7+kVR5kRsymCYWV1b0RdcYarW4eiT5qdGhTjgu0ZuhWh0qrde
        qBWqTQ63NUga4gx9JvRE6Oc1SijLQP926B2XPR60dGpdqmNF7icdx3Gnst3f7ODq
        MMWc1gaSG96V2hF0heiUAX5L4meAaI4UOlEgik9JE9Mr3FPNul7jSKTGKVNeZeLZ
        oaMz2qeMm1ZA2c52cw6k18oJdkgpSdMuboL9SSPH0iuZXNyz7pNg/9Pvue3Q==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b2ytbYYLEpa1 for <linux-kernel@vger.kernel.org>;
        Mon, 29 Apr 2019 01:45:04 -0500 (CDT)
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com [209.85.166.180])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id 263B5603
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 01:45:04 -0500 (CDT)
Received: by mail-it1-f180.google.com with SMTP id z17so9975498itc.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 23:45:04 -0700 (PDT)
X-Gm-Message-State: APjAAAXdAuyuzsw6WdmgVths9qxMqdwvGT5aZzTvsWZzDbAoKG21kqbI
        0UDJo4EDnpOBm+qTcfml94jShwb05h+8DmbnEYM=
X-Google-Smtp-Source: APXvYqwmcBj42HoRDaYE7ExTxp+2Gctub0ZLZgUoKG3V35QOlgB829b/DrYE8s3uHW8sArdfI7YGEeZfc8W1tYIFh8s=
X-Received: by 2002:a05:660c:148:: with SMTP id r8mr4672499itk.125.1556520303936;
 Sun, 28 Apr 2019 23:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <1556433754-3291-1-git-send-email-wang6495@umn.edu>
 <s5hd0l6mwbz.wl-tiwai@suse.de> <s5ha7g9l6ea.wl-tiwai@suse.de>
 <CAAa=b7f7MMJ=2PBxz8yYM6u2SX7T2-YnC37gbapc1f9HOPQdeA@mail.gmail.com> <s5h4l6hl3ca.wl-tiwai@suse.de>
In-Reply-To: <s5h4l6hl3ca.wl-tiwai@suse.de>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Apr 2019 01:44:28 -0500
X-Gmail-Original-Message-ID: <CAAa=b7dHFLnXWEd+v5LOVuGDim5zP+w=qy_aFAgiiMrbVBmmxA@mail.gmail.com>
Message-ID: <CAAa=b7dHFLnXWEd+v5LOVuGDim5zP+w=qy_aFAgiiMrbVBmmxA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usx2y: fix a memory leak bug
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kees Cook <keescook@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 1:42 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 29 Apr 2019 07:50:11 +0200,
> Wenwen Wang wrote:
> >
> > On Mon, Apr 29, 2019 at 12:36 AM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Sun, 28 Apr 2019 09:18:40 +0200,
> > > Takashi Iwai wrote:
> > > >
> > > > On Sun, 28 Apr 2019 08:42:32 +0200,
> > > > Wenwen Wang wrote:
> > > > >
> > > > > In usX2Y_In04_init(), a new urb is firstly created through usb_alloc_urb()
> > > > > and saved to 'usX2Y->In04urb'. Then, a buffer is allocated through
> > > > > kmalloc() and saved to 'usX2Y->In04Buf'. After the urb is initialized, a
> > > > > sanity check is performed for the endpoint in the urb by invoking
> > > > > usb_urb_ep_type_check(). If the check fails, the error code EINVAL will be
> > > > > returned. In that case, however, the created urb and the allocated buffer
> > > > > are not freed, leading to memory leaks.
> > > > >
> > > > > To fix the above issue, free the urb and the buffer if the check fails.
> > > > >
> > > > > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > > >
> > > > Applied now, thanks.
> > >
> > > ... and looking at the code again, this patch turned out to be wrong.
> > > The in04 urb and transfer buffer are freed at card->private_free
> > > callback (snd_usX2Y_card_private_free()) later, so this patch would
> > > lead to double-free.
> >
> > Thanks for your comment! Does that mean we should remove
> > usb_free_urb() in the if statement of allocating 'usX2Y->In04Buf',
> > because it may also lead to double free?
>
> Yes, that's another superfluous code.

Thanks! I will rework the patch.

Wenwen
