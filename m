Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155AFC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 12:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B2120989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 12:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kI7I5iBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfGFMTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 08:19:23 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:46838 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGFMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 08:19:23 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x66CJA2H019455
        for <linux-kernel@vger.kernel.org>; Sat, 6 Jul 2019 21:19:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x66CJA2H019455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562415551;
        bh=EJ3W14PBrsskJ+euSqEK+tPd+XewB591N5inw23HqiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kI7I5iBpL5v2OTJd3z2kRG3a4HIQDTa+CtyTYqilme7nWmCIK9tMEThmta7sCsDrj
         dB9dvsTVeZKhdZ8+6PyZsZCTZ7JI1j/4fnyaE3OLryH0gPRsE2oiRuLWZ7pG2LS9Sl
         RL9pElNCuYWVARjvomYa3RETSCrKsW/3e5i1EsgjMtLrxup03mFcPyJMMMiRNBSz32
         wy4C+uvq5jCJUVJtnJLgMdgKIKFmPP39iH0mhh5TZfzCzMwSPf0NLyGAcQCsDw/Zma
         jnle87IsYBZwUk/tLhB9Eb2Vug0vtHXrJ4lMtnU/TB7wMGGUVBWblwWPzS5/9G6rlD
         qj+fmSQiRtgMw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id u3so5370675vsh.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 05:19:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUex2WOk2x4pLsrGtv5btcWG8/oT/SQjWrza6v1sC2nbMVVCu6K
        uIi615bgCp4WeLl2fluYLNSacTaKoWT1ADGRIyU=
X-Google-Smtp-Source: APXvYqw9u6OIEEHZWSCpZvPbBaJl215dh9WqmzIWQwBghHvnbXg89EytVr3UMKjsfD1g6pCehQNTctoXrgBq4JT6o0I=
X-Received: by 2002:a67:f495:: with SMTP id o21mr5066465vsn.54.1562415550310;
 Sat, 06 Jul 2019 05:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190408191432.1269-1-rikard.falkeborn@gmail.com> <alpine.DEB.2.21.1904082119190.2612@hadrien>
In-Reply-To: <alpine.DEB.2.21.1904082119190.2612@hadrien>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 6 Jul 2019 21:18:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNB7DM9dPRFRqzKO41hG=dKPfTz8r0dkceSwk4VnvwtQ@mail.gmail.com>
Message-ID: <CAK7LNAQNB7DM9dPRFRqzKO41hG=dKPfTz8r0dkceSwk4VnvwtQ@mail.gmail.com>
Subject: Re: [Cocci] [PATCH] Coccinelle: kstrdup: Fix typo in warning messages
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 4:20 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Mon, 8 Apr 2019, Rikard Falkeborn wrote:
>
> > Replace 'kstrdep' with 'kstrdup' in warning messages.
> >
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
>
> Acked-by: Julia.Lawall@lip6.fr


Applied to linux-kbuild.



-- 
Best Regards
Masahiro Yamada
