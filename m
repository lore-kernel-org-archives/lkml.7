Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95715C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD6720880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtKypqkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfDPW7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:59:10 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:36451 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730844AbfDPW7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:59:09 -0400
Received: by mail-vs1-f54.google.com with SMTP id n4so12540692vsm.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkKooqQ06/x99Omqb2YZsUWOnyhQfZoAkUghY8lDlLM=;
        b=LtKypqkZz/Avmq/R7FBhrtR/OhkkC2OJxwlOgGAjNNo4ApmgDl1OwAm9oIC94WGDI8
         mDLa1uLy8HP4RD0i+4P2bs11eWBqmIGbwEMrJYiDvjrIIaCzEBgmGHAxLCsai1i7Hx/+
         BsncVnyzke5GqRZNvq81Amhgn9Sm+LGezJrTNdyKR+IdIS7uiCJniUdf8nEYEcYPp+jf
         hy00cmcfvojmuOIn5QgvSukslKGNbeLBgSCHVSGCcSx+MUC9Iwab1SLagdtK+g7liMg6
         4pSwyX2cm48P6SKPY237YQKCHqV2TPjxooIs84waCtJmdSACfemUSYQbfLgzaZmNBm/C
         x3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkKooqQ06/x99Omqb2YZsUWOnyhQfZoAkUghY8lDlLM=;
        b=JJR2DhbyFDLEERqUkJ0YyYBXEiuwNvTLXdiMaJYsXy1UpjNYQ54vvfImdPJ9s4IN7w
         sbTnqR4KY9J93odtnWBh3afqxR0XkjgUsFeAd4m1J26mWq1SOudL6waW3npWwbD3Y52l
         WYzxTKjDPJBWUMq39k80jmfUf8PT4AtDdYO+YW8NnAkQWvvYuV5v6YIukNzC/x4DaOaO
         prxrrlrVUR6RoMwUZanT3YelWRzcUbEbeG98f1mgDS2DchCtZCkCByZZN5fDFWX0/55P
         3/N+ZFqA0hXgmIVsBqoUiP6ypt5T5a443xyDWah42ePvbWNNe81Qus2MHgp3h7czlANU
         sWyw==
X-Gm-Message-State: APjAAAXNAVtcODuanS0OZ0W3Ygq0oB+VFenlWh6CKQ5BAsQDDPBvTWiq
        mfX/yIRWNHZkBmi9TnEjvOtBwU8X25W7TtHctAuzM8fJ
X-Google-Smtp-Source: APXvYqw94kp9wRUX5NwhZXgGf/7N2oc1Pq1PZq2W5ytATATR6YKZIyvzu+6cdsq02yFUgNH+T0BbchOxH4J7Jor/jN0=
X-Received: by 2002:a67:f04e:: with SMTP id q14mr47183774vsm.133.1555455547820;
 Tue, 16 Apr 2019 15:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXu5jL6LVU7KyUvwaEHWE6t2TaVBs5TWNayB5cW2=PWzSMyEw@mail.gmail.com>
 <CAGXu5j+Ny=1YF0BkATbU3Xb-fb=_0a1W-iZ3jYFhTcWrTPqCJQ@mail.gmail.com> <40a6486d-2dba-5574-06da-3e0ebb25f2b1@iogearbox.net>
In-Reply-To: <40a6486d-2dba-5574-06da-3e0ebb25f2b1@iogearbox.net>
From:   Kees Cook <keescook@google.com>
Date:   Tue, 16 Apr 2019 17:58:56 -0500
Message-ID: <CAGXu5jKj=SfzZqiPtRir7ombU7cLd=sD0e2ehoY=4+y7pZjyjA@mail.gmail.com>
Subject: Re: BPF RNG
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Hannes Frederic Sowa <hannes@stressinduktion.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:13 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 04/16/2019 03:55 PM, Kees Cook wrote:
> > [correcting Alexei's email address and resending...]
> >
> > On Tue, Apr 16, 2019 at 8:54 AM Kees Cook <keescook@google.com> wrote:
> >>
> >> Hi,
> >>
> >> In looking at prandom_u32() users, I noticed that BPF uses its own
> >> state variable with bpf_user_rnd_u32(). It appears that this state is
>
> Correct, we split that off from the main one.
>
> >> never reseeded like regular prandom_u32(). (See __prandom_timer().) Is
> >> this intentional, or should reseeding be happening?
>
> The prng is not to be used in any security-critical context. That said,
> we optionally could perform reseeding from time to time, though that
> should probably be done generically, so that all "external"
> prandom_u32_state() users could register themselves upon init whether
> they opt-in for periodic reseeding or not.

Yeah, it seemed like it should be built into the API. I'll add this to
the TODO list. ;)

Thanks for double-checking.

-- 
Kees Cook
