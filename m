Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1467DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D459C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGu+T7cO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfIJI6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:58:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37516 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfIJI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:58:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so17875754wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uM1JHpYUMo3Cp4di2I20gUOtFuQlYUuIB4UQxpZ8dOc=;
        b=MGu+T7cOqK98jSo1eTCQ2pKjbL5XTl/1XsHxliFkZuPfKm3K5Ktj0q24+QlcwMtnlO
         ew87wYK/YyqUjDhHpD5pD3HkBDDfdm82cNQGMkPTkckyAmyTbdEcfzj0clqI/U2ia/R9
         qJak+UvS49/jHzbNBWm3nI0Lm4/jLaECIv6SBK7SEJgI9Yhrt8L7BB2Twx39gocXjb7N
         gg4QWq+oX9ZJOij9g7faFIVdjyYm9UMdympcV5jaLMmGA9CgyBdKcdY4apkTgUz8CySJ
         KBNfDhvpjqA022kvyW1N1UE2K2U4HxUwnq7NM4RuGtDbfpc1YS5CCkJ2N+8moedwCa+M
         8Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=uM1JHpYUMo3Cp4di2I20gUOtFuQlYUuIB4UQxpZ8dOc=;
        b=HQ+fIjpQoBxy6bMcuZoIQcQoaAjjn1w/Gw7HelBqBaN0csenvLMVX/AdwJrdRYPlKy
         eIuDByhlJC+F/b1/Z2OpfyJYCPt6CWvUFtKDGZLjP1zefbhsrpBSvXWedm79zVBVktH4
         +7PlAE2IbENV33E6pflc9nh9VlFM4cicNQkcEpu9NpgSZ4kGa6J4Wlh3RlntJ+nKLzN5
         QF2mz2mXJKp1a8OtcdSdZJNy03U9uq+2rXNZDRKD7VcNEuPkM+Os1hquCJ5d/puPerRn
         tzbStJc/Y2ESOKwjV67WmuXv58JaiJLZbyK8TSiL43oHWxqlaTsVfGlpoRmGmGTVwCeP
         VAEg==
X-Gm-Message-State: APjAAAUEgmkD7cigU/Rm9OArIs6KTrP1kvpWaQFgE18rtOPnAW2xLrRh
        hF2p3cVvaHNVo2CZX1XVuYD2d/jubxJkKhggUdg=
X-Google-Smtp-Source: APXvYqyruTqEO33YqxkX3BPmsdW2MSG9Qb+7nWIXpI+eBMKJI355V9C/L1sxuVLS46qTGcri9MtUQLmbmJ2mr9NfrkQ=
X-Received: by 2002:adf:a54d:: with SMTP id j13mr23663252wrb.261.1568105900512;
 Tue, 10 Sep 2019 01:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190904181740.GA19688@gmail.com> <CAHk-=wi2VOPoweqnDhxXKJ9fcLQzkV1oEDjteV=z-C7KXrpomg@mail.gmail.com>
 <CANiq72mXLbaefVBqZzz1vSREi0=HiBUgR1KU3iRjOCum7rvfrw@mail.gmail.com>
 <CAHk-=wiNksYaQ5zRFgTdY4TMHkxRi3aOcTC2zMMS6+aVSx+yeQ@mail.gmail.com>
 <CANiq72kyk6uzxS3LRvcOs9zgYYh7V7V2yPtAFkDwpHmyYcsz_Q@mail.gmail.com>
 <CAKwvOdkodVFxUr_Xc-qeUHnpxEmofENDhNdvCuiRzcGXQ54QkQ@mail.gmail.com>
 <CAHk-=wg+PD-+FEdKJuRVrrsgnFFLoAgU4Uz7tnohq_TgsEcNig@mail.gmail.com>
 <CAKwvOdmCBgKMLkXt29=vgvws_ek4XY3urMdfBUzbREH8Bj3uYA@mail.gmail.com>
 <CAHk-=whZ-ac4jm9zt=805xWsXaDAFWn2Bwn2PNtOBVx1vUmVvQ@mail.gmail.com>
 <CAKwvOdkWcB6jhqpr6p3LQkJOOt2si3i=bTGM11Poz8cZypS5EA@mail.gmail.com>
 <CAHk-=wiyxKDMW2fPumh2WyP3tP1BHpispjGfTWQ-we8keZ=q7Q@mail.gmail.com>
 <CA+icZUVNATrXZ7SDTrKa10cK8xtrRiC6VeXjkP6e9WyeKstMnA@mail.gmail.com> <CANiq72mOjC+JrpAOveqLPuE8f=XLXnr99DHb79ZVz=SKV6zhnA@mail.gmail.com>
In-Reply-To: <CANiq72mOjC+JrpAOveqLPuE8f=XLXnr99DHb79ZVz=SKV6zhnA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 10 Sep 2019 10:58:09 +0200
Message-ID: <CA+icZUVPFHimzas_YfmYJc14-qthsPRAXwj1m-fvBfP-HpziOQ@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Burton <paul.burton@mips.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@gmail.com>,
        Behan Webster <behanw@converseincode.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 1:59 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Sep 7, 2019 at 7:50 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > The compiler-attribute patchset sit for some weeks in linux-next, so I
> > have not seen any complains.
>
> It has been there only since Monday (cleanly), not weeks.
>


Sorry, I was not precise enough and didn't remember correctly.

I have re-tested with Linux v5.3-rc8. All OK.

- Sedat -
