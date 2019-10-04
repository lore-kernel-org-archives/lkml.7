Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2732BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F346A222CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYK89Msw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfJDNkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:40:52 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:35812
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388270AbfJDNkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEd4B/gU1Z5k76q2obnkYnRiKhut2+E/X+dBNc6XJbXrxLViqlUPFUi1Y5SJPES+rZy05RaSunOJp3LL/GHXPBkdSZu9qc5PA3e65VcPvmF/yBfFiDsZWaolZFphbYOrAND+jVVrNhN3xNaLaU5iemFLzm8OAJm4DJ/Xruicxf+6PvoNkbhO6oDdyxDcmIcmeZk1TyqL1/2A59VLISSpw0woD/l9ImL9XIyWnXjN93xtDaJzEwYo7bcDzl1BQwfI9NElYyK/YdQMufW+84aWauLaKVwXRGpM8pPGiyqDt/M+tHLowRmBn6uEbPU0WQ1tT6Y9fh4au1ZklfW6dc9WjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAqQhnB9OCw+1cyAwit8CjnmkGxZUd5/qxjBxXYoZmU=;
 b=KH60EO6gda78uBXR+AQCPseEUKHmHpK7ekGQn9U0Pnfl2LPCH66MOurD6UFX6kRBI9ngu8V15lB9UvHSh55C7knla5HJx2vvbGLbv2VpyLGq8Iee0Onc26up8BWiG7hYLf8KnwvKF20tELX7aTHtR8DzivLV8LxScW+p6NBIo0dRnUFA4+LiVuSb4Mj/B+psW4p2L4ObItUkZYYwIMkJL1WmANYWjYT6FUGkLLi2d9gk6iHUVrDJAtL5F61sPtkXJNwJdtQ0EoDfisOZn0+enJv2/iKblEbgLwz+jNszE1Ah1bCqe37d84G+Elym1jtCI051qpe4rJYH+trePssmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAqQhnB9OCw+1cyAwit8CjnmkGxZUd5/qxjBxXYoZmU=;
 b=hYK89MswdX0Jbzuz3PNCoMt/XpZzjpH11+EVG0GSqPOKq2Pjl2QqkQzOPi43VB28+n4tdvGACxqubkTCKdsdfuo7aL34Pct4HJ/GMosSt5H9kFtxeyGdjmpb8pa/ItV0raNmIQCrnBSDqQnOkjQVa1l+i/KzJf1bgfZ3vgMNmkU=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3838.eurprd04.prod.outlook.com (52.134.16.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 13:40:48 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::fd33:c447:3cab:c36%7]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 13:40:48 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/5] serial: fsl_linflexuart: Be consistent with the
 name
Thread-Topic: [PATCH v5 3/5] serial: fsl_linflexuart: Be consistent with the
 name
Thread-Index: AQHVerlUg6aq6mZeEE2PCdc5NmXbcA==
Date:   Fri, 4 Oct 2019 13:40:48 +0000
Message-ID: <VI1PR0402MB2863C5C76A9F709B98C7BDE7DF9E0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
 <20191002130425.28905-4-stefan-gabriel.mirea@nxp.com>
 <20191004130712.GA622272@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffc368f5-ff23-4639-bdb6-08d748d07722
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR0402MB3838:
x-microsoft-antispam-prvs: <VI1PR0402MB38385C8E83847431008C90B9DF9E0@VI1PR0402MB3838.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(8936002)(7416002)(52536014)(4744005)(99286004)(6916009)(66556008)(4326008)(66476007)(64756008)(66446008)(7696005)(76176011)(305945005)(186003)(6506007)(7736002)(26005)(102836004)(53546011)(8676002)(1730700003)(81156014)(446003)(5660300002)(81166006)(86362001)(74316002)(2351001)(256004)(25786009)(229853002)(3846002)(2501003)(6116002)(33656002)(6246003)(476003)(14454004)(316002)(76116006)(66946007)(91956017)(6436002)(71190400001)(2906002)(54906003)(71200400001)(5640700003)(478600001)(55016002)(9686003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3838;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QrAuTePPkOPBlNQQrMGP8w3ZsaCtxJcmtggHpE0mPvCaNgHQS+K678/MDPid6KYDFCarx/f077OWnYUau1Hw2er8NBZojmLd00mtx+SzigYx5PvU5vbfVo0t1VA/qPHOA+kf0atAUgg+oPd4t8QrSEovXBgju+enu/3ncfNelfrV3j7ahquvO766FbItanmC8A1wTw0oW01RzweGYcfUz8gIXOhSHazXb++8ohBck/6WaptOAhDQjY7zTIrw0yk2WRbwpcQPyQkG5JVUIvM8V0DyNdPFzXUnZO3k1z0CqzrNT0r/07m5UX6zMM1OTFT6sYxrPU3JzWThXqvTkfUE8Tk3T/QC3ov31iyYEvYJbXKZWi9O6YafZ7SZxF5jRfk5GYMWdw99ZuPO4T3OoKLh/4/MycI0eXuptEB2txDeIWo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc368f5-ff23-4639-bdb6-08d748d07722
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 13:40:48.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSLWXAjH9eSH5rkmCl197xtAMsiXR4XoDSUT4b8ZutalNRANy9ITFfglCgDwwi/LkAY5+Gkye5nLLu6fIQFH3JzMDyIy90YjKWufCPyWg6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,=0A=
=0A=
On 10/4/2019 4:07 PM, gregkh@linuxfoundation.org wrote:=0A=
> On Wed, Oct 02, 2019 at 01:04:42PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> --- a/include/uapi/linux/serial_core.h=0A=
>> +++ b/include/uapi/linux/serial_core.h=0A=
>> @@ -290,7 +290,7 @@=0A=
>>  /* Sunix UART */=0A=
>>  #define PORT_SUNIX   121=0A=
>>=0A=
>> -/* Freescale Linflex UART */=0A=
>> -#define PORT_LINFLEXUART     121=0A=
>> +/* Freescale LINFlexD UART */=0A=
>> +#define PORT_LINFLEXUART     122=0A=
> =0A=
> This is a different change, and one that should be split out and=0A=
> submitted now, for 5.4.  Please do that as the id number is incorrect,=0A=
> don't bury a valid change in the middle of a "marketing renamed the=0A=
> device" patch :)=0A=
=0A=
I will do that, thanks!=0A=
=0A=
Regards,=0A=
Stefan=0A=
