Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F66BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A9D2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfCLVNM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:13:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45076 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfCLVNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:13:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12so3823350otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3jmJXa4rzUEjqLYYUxVP8wSbrNr3+v4uEdwLGkO9joA=;
        b=H7MJE2O98BdH+vFlWKRztqDkhCGuXZuxUJWqLWglZ4PCh+Ixok7F+DAjXfYgfJy6N5
         2DDUl3J0436L+Ur53yZVHhAI3QyluXbVmG2Kh42g1Ew/3+LjIw8TUaqvK7aBfP1LPfIj
         7aGzlQj2GHkmZ2XinJ5NGLgUFpaHDNg63nj3KJw4IhN05H8mP4HgxyM57Ly7JShrpZ78
         Z5LpEh3G7gvsmhcFxPV40brjkE+T1Etn5wrRx26W2f94ekj7kNkjO2pjEh0t1mASl1ax
         iePiBUV1Juts6iX43DEJBAgkXsm6fpIoJRyJjXQjT+948JqrPe0muZOWJfCqds3Gw84V
         n2kQ==
X-Gm-Message-State: APjAAAUMYr6Jw/yEIFnrIsiyEaeSKxgZHMPeYxYG0TLC2RXRjFs3SpOe
        8qwKOg4RxZe4aZpeuaZoTzrleZ4VvQpJKtNjxlUbZw==
X-Google-Smtp-Source: APXvYqzN2+BHlrw2pWgucJMJKUY//qSZUyb7RDQg4jcbZNAvYOwJ1WSHOgGonfgzc6DOPGRUWj2muPjZQ2TYGJJThIE=
X-Received: by 2002:a9d:5616:: with SMTP id e22mr25903782oti.365.1552425191717;
 Tue, 12 Mar 2019 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190312202008.29681-1-malat@debian.org> <57a0d93c-8784-d6af-a5fb-75e31455ae57@c-s.fr>
In-Reply-To: <57a0d93c-8784-d6af-a5fb-75e31455ae57@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Tue, 12 Mar 2019 22:12:59 +0100
Message-ID: <CA+7wUsyA698UtNLni7wi3=cKjbCd1V71YA0sxDtMD=MmQvQxTQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: sstep: Mark variable `rc` as unused in function 'analyse_instr'
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 9:56 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 12/03/2019 à 21:20, Mathieu Malaterre a écrit :
> > Add gcc attribute unused for `rc` variable.
> >
> > Fix warnings treated as errors with W=1:
> >
> >    arch/powerpc/lib/sstep.c:1172:31: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/lib/sstep.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> > index 3d33fb509ef4..32d092f62ae0 100644
> > --- a/arch/powerpc/lib/sstep.c
> > +++ b/arch/powerpc/lib/sstep.c
> > @@ -1169,7 +1169,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
> >   int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
> >                 unsigned int instr)
> >   {
> > -     unsigned int opcode, ra, rb, rc, rd, spr, u;
> > +     unsigned int opcode, ra, rb, rc __maybe_unused, rd, spr, u;
>
> I think it would be better to enclose 'rc' inside a #ifdef CONFIG_PPC64

Hum odd, I would have bet you would have suggested me to use
IS_ENABLED with some crazy scheme (I was not able to mix it with the
switch case nicely).

Anyway I'll try your suggestion and post a v2.

> Christophe
>
> >       unsigned long int imm;
> >       unsigned long int val, val2;
> >       unsigned int mb, me, sh;
> >
