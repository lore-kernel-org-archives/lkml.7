Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368D1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6F0205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XkzWPC34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfLKJiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:38:21 -0500
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:13786
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727851AbfLKJiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:38:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUYYgIY+0his54nLgiEHrzAJ+2iZYMwrsUNgCysO/R8i8/8/3iJK1eAj+ofeXB26ogK4sSc1TfrZ1A3lxXWX3rNTxIcF4ovBDGCVF+3s+auHO762JAvSScZ5Qz7OeyDaNOCYjL5dkxRB882jXVIDuZpy2BGzMQMYVBpp9MGuZOZQ0ZKRtOVztE9hh5VT4BU0ORY98/eCQudyF98MAWOz8eHnVw+0umgZ2wcwKB8W1H1VH+lZHamyxZiKRPge3LM5wED9v7f/hHLP9+SBtDA/zyDQTv1AgLGvPcuvnrXuhU88vXErbE7vs6qrhqxixwLfKhvPqBBNO6MwcIQmcu5pBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJnAbYY3NBzgSR37R6v8xD9PjuwgO9sReQvcAnaZBRI=;
 b=FmFc/06iYtAJ9Pz4gWO8d18tCFn1qMSQqNHnSohcmoKxqU85cBLM0OFMdAOjxPd5q+8ltYwR7TtwgBnyMSw36GdVwrXeMdqJZyREAijOQYYMVt9yzwvnHBE9Ff8EMvCrVSut9LDL9v2GMHJPR35b2SKzKo8LRaFV4H4Qz98u1VLNTOtZjg7eVFBRUkczIF+fJ5fECbUPPtIPZdwi2Wo+rJg167yL1NgNitFw+ey+b/sQt+0b3OExgzTGzZTKAmxVbHi4phZKeFFCbVy7WSn+2l2+HdJXRvEcHBwH/4asYmQSw1JqhVotSTkqCzhseak2UmLb5Rh1Z0XWnNnZdE7juA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJnAbYY3NBzgSR37R6v8xD9PjuwgO9sReQvcAnaZBRI=;
 b=XkzWPC34+O/xfWADKcFiDjNBBPOqAYaYh/8kNa7Ghvur/VjQZDt8zpTpy4wdKIEsnPMsECX2CEDOInRg/t8poeQb5Y/ny35ur0I6ZunJgh94k6/ge11PEfIOaakERJ1mxcMnBUlKWCQYa4vbz9PujO/iTYHUCeQ6fJxgRVRQ9oQ=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 09:38:13 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2c49:44c8:2c02:68b1%5]) with mapi id 15.20.2538.016; Wed, 11 Dec 2019
 09:38:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
 regulator
Thread-Topic: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO
 regulator
Thread-Index: AQHVikhFuKo1SLIff0mMLrsG10nb5A==
Date:   Wed, 11 Dec 2019 09:38:13 +0000
Message-ID: <VI1PR04MB7023B082934A79C181DAE7DDEE5A0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1571906920-29966-1-git-send-email-Anson.Huang@nxp.com>
 <VI1PR04MB7023CD288FCC57806F067FD9EE5B0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916D3DB4C0CE0017FC2D4B1F55A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191211072721.ze6yn2felxyae5eb@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d8c2ccb-f361-4767-cdd7-08d77e1dd7fa
x-ms-traffictypediagnostic: VI1PR04MB5311:|VI1PR04MB5311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5311395B84B83573861883B7EE5A0@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(199004)(189003)(8676002)(110136005)(64756008)(66476007)(54906003)(66446008)(4326008)(4001150100001)(66946007)(6636002)(91956017)(76116006)(186003)(478600001)(71200400001)(316002)(66556008)(33656002)(7416002)(2906002)(44832011)(52536014)(6506007)(53546011)(26005)(86362001)(8936002)(55016002)(81156014)(5660300002)(81166006)(9686003)(7696005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5311;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWMqsRJI3zam74mh+vhm26F8dGvA6zMNo0EB/JBpd9Bw3tOMTZX6me14+pvokG9Iw602VUTYBZP00nLf5PfmXWNRJYbh0p8kV8IOpua2LFA5KU454WnLRAh1lBw8Li97TD8TjOeWAsYrUc6o8Aqhihf8QgUKhE/lvKodqilgXXbOHhpTki9xki7cPASnhPwPJLOzsIuepe17narlV3P5qC38DXGGXEPOKUd8kKNda9I0tnW9UhNL08vd6k8R1tmI6ldBuxuAIcOCxjIyzVlELn9YnFnuvIC9We0v5VIpXpLW1kPrSlHKJJxHpn4SADLvV9Nj+pSVtvFuHAFGhSs0enOoazkYrg+vAwNshxZuIlgwRONUZAEV1rF62MRZAukQk2H6rR7CQ1rOdmlkkmGQHXFkaKQxevxvIQ7Ji6BAHtMfBrQ4ol6ysWn1aDdRKeYMhauoLX32CXi6hQsFCvz8nu9+7CWJXfrF8UaUxZ8Qa0DzZDUiZad02fHuENWxbu6W
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8c2ccb-f361-4767-cdd7-08d77e1dd7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 09:38:13.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ux64KqaQ+ej0538RNyQz1pQivll94wLsdzA3NIyvK75WXP4+Ho3Q9dXcbfXrnj3QhvFA4o0TzSuRXJ3XUWA0sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-11 9:27 AM, Marco Felsch wrote:=0A=
> On 19-12-11 01:06, Anson Huang wrote:=0A=
>>> Subject: Re: [PATCH 1/3] ARM: dts: imx6ul-14x14-evk: Add sensors' GPIO=
=0A=
>>> regulator=0A=
>>>=0A=
>>> On 24.10.2019 11:51, Anson Huang wrote:=0A=
>>>> On i.MX6UL 14x14 EVK board, sensors' power are controlled by=0A=
>>>> GPIO5_IO02, add GPIO regulator for sensors to manage their power.=0A=
>>>>=0A=
>>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
>>>=0A=
>>> For me this breaks network boot on imx6ul evk, relevant log snippet is =
this:=0A=
>>>=0A=
>>>       fec 20b4000.ethernet eth0: Unable to connect to phy=0A=
>>>       IP-Config: Failed to open eth0=0A=
>>>=0A=
>>> Looking at schematics (SPF-28616_C2.pdf) I see that SNVS_TAMPER2 pin is=
=0A=
>>> connected to PERI_PWREN which controls VPERI_3V3 which is used across=
=0A=
>>> the board:=0A=
>>>    * Sensors (VSENSOR_3V3)=0A=
>>>    * Ethernet (VENET_3V3)=0A=
>>>    * Bluetooth=0A=
>>>    * CAN=0A=
>>>    * Arduino header=0A=
>>>    * Camera=0A=
>>>=0A=
>>> Maybe there are board revision differences? As far as I can tell this r=
egulator=0A=
>>> is not specific to sensors so it should be always on.=0A=
>>=0A=
>> You are correct, this regulator controls many other peripherals, I shoul=
d make it always ON for now=0A=
>> to make sure NOT break other peripheral, and after all other peripherals=
 controlled=0A=
>> by this regulator have added this regulator management, then the always =
ON can be=0A=
>> removed.=0A=
> =0A=
> IMHO marking the regulator as always on shouldn't be the fix. Is it to=0A=
> much work to add all required regulators? At least please add a comment=
=0A=
> which describes the need of the always-on property.=0A=
=0A=
I don't have the hardware to test all affected peripherals on hand and =0A=
no familiarity with stuff like CAN.=0A=
=0A=
Renaming reg_sensor and adding a comment makes sense.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
