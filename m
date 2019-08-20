Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA781C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C3230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CtrXHZU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfHTQil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:38:41 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:13543
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfHTQil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:38:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBmc8noZq8RJ/BedsDjXnEnodz9VhVtv3h8njZKMpsJLf0JcDM4XQ+GW4/QZMttikiIgUmcQh7ZVzwUW/adP0a3QcP0Y0S9Q8jV0B0EeF44/8Xy/hsQRom2JYWUJsW40oJehTQGu97vGBPKMyqICJGqwF7HR79EaO8ogJ/EVHYvIL22TKQCfSZBkozL8fVm29YeE/pfGxZA57RNyqDStWcGsARIrXtGGIgjGIfKN9AVcKcjSxod+dD7146QaTSiiJ/lD9ZRllS0pxbnB/64u3di6EeCEiu9HeMOWO7apjXqTvdLnqsnYad1Wpltk+KmGu9FKmz4rarHJHpkbk5EbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FLbOdTX0wSybYtQ9hXAsJhEjrhBxn1NRZuoSp8LI80=;
 b=B3rG2yHAex8v7GHBHql765COspBYcXhHpJNa/542rzfoZAPvdz3EyIJYNFarPtPG+AyfJj5gHG1pCvZGLDDBQT6yONwATtDaBkIAncrUz8ZXMsQuIb9Q63TDRhYbBD6E9D3fnHZ2ocPc1WBX3GIe6srjpVxYtF/ewybqpZiP37cWpYJFjPapZAsSsQjDGhPWR3dPfowP0LyrUpbdrzcuHEB77tmkLjax1kaSrV3pgjhFHV3SrVNcoAPenjeyE2j/xu8ecrMesL+l9l6JPURqiHnK9WcoSLKtGaskvR/GZMA+eML9ty/nJNFIHldOO8TA+VE3uB58pi4Dk1Jdj15iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FLbOdTX0wSybYtQ9hXAsJhEjrhBxn1NRZuoSp8LI80=;
 b=CtrXHZU5Zw5a1IbNHiuq0+qqUmosRzU2r0rHlpSFUStA3gSLPr0gbshTFxrADkd6UasgJupbHNGn1L1YheCS4lT+KVrqhIvDYcLvgIiZcjYXOoB4CPx/g8mRC5R840y4ylx+V0yXrsHseCv8qj9VdVo5ZBcj28gmTkMs4X3C9lw=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3343.eurprd04.prod.outlook.com (52.134.8.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 16:38:31 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 16:38:31 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>
Subject: Re: [PATCH v2 2/6] arm64: Introduce config for S32
Thread-Topic: [PATCH v2 2/6] arm64: Introduce config for S32
Thread-Index: AQHVV3WzypZWNneu9kiQkORbn2Hd8w==
Date:   Tue, 20 Aug 2019 16:38:30 +0000
Message-ID: <VI1PR0402MB2863F70B8497B8901087B7A4DFAB0@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-3-stefan-gabriel.mirea@nxp.com>
 <20190819081457.GH5999@X250>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80742a49-84df-47f0-3984-08d7258cd5e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3343;
x-ms-traffictypediagnostic: VI1PR0402MB3343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB334359C298A74213AC7C4DD4DFAB0@VI1PR0402MB3343.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(189003)(199004)(71200400001)(71190400001)(9686003)(53936002)(6436002)(33656002)(55016002)(256004)(6916009)(4744005)(5660300002)(229853002)(6246003)(99286004)(25786009)(53546011)(6506007)(52536014)(4326008)(102836004)(54906003)(316002)(14454004)(7696005)(486006)(26005)(476003)(446003)(76176011)(2906002)(7416002)(186003)(8936002)(74316002)(81166006)(81156014)(478600001)(3846002)(8676002)(66066001)(86362001)(76116006)(91956017)(66946007)(6116002)(64756008)(66556008)(66476007)(66446008)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3343;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ue/VcgzjdsQdaBLZsxcoOTV0hJV5CRBrIXuVlP13ngS5HpSIfyVgBypLzChauXcL98EpRQHxRNs3QfR/jlOwYoPzlOgYTnBfX7UmEpAEDgGwr3tbelkcCrhoZQCZWf7B2wlwOU/xeXGo92aL4GXeJ+hYrF1Y1kmeeXfwLUHPl9X8cTUc/+3O3XzgElTqgdhbCbO9WAyF2UR+RLrWDCy0MOqC1AxJLr7KwvNTkozvfjnNPz3Nx5+dsNsa9et+WrUe+xGafl4jMvJzKOPGY0t6QHZa5uWCfLijAer6tvFMqSjQHY8FSMwpmkTa0a3pIhzyB0f7qGCvIpql2jLXC82IwfDPkinbYywHd5pI49EwMoVeh5IOw8KvbG2d2UdLHPoa6TdPYC+ZldqJ4LlfNAKDnWyxcBMzJep1msSso6Kg3HQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80742a49-84df-47f0-3984-08d7258cd5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 16:38:30.9260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31cL24he+y4J9FJTM5jD8DtAmSpK6TDZrlQlhO/mffWDnAMlfu7F7iR7vyGl76VPXa1HMNuKhG2Xn383YTa9nTAe6JYN2h5RVqzkiV38JeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,=0A=
=0A=
On 8/19/2019 11:15 AM, Shawn Guo wrote:=0A=
> On Fri, Aug 09, 2019 at 11:29:10AM +0000, Stefan-gabriel Mirea wrote:=0A=
>> +config ARCH_S32=0A=
>> +     bool "Freescale S32 SoC Family"=0A=
> =0A=
> So you still want to use 'Freescale' than 'NXP' here?=0A=
> =0A=
>> +     help=0A=
>> +       This enables support for the Freescale S32 family of processors.=
=0A=
=0A=
Thanks; I will replace Freescale with NXP wherever possible in the next=0A=
version.=0A=
=0A=
Regards,=0A=
Stefan=0A=
