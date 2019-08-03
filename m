Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEC7C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 08:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5DD20665
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 08:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="baXXQabj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbfHCIAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:00:37 -0400
Received: from mail-eopbgr150079.outbound.protection.outlook.com ([40.107.15.79]:1158
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387429AbfHCIAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMonDt/Nmb7iY3iweg+/XMhlclbw2FReYuc5suf0GOd5t8T7mDGg22zraVDTAvMGzXN32hAOzFaq1qfxQL8XyBGkZjcT5Edi7JCE/yp4sQO+yyOHbMP/CpKaxA+u5LvKUQBJcMZdiBR8Yqw5evzApI7CN/cFclCYQJobEot+0zwbyuH9Mo7hrt7rYjkcuZ+7iDLEezyQE4iIulntfngxPquInljyBuFqUWjieS7oKI8cub49gaZj8YUy8/K31PUGK1r2r3MAYL4GNriAaOlf1nKLKFWi4jdrYNOmMMEcXjIfgjyEalf85lHsBDVU7MRVPbPebFrkUmLIUXjkGcT+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBlcK4FrdXarGimycrF+WJICxZD7DjSwyXNQoc6xHtc=;
 b=nKZLJO+iiNGD1pP4JuHU9bmeq3+xRFC0uN5NYfZkKPsNk7nxh6fsXd1jPYAV4lVim758d+VUmOetwbsoRhz4DuGokRgUwRt3HZJ6bsTKrd1ZGL0RgskOLfp0XhrjocBZr/+W+Vk+dE5xunoTmkQZbtFVGA7cwuf43wafneZHfaaKtu13VgVyNutGs84/q4VR/0YCpHefKTyHEpCwJ2bcdtm3zJLhRxE+vDvXNZh0ZXeobYP7eZEkKJRPXtYyUFxQ86c1BcubTJM9s5Ur06i3idPszl0CKNV+BKIe02lYyguOELK9YbAzH3b5wPAmQ5NL/tHg+Tg53WFnNi/R1UrOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBlcK4FrdXarGimycrF+WJICxZD7DjSwyXNQoc6xHtc=;
 b=baXXQabjHK/L616tcwbKBh4Cb6uzgDqO7tks45BmPnhH56cA++BipAwQ2j3M8BWhFeghNx/wKVyPU+luaurmPkK8qO+AeLrCfmDLCXSQaW56lz0pp1UT8dpMm7LqJsouY++r8LmrbxA5Ac6xhTJweV4xkoyRPCll1aGxCovUjbE=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3821.eurprd04.prod.outlook.com (52.134.16.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Sat, 3 Aug 2019 08:00:31 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2136.010; Sat, 3 Aug 2019
 08:00:31 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Eddy Petrisor <eddy.petrisor@nxp.com>
Subject: Re: [EXT] Re: [PATCH 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB
 board
Thread-Topic: [EXT] Re: [PATCH 1/6] dt-bindings: arm: fsl: Add the S32V234-EVB
 board
Thread-Index: AQHVSWsWLPLKyRuIh0CSHJAAi/FmUA==
Date:   Sat, 3 Aug 2019 08:00:31 +0000
Message-ID: <VI1PR0402MB28635B9758CBF72504191693DFD80@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-2-stefan-gabriel.mirea@nxp.com>
 <CAL_JsqL++GZBxczxePni9ysNq06kObB4EzJEi1e4M=PurPZFgQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [86.120.183.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 651eb805-28b5-4f93-791a-08d717e8a804
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3821;
x-ms-traffictypediagnostic: VI1PR0402MB3821:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB38214F3893B613D6287C41E8DFD80@VI1PR0402MB3821.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0118CD8765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(199004)(189003)(68736007)(305945005)(4326008)(81156014)(99286004)(66066001)(53546011)(26005)(6116002)(5660300002)(6506007)(186003)(102836004)(3846002)(74316002)(7696005)(4744005)(53936002)(55016002)(6306002)(71190400001)(2906002)(52536014)(71200400001)(76176011)(9686003)(8676002)(64756008)(86362001)(66446008)(256004)(14444005)(76116006)(66946007)(6436002)(966005)(66556008)(66476007)(6246003)(446003)(33656002)(7736002)(8936002)(14454004)(478600001)(486006)(25786009)(81166006)(476003)(229853002)(7416002)(316002)(54906003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3821;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oT524hOSLPtI59pv4c8gZe+bdjgqeIQDuPYhHv6njtFc61Y9+k6AknuIVpsamFV+9m1Prsh65PwEYcvDaEKYRM4GhHGGsjK6aF7jcK862BlaGtpPtPi1Lt2cy7fHQbJIR3ORa1tteKQsqWPF2k4lKrfpXdaUOoqDEItCHXHxdV6lvr75WxmaEPaDIb+lSMLVQCL8inLre/GcqmwkmNGF7DaCSDt7kykc6FuhgWFwSR+HNiTNNIW48jzfy8vHXweGsQc/Gs8ajJIWnMfy9ylPI8HYIXqPE2Vo4HkB+60+7/SdaSE/1qDz5MaH9ur6HID67OUrE+aghxW7jWGFiGqgEbLM25fohYfKPUTxpWOp1TaTJkvsm+2U7K9v7WanabGneEDkSNTpMz2Y40EGCNFVKdb9OzBeH4H1DzIk1w9E03s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651eb805-28b5-4f93-791a-08d717e8a804
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2019 08:00:31.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stefan-gabriel.mirea@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,=0A=
=0A=
On 8/3/2019 1:38 AM, Rob Herring wrote:=0A=
> On Fri, Aug 2, 2019 at 1:47 PM Stefan-gabriel Mirea=0A=
> <stefan-gabriel.mirea@nxp.com> wrote:=0A=
>> +      - description: S32V234 Customer Evaluation Board=0A=
>=0A=
> Most of the entries in this file are for all the boards for an SoC.=0A=
>=0A=
>> +        items:=0A=
>> +          - enum:=0A=
>> +              - fsl,s32v234-evb=0A=
>=0A=
> If that's not going to be the case here, you can use 'const' here.=0A=
=0A=
We also intend to submit patches for the SBC-S32V234[1] board in the=0A=
future and I believe that its 'compatible' should share this entry.=0A=
Would it therefore be preferable to update the description at this=0A=
moment and add a comment, like:=0A=
=0A=
      - description: S32V234 based Boards=0A=
        items:=0A=
          - enum:=0A=
              - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluatio=
n Board=0A=
          - const: fsl,s32v234=0A=
=0A=
or just replace the single-value 'enum' with a 'const' for now?=0A=
=0A=
Regards,=0A=
Stefan=0A=
=0A=
[1] https://www.nxp.com/design/development-boards/automotive-development-pl=
atforms/s32v-mpus-platforms/s32v-vision-and-sensor-fusion-evaluation-board:=
SBC-S32V234=0A=
