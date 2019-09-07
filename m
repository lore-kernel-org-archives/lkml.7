Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AACC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118AE21871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 11:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaLYeJvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405912AbfIGL7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 07:59:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40984 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIGL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 07:59:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id a4so8394459ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4q8PibI6QMVD9FiIqYScjOwTYHwYTKV2iQ/Tzw4gmwE=;
        b=RaLYeJvMcfX9iX/4eS0savsC6Ao1+f/POEXbjiM3fClnR590HN22UvmQypBFz2xiWQ
         kTIF3iPMbLYd0UZgVw7iHBYtd2TuQrR+NySUwy29Sx2AschwDktfqT1xX0VrV0Ialuxy
         XEtfRQPTvYr1Q6ZHzcXArUOFonJ9rnXCrHpf65mQU6C0878VidUjtvgUGj6B2Nr1qTH7
         TSNdwL/FQMZmEA0O5D+q3dORI6rFs6PRW7I5UYk1NPzKn1baZI4Co8jz9YJK2tOkvb4l
         5yzxBI9WwViuGVERut011g14k3dag3pIev4u3gxIqm9lQdUQ/uz0g1nza7m9ux0eDqjg
         lIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4q8PibI6QMVD9FiIqYScjOwTYHwYTKV2iQ/Tzw4gmwE=;
        b=l5zQlu5CHaMhQ6JY1mIaPttmlUhe8r5OZHHZUDZuKTJ1bjIyczRhDWa1zSmGsEptsX
         Il0ZtcPpswLnvEEj91zSaQOFop1/RoQ4b43AZpWoJhpE6WlThI5ODIvWEnxTgrYQI+fr
         DL0Nau/9ZjgBconHUzkoF4UEQz22mjr1ck5RblIQ9YI/jd42Xxga93XPjPy2vlzX5l8p
         2QCsXkhSZ0rViDGcuSBrltx7CgS1dNqif9bU4JyMPZvz1xdoIWY/9cj2r7J5tab6OfjB
         r7hC2/pdOXU0j1S1BAXhf+mwbDoBvsS2uFLOKKuCt8bkAT12WYlTLXp0oORP3xIu1ToB
         0Zbw==
X-Gm-Message-State: APjAAAWG4x2VBI0uN0V373Gmn8SQA6DfTuiuQENsaejlvdMOPZ6ZhWds
        itBe7VPw2BLXa4zvLy43+uWKJUU6L4q6wmXIxGs=
X-Google-Smtp-Source: APXvYqxDtlPlfyzM142DqSd8UpsfopeOk0p/vdP6A7eFzNwLpH8QOSjnF0czo6k5np0DwZKWP6oJ/IqhjfPOwGgtYpo=
X-Received: by 2002:a2e:8814:: with SMTP id x20mr9140300ljh.221.1567857578606;
 Sat, 07 Sep 2019 04:59:38 -0700 (PDT)
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
 <CAHk-=wiyxKDMW2fPumh2WyP3tP1BHpispjGfTWQ-we8keZ=q7Q@mail.gmail.com> <CA+icZUVNATrXZ7SDTrKa10cK8xtrRiC6VeXjkP6e9WyeKstMnA@mail.gmail.com>
In-Reply-To: <CA+icZUVNATrXZ7SDTrKa10cK8xtrRiC6VeXjkP6e9WyeKstMnA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Sep 2019 13:59:27 +0200
Message-ID: <CANiq72mOjC+JrpAOveqLPuE8f=XLXnr99DHb79ZVz=SKV6zhnA@mail.gmail.com>
Subject: Re: [GIT PULL] compiler-attributes for v5.3-rc8
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Sat, Sep 7, 2019 at 7:50 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> The compiler-attribute patchset sit for some weeks in linux-next, so I
> have not seen any complains.

It has been there only since Monday (cleanly), not weeks.

Cheers,
Miguel
