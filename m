Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169AC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FB021883
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LUWTIJET";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U7fZgebu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfERAnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 20:43:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32197 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfERAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 20:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558140229; x=1589676229;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=voHz8DzEEwVrjaFA9dwAyHiVwW12ssUslC5tou6+wkw=;
  b=LUWTIJETuocjdjhgpr2XOxDXMmV9g7vJTyebzW6cuUfIqeF5+T3UyG6r
   YLcXUQmcfQ2s44ipXvkeCjM9UTv+MZvW1DclzHKjO/ByjQLqSofMowBQf
   Ziedec/hX/ejDgHrOWPu6T//mZD82bX3c1LrD8I22FxfsQAXfugT4RX+J
   7uZ3/Vkt5Vo5kqMW985Gsal1RixQcMbZ+pExyyoVa66abCbFAOvze42Fx
   xlWPy7dtl+zdPpVNK6FQRMcwNzvqXCV3cfWS76bnq9kAJqOfXougQHbAT
   zKVQZTnwPJ02iOwX2I/l1HKP/sFbm8zPRUyXJV23rcNz4uwGlKwAeKxj1
   A==;
X-IronPort-AV: E=Sophos;i="5.60,482,1549900800"; 
   d="scan'208";a="108555838"
Received: from mail-by2nam05lp2052.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.52])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 08:43:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4wBf4N4iesUuFoOWaMlrTWJuA7Sh/IWj6qnvWKsVBc=;
 b=U7fZgebutcCbt5TUdMb9GybHPIPlqzA27Avz+58X3/5O7QQUJMhjVit9al3oV8a+K4z8+w5V2omf5bCGsDxNSDODj1KoASXgdJaEJgwulE+iQ+XADN9+dcjj2XIdLW2b7aD6al8RUqCR3g3kD3bFtIVldjtH3BJ9pkoytIWhtqY=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3918.namprd04.prod.outlook.com (52.135.81.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Sat, 18 May 2019 00:43:47 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::b163:e740:af6e:2602]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::b163:e740:af6e:2602%6]) with mapi id 15.20.1900.010; Sat, 18 May 2019
 00:43:47 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "xiaolinkui <xiaolinkui@kylinos.cn> Jens Axboe" <axboe@kernel.dk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: bio: use struct_size() in kmalloc()
Thread-Topic: [PATCH] block: bio: use struct_size() in kmalloc()
Thread-Index: AQHVDJFi2AQuSKSW70u18m79g25Ygg==
Date:   Sat, 18 May 2019 00:43:46 +0000
Message-ID: <SN6PR04MB45270B6B0A4EDE903568A29E86040@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
 <e46a73e2-b04d-371b-f199-e789dbdbd9fc@kernel.dk>
 <d83390a9-33be-3d76-3e23-b97f0a05b72f@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:c053:5ca8:ccaf:faa6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b8e1a1-80f2-44a1-43d4-08d6db29e342
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3918;
x-ms-traffictypediagnostic: SN6PR04MB3918:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3918891827D1089D3690DC5386040@SN6PR04MB3918.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0041D46242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39860400002)(376002)(199004)(189003)(6246003)(53546011)(256004)(99286004)(25786009)(14444005)(6506007)(8936002)(76176011)(4326008)(6116002)(33656002)(14454004)(2906002)(478600001)(72206003)(66446008)(66946007)(91956017)(73956011)(186003)(74316002)(66476007)(66556008)(64756008)(71190400001)(71200400001)(76116006)(476003)(7696005)(446003)(6436002)(68736007)(53936002)(9686003)(316002)(86362001)(8676002)(305945005)(486006)(81166006)(81156014)(7736002)(229853002)(46003)(55016002)(52536014)(102836004)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3918;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GnJzNmxNAWW0khy9v2pXbcjTD5nh+0RbGik5t4++e/kcNQ+yIDMQf8aGxHi0zBBU0K2fsrUJNk5n0jz6fg/sVvARyZUr/b0JxdBN2ppAGBEPLQ2erwAiZ43l+uX8IM0TfLl5+7SzNWPqEqZ27YQUDATRM7MBRv+6kKdFbh+9KzXGR9fOlifNrzgt518+L44uLRo/VDFqV5nREkITbOj43a2K8QGrbjjm1sZ4IdYYIuwzAbF/C2S/VG5QNvubNzWentia19aFncugzavXJSM9fYrO/1U4x5UH8FObPDXZDmZS8l+c0y0gsli454JbDfGhsVXP5uSXrH7wLSdKPBDJFEQTP+7t2FaLRuJ4VPwz6gH99+TGedYGwq4tQxz854B12YX65OKa+m3ub89mQKv9sUpopHAh0Kerq1A9wGkAXrQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b8e1a1-80f2-44a1-43d4-08d6db29e342
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2019 00:43:47.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3918
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- linux-block@vger.kernel.org <linux-block@vger.kernel.org> to reduce=0A=
the noise.=0A=
=0A=
I apologies Jens, I didn't apply and tested these patches before=0A=
submitting the=0A=
review and assumed that patches are compiled and tested, I'll do so for eac=
h=0A=
patch before submitting the review.=0A=
=0A=
Xiaolinkui,=0A=
=0A=
Please send compiled and tested patch only on the latest kernel on the=0A=
appropriate subsystem, otherwise mark the patch appropriately=0A=
[RFC/Compile only] so reviewer would know without such a tag=0A=
it is easy to assume that patch is compiled and tested.=0A=
=0A=
You have also sent out the couple of more patches with this fix.=0A=
=0A=
If they are not compiled and tested with right kernel branch for each=0A=
subsystem, please update the appropriate mail thread either to ignore those=
=0A=
patches (if they have compilation problem on appropriate branch) or mark=0A=
them compile test only (this needs to be avoided for these patches), in=0A=
either=0A=
case please send updated patches for this fix if needed.=0A=
=0A=
Thanks.=0A=
=0A=
On 5/17/19 3:59 PM, Jens Axboe wrote:=0A=
> On 5/17/19 3:17 PM, Jens Axboe wrote:=0A=
>> On 5/17/19 3:12 AM, xiaolinkui wrote:=0A=
>>> One of the more common cases of allocation size calculations is finding=
=0A=
>>> the size of a structure that has a zero-sized array at the end, along=
=0A=
>>> with memory for some number of elements for that array. For example:=0A=
>>>=0A=
>>> struct foo {=0A=
>>>     int stuff;=0A=
>>>     struct boo entry[];=0A=
>>> };=0A=
>>>=0A=
>>> instance =3D kmalloc(sizeof(struct foo) + count * sizeof(struct boo), G=
FP_KERNEL);=0A=
>>>=0A=
>>> Instead of leaving these open-coded and prone to type mistakes, we can=
=0A=
>>> now use the new struct_size() helper:=0A=
>>>=0A=
>>> instance =3D kmalloc(struct_size(instance, entry, count), GFP_KERNEL);=
=0A=
>> Applied, thanks.=0A=
> I take that back, you obviously didn't even compile this patch. Never=0A=
> send untested crap, without explicitly saying so.=0A=
>=0A=
=0A=
