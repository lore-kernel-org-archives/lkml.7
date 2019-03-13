Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076FC2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552500893;
	bh=bWzH3W60Z887MLOLLyBjDuEpNtaggMN+JV0O0KD6dnw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=icsHtZorXTtaDFEIdRa17INGTod3SUw3gkZ4tI+/joK/X7VlPmdqCZwEbtfRLFxvC
	 47toKCE/PK3P6k4sWJ2xBiS84P6UABYILrSbziZmcNoFzehwv6muvilU3Gk7Twecre
	 zJyaeQSggCahsdgdSfShTTKoESZVUq9PwHPgZjQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfCMSOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMSOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:14:51 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43DA021019;
        Wed, 13 Mar 2019 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552500890;
        bh=bWzH3W60Z887MLOLLyBjDuEpNtaggMN+JV0O0KD6dnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u3shdev9LQebkOuTeNAa9QY3+d8a87O9v2C3xnl3YGSFA5NvMFTbkWizuwNKk2mbA
         LKT+SOKw4ByfouB/cZZZs9rdMjPpjcMsrEGCBdZjMWLSonODy4t65exVjpI00m1N8u
         XMPqr64kgod/uBrxS7OrfKMnhkOr4gm9ymz30slU=
Received: by mail-qt1-f180.google.com with SMTP id v10so3018948qtp.8;
        Wed, 13 Mar 2019 11:14:50 -0700 (PDT)
X-Gm-Message-State: APjAAAUK4f6+3tMDFoDsoqkjq5KmoYxlUVjx09oVChRP9/cGGmTF+HGq
        ddh0SE7vMwWH7rd4rjJ9FDfATKbM237mohbAow==
X-Google-Smtp-Source: APXvYqxfz2drWeBbPzzxmMmPm3+gjXx6jCcFEdMvw5BaLbUdoVoUZem7B0SE+2jNsuITz9JwE0SqbpUQYRSE1v25Z9Y=
X-Received: by 2002:a0c:c585:: with SMTP id a5mr10595250qvj.246.1552500889484;
 Wed, 13 Mar 2019 11:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <1548387699-9222-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQ6bRxhXuSgVS0DqZ_izMyKuujmQe9TVV8pDXve-gs90g@mail.gmail.com> <CAK7LNASfATE2zgm7Qz3i2Hm1vxTg_jE-jDwDDJ8ASVg19EdCXQ@mail.gmail.com>
In-Reply-To: <CAK7LNASfATE2zgm7Qz3i2Hm1vxTg_jE-jDwDDJ8ASVg19EdCXQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Mar 2019 13:14:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJm6RP5KNt8tYOa=8Uj2V9EFJMjw=xoabSfEzX-YQEZgA@mail.gmail.com>
Message-ID: <CAL_JsqJm6RP5KNt8tYOa=8Uj2V9EFJMjw=xoabSfEzX-YQEZgA@mail.gmail.com>
Subject: Re: [PATCH] libfdt: prefix header search paths with $(srctree)/
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:36 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Mon, Feb 11, 2019 at 10:43 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Rob,
> >
> >
> > On Fri, Jan 25, 2019 at 12:42 PM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > Currently, the Kbuild core manipulates header search paths in a crazy
> > > way [1].
> > >
> > > To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> > > the search paths in the srctree. Some Makefiles are already written in
> > > that way, but not all. The goal of this work is to make the notation
> > > consistent, and finally get rid of the gross hacks.
> > >
> > > Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> > > ("kbuild: do not drop -I without parameter").
> > >
> > > [1]: https://patchwork.kernel.org/patch/9632347/
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> >
> > Could you apply this to your tree?
>
>
> Anyway, this one is trivial Makefile change.
>
> Applied to linux-kbuild now.

Sorry, I missed this. It tends to happen with things outside my normal
search path.

Rob
