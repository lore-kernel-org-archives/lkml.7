Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E747AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9534F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OYF/+NOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfHMH3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:29:50 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:1693
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726789AbfHMH3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:29:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir+TzaPFMju12iQesRF+MhbxaQni4LKC8jabklQx6mNspyr1vsqNIt/TdaCcD/UEVMUsV6XCrzrZ1Kget7ox58M1PDQvLp4bxfAiMgJQqywIZFP06cpoPWT7EwJybqDG0xVFMIGSaWLAW/9sREb8Mfyx+rssLCwt6ndfb3LKFInIKrg9ws9fvkjpJcXbJNhmbQKCj2IvF5vc1IDC2Apne0DYGwYZgUFuvlPg2ezq0Dg/zD9fwBcTSOv95wcLGPClIqpoqx64UyWiybySjSQO5JnUEJoeKrJBb9YCP8xM8narI/1BKpwq+5qTdRGBePmFzjN3Y4C5k1CeLthA6mUFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFDTqgKsLT+T3uo9cLffRrI640myAFatY9wgzDSuyOU=;
 b=KNmd1FRA+BZ3ZUyNIGfsz3WCfja/zkQXgepE16AW9cR9HV2b/4C/Lqj0RgLy1Y0GMH65pZdA3Rf7L0+u3jIBYmyRG89+yyYxrq6NCd2ukCnblS2mK8gFn6WLSaopp5ueGU4pjwBtacJSghvZ4umZr36tQPu2DNrLvyuS7M23rxp2E7q08iT5DoGAUhj+FNweDfw//B8F5oZNVHbbzk9GcJaxqQdjxubxcL4ZLzBOMZnxAILM9tKqobr3/n4urjbaK6dm22zGu3K1mtpt9pMvj+DY0Bpli36yTGPPqqG0NGbqVEV6cdfxJE42Fp8tyKaF2CAdP4042iGfFbfxGPSvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFDTqgKsLT+T3uo9cLffRrI640myAFatY9wgzDSuyOU=;
 b=OYF/+NOEASRHD3GgYyk3BaXTYX1SHekDlPNC2XMmWHnTXWdhhGmT9VPTvHKeBFmy55/MIwEhtxg7gTZiL10JzeeAFO47XdVrkTi5lf9I4/yyFgn4yt6RSoIoq8CLiy6VKNdWhlggQZJbw/xJF8pwCPCY5d0Ywf8qVd0e0uV/jrU=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.175.24.138) by
 VI1PR0402MB3952.eurprd04.prod.outlook.com (52.134.17.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Tue, 13 Aug 2019 07:29:47 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::85d1:9f00:3d4c:1860]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::85d1:9f00:3d4c:1860%7]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 07:29:47 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 03/10] staging: fsl-dpaa2/ethsw: add line terminator to
 all formats
Thread-Topic: [PATCH 03/10] staging: fsl-dpaa2/ethsw: add line terminator to
 all formats
Thread-Index: AQHVUPHZyY79KmlMrUC9ivwdgb2X+w==
Date:   Tue, 13 Aug 2019 07:29:46 +0000
Message-ID: <VI1PR0402MB280072E23E15D85AC7442105E0D20@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <1565602758-14434-1-git-send-email-ioana.ciornei@nxp.com>
 <1565602758-14434-4-git-send-email-ioana.ciornei@nxp.com>
 <20190812144414.GA25512@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [188.25.91.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae885837-880f-4065-b920-08d71fc004d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB3952;
x-ms-traffictypediagnostic: VI1PR0402MB3952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3952747CD7028F9AA7D48018E0D20@VI1PR0402MB3952.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(71190400001)(54906003)(71200400001)(316002)(4326008)(8676002)(4744005)(256004)(86362001)(102836004)(6246003)(7696005)(9686003)(6506007)(53546011)(6436002)(14454004)(229853002)(186003)(26005)(76176011)(99286004)(478600001)(52536014)(53936002)(44832011)(486006)(2906002)(64756008)(66556008)(5660300002)(55016002)(66446008)(7736002)(66476007)(66066001)(74316002)(446003)(3846002)(25786009)(6116002)(476003)(76116006)(66946007)(8936002)(33656002)(305945005)(6916009)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3952;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: czjGwMrgOCddET5+NW2gVpYV5RcWSg1sRx3YOjjiY2cvRAbKJTvTQrSu5rlcef6jsj/evvehCdnY/eZCihLqARc4i0w5Knv2Zcx4AtbeVcWKNQ5H/Ix4JwcE2evvgqocXx2sA8Fi2VJ5psRLb3v4w5q50qBRjleehzKlvi32j4NSZIheBiMO7LT4VP4dY0Y8SMZZ8/VRobCBf3VCGntl4kUK3t575ZTFYX5NJHs+3th6+cj/42p6JrYDK0V1ngFxo9DdEVQjl83TitVHK5YzXNW3VDsRsUWZspgR720gfZumTSv936GQTB3YRiMLKKpWGzPkOmKvuyu0n9hl1nYO/H1We6P/kgN09W0vKJfoO60jfv3W4ROJ6W89ntomBqV/mf+49ajJbTNYcozZ1tUdPP4R5IEn9xoWf3UIV2J5tDE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae885837-880f-4065-b920-08d71fc004d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 07:29:47.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NN1bH6Ue19GWmjoqzYK6MSNIkGoE0emAtQ4q0AK2MrDpkwoWDufPHH78wall1Ii8hO9k6H988tLQ1mrR9oFL5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 5:44 PM, Greg KH wrote:=0A=
> On Mon, Aug 12, 2019 at 12:39:11PM +0300, Ioana Ciornei wrote:=0A=
>> Add the '\n' line terminator to the string formats missing it.=0A=
>>=0A=
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>=0A=
>> ---=0A=
>>   drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  2 +-=0A=
>>   drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 10 +++++-----=0A=
>>   2 files changed, 6 insertions(+), 6 deletions(-)=0A=
> =0A=
> Are you sure none of these patches should have a "Reported-by:" tag on=0A=
> them?  These were all done based on a review, so someone did that=0A=
> review...=0A=
> =0A=
> Please fix up the whole series and resend.=0A=
> =0A=
> thanks,=0A=
> =0A=
> greg k-h=0A=
> =0A=
=0A=
Sure, sorry for forgetting this. Will fix up.=0A=
=0A=
Ioana=0A=
