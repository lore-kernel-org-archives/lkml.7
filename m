Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7779C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E82184B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HuJo8Da3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbfEWXJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 19:09:24 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:34438
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387705AbfEWXJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 19:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSpLH9TddFeBxsJrHSjBfJSeah4jTYTNmw3N/iOI7p0=;
 b=HuJo8Da3LuyU0t7/A0tU1AIYqvxfEJKtIvh5BgJWGBzXTXV707evy/JVTbADT7d6A8tq+2a5m6cJOAH24iztVC6Q/TNTeFaD/3kvgLebI2vLzPHgl/hnF2qGu2tiwouK1+N1/2pEgFw6AcIcFuRvCoI5jac3ZABm0mTJuiRpJuY=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB6689.eurprd04.prod.outlook.com (20.179.255.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Thu, 23 May 2019 23:09:19 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1922.016; Thu, 23 May 2019
 23:09:18 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Fabiano Rosas <farosas@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: Re: [PATCH] scripts/gdb: Fix invocation when CONFIG_COMMON_CLK is not
 set
Thread-Topic: [PATCH] scripts/gdb: Fix invocation when CONFIG_COMMON_CLK is
 not set
Thread-Index: AQHVEaEw3la++p0LyEyZRXi/xw4poQ==
Date:   Thu, 23 May 2019 23:09:18 +0000
Message-ID: <AM0PR04MB6434A12D2DCB42ECAA7EB1FAEE010@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190523195313.24701-1-farosas@linux.ibm.com>
 <5ce722ac.1c69fb81.b62d2.16d0@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf21954e-eeb7-42b1-acff-08d6dfd3af30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6689;
x-ms-traffictypediagnostic: AM0PR04MB6689:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB66892084A22BCDA66653F79DEE010@AM0PR04MB6689.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(25786009)(66556008)(66446008)(966005)(64756008)(110136005)(76176011)(446003)(4326008)(73956011)(71200400001)(71190400001)(91956017)(76116006)(6116002)(66946007)(33656002)(66476007)(478600001)(305945005)(3846002)(9686003)(53546011)(6306002)(7696005)(6436002)(55016002)(229853002)(14454004)(476003)(99286004)(53936002)(7736002)(68736007)(66066001)(486006)(186003)(6246003)(26005)(2906002)(256004)(81166006)(316002)(54906003)(44832011)(86362001)(8936002)(81156014)(52536014)(8676002)(5660300002)(6506007)(102836004)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6689;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dpt3Kg89G0PTVJb8yjw/11r3N0JKhr9/mFW0NRp8UfmIlY+A/dVYHv5uwOauPrwPIwea1rM43YvO3Vg0lt/hzy5hvJl82BH94TBWjePfjoJQNEkD2McB/EEUws16i/ItBeVLOPFnh33N7ZRWYbnhtE2v4p4aVoEe0zIifaqFscplyrS/rwogGXaatobL/4d3NtLezzCLMRuLzUzTZiWj7z3ea1RB4mIl6nsRvxhfWHAYaSl2v5+j33LW2HkN5Bn21bP7t3juFb0xli8Hyti9n/lNbA68UBIvLvKgD6RmTNjMAUby7eBMxoiS80Vbe8n/Z2ktPUjSSt7lU+SbBbG+y+SelYsBNXd1PG16wlBWaU3AEj4cw2thSpjP/ZjDNotGd/VSiAjmHeksCPD9goCiHDxm9H822wKlz3r2hlq7yb8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf21954e-eeb7-42b1-acff-08d6dfd3af30
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 23:09:18.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/2019 1:46 AM, Stephen Boyd wrote:=0A=
> Quoting Fabiano Rosas (2019-05-23 12:53:11)=0A=
>> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/const=
ants.py.in=0A=
>> index 1d73083da6cb..2efbec6b6b8d 100644=0A=
>> --- a/scripts/gdb/linux/constants.py.in=0A=
>> +++ b/scripts/gdb/linux/constants.py.in=0A=
>> @@ -40,7 +40,8 @@=0A=
>>   import gdb=0A=
>>   =0A=
>>   /* linux/clk-provider.h */=0A=
>> -LX_GDBPARSED(CLK_GET_RATE_NOCACHE)=0A=
>> +if IS_BUILTIN(CONFIG_COMMON_CLK):=0A=
>> +    LX_GDBPARSED(CLK_GET_RATE_NOCACHE)=0A=
>>   =0A=
> =0A=
> Why is this LX_GDBPARSED() instead of LX_VALUE()? From what I can tell=0A=
> it doesn't need to be runtime evaluated, just assigned to something that=
=0A=
> is macro expanded by CPP.=0A=
=0A=
Because CLK_GET_RATE_NOCACHE expands to BIT() which expands to a =0A=
constant with an UL suffix which python doesn't understand.=0A=
=0A=
Alternatively we could redefine the BIT macros inside constants.py.in =0A=
but using gdb features seemed better. We could even try to strip integer =
=0A=
literal suffixes with sed.=0A=
=0A=
Mentioned before: https://lkml.org/lkml/2019/5/3/341=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
