Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC64C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040462184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NDj84d3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbfHHMrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:47:05 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:32241
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732239AbfHHMrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:47:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNofIBclOGjZiXi3zMwFSX8lLdnjzZE4cD5xRNxZfBNxUMmmMJWwlkOdOCQbjHaUO710cidFl24zh5wxvruBA/8L4rKjvN5Kn8loyzWm5EafFTA6KBjKOXLQ45fMXyA1lLkMwVuJtnb86lGLLMxvHh/pGSyKBbAmrw5OtaC9+nJZGeVhu9h+B8xv4Mierz8CDvk7AmiVx0S37kNOEgC8a3X+Y3Ma6hw1qBaV0QUVrhvLGRtW4t87y22EPbQ4+wQTXFas94OaQRwR4gHS8LMhzSvbm150tGAgoRGO5Q6fn0fAFzyHKuzn08Dik3xgCuFKVhIAQ+fOkCIcg+F0ic1q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmyIWJg3VCBHJyFHlAwXSgvEbQflGmrOz9toDxtGAHw=;
 b=OApBa7ySvx+ImOgf8GJ1z717S4qp8S741d23BvgOiEwpRoTLS5UPOBpd9/zGyhpmWDTx81hJVh8gGGCL5rze3Zx0AUC06uhRGe0fs0pVq10aK1HcX54+eSLitUQ0UrJ3j1B3Ydp9UZJ9zCJO2148WwAp3hN58iqFLOsyQcVBiWy+js1c5kELnbbJ3xUzZb3wGv4IS0/xtiNQf+n2pcWMewL8M8nGLhV3d9UtQoOFSX2dJivdbx9aHyrbxN4X30jFtcwIvXqKV7m4Cp157nJIvuHRVB3BRoSckxFxT1UFz2P+ZrTXJ7h4wLX8qQyjTs8VdgoWHO8JaBiqQ/EUKlW/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmyIWJg3VCBHJyFHlAwXSgvEbQflGmrOz9toDxtGAHw=;
 b=NDj84d3Xl3VtQEyDeH3JLW9yz78V8v0Y6QZ9xEH+1+sGmQ9VAcuy711cq2WbIQBgaiatKZQo+FIhpi2QAq3kRqpl0M5ax1cZON/5wstjLSZBwR11WXp/O/yrbwjkjnIDqCA2pKPbtVQ7HopL8Fq8fpW0DwroESQ65h695BJWq68=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3486.eurprd04.prod.outlook.com (52.134.4.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Thu, 8 Aug 2019 12:47:00 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 12:47:00 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Will Deacon <will@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Topic: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Index: AQHVTedeF3dhRXLcj0y74YIrrBcLXw==
Date:   Thu, 8 Aug 2019 12:47:00 +0000
Message-ID: <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c582575-b651-4513-b70c-08d71bfe8191
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3486;
x-ms-traffictypediagnostic: VI1PR0402MB3486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB348633D1EBEE64E92FB040FADFD70@VI1PR0402MB3486.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(64756008)(66946007)(91956017)(229853002)(66556008)(6436002)(66476007)(76116006)(7736002)(99286004)(2906002)(4744005)(186003)(26005)(8936002)(476003)(52536014)(5660300002)(14454004)(54906003)(316002)(33656002)(6916009)(25786009)(4326008)(7696005)(256004)(6246003)(53546011)(66066001)(478600001)(6506007)(305945005)(3846002)(66446008)(71190400001)(81156014)(7416002)(9686003)(86362001)(446003)(486006)(74316002)(81166006)(76176011)(8676002)(55016002)(102836004)(6116002)(71200400001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3486;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BgjKTf/kBsvFpTpJggHinQVW9X0pBbFxTEFxaBiDL+1S9EjqYa/wAEIfe+e4NmF3QJl4sP9wuhAnNwG9r0BQuzoJjUADaCiugUsYqE9rhjmW3hezxzMn/9pGocHuBRP6LmzUWsQ07nxG7YdJe8Ud8YA26JzVJzyvfY/fIFI5wI7P9fJwSMTWmb3UOvqwMX827tid436dT2K2tuXxS4hsXpPMXbrL+iKmw1X6d+OAoSy6gZ/1YppqxO/nyMxJfO4CzJY5A/Tl+sTFxWzKewRCQsigjZuE/JVPyKLQjvt+xOaqpbiwY34RPcIKqO27WllOvaGpmcKPAAqq9UCM1an5DaCROsqhamfcK+q/tymyWvFPbQOeIgM3PwJ3asjP9GkCsB3FdQ0yfwktAXJYDh3NLmjJ4EilZVQQZYvv/ge38pA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c582575-b651-4513-b70c-08d71bfe8191
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 12:47:00.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CerixfyV5LJpr6/SlEDA8FuQ0eFQyh0hZwmmAtDDISjSZIKHYnPowRjT3Zmg3Hm7ug7rQuUS9g5QlCqsQjP8X791RdSC5bEf7cZsV3WEj3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Will,=0A=
=0A=
On 8/8/2019 11:08 AM, Will Deacon wrote:=0A=
> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> +             linflex,<addr>=0A=
>> +                     Use early console provided by Freescale LinFlex UA=
RT=0A=
>> +                     serial driver for NXP S32V234 SoCs. A valid base=
=0A=
>> +                     address must be provided, and the serial port must=
=0A=
>> +                     already be setup and configured.=0A=
> =0A=
> Why isn't earlycon=3D sufficient for this?=0A=
=0A=
"earlycon=3D" is not actually supported. I will fix this in the next=0A=
version by adding a /chosen/stdout-path to the dts. The compatible=0A=
string provided to OF_EARLYCON_DECLARE will also be changed from=0A=
"fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in=0A=
the device tree nodes. I missed this after importing a rename from our=0A=
codebase.=0A=
=0A=
Should I remove this addition from kernel-parameters.txt after that?=0A=
=0A=
Regards,=0A=
Stefan=0A=
