Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FBC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C582183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovjE5Vd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbfDRTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:11:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40398 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:11:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so2819220ljq.7;
        Thu, 18 Apr 2019 12:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RHHGOHwosqs6I3QLp8i+LTp60aneQYuKN4bfTcUI3/I=;
        b=ovjE5Vd8ZSu6+B43E9Fbj+IMHu17dAnzXDECOxyNOcpzONlA7kswMXlwG5uyOlSwij
         PEarH3rsNx8Ku3yByZ6o2I2M1DIohaNPNwykzdgTCUsDMlwmb2RN6wYDHTNCC0GqKMr5
         j4d7OLud/4d9NgNrV3fhByj6eln0QWgSVHwPE9K1mNFrbZ2facA4jfgQs+9miyrUaW7K
         FodjWqe4kolh/KxPnZWJcon3brI6Fd9K6YkcXMDCwmW6ZwlVrjUmSR8E0Eluykb4Sqnr
         pS0xxEU0stGIiNGMlZnfDvJ/A7TEpEZADiN5t7ewB5C2vQCubfPtAN8mvSJwHQFDjl8I
         TY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RHHGOHwosqs6I3QLp8i+LTp60aneQYuKN4bfTcUI3/I=;
        b=BsJOGD5q56WNcD80QKa8c5x9naEQ5D6M0EjG1PwMWqtDJU90mk7sVrqMlebuK228PU
         pFipLBH4njXcgKO7RUwJ4UigqgUwuVmTy9HliOzkWJTL/Jr0022/CFKY8gxOUZJBeUZz
         uEUcuXu4vPNPQ2glUTe9ml64FffXrdDAyS5Qmlu4LyyStsiYnvr9ykAIqCfag9e3qYsD
         LH0wrJTWUwo5V5BwWyitWJJy5zPE3CMvrxx0Pyv83yC75YC1xLT3PBUMrvI7LRmMA8ml
         yzugzx73mfjnOWFLDGNof6Kp23gnb1rt0rx5pYFKYRHfXUsx3c5Qp52ns/Nuc0n2xB0u
         B08w==
X-Gm-Message-State: APjAAAU0pespGy1/8ZxJ4cQIfKimaBfZXJp2fwHMsGETAze8mhnpmQ1w
        sxe0vWJGDCQJYjhicszqEIU=
X-Google-Smtp-Source: APXvYqyKbQ22SHB0KxSu19bxHvemm2v4ihEUCVkgWR3I43d2zScebayyk4m9Bq3kInadibOYAihC/A==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr11242504ljk.158.1555614678148;
        Thu, 18 Apr 2019 12:11:18 -0700 (PDT)
Received: from z50.localnet (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id j28sm655344lfh.81.2019.04.18.12.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:11:17 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Thu, 18 Apr 2019 21:11:14 +0200
Message-ID: <5022351.qh9aoUC7DE@z50>
In-Reply-To: <20190418084929.7ac2cb67@xps13>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <3638685.4RdFRBT8kZ@z50> <20190418084929.7ac2cb67@xps13>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=E8l,

I'm wondering if we could register up a custom mtd partition parser from th=
e=20
board file.  It could return a pointer to a statically defined table.  Then=
 we=20
could add its name to the list of parsers the driver is going to try if the=
=20
board is enabled in .config.
Would that be acceptable from the MTD subsystem point of view?

Thanks,
Janusz


On Thursday, April 18, 2019 8:49:29 AM CEST Miquel Raynal wrote:
> Hi Janusz,
>=20
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Thu, 18 Apr 2019
> 01:09:59 +0200:
>=20
> > Hi Aaro, Tony,
> >=20
> > On Wednesday, April 17, 2019 11:40:10 AM CEST Miquel Raynal wrote:
> > > Hi Janusz,
> > >=20
> > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Sun, 24 Mar 2019
> > > 23:33:44 +0100:
> > >  =20
> > > > After recent modifications, only a hardcoded partition info makes
> > > > the driver device specific.  Other than that, the driver uses GPIO
> > > > exclusively and can be used on any hardware.
> > > >=20
> > > > Drop the partition info and use MTD partition parser with default l=
ist
> > > > of parser names instead.  For the OF parser to work correctly, pass
> > > > device of_node to mtd.
> > > >=20
> > > > Amstrad Delta users should append the following partition info to=20
their
> > > > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> > > >=20
> > > > mtdparts=3Dams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-
boot_params),\
> > > > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).
> > > >=20
> > > > For their convenience, CONFIG_MTD_CMDLINE_PARTS symbol is selected
> > > > automatically from that board Kconfig if this NAND driver is also
> > > > selected.
> > > >=20
> > > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > --- =20
> > >=20
> > > FYI I am okay with the change but I am waiting for acks before applyi=
ng
> > > it. =20
> >=20
> > May we have an ack from you?
> >=20
> > If still not convinced with my clarifications, I can add a comment to h=
elp=20
text=20
> > in Kconfig, either squashed or in a follow up patch, on the requirement=
 of=20
> > appending mtdparts parameter to command line.  What do you think?
>=20
> In the same patch I guess that would be fine.
>=20
> Thanks,
> Miqu=E8l
>=20




