Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E13207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyuEBoMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfIJJQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:16:13 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43559 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfIJJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:16:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id q27so12825483lfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ip8Tgw+p2G5k0S3Bh1zyW4MCMwm2IXBnOauC9pyqqGM=;
        b=uyuEBoMMeYZP3Bjkc6hSX/k1miX7i4H8wHCAfvP32VB5mcSoR9rIxSo1oFzyXsrJkT
         e46f9NcYBFCmRelWJJGfttHcjeYz0rIqU50nug3VUVPoP4oPIBUoqUmfU0+tSk7zoI2x
         omcxcFD0KHVxRe7mHMSLfdsTL8YTu2aLKCqlzIv4ANsOuP21dVnhTOEAbLnCOHkRuEcK
         kr4BKK15u+Q++4hQaPxF6rEKO723up/0bxU9w0sdM8o6gENYqw0kBD8km+KVwc2uvb1j
         GO/ZpKPgHcI1Ux5/u8T4x6wSFLhRMFdNcHj01FtwkinSgVOWrm8/B6PX0rFeQW8mEFhf
         pCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ip8Tgw+p2G5k0S3Bh1zyW4MCMwm2IXBnOauC9pyqqGM=;
        b=pQf9D3bh54SlHGpXJ7ZpW6C3S2ljeTd95bhYHPfLy8+BZZDwyJNRLLzMrK2sl5ARRX
         xoNFh794pnOeHACh/66i81NhZbJCYYSg4PaOrc/BLeL9knTiFTcnTsZD6wK2o1k/UAc0
         9U88awHIgwmtIor6yrm8TZwl5z4FyBVxY/d+gOkrXhDk3IKg7MQ5LHMBG7WTCUVQJ5B+
         zkKVbc/QWPv2G3FAhLstdzCM3di4OdxgSj70TUEGZY/GkF6IY/hOALIYpVARXviIKlQS
         dyjbre8G3+jqbn9wHAkNJH98+/rKepo12nOwiSSb1wouCVmTb2pqi9abujv8HmB0dv9D
         whVA==
X-Gm-Message-State: APjAAAXk/Cd9gB9eHRC6UbQHXzwI8a2YbYuKdnNlNS+9k+GEjeOJs+JR
        2unsUEteuWIKgCwgVwa2wziPJ7HOszBG8Ff7Rm7dtQ==
X-Google-Smtp-Source: APXvYqz4IkxmLERS+Sdx4yJ2TjFnNAxzIkZaexDSGRqUjspc4l++Q8xMc81KQJgAAL8Am7iCT/LUKtxuGmV+CeBtGII=
X-Received: by 2002:ac2:568c:: with SMTP id 12mr19253689lfr.133.1568106971437;
 Tue, 10 Sep 2019 02:16:11 -0700 (PDT)
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
 <CA+icZUVNATrXZ7SDTrKa10cK8xtrRiC6VeXjkP6e9WyeKstMnA@mail.gmail.com>
 <CANiq72mOjC+JrpAOveqLPuE8f=XLXnr99DHb79ZVz=SKV6zhnA@mail.gmail.com> <CA+icZUVPFHimzas_YfmYJc14-qthsPRAXwj1m-fvBfP-HpziOQ@mail.gmail.com>
In-Reply-To: <CA+icZUVPFHimzas_YfmYJc14-qthsPRAXwj1m-fvBfP-HpziOQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 10 Sep 2019 11:16:00 +0200
Message-ID: <CANiq72mJHrYqYr8dSHh3O2Sy6GPscRc4pkSr3Pi_e76b8O3qzg@mail.gmail.com>
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

On Tue, Sep 10, 2019 at 10:58 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Sorry, I was not precise enough and didn't remember correctly.
>
> I have re-tested with Linux v5.3-rc8. All OK.

No worries at all! I just wanted to clarify it :)

Thanks a lot for confirming it works.

Cheers,
Miguel
