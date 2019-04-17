Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4CEC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30520835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NCI0ni3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfDQDWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:22:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33549 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfDQDWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:22:51 -0400
Received: by mail-vs1-f67.google.com with SMTP id s11so2108363vsn.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxvFZ8IaG2ZN1MUA/KWcr3EWiUYdKNMdKRGal60ZBBw=;
        b=NCI0ni3drpPOdYU9pW9QpwGYniGE4XO/OVYjYN7l9JVJUpxoBd0M5zIXbDoYBOLkec
         1YnwI85Szj4MD3KpZ49A9rA5EzqpRhfCtApu68ESj1sKRDSwYKZUCPKJxwyKNLhuZACs
         64h910mSYcm+wfgyrD5I3wc9UYxRxl4BbtXPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxvFZ8IaG2ZN1MUA/KWcr3EWiUYdKNMdKRGal60ZBBw=;
        b=Nqs/k44vruEuvlrPLKcfhD+SHxMDqRu395ydfp1fuA93/BMKmC3GefVzxjCqWAevC+
         B9zMZpAPqAeFpdHD5w3IyIY3BJngz52gX+vf8nSVgZ/eeyLg2rxw5wigceYzeNJ2qVuZ
         4zlLVKETrVcJXMfDxJ/rJ9aN0VX2KDgZn3u7w952fl68Q5yUlA8JLs+75DvcV9j/UHkV
         Vuy++iJOcGS5zzD662cTBu94HCXMEq0lhRGpL7pZ3WVQEU9DAH5/Eumg3THrrbyc+u7O
         buM2Yfk1UcXiX/kdkWvxNNTEGWCOBmIeTI/NZZaNyb/02MloXF+esIyWbGyUSvuEWA3H
         hupw==
X-Gm-Message-State: APjAAAUc4fnS/VFIHSNPgV0Pxx7vAMrQTznfyUymKdDcUXtpF8fYs5az
        feqs+vbXh4sSFZDuZk8N6r0AniXI/3M=
X-Google-Smtp-Source: APXvYqw9uzdkOxr6AJxUBxwWcicXPQrqGlxegrRgg8/3FNMolT1yvdec2t+LpaglhRZPdG0kc5Hadw==
X-Received: by 2002:a67:e418:: with SMTP id d24mr47035580vsf.8.1555471370293;
        Tue, 16 Apr 2019 20:22:50 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id u6sm5598288vsu.12.2019.04.16.20.22.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 20:22:49 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id n4so12798948vsm.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:22:49 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr45204600vsc.115.1555471368835;
 Tue, 16 Apr 2019 20:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
 <CAGXu5jKfWV=FXCoKORTdLooMxLCkzscPcq75HkM4EBGyvcVHkQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKfWV=FXCoKORTdLooMxLCkzscPcq75HkM4EBGyvcVHkQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 22:22:36 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJBcWjVKePH9VhPvG9H9xL+iLimESBbQvFaNBiAvGpKww@mail.gmail.com>
Message-ID: <CAGXu5jJBcWjVKePH9VhPvG9H9xL+iLimESBbQvFaNBiAvGpKww@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:21 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Apr 8, 2019 at 5:09 PM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > Use the shared variables for range check, instead of declaring a local one
> > in every source file.
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  kernel/pid_namespace.c |   3 +-
> >  kernel/sysctl.c        | 193 ++++++++++++++++++++---------------------
> >  kernel/ucount.c        |   6 +-
> >  3 files changed, 98 insertions(+), 104 deletions(-)
> >
> > diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> > index aa6e72fb7c08..ddbb51bc4968 100644
> > --- a/kernel/pid_namespace.c
> > +++ b/kernel/pid_namespace.c
> > @@ -290,14 +290,13 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
> >  }
> >
> >  extern int pid_max;
> > -static int zero = 0;
> >  static struct ctl_table pid_ns_ctl_table[] = {
> >         {
> >                 .procname = "ns_last_pid",
> >                 .maxlen = sizeof(int),
> >                 .mode = 0666, /* permissions are checked in the handler */
> >                 .proc_handler = pid_ns_ctl_handler,
> > -               .extra1 = &zero,
> > +               .extra1 = (void *)&sysctl_zero,
>
> BTW, I don't think these (void *) casts are actually needed. I thought
> extra1/2 were already void * so assignments don't need the casting.

Nevermind, I see akpm already mentioned this, and I see it's the
"const" removal now.

-- 
Kees Cook
