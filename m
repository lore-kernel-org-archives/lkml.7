Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB15C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62D52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sGqVGdMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfHZTTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:19:23 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:26698
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727504AbfHZTTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4vnbF3LfC0Er1Cwg7P/WQxWrYgqI1oVhtHluiYdy1g4mYEY44k4VUIa6z7ZyPIQtsd3PhzUjN7xqll1GcSWKeXbAxRZRZ3ybi7kiWAbz+DrHWLs5WW53FEczgqwzLDzmV4plmvlteUIsLGAeh1cO4TsACrTXqeGAGOyKcr6CPfBNErek6i7wCepk52EI1XFRPL8Ca+Cjir7epFPWFNVShxtYpDwq0T/erdD9rrdeJxbX87VJ9B1S3+X3ZyLsEyOq8qkKmaJD7L9cTWactnfoLp5b8x1n0h+/OpGrHcHmCiBp0UsOTRY+9R8tJNOPm+FzXs0dlKAl94TFEAIH787Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRspqHGpkffkgwELhLGwHdRPcZk7T7UDa07SdIKaT7k=;
 b=SGPBbGO/n5Fdb9TqzGH9WK6Y2/dx9geZmZkwJkwmqCJbjd9uD95xLuQdQsMhq3O/laB2ZrOr5CmP5dUdiUJQ5hZXzdO1n4Kk3rcjqREsC9uEmrFEZFyHiWMlAKEEqEz8QsyhTEXD17NWsYL1J2h5kDzQZLZv6dx/Sc2csyBD3gteZBcAPaMbjLlS8Xyz0jbCWPu9dYBAxA1l7GtVV0O3ORnNVJRWpSr0XZqpF41bTb81lqffbQhmOWSgBet05srtR5PgjdVdyo0F3jApV8ulQYohdP8Q6Y/xBeD+FhzDq6yavMRgjNT+dqvZ4coGafCY6x+PtWsSQYzz8dUJwW0T6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRspqHGpkffkgwELhLGwHdRPcZk7T7UDa07SdIKaT7k=;
 b=sGqVGdMRxcnVmcqZTgCw9KK36VaP3l9qWhGTpVT+WV7rzcyU1NLjB9YltCQxEj449ngrplCYfJk4QNtdVpgTBfleD6lqL3bP5Jkpt7UO0iYnAzx1gf6CvWRQPn2fbBUOzAndxyBDpvRLb78mG4SrehpxUPmcIyy/FgwJxHsLGnA=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3983.eurprd04.prod.outlook.com (10.171.182.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 19:19:18 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 19:19:17 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>,
        Robert Chiras <robert.chiras@nxp.com>
CC:     =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/15] Improvements and fixes for mxsfb DRM driver
Thread-Topic: [PATCH v3 00/15] Improvements and fixes for mxsfb DRM driver
Thread-Index: AQHVWAl4KWfQYrgkMk+Db70gagBB/g==
Date:   Mon, 26 Aug 2019 19:19:17 +0000
Message-ID: <VI1PR04MB70233374E91F85119FD21FD5EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1566382555-12102-1-git-send-email-robert.chiras@nxp.com>
 <20190826120548.GA14316@bogon.m.sigxcpu.org>
 <3bd35686e046048d35cd4987567a13cf@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d0d5059-de07-4019-3e3b-08d72a5a4a67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3983;
x-ms-traffictypediagnostic: VI1PR04MB3983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB398315D6AA1CDEA1C549CBFEEEA10@VI1PR04MB3983.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(189003)(199004)(71190400001)(6436002)(6506007)(55016002)(71200400001)(66066001)(86362001)(186003)(81156014)(81166006)(9686003)(8676002)(5660300002)(6116002)(66556008)(66946007)(66446008)(76116006)(3846002)(8936002)(33656002)(64756008)(91956017)(7696005)(2906002)(76176011)(66476007)(486006)(6246003)(476003)(26005)(25786009)(7416002)(446003)(102836004)(110136005)(14454004)(99286004)(4326008)(229853002)(305945005)(52536014)(74316002)(54906003)(256004)(316002)(7736002)(6636002)(44832011)(53546011)(478600001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3983;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ch1vJqoVWK787E3WK3WIHLNokRfeIUs3naTk6FihbNJrRWegFVTKIk50RuJYtrvPwEBB56DUJp9xvG75mcmUs7Y1zrP39/qui808I9qwKKMDMRvCpNlhhSQnENETg/17+aipkq211vR8zoRIvKFYJZtVo2xVEv3r8v9eMWdcnHHRBY5hg/co1y/yTLxC5kOscOE8oElKPe006K8Y6mAQcnmtnAlMht82OQOHSThSpGDnDjwFs1SVWILJicLGmK4xH2dnQ3PV7LLeCvYRTvlvA5+ZavTock5mZ+3dVvTJA1PqrOXKKRT4WenTVLQsqTxfqix896PmQ6oFe2j257OJDdtbCOvEbZgNZ9gaq8S+8mBs07fs+kjQylqgQ10XUlFrt+kMAR+2QDK9FwUgbgdk/7W+Br2iG0MtbfOY+wzMqho=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0d5059-de07-4019-3e3b-08d72a5a4a67
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 19:19:17.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTdibkanzX+uGMNpOCROORN3vgeGTN/WE2CdgK6JgQT5iuFHCRu28ZfrgUORoJY07ETY506M4rPXmQF9/i009Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.2019 17:35, Stefan Agner wrote:=0A=
> On 2019-08-26 14:05, Guido G=FCnther wrote:=0A=
>> Hi,=0A=
>> On Wed, Aug 21, 2019 at 01:15:40PM +0300, Robert Chiras wrote:=0A=
>>> This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like 8MQ=
, 8MM=0A=
>>> and 8QXP). Following, are the new features added and fixes from this=0A=
>>> patch-set:=0A=
>>=0A=
>> I've applied this whole series on top of my NWL work and it looks good=
=0A=
>> with a DSI panel. Applying the whole series also fixes an issue where=0A=
>> after unblank the output was sometimes shifted about half a screen width=
=0A=
>> to the right (which didn't happen with DCSS). So at least from the parts=
=0A=
>> I could test:=0A=
>>=0A=
>>    Tested-by: Guido G=FCnther <agx@sigxcpu.org>=0A=
>>=0A=
>> for the whole thing.=0A=
> =0A=
> Thanks for testing! What SoC did you use? I think it would be good to=0A=
> also give this a try on i.MX 7 or i.MX 6ULL before merging.=0A=
=0A=
I did a quick test on imx6sx-sdb and it seems that [PATCH 07/15] =0A=
"drm/mxsfb: Fix the vblank events" causes a hang on boot, even without a =
=0A=
panel.=0A=
=0A=
If I revert that particular patch it seems to be fine: the new pixel =0A=
formats seem to work in modetest (checked with sii,43wvf1g panel).=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
