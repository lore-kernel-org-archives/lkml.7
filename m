Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED51C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C5020640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="VWfYgiq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJALxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:53:12 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46434 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJALxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:53:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so10837588qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dqwnqVMd7Dh3OIWe4tAKRJ81nrl3lr0HTsA8KBQUJMQ=;
        b=VWfYgiq8o4TxzI75gqE+97kJ2C7RzILaNdQFTlfC9HvX0NHGTLxEHA4D4XVALs+NFq
         HOho3Huo099ZkLxTOytzVXOOQ0ICzbhphJlDsRIgVTS2a6eUbd3Lc202l0dgak2MvwRK
         bNQ5F3XyUdjF+DEdcSAM3y5YQXiGEdvMbldIutIQzwDUaYODw1KWo+CJbUqp3YqhK8Vm
         dzkrxVBDza6cGphkJHE+sQvmVaNEXQzBnJttxFdPfEaedU2vJb9PN0ryuzCy4VUuTX1t
         uxBQcqZE7EqfBGNA6Z0dOO/m/1wuRBd+SIEeE/d1ODL7rl5jy/hD7QpQj4152+RL5wDr
         Deqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dqwnqVMd7Dh3OIWe4tAKRJ81nrl3lr0HTsA8KBQUJMQ=;
        b=RxJQa41czAam5P727vX1m63K4E8rSaiDvc4OlR+Z7i7iidJy8nElboRTterV73QTah
         aia1Yh5Eu+49ftA4F2N76zpB/22IbPpqNieYWa9Ed4xSW2QV7AciOWTtQMhHqtBcbBhM
         ljGew05UxThwdBHybgKmdKuN2BTH3fueAPc0TD1iLrfxdsoWq9Zog/phj/WyK8Nx21Gv
         GiWZl+4iiL9hAueUZxoy5204XtYo26dUl6Dw1klJXTM1sfnDxyHVDT3m5+1+rblaJE28
         CXZqzB5gMezngGQpCGH1vHHh0yAyqp6AK8k1v3EuDp3ANmiOzykNjqRPGdUL5kT20/8E
         OEHA==
X-Gm-Message-State: APjAAAXUerrwczUpqnV8CV9eDOoEell+zfBALcoBeCVikgJjyPy2W2L0
        s9xF/zuMhMeViIWPggP4PUSnXSQXdyUQXEnshTF/lg==
X-Google-Smtp-Source: APXvYqxP855s+EE2N4Y1fo0EProBOXtvkHBsF3VzoAMrv/RCwrkN37cc1TE0VS1T0HeKDv98emTi1km3cxN1jGfZgNo=
X-Received: by 2002:a37:4dd0:: with SMTP id a199mr5267390qkb.195.1569930789388;
 Tue, 01 Oct 2019 04:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190926055128.23434-1-axel.lin@ingics.com> <AM5PR1001MB0994D5D70956F903FDFB989680860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB0994D5D70956F903FDFB989680860@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 1 Oct 2019 19:52:58 +0800
Message-ID: <CAFRkauAk6c_nkMh+W5zKJmNttKwzJgqMzsprKdcAyi1v5iouWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: da9062: Simplify da9062_buck_set_mode for
 BUCK_MODE_MANUAL case
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Thomson <Adam.Thomson.Opensource@diasemi.com> =E6=96=BC 2019=E5=B9=B49=
=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:22=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On 26 September 2019 06:51, Axel Lin wrote:
>
> > The sleep flag bit decides the mode for BUCK_MODE_MANUAL case, simplify
> > the logic as the result is the same.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> This patch will need to be rebased on Marco's update titled:
>
>         "regulator: da9062: fix suspend_enable/disable preparation"
This patch is on top of above commit.
Should be applied cleanly.

Thanks,
Axel
