Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA44C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030FD2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LvI6nHu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbfHHNSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:18:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45060 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732866AbfHHNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565270291; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4qUpkQ5lf2VSF7E7ye2GJyI9xuZ8PAm84q8AX/Lmj0=;
        b=LvI6nHu8brxZD/H8sra1G1FTx5IFZuzQ4+J3KsIZig1hG7RVCxTytTvBLs96OKJtCDD6Jc
        rd0uI7YQ7Dav4mRAKqlJ2V/iyMJ9dJHxFrc48bKmn20IlR+6SQbCoFJAlWKNWxRxJGXyjE
        ZOI/FliIxkzmWO6zorF1K6qlE6tCcXY=
Date:   Thu, 08 Aug 2019 15:18:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic/jz4740: Fix "pll half" divider not
 read/written properly
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1565270287.15950.0@crapouillou.net>
In-Reply-To: <20190808040822.430582186A@mail.kernel.org>
References: <20190701113606.4130-1-paul@crapouillou.net>
        <20190807213358.A62002186A@mail.kernel.org>
        <1565220490.15188.0@crapouillou.net>
        <20190808040822.430582186A@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le jeu. 8 ao=FBt 2019 =E0 6:08, Stephen Boyd <sboyd@kernel.org> a =E9crit :
> Quoting Paul Cercueil (2019-08-07 16:28:10)
>>=20
>>=20
>>  Le mer. 7 ao=FBt 2019 =E0 23:33, Stephen Boyd <sboyd@kernel.org> a=20
>> =E9crit
>>  :
>>  > Quoting Paul Cercueil (2019-07-01 04:36:06)
>>  >>  The code was setting the bit 21 of the CPCCR register to use a
>>  >> divider
>>  >>  of 2 for the "pll half" clock, and clearing the bit to use a=20
>> divider
>>  >>  of 1.
>>  >>
>>  >>  This is the opposite of how this register field works: a=20
>> cleared bit
>>  >>  means that the /2 divider is used, and a set bit means that the
>>  >> divider
>>  >>  is 1.
>>  >>
>>  >>  Restore the correct behaviour using the newly introduced=20
>> .div_table
>>  >>  field.
>>  >>
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  ---
>>  >
>>  > Applied to clk-next. Does this need a fixes tag?
>>=20
>>  It depends on commit a9fa2893fcc6 ("clk: ingenic: Add support for
>>  divider tables") which was sent without a fixes tag, so it'd be
>>  a bit difficult. Probably not worth the trouble.
>>=20
>=20
> Does it need to go in as a fix for this -rc series then? Or is it not
> causing issues for you so it's ok to wait until next merge window?

It can wait for the next merge window, yes.

-Paul

=

