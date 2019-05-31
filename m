Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C516C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE1B26989
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QDhWzKZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfEaThq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:37:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37527 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfEaThp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:37:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so10363950otd.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LazJJ0VAlutqms0EccXBPd/Ke6xqMO7nmzYQCeNQITo=;
        b=QDhWzKZiTDUw+ka9a3mdapW1M2P8x5RwH1HYXazE9uYQhQgNrftNWlgLdXFpiEmuG8
         xLJayxychMQ+Pn5hyv+08cHRgndcON1YZvEx9MyPvg58IVqQ1dx844wVObVmGx2m3Ija
         WrLUBRPPBbezJKGVtvhFmvZuoEOq83MENcJhfB3bISKm5up7ahiG2/x+qh+19Umybg8x
         iTvdyelGVOeaUZTdxFEoPsjehp6rWhoeLZZCsmEEI/ZJ4BmkF63iPyMPKXQArqeg7iHq
         WhqPehMhljKoh+pqvPFeVjH77rjmt/qNag1w+acKEc8eVi9xXrWMmP8ZE1XCZLzYsVRm
         jiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LazJJ0VAlutqms0EccXBPd/Ke6xqMO7nmzYQCeNQITo=;
        b=e7xPP92OZzeirnzUtnaH1VH0TteRT6j+3q+V5BTDRF9aKlUxZDQ7nGfJZlZ+CjuPQu
         MUl5kZ3yJBGos9v/QGQ8FHqiQaQIftwS/Pi3S1G2+Y8TeVDwkiXPCkXQt3pWl72cV2P2
         /8PbaXEqt464jDvbet40crS/1C/YlqDgKKlYvWM5kB1YTxbzBxsF0BWj2/ixlLN8vPQU
         mv0CeICx7Z2V19Ro6rFBLsZI6jV8LOQMchDfDedbH0iWv0hShNsoaWjIlWBLetGMvN2I
         Zw9RmM++lPA2sdp10SIL9H8hOuZIBo0wrf5oM/NXLd5B4P7MwTZ3+zsIxk8SpmGC4dRK
         6Jxw==
X-Gm-Message-State: APjAAAU/dYh4q5jGOODchg7hNyBCcCV0G/8srIaxIGQLydKFrjueXWXm
        PYjXsySfh1G7uVQpCCz/kUxEUTBv5JQ28FhMvqqxCA==
X-Google-Smtp-Source: APXvYqzwo/L+a9o1meY72F4EWaxvBuSyyff6w0cP4UBzQTi9oFpKR1tmAMG4wIPmb/GdAmGGc82tuYpAJU9gm2hydxg=
X-Received: by 2002:a05:6830:1283:: with SMTP id z3mr3030425otp.228.1559331464853;
 Fri, 31 May 2019 12:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190529113157.227380-1-jannh@google.com> <20190530123452.GF22536@redhat.com>
 <CAG48ez0ivQ+gfwKMife-3ZwBuqAuc1BhDGW3dtYTHMq0sByuNw@mail.gmail.com> <20190531133535.GB31323@redhat.com>
In-Reply-To: <20190531133535.GB31323@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 May 2019 21:37:18 +0200
Message-ID: <CAG48ez3R=hjfKgh9zR6uoXBM54CRwh99QBqZNvAyHznBd8edgg@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 3:35 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 05/31, Jann Horn wrote:
> >
> > So I guess I should make a v2 that still adds the smp_rmb() in
> > __ptrace_may_access(), but gets rid of the smp_wmb() in
> > commit_creds()? (With a comment above the rcu_assign_pointer() that
> > explains the ordering?)
>
> I am fine either way, whatever you like more.
>
> If you prefer v1 (this patch), feel free to add
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Thanks! I think I actually like the current version more, since this
way, we have a nice simple pairing of smp_rmb() and smp_wmb().
Otherwise we end up mixing smp_rmb() with smp_store_release(), which I
find kind of weird. And to me, semantically, it also seems slightly
weird to use rcu_assign_pointer() as a barrier for previous writes
that are not pointed to by the pointer being assigned. Maybe I'm just
not familiar enough with the details of how memory ordering works to
feel comfortable with it...
