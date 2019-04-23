Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A8720811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fFm0kVE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfDWLMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:12:53 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:25478
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfDWLMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI8bzhVLhzl/vsuyv29RxAaCoFa3wFq/y32yjma+fkM=;
 b=fFm0kVE8c9Nb1YMoYMaHDNL4ZE4LiMSuXaYrjB95CO5hrMFTtS90HudXF1Vtem6RCa+JllD/oCTO0HpSases+LaaCYojgoiab43Cz3icgwXueIjnv0ueG0R2StpyE5U/M1R1c0g2vhZjjvmfZoXxjx9WY2HrkHwcGPMZkcj7ecU=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4564.eurprd04.prod.outlook.com (52.135.149.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Tue, 23 Apr 2019 11:12:49 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::a1d7:51b5:9893:dcee%2]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 11:12:49 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] scripts/gdb: Add $lx_clk_core_lookup function
Thread-Topic: [PATCH 3/3] scripts/gdb: Add $lx_clk_core_lookup function
Thread-Index: AQHU+OUmSMastDjNC0mx+PohUrHy2g==
Date:   Tue, 23 Apr 2019 11:12:49 +0000
Message-ID: <AM0PR04MB6434A133CB5ABA0286B0F487EE230@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <cover.1555921081.git.leonard.crestez@nxp.com>
 <ebda22b2d3f7e35db5809bf21f4f9ee3ac38f5d9.1555921081.git.leonard.crestez@nxp.com>
 <155596430227.15276.13435242792506854365@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0670d77-d2bd-4ce3-7f68-08d6c7dc9f39
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4564;
x-ms-traffictypediagnostic: AM0PR04MB4564:
x-microsoft-antispam-prvs: <AM0PR04MB45647B95FDD77AE1EF40F836EE230@AM0PR04MB4564.eurprd04.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(71200400001)(71190400001)(44832011)(186003)(6116002)(97736004)(6246003)(14454004)(6436002)(486006)(26005)(53936002)(4326008)(476003)(66476007)(446003)(3846002)(73956011)(66946007)(66556008)(66446008)(99286004)(64756008)(7736002)(305945005)(7696005)(74316002)(6916009)(76116006)(2906002)(91956017)(33656002)(229853002)(478600001)(54906003)(316002)(68736007)(66066001)(256004)(8936002)(81166006)(81156014)(8676002)(6506007)(53546011)(86362001)(55016002)(102836004)(52536014)(9686003)(76176011)(25786009)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4564;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FUmW5A8I81wCSASNpKh8V+rGJttFeaktPz9bQA+iqfUMG/ozyTqfva8D3GJ/qTXdI3IEtuYvBuJqRiIBnw1XIzqdHRHI4OFMujYz17ARE91l+8eZ2UeO3calauYnSWBgrGi1IxHHIvo5R6ZctEmf5q/g4fzScNOvs5VoDOEtMYRX7cmBMfBBN/SSAVTofYjtnsI3ZWbLmaR76TUTvziK7Wioz6e2JnZhhbBb7o+gHSrqvZeA52yM3u4P1LhFhJpl1W0LXKFRizyXHIkI9bBVbarj0vcSQSNCwaDZaFTrdX1E13QScfgnP/ophzzqrrOgbDqNub7UZat+ZwJsTRVwXmgMFm/bKkVVPUHpMFutBOye3IKdZwjb14JyZAivT0vazFmFLdZpB+Ds1ifp8HJBRqn73uUKg0o+w6hJNtbasU0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0670d77-d2bd-4ce3-7f68-08d6c7dc9f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 11:12:49.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/2019 11:18 PM, Stephen Boyd wrote:=0A=
> Quoting Leonard Crestez (2019-04-22 01:26:57)=0A=
>> diff --git a/scripts/gdb/linux/clk.py b/scripts/gdb/linux/clk.py=0A=
>> +class LxClkCoreLookup(gdb.Function):=0A=
>> +    """Find struct clk_core by name"""=0A=
>> +=0A=
>> +    def __init__(self):=0A=
>> +        super(LxClkCoreLookup, self).__init__("lx_clk_core_lookup")=0A=
>> +=0A=
>> +    def lookup_hlist(self, hlist_head, name):=0A=
>> +        for child in clk_core_for_each_child(hlist_head):=0A=
>> +            if child['name'].string() =3D=3D name:=0A=
> =0A=
> Do you need to do the .string() for comparison? Or does it work just as=
=0A=
> well to compare a gdb.Value object to a python string? It would be nice=
=0A=
> if the gdb.Value object could figure out that they're not both gdb.Value=
=0A=
> objects so it can do a string comparison itself.=0A=
=0A=
The gdb manual is not clear on how comparisons work on gdb.Value types. =0A=
Converting to a python string and comparing in python work well, using =0A=
=3D=3D on string gdb.Values results in this:=0A=
=0A=
     gdb.error: evaluation of this expression requires the program to =0A=
have a function "malloc"=0A=
=0A=
My guess is gdb attempts to convert both arguments to gdb.Value and do =0A=
the comparison via a call on the target? This is very undesirable here.=0A=
=0A=
I get the same error if "name" is a gdb.Value instead of being converted =
=0A=
to a string in invoke().=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
