Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A9FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F98204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu8Q9a98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfHBPV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:21:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38179 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfHBPV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:21:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so37918821edo.5;
        Fri, 02 Aug 2019 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u/6xSIRYHiOP85ntjseSZQgtsjWb+fEA7f5+m0DuZOs=;
        b=Eu8Q9a98dbycsbHrjw5S2fpv5HWJJvMYh368ryAYZgHoUjo2Z2fD1TXsG/RmsM9KzN
         pxACT1HmAvWqBnrsjrCHaV29OWB8+z8mOF7LDEwG84CfrctxqmN2DDxoNmnvXRKzfr0f
         gdZd99XWAUVenMrtkx8XFjFZlTwgdwgVA88+XiQ/dnwYQM1gnyUtO3qWrxyu6UZMGAqr
         5FdLvKYXo+ZKLpqZ6NBEvzdo/f4CYuHHaGITr71dYkzvlfXJ7cqAWQp4D9+d8g44nW4R
         NWhYRm15UuTNqpvnjSwCCFPh8iUCsMHe2hGJmgD/AvseERpi+KBAyXQSfqPSM5fRxH7i
         mYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u/6xSIRYHiOP85ntjseSZQgtsjWb+fEA7f5+m0DuZOs=;
        b=f0VWoMl1eLsBr3IlINFB35jTSQhWj8vSk/RgGCIcDxkc7217W+CJFDbp5twhsCB3OK
         9PlIOmEQQpMGq1GdrmdgIZKcCTBTMORFf7zslHymrHyZveaOKwU4Lgnhlh86p4mWO5d2
         O9EuHWoljKfC5ETO/HiinYd67GmtNLjQQAG2WxxaOMSATv4u1d+eHxaU2iO1urUhF7rT
         vbjvhfH2g1DZ3m0aD9CSmYI5lhDlr4t1BwhNU13HZcXKZEnEbihxL+ynUicdgfwRORo7
         xZVw1/3XAcAGsCcz7C09t56hCvS6b97+fSDcOnX1AsMM2EMmcMH4igYhumeDorHYi9Pl
         e8SA==
X-Gm-Message-State: APjAAAU9laJ+G6UpZj9fELyZSgZhJIJ6CnwsOXT5XEb+DuZao1thCWuG
        C9WsQEW6OQkOFDcM2v2j4udogYILEBNZk3ZhlU42IdzsGCo=
X-Google-Smtp-Source: APXvYqzVCrZejk2zw7E8YTLUxwOLFwwlBwdv2rI44EljcQy/4/XE5SgR8YwCaLt00Ld+MkSGZgxVpLrcIIZtG0FcGOY=
X-Received: by 2002:a17:906:7cd6:: with SMTP id h22mr12851541ejp.254.1564759285374;
 Fri, 02 Aug 2019 08:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190802062537.11510-1-hslester96@gmail.com> <20190802073858.19a86f82@lwn.net>
In-Reply-To: <20190802073858.19a86f82@lwn.net>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 2 Aug 2019 23:21:14 +0800
Message-ID: <CANhBUQ23mc8e+RhG48Vcb_xNUcBuGACMN6SuAJzTom5yUirXgA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/checkpatch: Prefer str_has_prefix over strncmp
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> =E4=BA=8E2019=E5=B9=B48=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri,  2 Aug 2019 14:25:37 +0800
> Chuhong Yuan <hslester96@gmail.com> wrote:
>
> > Add strncmp() to Documentation/process/deprecated.rst since
> > using strncmp() to check whether a string starts with a
> > prefix is error-prone.
> > The safe replacement is str_has_prefix().
>
> Is that the *only* use of strncmp()?

This is not the only use of strncmp().
Maybe add a case description like strncpy() is more precise?
For example, "strncmp() on string prefix".

>
> > Also add check to the newly introduced deprecated_string_apis
> > in checkpatch.pl.
> >
> > This patch depends on patch:
> > "Documentation/checkpatch: Prefer stracpy/strscpy over
> > strcpy/strlcpy/strncpy."
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  Documentation/process/deprecated.rst | 8 ++++++++
> >  scripts/checkpatch.pl                | 1 +
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/Documentation/process/deprecated.rst b/Documentation/proce=
ss/deprecated.rst
> > index 56280e108d5a..22d3f0dbcf61 100644
> > --- a/Documentation/process/deprecated.rst
> > +++ b/Documentation/process/deprecated.rst
> > @@ -109,6 +109,14 @@ the given limit of bytes to copy. This is ineffici=
ent and can lead to
> >  linear read overflows if a source string is not NUL-terminated. The
> >  safe replacement is stracpy() or strscpy().
> >
> > +strncmp()
> > +---------
> > +:c:func:`strncmp` is often used to test if a string starts with a pref=
ix
>
> Please don't use :c:func: anymore; just say strncmp() and the right thing=
s
> will happen.
>

I will revise this in the next version.

Regards,
Chuhong

> Thanks,
>
> jon
