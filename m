Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749E3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D2A214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H9f5jEOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392116AbfETPum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:50:42 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34961 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388243AbfETPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:50:41 -0400
Received: by mail-ot1-f51.google.com with SMTP id n14so13450867otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1C4iYxtac7p2VqbEpBfg+iudX1250ZzqlzhHmAXXEfs=;
        b=H9f5jEOyoAXQMUsOjBnZjUWDTwH5HSn1UqH7DWPl0hqRlsoCzfxfaVqGveP9uYjrcQ
         OOIVCktFwgQ66IAGhiQ+b0FjoY5fAkIES1xibaeuB53zVisAPvGguWzW6ItAIgXKW15K
         dLEKhUyyFM7y3/OMc7gfQX+zsp4m52PdWa+b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1C4iYxtac7p2VqbEpBfg+iudX1250ZzqlzhHmAXXEfs=;
        b=MRtoScYkSU5Uz3yH8dn0FmGjNjM67NweKW5gNKIVbrSoY7HKzFIsasX0XmrfzUg37I
         w2NR9ypnCa7PY9mTyhfcnW+N4Labp8NjcFAsBnz8IyRcv6ZsJDIKi8i07EV8h9S69UK4
         VYNvxk3Vk4ITS8EYXY7G0ouicmsVZZ4fY8ZoVnmUkHMODUL8yJnUTHK463Gy1WmVU9nD
         r0Z5J6tizPMoEojSjRmzPm1+MqzTZzY5lIqYijPcDQuAO6l/vr4mM1sjbauwMvum+c20
         DaQ/Zn/QPjwt35MZYgsCoGJ2/0aKEtEmt+71yjLVqnUZLgLsdT9NoL9dFAGB55hKr/Zj
         f9Sg==
X-Gm-Message-State: APjAAAVedWzt1IW1vB/3wHPUwb93veZg5AFVuMkGxTCoQdEr8HBmQ1uo
        9X/EbkAwSuD163wNp/4nEySBJy4ynXyz8t8prxnuPQ==
X-Google-Smtp-Source: APXvYqwQiK12oNKt4WyuEMkDM/UDHjft/A0ubG87a1nrc9MfTcDKmzXwKAYCSN0bzZpdjwz/lxRBNDPxn5QiETsqLDI=
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr45694071otr.188.1558367440915;
 Mon, 20 May 2019 08:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <386d7978-18fd-318e-ddc9-784266b75d9e@amd.com> <2f4fb196-e66e-bb0e-c5b2-d9072561f648@amd.com>
In-Reply-To: <2f4fb196-e66e-bb0e-c5b2-d9072561f648@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 20 May 2019 17:50:29 +0200
Message-ID: <CAKMK7uEAUxKSnTJKyZvbjRR3fKMgkCDWNV-ty5LENXsy6X+P_Q@mail.gmail.com>
Subject: Re: Confusing lockdep message
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 1:38 PM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Please ignore this mail,
>
> I've fixed the double unlock and lockdep is still complaining about the
> nested locking, so I'm actually facing multiple issues here.

The way we model the ww-mutex stuff is that the acquire-ctx is treated
as a lockdep lock, and then we require that one if you take two or
more ww-mutexes (the nested locking stuff lockdep complains about).

So you already hold a ww-mutex while trying to get a 2nd one, without
holding a ww-mutex acquire ctx ticket. Could be a ww-mutex you forgot
to unlock somewhere.
-Daniel
>
> Sorry to waste your time,
> Christian.
>
> Am 20.05.19 um 13:19 schrieb Christian K=C3=B6nig:
> > Hi guys,
> >
> > writing the usual suspects about locking/lockdep stuff and also Daniel
> > in CC because he might have stumbled over this as well.
> >
> > It took me a while to figuring out what the heck lockdep was
> > complaining about. The relevant dmesg was the following:
> >> [  145.623005] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [  145.623094] WARNING: Nested lock was not taken
> >> [  145.623184] 5.0.0-rc1+ #144 Not tainted
> >> [  145.623261] ----------------------------------
> >> [  145.623351] amdgpu_test/1411 is trying to lock:
> >> [  145.623442] 0000000098a1c4d3 (reservation_ww_class_mutex){+.+.},
> >> at: ttm_eu_reserve_buffers+0x46e/0x910 [ttm]
> >> [  145.623651]
> >>                but this task is not holding:
> >> [  145.623758] reservation_ww_class_acquire
> >> [  145.623836]
> >>                stack backtrace:
> >> [  145.623924] CPU: 4 PID: 1411 Comm: amdgpu_test Not tainted
> >> 5.0.0-rc1+ #144
> >> [  145.624058] Hardware name: System manufacturer System Product
> >> Name/PRIME X399-A, BIOS 0808 10/12/2018
> >> [  145.624234] Call Trace:
> >> ...
> >
> > The problem is now that the message is very confusion because the
> > issue was *not* that I tried to acquire a lock, but rather that I
> > accidentally released a lock twice.
> >
> > Now releasing a lock twice is a rather common mistake and I'm really
> > surprised that I didn't get that pointed out by lockdep immediately.
> >
> > Additional to that I'm pretty sure that this used to work correctly
> > sometimes in the past, so I'm either hitting a rare corner case or
> > this broke just recently.
> >
> > Anyway can somebody take a look? I can try to provide a test case if
> > required.
> >
> > Thanks in advance,
> > Christian.
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
