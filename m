Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73010C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4282221D7F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573167467;
	bh=hEGb+zDEusUB1QbYTDvDDRK18XwzYMPr2cgYlxDaRV8=;
	h=In-Reply-To:References:From:To:Subject:Date:List-ID:From;
	b=TozaqVmFZ2FUbGAxCbjrMSokYBTXnFEs5YV3p6HzspqHdy0HeCuLKYodR2ekkAA5x
	 wO46kggtFPImdBR3FEN9p+FiUqTfkIkMIZbdGbyhiH/SjdkCMm711bwdjvwbZJUNHE
	 69LTiErzIQqzyF9Fi2IEnX78vnhKC8TWbBzFRUVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKGW5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:57:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfKGW5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:57:46 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A01C2178F;
        Thu,  7 Nov 2019 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573167465;
        bh=hEGb+zDEusUB1QbYTDvDDRK18XwzYMPr2cgYlxDaRV8=;
        h=In-Reply-To:References:From:To:Subject:Date:From;
        b=G+3Vb4HLoXCXyCcFfYGzyoG9QhxGXWHVRMhts2uUN4SVicYLrgFPR1DUDqmFhK7u4
         9xwPvtVYYK3pNtcENZJiuu9LScaNNK1LnA8vDoYbbAINdvui7Z1d49zN/1Axb8DU/v
         E17bLWOHdT8nbqvrz3H6exkTIUIf26CRSPsS9GQ4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB7PR04MB51956205E7FE92C9EB00A882E2780@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20191105090221.45381-1-wen.he_1@nxp.com> <20191105090221.45381-2-wen.he_1@nxp.com> <VE1PR04MB66879681CE5231F5C80F85148F7E0@VE1PR04MB6687.eurprd04.prod.outlook.com> <DB7PR04MB51956205E7FE92C9EB00A882E2780@DB7PR04MB5195.eurprd04.prod.outlook.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-devel@linux.nxdi.nxp.com, linux-kernel@vger.kernel.org
Subject: RE: [v6 2/2] clk: ls1028a: Add clock driver for Display output interface
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 14:57:44 -0800
Message-Id: <20191107225745.1A01C2178F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-11-06 19:13:48)
>=20
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile index
> > > 0138fb14e6f8..d23b7464aba8 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -45,6 +45,7 @@ obj-$(CONFIG_COMMON_CLK_OXNAS)            +=3D
> > > clk-oxnas.o
> > >  obj-$(CONFIG_COMMON_CLK_PALMAS)            +=3D clk-palmas.o
> > >  obj-$(CONFIG_COMMON_CLK_PWM)               +=3D clk-pwm.o
> > >  obj-$(CONFIG_CLK_QORIQ)                    +=3D clk-qoriq.o
> > > +obj-$(CONFIG_CLK_LS1028A_PLLDIG)   +=3D clk-plldig.o
> >=20
> > Wrong ordering.  This section of Makefile requires ordering by driver f=
ile
> > name:
> >=20
> > # hardware specific clock types
> > # please keep this section sorted lexicographically by file path name
> >=20
>=20
> Hi Leo,
>=20
> Stephen once suggest the Kconfig variable name should be given a more
> specific name like CLK_LS1028A_PLLDIG, so I have to changed it.
>=20
> Hi Stephen,
>=20
> How do you think?
>=20


Config name looks fine to me, but you haven't sorted this based on the
file name, i.e. clk-plldig.o, so please insert this in the right place
in this file.

