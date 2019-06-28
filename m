Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4891C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FDD21726
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StQri7Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfF1JLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:11:21 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34125 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1JLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:11:20 -0400
Received: by mail-yw1-f66.google.com with SMTP id q128so3185383ywc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NYW6PlEeaH367Jvr1ZMSoo3Aj5m51ktezngndfggtvY=;
        b=StQri7FfBnbBGEumveJwe5nkZAxrnsl671ui5e4oGfnTsl6m3afqK8KoJktb7l92/5
         npAV5CxaY7ELNtmAqoi55qQvXqnPFo4n9uX1BUNUb4t/dwYtyeQ/M7EXSrB/v0zRegJE
         P8e0j9feRAtEl3LJ8zHZ7pplU8UWCoy5zEZKLE3lZFonv0QcEwAQCmBlTUpcPzCpORaU
         KWr3K/480ZFGenmaWVLmNgEVOZh9JAXlLCQJS/VVNfNlmf9I31Ygk4UJv7rV/7N3txa1
         fb3GUv4xRMJn7E6lc58vZ0lrTIQBrPETcl9F7RauB7UNsjwvdYHz6nVtH4zpR7o3zpzr
         JYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NYW6PlEeaH367Jvr1ZMSoo3Aj5m51ktezngndfggtvY=;
        b=YjkJK3PtQ2v3lIuDuFW35AeTvdmLA01uJATrxRAu5GAf5qLjfNpyAIrlxMDkOW5BA+
         3luybe0cUKMUxpbXESOsJdBDNR8pj/oPdgWjK465XibjjNnzAWdn9KAu/D5pt4LMzyph
         YgkQR6qCet1HUwCn24qSPiepf93nGDRKPVDptnsuMod/tB3cwXVJW4cLmNjtFKZNFzP9
         jqEa/YBBG0DLrtIRYyI5MINf2ptONveSGJ0YFzCVeuudaeAq+jnPGhb5fIvd8DDscKgL
         0l3JtfP3sRPRev2LQRFpRn+gqJvqNJPix7NqmSZy9pP4aj0IIAT1iqR/Hzc8/Z+G0VvO
         7Zxg==
X-Gm-Message-State: APjAAAVCTTQlvGO6QT7ESTDCJCdefLQLvz6ePjRxMWF3DQI4uc93C/Hd
        jl7Kl2kXEWXxADqBL3r99udAa7Np0VMQxQMBz/E=
X-Google-Smtp-Source: APXvYqwdZqvPFf/v+xf0c8m2QQzjwkm9pBnQirbxjOXTyW1AetvGjdJMH0+2ZUJRnpOn1unVXGCt7KHq84C5BQbqQa4=
X-Received: by 2002:a0d:e1d7:: with SMTP id k206mr5230972ywe.229.1561713079518;
 Fri, 28 Jun 2019 02:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190628025055.16242-1-huangfq.daxian@gmail.com> <83108dee-72f7-e56f-95f6-26162c9a0ccc@c-s.fr>
In-Reply-To: <83108dee-72f7-e56f-95f6-26162c9a0ccc@c-s.fr>
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Date:   Fri, 28 Jun 2019 17:11:08 +0800
Message-ID: <CABXRUiT6jSP2xL9JyqngS9KBx_=fZ13x0UGGFPnQPrfh-_N5xQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/27] sound: ppc: remove unneeded memset after dma_alloc_coherent
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Richard Fontana <rfontana@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The merge commit log tells (dma-mapping: zero memory returned from
dma_alloc_* and deprecating the dma_zalloc_coherent).
I used this commit just want to say that dma_alloc_coherent  has
zeroed the allocated memory.
Sorry for this mistake.

Maybe this commit 518a2f1925c3("dma-mapping: zero memory returned from
dma_alloc_*") is correct.

Christophe Leroy <christophe.leroy@c-s.fr> =E6=96=BC 2019=E5=B9=B46=E6=9C=
=8828=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:59=E5=AF=AB=E9=81=93=
=EF=BC=9A

>
>
>
> Le 28/06/2019 =C3=A0 04:50, Fuqian Huang a =C3=A9crit :
> > In commit af7ddd8a627c
> > ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma=
-mapping"),
> > dma_alloc_coherent has already zeroed the memory.
> > So memset is not needed.
>
> You are refering to a merge commit, is that correct ?
>
> I can't see anything related in that commit, can you please pinpoint it ?
>
> As far as I can see, on powerpc the memory has always been zeroized
> (since 2005 at least).
>
> Christophe
>
> >
> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> > ---
> >   sound/ppc/pmac.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
> > index 1b11e53f6a62..1ab12f4f8631 100644
> > --- a/sound/ppc/pmac.c
> > +++ b/sound/ppc/pmac.c
> > @@ -56,7 +56,6 @@ static int snd_pmac_dbdma_alloc(struct snd_pmac *chip=
, struct pmac_dbdma *rec, i
> >       if (rec->space =3D=3D NULL)
> >               return -ENOMEM;
> >       rec->size =3D size;
> > -     memset(rec->space, 0, rsize);
> >       rec->cmds =3D (void __iomem *)DBDMA_ALIGN(rec->space);
> >       rec->addr =3D rec->dma_base + (unsigned long)((char *)rec->cmds -=
 (char *)rec->space);
> >
> >
