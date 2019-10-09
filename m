Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397A1C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03942206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ryno+aaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfJIBKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:10:07 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:30532
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfJIBKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/kzCXrGH6xJitYALgOuhOr8ZKWgR1cFlVip62J/w9U/NgOsWQvzxQlX68+zog3q0rRbCs+QJQae/LcsHWbeSmf9fcmFJliq6upLcvO1JH1aBzIQd+BG5xWAKAniXUswTMgBf9Stz5C6qFFEDxPKdLAvbGnzWMvL2ty3ynixxLErjNZDDBP8eUHDviYJqsRyk7e1paIAFDxJqRgtOkc1hMvi1SC91g5Y6ScNBmOk/c0jqskDZLw4JHs9gCW53KZaMpXa6GeIbVy7u/nFQoYiDFGwj93t93pW+40BsK1aPDKhb4X/QFHeXwHi5RfUOkscPeMm8XgoPPkpojWDXtHtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqLIb9mTGELv7jCYd4zZtp23+oJ/NSkEgxRRLutbY00=;
 b=XUeVrRgdMq/HRdnRHnJ2NV+/+/3S3kNLpNcsdF9tMmU3iI62XOulSlsvd7S9pCDLWWHC3gO9SfvXBHvKBTZnJNYlOKnhYb0XDVIgPFr+BW/KKbJBhgKfV+l7w1kR0A7jqKEpcQaNast3dGrZmrjoEGmdUwyC2QuJa5C4ibbmO0ZK0slwvwqW0LgAukEJCES0KB8griJxsil4T+mvOwmqYZP7A7rD/AqlvPXRdANYSfWfv6C0NDXLEgxATW6k+pKNLCh9BK81EfAhveEwPRJpvYhLjobOk4NfCoc511lTLVkpc6jAOoDIEK5d4o1FH0/Iuxy/5t/2GH+o66Vx3Ok1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqLIb9mTGELv7jCYd4zZtp23+oJ/NSkEgxRRLutbY00=;
 b=Ryno+aaweIwbqfnvp9u3b6Ze36E3kqjStyASAAAXF9NJVQ2PDf8cNjFUTcxDgCSRYbbLtEhYDftF71z0lKIbpJMy5OPJENr3YnXnJMwQAY7tCywJRAu41Lr+/Ru/nC0W304240tGCthgMInLaH4ZpyxYQ+KmbEgzxj7KkK5RU4M=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5426.eurprd04.prod.outlook.com (20.178.116.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Wed, 9 Oct 2019 01:10:01 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 01:10:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V10 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Topic: [PATCH V10 0/2] mailbox: arm: introduce smc triggered mailbox
Thread-Index: AQHVd1cZbembLLIl0UWluk5SdDoXkKdRjZNQ
Date:   Wed, 9 Oct 2019 01:10:01 +0000
Message-ID: <AM0PR04MB4481F68159D932DA455634A988950@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290f3d04-30e9-48ff-959e-08d74c5568f8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB5426:|AM0PR04MB5426:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB54268A42504C105AD487551888950@AM0PR04MB5426.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(76176011)(54906003)(52536014)(110136005)(316002)(2906002)(6246003)(3846002)(99286004)(6116002)(966005)(5660300002)(2501003)(14454004)(71200400001)(71190400001)(4326008)(478600001)(6306002)(9686003)(446003)(8936002)(66946007)(6506007)(86362001)(11346002)(55016002)(476003)(25786009)(66446008)(486006)(2201001)(305945005)(102836004)(186003)(76116006)(7736002)(74316002)(81156014)(81166006)(33656002)(14444005)(229853002)(7696005)(256004)(44832011)(6436002)(66066001)(8676002)(15650500001)(26005)(64756008)(66556008)(66476007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5426;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIfVYhxDDpLQlU2CZk0vHdcKzqRhT5U/lXKVKrHscmntpRdUZaHm49vcu3fDB60QgpypLc/zRPBsYjWh4caKQvmyLyxFrxIIYIwZ7Eg177ze8ASAku6/ASLeG+XN3O5u10SazszfzrWOMC8RpMHEHrIPLSoOEfP9LUh98J2l0lIP1Fykm+qaus/GVyv3aaRdymIGogBio0oCd4mNS3ARU698viVaAM2V3GZViIPQunF4Wvb8h2VyC9lqm2WxMrE4xVUKrbf8M/jMjX6ryyo4KalJuOmuEPGB8xnxeid9XtMTQH2aJXJymMlWo8X3pXvPYa7hnmfoOr7TdIkIEgkXS9fYj1KmcqHtADxEBaEOeSdTqJzl2gKv3SyhR8PU+Xy5lQg+ZQ5aVKSPtufGOz/o+RsOFZvfw/og4v7gFXWHP7ga25IYY0SE2b1DZY8ckFecMy+TOW+63OP5czbuVamRFA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f3d04-30e9-48ff-959e-08d74c5568f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 01:10:01.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oOUC26saKUaiMpxO0j0Xo0LeWjHemf08+bgzInyZaYiT1RounEf+wLAUEQa3XldQD+68UKL3Mla7im5SjsaIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5426
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

> Subject: [PATCH V10 0/2] mailbox: arm: introduce smc triggered mailbox

Are you fine with this patch set?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V10:
>  - Add R-b tag from Andre, Rob and Florian
>  - Two minor fixes
>   - Drop "passed from consumers" in patch 1/2 per Andre's comments
>   - Drop interrupts.h in patch 2/2 per Andre's comments
>=20
> V9:
>  - Add Florian's R-b tag in patch 1/2
>  - Mark arm,func-id as a required property per Andre's comments in patch
> 1/2.
>  - Make invoke_smc_mbox_fn as a private entry in a channal per Florian's
>    comments in pach 2/2
>  - Include linux/types.h in arm-smccc-mbox.h in patch 2/2
>  - Drop function_id from arm_smccc_mbox_cmd since func-id is from DT
>    in patch 2/2/.
>=20
>    Andre,
>     I have marked arm,func-id as a required property and dropped
> function-id
>     from client, please see whether you are happy with the patchset.
>     Hope we could finalize and get patches land in.
>=20
>    Thanks,
>    Peng.
>=20
> V8:
> Add missed arm-smccc-mbox.h
>=20
> V7:
> Typo fix
> #mbox-cells changed to 0
> Add a new header file arm-smccc-mbox.h
> Use ARM_SMCCC_IS_64
>=20
> Andre,
>   The function_id is still kept in arm_smccc_mbox_cmd, because arm,func-i=
d
> property is optional, so clients could pass function_id to mbox driver.
>=20
> V6:
> Switch to per-channel a mbox controller
> Drop arm,num-chans, transports, method
> Add arm,hvc-mbox compatible
> Fix smc/hvc args, drop client id and use correct type.
> https://patchwork.kernel.org/cover/11146641/
>=20
> V5:
> yaml fix
> https://patchwork.kernel.org/cover/11117741/
>=20
> V4:
> yaml fix for num-chans in patch 1/2.
> https://patchwork.kernel.org/cover/11116521/
>=20
> V3:
> Drop interrupt
> Introduce transports for mem/reg usage
> Add chan-id for mem usage
> Convert to yaml format
> https://patchwork.kernel.org/cover/11043541/
>=20
> V2:
> This is a modified version from Andre Przywara's patch series
> https://lore.kernel.org/patchwork/cover/812997/.
> The modification are mostly:
> Introduce arm,num-chans
> Introduce arm_smccc_mbox_cmd
> txdone_poll and txdone_irq are both set to false arm,func-ids are kept, b=
ut as
> an optional property.
> Rewords SCPI to SCMI, because I am trying SCMI over SMC, not SCPI.
> Introduce interrupts notification.
>=20
> [1] is a draft implementation of i.MX8MM SCMI ATF implementation that use
> smc as mailbox, power/clk is included, but only part of clk has been
> implemented to work with hardware, power domain only supports get name
> for now.
>=20
> The traditional Linux mailbox mechanism uses some kind of dedicated
> hardware IP to signal a condition to some other processing unit, typicall=
y a
> dedicated management processor.
> This mailbox feature is used for instance by the SCMI protocol to signal =
a
> request for some action to be taken by the management processor.
> However some SoCs does not have a dedicated management core to provide
> those services. In order to service TEE and to avoid linux shutdown power=
 and
> clock that used by TEE, need let firmware to handle power and clock, the
> firmware here is ARM Trusted Firmware that could also run SCMI service.
>=20
> The existing SCMI implementation uses a rather flexible shared memory
> region to communicate commands and their parameters, it still requires a
> mailbox to actually trigger the action.
>=20
> This patch series provides a Linux mailbox compatible service which uses =
smc
> calls to invoke firmware code, for instance taking care of SCMI requests.
> The actual requests are still communicated using the standard SCMI way of
> shared memory regions, but a dedicated mailbox hardware IP can be replace=
d
> via this new driver.
>=20
> This simple driver uses the architected SMC calling convention to trigger
> firmware services, also allows for using "HVC" calls to call into hypervi=
sors or
> firmware layers running in the EL2 exception level.
>=20
> Patch 1 contains the device tree binding documentation, patch 2 introduce=
s
> the actual mailbox driver.
>=20
> Please note that this driver just provides a generic mailbox mechanism, I=
t
> could support synchronous TX/RX, or synchronous TX with asynchronous RX.
> And while providing SCMI services was the reason for this exercise, this =
driver
> is in no way bound to this use case, but can be used generically where th=
e OS
> wants to signal a mailbox condition to firmware or a hypervisor.
> Also the driver is in no way meant to replace any existing firmware inter=
face,
> but actually to complement existing interfaces.
>=20
> [1] https://github.com/MrVan/arm-trusted-firmware/tree/scmi
>=20
>=20
>=20
> Peng Fan (2):
>   dt-bindings: mailbox: add binding doc for the ARM SMC/HVC mailbox
>   mailbox: introduce ARM SMC based mailbox
>=20
>  .../devicetree/bindings/mailbox/arm-smc.yaml       |  96
> ++++++++++++
>  drivers/mailbox/Kconfig                            |   7 +
>  drivers/mailbox/Makefile                           |   2 +
>  drivers/mailbox/arm-smc-mailbox.c                  | 166
> +++++++++++++++++++++
>  include/linux/mailbox/arm-smccc-mbox.h             |  20 +++
>  5 files changed, 291 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/mailbox/arm-smc.yaml
>  create mode 100644 drivers/mailbox/arm-smc-mailbox.c  create mode
> 100644 include/linux/mailbox/arm-smccc-mbox.h
>=20
> --
> 2.16.4

