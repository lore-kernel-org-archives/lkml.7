Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80A0C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 00:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C2720838
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 00:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="Flo9H/by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL2ALI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 19:11:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45135 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfL2ALI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 19:11:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so28852096edw.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 16:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vvh824TZBnegJvSkK9xRvfwQduMxT+onfQ7CGqFsH/0=;
        b=Flo9H/byGBYPx88NBrUk0p/S0kSMWqsqM20WhXB+e8Gs4ezuPPD6d5/sRxYjir/GdL
         qQtvdeJVpjFwAZA46/fvMNCnVIH+1g3wJjEybGdrC4kN3wkR0LA6w0TP6Lj8G4iJsVbm
         5BEKgNETR7pEOOQNEQ/1FZoIwXB15hLxbGZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vvh824TZBnegJvSkK9xRvfwQduMxT+onfQ7CGqFsH/0=;
        b=BgbvzedI7RA0AhzlxgnImoCFxKf6/THkbc34JVsRDnL1u2vGmPhsPCb79pPQ3Q6dCZ
         MwAoRaq/+SNd0e0KJL8ywURKCLCrYc+HgL0dFYDzTtf0ecHD9qqxliyBMU9a4R8in9jz
         uDMnDsgOCxpNg8kre7dML6SlMMxwG6QYN/PP6hxFJ8TDduzNdIM6uaZl85ofJSkXhht8
         s36MffBxFFOPkIIxnPG8eypVrbxWWyYrbal/OXYG/OMTOTdx0kGj0AKgH7d1rr6wglzz
         QhXhNIyF5pxYsiCZ5d3WIRJiqJULls3LeDSPQiDXFVUcbYM6VRNQaBrOlDAW0GSIWtct
         AV2A==
X-Gm-Message-State: APjAAAWtVTis0zlYoMciTyCy4NyOBzuflm+AFQm2YHcEOZZdnpORtgrS
        zgzEOgLARQrS/oiyq7XFnTTF++mcbl2aen1rgNX+5A==
X-Google-Smtp-Source: APXvYqzOB5yH7dZk4bwrTsn7INBIkA6k8Lm79RJV2L22B4Ra+1C3I+kKbxUBH9HEmK/i+WEbfdRW24yd7NwQjfB2oCw=
X-Received: by 2002:aa7:d714:: with SMTP id t20mr63876652edq.93.1577578265781;
 Sat, 28 Dec 2019 16:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal> <20191228181825.GB6746@cisco>
In-Reply-To: <20191228181825.GB6746@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sat, 28 Dec 2019 19:10:29 -0500
Message-ID: <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 1:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Sat, Dec 28, 2019 at 01:48:39AM +0000, Sargun Dhillon wrote:
> > The seccomp_notif structure should be zeroed out prior to calling the
> > SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> > whether these structures were zeroed out or not, so these worked.
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  samples/seccomp/user-trap.c                   | 2 +-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> > index 6d0125ca8af7..0ca8fb37cd79 100644
> > --- a/samples/seccomp/user-trap.c
> > +++ b/samples/seccomp/user-trap.c
> > @@ -298,7 +298,6 @@ int main(void)
> >               req = malloc(sizes.seccomp_notif);
> >               if (!req)
> >                       goto out_close;
> > -             memset(req, 0, sizeof(*req));
> >
> >               resp = malloc(sizes.seccomp_notif_resp);
> >               if (!resp)
> > @@ -306,6 +305,7 @@ int main(void)
> >               memset(resp, 0, sizeof(*resp));
>
> I know it's unrelated, but it's probably worth sending a patch to fix
> this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
> the kernel is older this will over-zero things. I can do that, or you
> can add the patch to this series, just let me know which.

I was thinking about this, and initially, I chose to make the smaller
change. I think it might make more sense to combine the patch,
given that the memset behaviour is "incorrect" if we do it based on
sizeof(*req), or sizeof(*resp).

I'll go ahead and respin this patch with the change to call memset
based on sizes.

>
> But in any case, this patch is:
>
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
>
> Cheers,
>
> Tycho
