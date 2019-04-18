Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60431C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB9B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IO/UfMjY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fcf3hvqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfDRGUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:20:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19902 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555568429; x=1587104429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oGj0wt0GSqBf1TatphKEYYttoUcH2nZNCBW7ofe3qvU=;
  b=IO/UfMjYceSfy0II3f2ULU+CtlfyKmX0PjuBo92VwYbSU1HawrGTJq4P
   FVqjVhjxysnxh41rUkZhbdcFyemN1BYoSBfYZVguXVw++1MlbNi+xTXaC
   aZ54Decf33On6xAI0NnuDX59jwGh6nT19thIJ7xhXVSdG2km6L+8+k7hs
   1/tObv17YhZ1CJfA6gk7GYDDtTCbzNq60m6tXfKBWW/o7YPk6/DaZsWyg
   ADW6pENcrYUfAC34qg1i6kg6BkyGaIcdVUWgHfOtpjSrnaBRStrVCzPwM
   S8Tb+0Up8kQDGffm/Jbs6HxG2CfD5vFO4CgWnDmyp0XJXyBytQphfFiWL
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,364,1549900800"; 
   d="scan'208";a="107980545"
Received: from mail-by2nam03lp2057.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.57])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2019 14:20:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGj0wt0GSqBf1TatphKEYYttoUcH2nZNCBW7ofe3qvU=;
 b=Fcf3hvqv3k74reEcQEniqP3t/MBjU2Nq5YhuGLSGw6JeI9hNuUXHlIg1im9YLUeWSrMjyINthEyBpDBWPVFkt2Kx2IW37Hy/GrgFJG2epnfIzdCi+9NEpDzeE75qDSjqiZ1xSILaSclskD9AQKaMSj2uT/uYAByC9anrLT+xOW8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4734.namprd04.prod.outlook.com (52.135.122.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Thu, 18 Apr 2019 06:20:26 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::18d2:ac1f:7c5e:186e]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::18d2:ac1f:7c5e:186e%2]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 06:20:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Raul E Rangel <rrangel@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "zwisler@chromium.org" <zwisler@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v2] mmc: core: Verify SD bus width
Thread-Topic: [PATCH v2] mmc: core: Verify SD bus width
Thread-Index: AQHU9IY0QbLznX26DESp6qZ0x+rn3qZBdEzw
Date:   Thu, 18 Apr 2019 06:20:26 +0000
Message-ID: <SN6PR04MB4925C1C304B992339621808AFC260@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190416185705.256369-1-rrangel@chromium.org>
In-Reply-To: <20190416185705.256369-1-rrangel@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f33fc34c-2f17-478e-3297-08d6c3c5f2d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4734;
x-ms-traffictypediagnostic: SN6PR04MB4734:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB47348CA54E3BCF047982636AFC260@SN6PR04MB4734.namprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(8936002)(76176011)(256004)(68736007)(3846002)(53936002)(316002)(6116002)(305945005)(74316002)(7696005)(7736002)(71190400001)(6436002)(14454004)(99286004)(66066001)(54906003)(110136005)(81166006)(8676002)(81156014)(33656002)(5660300002)(476003)(52536014)(26005)(6506007)(229853002)(11346002)(71200400001)(86362001)(446003)(486006)(72206003)(478600001)(9686003)(2906002)(55016002)(102836004)(186003)(2501003)(6246003)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4734;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fF1LLbSJ6PkRG/rmmIwmYrrVQseUnVWf/sfZ+GJ/7WDjbI6BeaxvjGHk7FQ1katOj/uGprbWUysccYSYv9ezucoWJkT/h6P9UiwdY+Zt7dXD+WrhNOzzBKA5Win4JlPXeqTitdYVfFH1VC4nmKZTvetimrFZbRRk4NaqafD2Q90NmxkaH864nKnJiq4J4ya5zcCA8djXQG3L0XvZisKNJMhESFGZhaNDlU6EzleVRfE3bS/ap324YvlvVw19iKTZKbwXejS2IzwY1XtBDlghVj4p8exzjivyE93A85hMoV03KB6y9G86E7QFTb7208QGB/mY0tZF2KIe6l3LFC8mUkGo2VE8j47xXaFYe6GooNNHIH2/UVyNpZk2/diFRRlrC/GAItqQXNwLlGrM5KcyA6kwSvmmcukPYol2FauZ3A8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33fc34c-2f17-478e-3297-08d6c3c5f2d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 06:20:26.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> The SD Physical Layer Spec says the following: Since the SD Memory Card
> shall support at least the two bus modes 1-bit or 4-bit width, then any S=
D
> Card shall set at least bits 0 and 2 (SD_BUS_WIDTH=3D"0101").
>=20
> This change verifies the card has specified a bus width.
>=20
> AMD SDHC Device 7806 can get into a bad state after a card disconnect
> where anything transferred via the DATA lines will always result in a
> zero filled buffer. Currently the driver will continue without error if
> the HC is in this condition. A block device will be created, but reading
> from it will result in a zero buffer. This makes it seem like the SD
> device has been erased, when in actuality the data is never getting
> copied from the DATA lines to the data buffer.
>=20
> SCR is the first command in the SD initialization sequence that uses the
> DATA lines. By checking that the response was invalid, we can abort
> mounting the card.
>=20
> Acked-by: Avri Altman <avri.altman@wdc.com>
>=20
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks,
Avri
