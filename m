Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9152CC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6408F21537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMGu7W8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfGICUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:20:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46662 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:20:24 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so39750820iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqqLzTYgfQxqS7WeMJ8j0MU1nn2fiHKsb4BBFyiKEmI=;
        b=OMGu7W8ASNA2F50nIS4M1xfIwcL/esB9I9lXSnfIXcIbD874tTTaEF1ABDM8SALR6I
         n4S1WMnJCTe3/W6z9o8Lx7wq1YFF65hvl68HKz1nvhu5cygsDrkUVtXB+EksGde1w1mR
         rwC7HnmzOfAJfnECJ7lsdg+9CFA3OV601tC5q9MNIwItgRxOX+WafU/xHe6rGzCdl9ds
         FOHOQGhVTdyhq3RFBTvV1asJ7PQD+ajEoGch0X06+xtwe9svY1vXfyBC+1W3Qv7SB+EH
         T+1fJs8HsgLu+yOZkjJJ26e7x3HqY+fNFKD6CCOSlqCOksT9F5CIYwRpiovXz0oPELzQ
         YY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqqLzTYgfQxqS7WeMJ8j0MU1nn2fiHKsb4BBFyiKEmI=;
        b=I8J4eFeyzroTCW7uB7YZU5VImY80wA1idoUkmQcErNUurgE4vaDxcQKXZyf8sfKags
         h84rzykS13RKXQDBiH9DpOlTFS/fWVW28nkYs9jl6OygtXd8kt0Sw83FFeIWkGUrZqNc
         KEDe1ok1uM0dYR2SfgQCnkH00j/1RXJ6q+Vcz1QA4CKn9TvrJgBbpAPYm179UV/Oj4HO
         q/7d8hiZkMuGRy8XPn8AswcAto2tHNSmb+7EA/vCxXnHPfvosbaaxWOoddAobMHlMBIC
         8LjeNFhr2Ui2pwsxhnRYUxeVrSIQJfGCcW1bVsTsZxYgyBNKTuwVBG4GDTb9twoyAVJd
         U/gg==
X-Gm-Message-State: APjAAAUf1kyaXTMY6KLE5Xlv6h9fe+vjiQ+n5PzpTPYbDSQoJ5pAcEtx
        UZvq5SyrDUaeVCNtINouMPcx5rFFEdKZQJ2Hmao=
X-Google-Smtp-Source: APXvYqzwwSPcBygzgpPc++VFRInbOx3Vxz9b08adPYXTcT1Fz+zr8amDiOvv+RltV/YRKkW51A1K3UDPLktZFZDjEIU=
X-Received: by 2002:a5d:8497:: with SMTP id t23mr2052187iom.298.1562638823991;
 Mon, 08 Jul 2019 19:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
 <d6f628ffdeb9c7863da722a8f6ef2949e57bb360.1557824379.git.christophe.leroy@c-s.fr>
 <87y318d2th.fsf@linux.ibm.com>
In-Reply-To: <87y318d2th.fsf@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 9 Jul 2019 12:20:12 +1000
Message-ID: <CAOSf1CG-oxpSDsAPw8xHV5367MrMn2Ty_yDpPY9TvA6wMrMZHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] powerpc/64: reuse PPC32 static inline flush_dcache_range()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 12:22 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
> > *snip*
> > +     if (IS_ENABLED(CONFIG_PPC64))
> > +             isync();
> >  }
>
>
> Was checking with Michael about why we need that extra isync. Michael
> pointed this came via
>
> https://github.com/mpe/linux-fullhistory/commit/faa5ee3743ff9b6df9f9a03600e34fdae596cfb2#diff-67c7ffa8e420c7d4206cae4a9e888e14
>
> for 970 which doesn't have coherent icache. So possibly isync there is
> to flush the prefetch instructions? But even so we would need an icbi
> there before that isync.

I don't think it's that, there's some magic in flush_icache_range() to
handle dropping prefetched instructions on 970.

> So overall wondering why we need that extra barriers there.

I think the isync is needed there because the architecture only
requires sync to provide ordering. A sync alone doesn't guarantee the
dcbfs have actually completed so the isync is necessary to ensure the
flushed cache lines are back in memory. That said, as far as I know
all the IBM book3s chips from power4 onwards will wait for pending
dcbfs when they hit a sync, but that might change in the future.

If it's a problem we could add a cpu-feature section around the isync
to no-op it in the common case. However, when I had a look with perf
it always showed that the sync was the hotspot so I don't think it'll
help much.

Oliver
