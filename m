Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74FBC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE98217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="I1dWrzw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfIZJPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:15:52 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:26117
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727791AbfIZJPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:15:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duC4lA7avR8C4KdHHDTwywKyby8FtJtAbvZ0ykXwp40Tq+kjh1gYJD7mUo3H9Mx5toszZoad6IwVCGeGjSgCvIYsWznRnt6p2QP3ixegc+s01+HXKQrChn7zErofZMAdEsgST5EGKJtvgqzfmVAxIw/0IialU+wld7E54K9j+3hkQLraNRm1+0mcBJL3k3YsE4Ikd3cHSO8wT6h/8YJQ+XsqwX6vwQEkV3aeY9qD/lNt9JjIDnfRN6lHGspMMQOABmiVyW1ReK9Bep8Jo3AQSVjZKmlDUiBwE/oj/QquHBxV/dlr7MS2189U87KhotpCM8puC4OfIA+uHGVCjDzGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5WFrf02fOK2GbKZyow8uYygsBvHbh/Xx71EcqcALJo=;
 b=A4ZxtXkwo4iclfk67x0s7pIYdbRBGYhhjbAV5IzfPoPk10EXButaQmLlr1v387BU6eXMHr0twdCTjlCE7qvuL8wOMvzPLTub/MYpHHkF5K3QwF6cQ7igvKFQYcQfNgSAe2p/G49mBpYL0fZtVlOYapHRMOiYZ/n4CRBWmBENvP9fQnpKoVcunp44lPzP1QfkW24+gKy452KK+REDrZ7hUOqKI1/GO97w9Ypwu3Xc1IQvoi2qTdVsLX//ej9lrtfoyq5gEUPZrw0bXbbGQg2FUue8BW3paWZ0v+5bS1LDqFZP6Ip4ydcHeUMJyuB6LeMKEUbNejt1woRvIy76JdaTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5WFrf02fOK2GbKZyow8uYygsBvHbh/Xx71EcqcALJo=;
 b=I1dWrzw0+djnyUChyVHvVEhzAV7tWJJCoO8Qq99RDztpNvrXu+6Zd1Va6Bwaa0Q/KgzmLWKPXhoVjq0lBvKo4okjaDn7Fjz+t8+HMRCbC8+/qJGRor99MltuZYjPSFrIMjwRzRvpSOwof7MFnyxnydmq1s6R2W8OBzA1DTCBw/4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB3972.eurprd04.prod.outlook.com (52.134.124.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Thu, 26 Sep 2019 09:15:48 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6ca2:ec08:2b37:8ab8%6]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 09:15:48 +0000
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
Subject: RE: [PATCH V9 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Topic: [PATCH V9 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
Thread-Index: AQHVc0Y291KPBxEKYUuzX6RMzv1Tyac8oU2AgAENj5A=
Date:   Thu, 26 Sep 2019 09:15:48 +0000
Message-ID: <AM0PR04MB4481EA21FAC45DCCF295A71F88860@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1569377224-5755-1-git-send-email-peng.fan@nxp.com>
        <1569377224-5755-2-git-send-email-peng.fan@nxp.com>
 <20190925180901.11fe5165@donnerap.cambridge.arm.com>
In-Reply-To: <20190925180901.11fe5165@donnerap.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfd87df5-a82c-4ecf-089a-08d742621ea3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB3972;
x-ms-traffictypediagnostic: AM0PR04MB3972:|AM0PR04MB3972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB3972D8604B7B9B6F3574897D88860@AM0PR04MB3972.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(51914003)(189003)(199004)(478600001)(54906003)(316002)(52536014)(5660300002)(256004)(86362001)(64756008)(476003)(71190400001)(71200400001)(66476007)(66946007)(66556008)(15650500001)(446003)(66066001)(11346002)(66446008)(44832011)(2906002)(486006)(3846002)(6116002)(6506007)(76176011)(14454004)(102836004)(81166006)(8676002)(8936002)(81156014)(25786009)(76116006)(33656002)(26005)(229853002)(7736002)(99286004)(7696005)(186003)(6436002)(55016002)(9686003)(6246003)(305945005)(4326008)(6916009)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3972;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AQDe3lv8Px8MESWNrH8Oz2TMK4GjIs9gqKIAKyCjhnn/qphE5la7PqMoRTTcUt4tIXzfVYib/DDBAH5Nq6pABaxQxSQyjFdmpAmBeKeHP5UAU3ej5EkicXtyLyb+Qmwz5tYwwvXzsuXhT3pC/N5ryrrFt+YDL9coXWEwtTx2Eba4FOYZf0w+wqXhb++K7lMYk+9GYRwZqUUmZ6G5r4P3LRXmGPUsaVyGBFV7Y+Wv/iSbBz+UKiQALzuS1TJafZrhaAVrUe8KzaVJUZ4t/2vAnGLKyR85eNtrvu+ZUej1S+Wlp9qugaxOilZCiV6hOg3V56LFnoFRuuMFIrqioFQXwDMTh+RgbfPzRtxW3a2NC9zhfypzAqS8/NAPDPoB60cNbCnEgL+36sz9uNH/fOVW7njz/s7b8YUJiMYCX1MuX70=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd87df5-a82c-4ecf-089a-08d742621ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 09:15:48.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyy3T4LMMcRLAMFSxwRQgmyxTCnnBDYICj61KcudQUzjdVq7mwxSRKiYslUbmeZDQlYGVTqsVyOjahSuRZXbfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3972
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> Subject: Re: [PATCH V9 1/2] dt-bindings: mailbox: add binding doc for the
> ARM SMC/HVC mailbox
>=20
[...]
> > + supported  identifier are passed from consumers, or listed in the
> > + the arm,func-id
>=20
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 		This is now obsolete.
>=20
> The rest looks good to me, thanks for the changes!
>=20
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks, I'll wait to see whether Rob and Jassi has some comments or not.

Then post out v10 to address your comments.

Thanks,
Peng.

>=20
> Cheers,
> Andre.
>=20
> > +  property as described below. The firmware can return one value in
> > + the first SMC result register, it is expected to be an error value,
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
> > +
> > +  "#mbox-cells":
> > +    const: 0
> > +
> > +  arm,func-id:
> > +    description: |
> > +      An single 32-bit value specifying the function ID used by the
> mailbox.
> > +      The function ID follows the ARM SMC calling convention standard.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +required:
> > +  - compatible
> > +  - "#mbox-cells"
> > +  - arm,func-id
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
> > +      #mbox-cells =3D <0>;
> > +      compatible =3D "arm,smc-mbox";
> > +      arm,func-id =3D <0xc20000fe>;
> > +    };
> > +
> > +    firmware {
> > +      scmi {
> > +        compatible =3D "arm,scmi";
> > +        mboxes =3D <&smc_tx_mbox>;
> > +        mbox-names =3D "tx";
> > +        shmem =3D <&cpu_scp_lpri>;
> > +      };
> > +    };
> > +
> > +...

