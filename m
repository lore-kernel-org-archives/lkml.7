Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA5C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9549F23BAD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPNQdOcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfE2Pom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:44:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46556 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfE2Pol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:44:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id x144so1242608ywd.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzvX+fHwwsVK/rYT0lCyOiKU2IYlx0wYtIIUBRbu7rI=;
        b=wPNQdOcNDJpcN8SLZ3QoXpbTi5+UGW9J1bJY4DkqqyBqOI5d3yqzNACNWIULW+15uA
         IOXbGpvkbYBV0VebvqxyIL8ibS8C+tAyRbVca1/XXkDA4xi9WNrW/FL80v5lLwXrn6WX
         cwhMZKxdm4TSwzUMarPMwb5BPTzYFDP5T/Ff+/xk4GmpGLuIB99ZDBFE5ZsPst2thb98
         KdZKvl1cychGGc0G2K0seDV4UyZX6QAlop/QAK4INAj89+MOLqABeimnQbx0EAjB+tY6
         Hst//WxZmOF9GBbIbUWdiIPxGEGXGapkxHSeWkuEL+nez7jMLVZmRFPRVONUbF3V+1jb
         nIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzvX+fHwwsVK/rYT0lCyOiKU2IYlx0wYtIIUBRbu7rI=;
        b=U579i1/kMZ945Q85I21gHCAu3/nDQfKLl4A9W6cqljzWYY5N3rTHT9hV5nOp1t+PTu
         lQHgWUz2e2Mj/Z/v11lAdLZrhwjASlgWKobvnGaiPsDt7fXM7U+ZwpQUhpVwWcOTFTIh
         MxXKGTB6B3XuRYULED7XQGrBlNIIiNNpPRYfXTlqgwtH/QSRlauUk3TMlmZ3npEm0NHj
         yoxKevGXInlAkSvJTzdYK/yIa59dEPhzwA/1BzUYaBmVjp1YVjbJz5bVhEJIx3kusonS
         ulpYl++pdc3eQdRzuZ5ozfWGAzBWVkB8WJM3gFaLQkShL9e3BGpQqTWukS3xI7GgKspe
         VcZA==
X-Gm-Message-State: APjAAAWVdpHDNvqbCwhE9WOrmYMmuM1b5qov2tBa5Y73OgYRogu97BbW
        nnAg7PVNg4zWSoUReoGO1XVFP3HCMRaHuqN8MTE8zQ==
X-Google-Smtp-Source: APXvYqzA+PBa1BbnJDLnJot49Cdhzw+OKvDs168TcBrvjO423z/o9cDuc2+4zCLPwjWJyT1pCgHVlblOYoJI3350nLM=
X-Received: by 2002:a81:59c2:: with SMTP id n185mr60560151ywb.21.1559144680103;
 Wed, 29 May 2019 08:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <1559117459-27353-1-git-send-email-92siuyang@gmail.com>
 <CANn89iLxxiX+4E7EURNKb=xRkk97rPaKTkpSc6Yu7fZbiwPT6w@mail.gmail.com> <CAKgHYH2uW=iSUM1j5pLhaQXpm35XK2rWq45M2Yih1-Dn=es0SA@mail.gmail.com>
In-Reply-To: <CAKgHYH2uW=iSUM1j5pLhaQXpm35XK2rWq45M2Yih1-Dn=es0SA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 May 2019 08:44:27 -0700
Message-ID: <CANn89iJ1qoP9PpJZVcatvdtRX4SqUrKrWDfer1hdid+gxYQXhA@mail.gmail.com>
Subject: Re: [PATCH] ipv4: tcp_input: fix stack out of bounds when parsing TCP options.
To:     Yang Xiao <92siuyang@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 8:11 AM Yang Xiao <92siuyang@gmail.com> wrote:
>
> Indeed, condition opsize < 2 and opsize > length can deduce that length >= 2.
> However, before the condition (if opsize < 2), there may be one-byte
> out-of-bound access in line 12.
> I'm not sure whether I have put it very clearly.

Maybe I should have been clear about the 320 bytes we have at the end
of skb->head

This is the struct skb_shared_info

So reading one byte, 'out-of-bound' here is harmless.

Whatever value is read, we will return early without ever looking at a
following byte.


>
> On Wed, May 29, 2019 at 10:20 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, May 29, 2019 at 1:10 AM Young Xiao <92siuyang@gmail.com> wrote:
> > >
> > > The TCP option parsing routines in tcp_parse_options function could
> > > read one byte out of the buffer of the TCP options.
> > >
> > > 1         while (length > 0) {
> > > 2                 int opcode = *ptr++;
> > > 3                 int opsize;
> > > 4
> > > 5                 switch (opcode) {
> > > 6                 case TCPOPT_EOL:
> > > 7                         return;
> > > 8                 case TCPOPT_NOP:        /* Ref: RFC 793 section 3.1 */
> > > 9                         length--;
> > > 10                        continue;
> > > 11                default:
> > > 12                        opsize = *ptr++; //out of bound access
> > >
> > > If length = 1, then there is an access in line2.
> > > And another access is occurred in line 12.
> > > This would lead to out-of-bound access.
> > >
> > > Therefore, in the patch we check that the available data length is
> > > larger enough to pase both TCP option code and size.
> > >
> > > Signed-off-by: Young Xiao <92siuyang@gmail.com>
> > > ---
> > >  net/ipv4/tcp_input.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 20f6fac..9775825 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -3791,6 +3791,8 @@ void tcp_parse_options(const struct net *net,
> > >                         length--;
> > >                         continue;
> > >                 default:
> > > +                       if (length < 2)
> > > +                               return;
> > >                         opsize = *ptr++;
> > >                         if (opsize < 2) /* "silly options" */
> > >                                 return;
> >
> > In practice we are good, since we have at least 320 bytes of room there,
> > and the test done later catches silly options.
> >
> > if (opsize < 2) /* "silly options" */
> >     return;
> > if (opsize > length)   /* remember, opsize >= 2 here */
> >      return; /* don't parse partial options */
> >
> > I guess adding yet another conditional will make this code obviously
> > correct for all eyes
> > and various tools.
> >
> > Thanks.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
>
>
> --
> Best regards!
>
> Young
> -----------------------------------------------------------
