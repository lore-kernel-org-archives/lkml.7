Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F9C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553FA214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="I6OUfOOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfLKFXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:23:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:61027 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfLKFXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:23:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 21:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="225388211"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2019 21:23:03 -0800
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Dec 2019 21:23:03 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX163.amr.corp.intel.com (10.22.240.88) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Dec 2019 21:23:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 10 Dec 2019 21:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHfv/WzulSlr6lYYPO/nlTUdRwEBymwVRmDZn3iF1XJR60YrNUYym9Sr3uIVTitMeWPH+ICexz76iE5OafKUmIcnP6OZ/qcVZc5DSEyQVcbPN5d+yO6dHCL/T3VeY6Zw/5pkoZikb80Zz1cmVUIkzQVZ4vOm1+7Vq6Rd/6nQjhCyClL/YgtROt+lxT8fsA8DOhfZmE4Jkn06uThBhjL2O+hlJYJPIU8RC2HGm9lX6uhbCPhcwj6C0fcumnQiumIayojCS/fZJEv06TsO/woExzliU/l1ksmAXpuf3Yn5lsbXg1h+pV9OOIdN1bJVVk2IplXVhkNRCJeiL7PZUpQ1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pt6UhA+KgH03GfD8q3zJrJWRQHNAotPFYF5hoezg/g=;
 b=DFoxrrB6Cb++dtQ7leqm1umJp8lSS6J0oKpfefH4mQG/ET+++jXcHq/VXezEUWxpxXqv42eddUCa6zjN1jTQcbrW568mgGAXCpk78XiT3UJNf7OtaOd8eNSUNFEJ1MAIUZRPSb125AyKRVQLgVn7NMpkqyEYX5N8pdDAwuf08csYrpESwNZSMkaQ9WH6Ggg+XWSxw0YlixMm4H9xmKOEfdm6iLbf2oJZUbICvvmS9s2ac9K3ZocST1l4xXvoqWPDzjvZKr6kB16nFwoZvDni7RGX5K6jtWVdpoXHYcXpJe8wLW+4bIIQywRzgfXQOqii2ToZsikNlJTQA1etr4MsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pt6UhA+KgH03GfD8q3zJrJWRQHNAotPFYF5hoezg/g=;
 b=I6OUfOOfOkaqZsk3Z8sL6LjBo+9Unr0bYnA/2A3szYK3OuAPOwvXCbFW+ne413Jn7NogZOokXnUpcXBlLy37abI+rkc6QNE2zAd9cvXkCnaH1kTvF49qJOx1k2F16T+JKIQHhXyEwfHPp8dXTfHOnwqew4WSJErLvj67esO+6I4=
Received: from MN2PR11MB4509.namprd11.prod.outlook.com (52.135.39.90) by
 MN2PR11MB4381.namprd11.prod.outlook.com (52.135.37.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 05:23:01 +0000
Received: from MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::a455:30f4:6f1c:e2fb]) by MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::a455:30f4:6f1c:e2fb%4]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 05:23:01 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mtd: rawnand: denali: add reset controlling
Thread-Topic: [PATCH] mtd: rawnand: denali: add reset controlling
Thread-Index: AQHVrzs7tJZlV61iv0eN4nwl1EYnh6e0Zffg
Date:   Wed, 11 Dec 2019 05:23:01 +0000
Message-ID: <MN2PR11MB4509B418D54E8DC7D3BE7DD2CC5A0@MN2PR11MB4509.namprd11.prod.outlook.com>
References: <20191210091453.26346-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191210091453.26346-1-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjFjY2E2NWItZTFhYS00ODM3LWI4MzItNTNiYWFhZTJjMDcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGZsbEorY1dVbWxzemhVb0doQVlXb3V3SHdFXC91V3RqMjYya2FmVERSRWFQQzZHYlNBeDFlSURNOFlCVStwa1UifQ==
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d57b9dc7-5437-4359-38b4-08d77dfa312c
x-ms-traffictypediagnostic: MN2PR11MB4381:
x-microsoft-antispam-prvs: <MN2PR11MB4381435B1AD830C80E6FEF12CC5A0@MN2PR11MB4381.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(39860400002)(346002)(85664002)(13464003)(189003)(199004)(8676002)(316002)(478600001)(8936002)(9686003)(2906002)(54906003)(7696005)(110136005)(4326008)(64756008)(33656002)(66446008)(81166006)(7416002)(66556008)(6506007)(86362001)(53546011)(76116006)(66946007)(66476007)(52536014)(55016002)(71200400001)(5660300002)(81156014)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB4381;H:MN2PR11MB4509.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SWIHTbdA+w2MHV1HnB50+xEssI+D+HT5A/MBydIBODbEWg+Qu1XXEZuSR2iVMfuv7w4ReKuwm7lO9gSrflS8y65kXSP47Rrkuo4R/yvizUH6V1dArg6x1+sPL9KR2cHyzve6cZuSbR6npXFeMwlnqrARo2LMogCRwBLxEaSIRK1Fcan/VW+5JStLzH0heUu68pGlg8Valstm1VJDXQYm5ydQWSOJgait3Y+juuzJbHDuvW+dcykDH22ot7pzRABxAcHO2Ec2Z6SLX7EMz/HT9Rt59w6izasTdiXwsQ1zpfklCCSMGz5Jq1kQxeNjaYcHhxZj4FMmmCMEtS1Ngol7vmRBYrXRi7LYR4zOaquRbcygxIXQMofqXjCeMomdEHMXQ6AhBHLAvfbuEjfaAvtWZ1N5EPM5AJKLPyF17WYppo2uJadpQROVEajR4FlaboSwD+TtTWzB9RUlhvw2kEDixkVAYwTPH16FTqnRJmrHIEUW39BHtETMpzLxlZgr2kyjUyFZV0NFzSo/RB2oynAwHA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d57b9dc7-5437-4359-38b4-08d77dfa312c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 05:23:01.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gqfMEBN44qYmhvimNRkqnRPl1wAppVnjZD/4VfwrhgHnYWvkctJJGbKdWVCwGxbt4sI+2MgeVzPjyq9WcGsqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4381
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Sent: Tuesday, December 10, 2019 5:15 PM
> To: linux-mtd@lists.infradead.org
> Cc: Dinh Nguyen <dinguyen@kernel.org>; Marek Vasut <marex@denx.de>;
> Tan, Ley Foon <ley.foon.tan@intel.com>; Masahiro Yamada
> <yamada.masahiro@socionext.com>; Mark Rutland
> <mark.rutland@arm.com>; Miquel Raynal <miquel.raynal@bootlin.com>;
> Philipp Zabel <p.zabel@pengutronix.de>; Richard Weinberger
> <richard@nod.at>; Rob Herring <robh+dt@kernel.org>; Vignesh
> Raghavendra <vigneshr@ti.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] mtd: rawnand: denali: add reset controlling
>=20
> According to the Denali User's Guide, this IP has two reset signals.
>=20
>   rst_n:     reset most of FFs in the controller core
>   reg_rst_n: reset all FFs in the register interface, and in the
>              initialization sequence
>=20
> This commit supports controlling those reset signals, although they might=
 be
> often tied up together in actual SoC integration.
>=20
> One thing that should be kept in mind is the automated initialization
> sequence (a.k.a. 'bootstrap' process) is kicked off when reg_rst_n is
> deasserted.
>=20
> When the reset is deasserted, the controller issues a RESET command to th=
e
> chip select 0, and attempts to read out the chip ID, and further more, ON=
FI
> parameters if it is an ONFI-compliant device. Then, the controller sets u=
p the
> relevant registers based on the detected device parameters.
>=20
> This process is just redundant for Linux because nand_scan_ident() probes
> devices and sets up parameters accordingly. Rather, this hardware feature=
 is
> annoying because it ends up with misdetection due to bugs.
>=20
> So, commit 0615e7ad5d52 ("mtd: nand: denali: remove Toshiba and Hynix
> specific fixup code") changed the driver to not rely on it.
>=20
> However, there is no way to prevent it from running. The IP provides the
> 'bootstrap_inhibit_init' port to suppress this sequence, but it is usuall=
y out of
> software control, and dependent on SoC implementation.
> As for the Socionext UniPhier platform, LD4 always enables it. For the la=
ter
> SoCs, the bootstrap sequence runs depending on the boot mode.
>=20
> I added usleep_range() to make the driver wait until the sequence finishe=
s.
> Otherwise, the driver would fail to detect the chip due to the race betwe=
en
> the driver and hardware-controlled sequence.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  .../devicetree/bindings/mtd/denali-nand.txt   |  7 ++++
>  drivers/mtd/nand/raw/denali_dt.c              | 40 ++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/denali-nand.txt
> b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> index b32aed1db46d..a48b17fb969a 100644
> --- a/Documentation/devicetree/bindings/mtd/denali-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> @@ -14,6 +14,11 @@ Required properties:
>      interface clock, and the ECC circuit clock.
>    - clock-names: should contain "nand", "nand_x", "ecc"
>=20
> +Optional properties:
> +  - resets: may contain phandles to the controller core reset, the
> +register  reset
> +  - reset-names: may contain "nand", "reg"
> +
>  Sub-nodes:
>    Sub-nodes represent available NAND chips.
>=20
> @@ -46,6 +51,8 @@ nand: nand@ff900000 {
>  	reg-names =3D "nand_data", "denali_reg";
>  	clocks =3D <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
>  	clock-names =3D "nand", "nand_x", "ecc";
> +	resets =3D <&nand_rst>, <&nand_reg_rst>;
> +	reset-names =3D "nand", "reg";
>  	interrupts =3D <0 144 4>;
>=20
>  	nand@0 {
> diff --git a/drivers/mtd/nand/raw/denali_dt.c
> b/drivers/mtd/nand/raw/denali_dt.c
> index 8b779a899dcf..132bc6cc066c 100644
> --- a/drivers/mtd/nand/raw/denali_dt.c
> +++ b/drivers/mtd/nand/raw/denali_dt.c
> @@ -6,6 +6,7 @@
>   */
>=20
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> @@ -14,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>=20
>  #include "denali.h"
>=20
> @@ -22,6 +24,8 @@ struct denali_dt {
>  	struct clk *clk;	/* core clock */
>  	struct clk *clk_x;	/* bus interface clock */
>  	struct clk *clk_ecc;	/* ECC circuit clock */
> +	struct reset_control *rst;	/* core reset */
> +	struct reset_control *rst_reg;	/* register reset */
>  };
>=20
>  struct denali_dt_data {
> @@ -151,6 +155,14 @@ static int denali_dt_probe(struct platform_device
> *pdev)
>  	if (IS_ERR(dt->clk_ecc))
>  		return PTR_ERR(dt->clk_ecc);
>=20
> +	dt->rst =3D devm_reset_control_get_optional_shared(dev, "nand");
> +	if (IS_ERR(dt->rst))
> +		return PTR_ERR(dt->rst);
> +
> +	dt->rst_reg =3D devm_reset_control_get_optional_shared(dev, "reg");
> +	if (IS_ERR(dt->rst_reg))
> +		return PTR_ERR(dt->rst_reg);
Will it trigger error if dts doesn't have "nand" or "reg" for reset-name?
SOCFPGA dts doesn't have this.

> +
>  	ret =3D clk_prepare_enable(dt->clk);
>  	if (ret)
>  		return ret;
> @@ -166,10 +178,30 @@ static int denali_dt_probe(struct platform_device
> *pdev)
>  	denali->clk_rate =3D clk_get_rate(dt->clk);
>  	denali->clk_x_rate =3D clk_get_rate(dt->clk_x);
>=20
> -	ret =3D denali_init(denali);
> +	/*
> +	 * Deassert the register reset, and the core reset in this order.
> +	 * Deasserting the core reset while the register reset is asserted
> +	 * will cause unpredictable behavior in the controller.
> +	 */
> +	ret =3D reset_control_deassert(dt->rst_reg);
>  	if (ret)
>  		goto out_disable_clk_ecc;
>=20
> +	ret =3D reset_control_deassert(dt->rst);
> +	if (ret)
> +		goto out_assert_rst_reg;
> +
> +	/*
> +	 * When the reset is deasserted, the initialization sequence is kicked
> +	 * (bootstrap process). This will take a while, and the driver must
> +	 * wait until it finished in order to avoid unpredictable behavior.
> +	 */
> +	usleep_range(200, 1000);
> +
> +	ret =3D denali_init(denali);
> +	if (ret)
> +		goto out_assert_rst;
> +
>  	for_each_child_of_node(dev->of_node, np) {
>  		ret =3D denali_dt_chip_init(denali, np);
>  		if (ret) {
> @@ -184,6 +216,10 @@ static int denali_dt_probe(struct platform_device
> *pdev)
>=20
>  out_remove_denali:
>  	denali_remove(denali);
> +out_assert_rst:
> +	reset_control_assert(dt->rst);
> +out_assert_rst_reg:
> +	reset_control_assert(dt->rst_reg);
>  out_disable_clk_ecc:
>  	clk_disable_unprepare(dt->clk_ecc);
>  out_disable_clk_x:
> @@ -199,6 +235,8 @@ static int denali_dt_remove(struct platform_device
> *pdev)
>  	struct denali_dt *dt =3D platform_get_drvdata(pdev);
>=20
>  	denali_remove(&dt->controller);
> +	reset_control_assert(dt->rst);
> +	reset_control_assert(dt->rst_reg);
>  	clk_disable_unprepare(dt->clk_ecc);
>  	clk_disable_unprepare(dt->clk_x);
>  	clk_disable_unprepare(dt->clk);
> --
> 2.17.1

