Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21946C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2F5218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AmWlcTio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfIRJCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:02:25 -0400
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:61179
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfIRJCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWVMizDwpvy3eGrL4/lehOUighWVvyiQ7cKRp/XMVA6B27O28vJ+SVMS7psGqNY/NViqrgi28gTxCB6HVCdGdnNGsvyYeqdO91NC6ILiH8hrtfaxv6iKQNq3ojzKGJB45CsKutbCTm4+dmiiV6M42Oictjk/H1F/DTM92UmUwR9/uc4SwWqKjJPamWh1wDejQBt49br03cuj6t4Y2+MyPJDRpxRG45xcP/8laKpXCmFG8IRZuwzzJ9s6Y95WfJ9VIpRQ8fZ5LeAsb3HQyQH8S6Ue3AFQTQmZs81mrKdZyOKaFHdN/SRR1eRmLV3xToRGOs1/tFwh/N9fHcYxPIOlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4fSV2tK8pdHXIYRyPRhXGYhtYsJjWXL4yj5Zbs1qvM=;
 b=hmupNI7mpixQ34s4mfJbIXIbo7hFQZTJv+T2k8PhXTpAbLB6K/SYDQSbC/4MsPenXuFNGc0MpdGKaf9LKMuQOOuXR9zUA55vtuprhRFxSRIaVL+WHbIfg7TfB0Fm/SLg+J5ZEuBHcIYQb+v8rc2tigrzVtBJaDFpgQ2lzTt1N5zVU56OYoE3I1HVLAd8E/WRjBAK3rFk+z6pNqcy79JUjnvfBM0+giLxmNDknLZvKFAX2nfWf98L449KT7hLXIcrXQ9nPehKHx1EwOx4L6jhylMi0oyNjT58/1mAdw2iMFRxEVHEY5x99+G0vVHyC7ffZsqATBQJYgW37SCH7bnc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4fSV2tK8pdHXIYRyPRhXGYhtYsJjWXL4yj5Zbs1qvM=;
 b=AmWlcTiokpeqzFnegJvKTXXgPuJB5477TJE0bGvERWdr8Jpt1D9IT3vk+QgcJxKsiG0MJvvxcNxNwZmf9rVSPhHwxk7wMTqT3+9DrDB69kXugMyClgae0cYI/c+vDktm9xfCPhiSs+tdNL6sAQnfIXS4KmYuzgcTMu9GWNcONDY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6772.eurprd04.prod.outlook.com (52.132.214.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Wed, 18 Sep 2019 09:02:15 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 09:02:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andre Przywara <andre.przywara@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVbHNaBQCH9BWPL0mqFSSgcphDeqcwIoOAgAEBqzA=
Date:   Wed, 18 Sep 2019 09:02:15 +0000
Message-ID: <AM0PR04MB4481E07A2DD996703EE9FADD888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
        <1568626884-5189-2-git-send-email-peng.fan@nxp.com>
 <20190917183115.3e40180f@donnerap.cambridge.arm.com>
In-Reply-To: <20190917183115.3e40180f@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 167818a7-99aa-4d43-2843-08d73c16e69b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6772;
x-ms-traffictypediagnostic: AM0PR04MB6772:|AM0PR04MB6772:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB677277224147B1ED17EBCF12888E0@AM0PR04MB6772.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(189003)(199004)(476003)(446003)(54906003)(52536014)(66066001)(9686003)(11346002)(66556008)(66476007)(66946007)(64756008)(66446008)(4326008)(6246003)(45080400002)(229853002)(99286004)(14454004)(25786009)(478600001)(6436002)(33656002)(26005)(7696005)(102836004)(76176011)(76116006)(6506007)(186003)(55016002)(486006)(71200400001)(71190400001)(86362001)(44832011)(15650500001)(6306002)(81166006)(305945005)(14444005)(8676002)(256004)(81156014)(74316002)(8936002)(7736002)(2906002)(6116002)(3846002)(5660300002)(316002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6772;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: evn6Da4DNsV0gQc/Z/FSp6ItD1wzkEvwFtWSh5ZAaqXBo4akA0vwXPkSvmgAQ+zlxhqa+Vul5C8cEjT5r0dEmZct1Mx7SJnaU3GG9FWQ0v9zl+kjNSTUaAt76KR5n+MuTC019tWPO2113mgj7QwDcl203m6J+sES3Bpq/e31SGbpH+Rk0PfPA2btQCcEnMiuBn/IMF2cAP3rk9aPgGUqv2YMN8ZzUcj7p4m5XGFxr69MvrufZ2IswBmbjinExN1J6u8ogQ1p2Eye7nJHlhX/PI9J13CLuK7PpFhesQMXXbU0ojmNVzBJZNjJzqM4M6kDLCwJgFkDKdI8WBYseBBWImvSlqvI2+PJGdll1Pgn66UYe7nGq2MWy17QciR32rlGrdGgoAFfvMWoniVNVIybpPlFqfkUK1H7Ed4Q+w7CeWY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167818a7-99aa-4d43-2843-08d73c16e69b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 09:02:15.0620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XQ7U6WOyW/uqUL9c+lm7jRvIrhW+LwdQRfLJoZrq4O8XqbCA816hFJsBtPqRvaaTyQXZIfC81k04RYOr3ZUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> Subject: Re: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the
> ARM SMC/HVC mailbox
>=20
> On Mon, 16 Sep 2019 09:44:37 +0000
> Peng Fan <peng.fan@nxp.com> wrote:
>=20
> Hi,
>=20
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The ARM SMC/HVC mailbox binding describes a firmware interface to
> > trigger actions in software layers running in the EL2 or EL3 exception =
levels.
> > The term "ARM" here relates to the SMC instruction as part of the ARM
> > instruction set, not as a standard endorsed by ARM Ltd.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/mailbox/arm-smc.yaml       | 96
> ++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> > b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> > new file mode 100644
> > index 000000000000..bf01bec035fc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fmailbox%2Farm-smc.yaml%23&amp;data=3D02%7
> C01%7Cp
> >
> +eng.fan%40nxp.com%7Cff378bc3d622436c39ba08d73b94dfcc%7C686ea1d
> 3bc2b4c
> >
> +6fa92cd99c5c301635%7C0%7C1%7C637043382928045369&amp;sdata=3Drnx
> KdDGjPPd
> > +8VBI5WmgnZ3jxIjL2hcRYzbljfFxDkA0%3D&amp;reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cpe
> ng.fan%
> >
> +40nxp.com%7Cff378bc3d622436c39ba08d73b94dfcc%7C686ea1d3bc2b4c6
> fa92cd9
> >
> +9c5c301635%7C0%7C1%7C637043382928045369&amp;sdata=3DR02nWzpp9
> %2BrDYG9tA
> > +ot4pdWb8tGGHet1MOjrD0dEjwA%3D&amp;reserved=3D0
> > +
> > +title: ARM SMC Mailbox Interface
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +description: |
> > +  This mailbox uses the ARM smc (secure monitor call) and hvc
> > +(hypervisor
>=20
> I think "or" instead of "and" is less confusing.

ok

>=20
> > +  call) instruction to trigger a mailbox-connected activity in
> > + firmware,  executing on the very same core as the caller. The value
> > + of r0/w0/x0  the firmware returns after the smc call is delivered as
> > + a received  message to the mailbox framework, so synchronous
> > + communication can be  established. The exact meaning of the action
> > + the mailbox triggers as  well as the return value is defined by
> > + their users and is not subject  to this binding.
> > +
> > +  One use case of this mailbox is the SCMI interface, which uses
> > + shared
>=20
>      One example use case of this mailbox ...
> (to make it more obvious that it's not restricted to this)

ok

>=20
> > +  memory to transfer commands and parameters, and a mailbox to
> > + trigger a  function call. This allows SoCs without a separate
> > + management processor  (or when such a processor is not available or
> > + used) to use this  standardized interface anyway.
> > +
> > +  This binding describes no hardware, but establishes a firmware
> interface.
> > +  Upon receiving an SMC using one of the described SMC function
> > + identifiers,
>=20
>                              ... the described SMC function identifier,

ok

>=20
> > +  the firmware is expected to trigger some mailbox connected
> functionality.
> > +  The communication follows the ARM SMC calling convention.
> > +  Firmware expects an SMC function identifier in r0 or w0. The
> > + supported  identifiers are passed from consumers,
>=20
>      identifier

ok

>=20
> "passed from consumers": How? Where?
> But I want to repeat: We should not allow this. This is a binding for a m=
ailbox
> controller driver, not a generic firmware backdoor.

As Jassi suggested the function identifier as an optional for mailbox drive=
r.
The driver should support function id passed from consumers.
Currently there is no users for such case that passed from consumers,
so I have no idea how.

> We should be as strict as possible to avoid any security issues.
> The firmware certainly knows the function ID it implements. The firmware
> controls the DT. So it is straight-forward to put the ID into the DT. The
> firmware could even do this at boot time, dynamically, before passing on =
the
> DT to the non-secure world (bootloader or kernel).
>=20
> What would be the use case of this functionality?
>=20
> > or listed in the the arm,func-ids
>=20
>                        arm,func-id

ok
>=20
> > +  properties as described below. The firmware can return one value in
>=20
>      property
ok
>=20
> > +  the first SMC result register, it is expected to be an error value,
> > + which shall be propagated to the mailbox client.
> > +
> > +  Any core which supports the SMC or HVC instruction can be used, as
> > + long  as a firmware component running in EL3 or EL2 is handling these
> calls.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description:
> > +          For implementations using ARM SMC instruction.
> > +        const: arm,smc-mbox
> > +
> > +      - description:
> > +          For implementations using ARM HVC instruction.
> > +        const: arm,hvc-mbox
>=20
> I am not particularly happy with this, but well ...
>=20
> > +
> > +  "#mbox-cells":
> > +    const: 1
>=20
> Why is this "1"? What is this number used for? It used to be the channel =
ID,
> but since you are describing a single channel controller only, this shoul=
d be 0
> now.

Mailbox bindings requires it at least 1, as replied to Jassi in the other m=
ail.

>=20
> > +
> > +  arm,func-id:
> > +    description: |
> > +      An 32-bit value specifying the function ID used by the mailbox.
>=20
>          A single 32-bit value ...
>=20
> > +      The function ID follow the ARM SMC calling convention standard
> [1].
>=20
>                          follows
>=20
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +required:
> > +  - compatible
> > +  - "#mbox-cells"
> > +
> > +examples:
> > +  - |
> > +    sram@93f000 {
> > +      compatible =3D "mmio-sram";
> > +      reg =3D <0x0 0x93f000 0x0 0x1000>;
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +      ranges =3D <0x0 0x93f000 0x1000>;
> > +
> > +      cpu_scp_lpri: scp-shmem@0 {
> > +        compatible =3D "arm,scmi-shmem";
> > +        reg =3D <0x0 0x200>;
> > +      };
> > +    };
> > +
> > +    smc_tx_mbox: tx_mbox {
> > +      #mbox-cells =3D <1>;
>=20
> As mentioned above, should be 0.
>=20
> > +      compatible =3D "arm,smc-mbox";
> > +      /* optional */
>=20
> First: having "optional" in a specific example is not helpful, just confu=
sing.
> Second: It is actually *not* optional in this case, as there is no other =
way of
> propagating the function ID. The SCMI driver as the mailbox client has
> certainly no clue about this.

I'll drop "/*optinal*/" since it is required in the example.

> I think I said this previously: Relying on the mailbox client to pass the=
 function
> ID sounds broken, as this is a property of the mailbox controller driver.=
 The
> mailbox client does not care about this mailbox communication detail, it =
just
> wants to trigger the mailbox.
>=20
> > +      arm,func-id =3D <0xc20000fe>;
> > +    };
> > +
> > +    firmware {
> > +      scmi {
> > +        compatible =3D "arm,scmi";
> > +        mboxes =3D <&smc_tx_mbox 0>;
>=20
> ... and here just <&smc_tx_mbox>; would suffice.

Mailbox requires mbox-cells at least 1, it must have one arg.
Otherwise of_mbox_index_xlate not work.

Thanks,
Peng.

>=20
> > +        mbox-names =3D "tx";
> > +        shmem =3D <&cpu_scp_lpri>;
> > +      };
> > +    };
> > +
> > +...
>=20
> Cheers,
> Andre.
