Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAC3C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C8A2189D
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssRhixgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfHRWSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 18:18:40 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34695 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfHRWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 18:18:40 -0400
Received: by mail-yb1-f196.google.com with SMTP id u68so1118686ybg.1;
        Sun, 18 Aug 2019 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OlWByN81JtOACLvajVFVonUlAoh5I9eX8MqOIhcnojM=;
        b=ssRhixgisigous6bB0ttqC7AFxjP/4IPqpEa0R02pRHF7gUhkDvspWlQajqCuTtsjj
         KcdorVPgxNg01pAbAkd0MHnvPArh0r14pWXJ9ewiFJzzVwuJu9tzD5yJP01bvTPt6ypI
         3uu+N/mKS9USlbCUE9l1/AZcszyb/RYWc9vZvEw/xi1/NcsRZM40+aj0Q5M3tGxWqO5j
         DHGXe8XxcNJqCFGtC71ewB6yMdtuLD4VNl7THAYBO+1Te8FygjmfVTUYVuvA43q8yEdx
         KNaa3hM71ZgBiWiK8oh9IDkP+6kmDg9cSwgEtY+4hiA43LaK0IpTKkJ3NcvKOCKzcXbf
         DkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OlWByN81JtOACLvajVFVonUlAoh5I9eX8MqOIhcnojM=;
        b=CruLCNyIsjThW6NKF2/Wz+dbpyDh+z7a/RKx3NHha9GudsN5dSe7WvxFrWNPppJpqM
         FGxXwJT+czZl6mbqVUqplOp8pRcBdnMrDcALPcqpqE7UKQ0j/8hkBZ4jBy52oy6yyYT/
         ZwNz/fSsl6t6+oIO/49pOty+P6LHWrILKQpB/k9s3aYIA45tY+K9ikVQX+5VbJHmwvdL
         CnYSNLYJbPJ6G3LV79lNEpfNB/9aiWKkz0J7v1q4SmQR0h5Nd2/Blthubci/TWkuhMiG
         XX/OSpdDbrwsh/YigC4ghOuLwCf1XRPJSwcl8S26IAQTgKvGdQQPo6pGRq+ao8bKmDSI
         2xTA==
X-Gm-Message-State: APjAAAUjw5fKbM0jvxyCh12k7uK3/2y8rDXVwQq3Fw8nadr0WNPBa4sr
        eY2NFWYCcWKocGgrfClDkiQAPvsuA/8XT4+kzgM=
X-Google-Smtp-Source: APXvYqwWTQ7mnDNbxBqiOGDZCHWdkh+f8A9ATA4uuVAXv7BKebR5KiyZIN/8M8wMuFEnuIMDiY+MOLGO/yiKaEp3+74=
X-Received: by 2002:a25:6b48:: with SMTP id o8mr15040871ybm.203.1566166719081;
 Sun, 18 Aug 2019 15:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190816205342.29552-3-jernej.skrabec@siol.net>
 <201908190222.ZdIp2gT1%lkp@intel.com> <7640522.c0V0aH5rf2@jernej-laptop>
In-Reply-To: <7640522.c0V0aH5rf2@jernej-laptop>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 19 Aug 2019 00:18:27 +0200
Message-ID: <CAJiuCcfSejK-fkk1TQW7e-WpjNCqR4h12xTUMYgnCApofL+X6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h6: Introduce Tanix TX6 board
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     kbuild test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        kbuild-all@01.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Aug 2019 at 21:00, Jernej =C5=A0krabec <jernej.skrabec@siol.net>=
 wrote:
>
> Dne nedelja, 18. avgust 2019 ob 20:42:49 CEST je kbuild test robot napisa=
l(a):
> > Hi Jernej,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on linus/master]
> > [cannot apply to v5.3-rc4 next-20190816]
> > [if your patch is applied to the wrong git tree, please drop us a note =
to
> > help improve the system]
> >
> > url:
> > https://github.com/0day-ci/linux/commits/Jernej-Skrabec/dt-bindings-arm=
-sun
> > xi-Add-compatible-for-Tanix-TX6-board/20190819-002034 config:
> > arm64-defconfig (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cros=
s -O
> > ~/bin/make.cross chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=3D7.4.0 make.cross ARCH=3Darm64
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> > >> Error: arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts:83.1-6 =
Label
> > >> or path r_ir not found FATAL ERROR: Syntax error parsing input tree
>
> Strange, Allwinner tree has commit, which introduces r_ir node:
> https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?
> h=3Dsunxi/dt-for-5.4&id=3D9267811aad3524c857cf2e16bbadd8c569e15ab9
>
> Maybe kbuild test robot tree doesn't have it?
Yes Kbuild is on v5.3-rc4 vs the IR patch is planned for 5.4.

Regards,
Cl=C3=A9ment

>
> Best regards,
> Jernej
>
> >
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology
> > Center https://lists.01.org/pipermail/kbuild-all                   Inte=
l
> > Corporation
>
>
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
