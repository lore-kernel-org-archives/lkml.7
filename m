Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2644FC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B4A2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 14:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qG4Zlr5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfHPO5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:57:25 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:1604
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfHPO5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 10:57:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvNHNckUAx8gQgLt/hlNtsQhrcKLojwg71vI9JqMu6S+3+0Lrlxtz9I7JJQX0w4z4cB+8X42gQPJRZzNis9KVspn9G/r8KgpdQ5LiYgUtPaSLSheSqrzdQ3y5vAWOtAq43XbIRV3RExw/afLjX53ssbQkb70d5abKxsRszlTJQgn8fgye8RS5UDcmth5mVn71fJQAE1dSjTTV76dyhnI8LX2n4xR4DtNHUjwOHHITRE6/qwosigRIBOrFxn8cl8WfInxhYTO4Lcs83HsTVhYCujdNeZK7YhLMR5IQrLF6bpgDA82shvZCHS3SE9nBHQdsJS/u54ATs0XHHn+A5lB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRnwzMf9BlWEo+bcFEsO2EvzdgFefsU1L79qg1vIn2k=;
 b=NMKyIV49BI4dfdFaoyW0OfJl/Qo+qC5a/KEMQMAFhfEOEYW5OiEQ/UL7TS1DwsjgAmmKOdkT8NVr2Qx4tHMhc3uOCsj7DFIWY9cHQpzCYt7xRXk0sZUPXff0hyw3ZcL7UWWkUqNSmBWy+kSQuRjYjQNWAfjvbrrhdBvpK33AgLNxQDZa0IArOM0Soe5yHIXQfYnJv/XcMdNIeQAU/XTV0lhrhOvAsBUCaFtsBIPlJSA1eiZ8Ot1omFIMqvs2h5ucujLKT2zloW9wTuSaf+XfCHOK7ZTvIWs8Q1VKGmFk76EtRGqHLdpCP3/ZbLClVat3LkcaEWOOTFhU745M32WjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRnwzMf9BlWEo+bcFEsO2EvzdgFefsU1L79qg1vIn2k=;
 b=qG4Zlr5Vnvdc2B45AAKXFx/dbMkp+kSfRfizEecIxhTJs8Zurf8EMq7effEarJlN4HlFAk9Eqn6Ka9ROlDBMEcA5ddRkKNdzMiFw5YBAjW3Gc2hLX9pEXD4ynlyy/XtgAFI7Cu912dA/ZfJpNWeMZaF+JrpMEShZQo18CfJnIPs=
Received: from VE1PR04MB6463.eurprd04.prod.outlook.com (20.179.233.20) by
 VE1PR04MB6589.eurprd04.prod.outlook.com (20.179.234.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 16 Aug 2019 14:56:41 +0000
Received: from VE1PR04MB6463.eurprd04.prod.outlook.com
 ([fe80::8fc:e04c:fbb6:4f1f]) by VE1PR04MB6463.eurprd04.prod.outlook.com
 ([fe80::8fc:e04c:fbb6:4f1f%7]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 14:56:41 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] soc: fsl: FSL_MC_DPIO selects directly FSL_GUTS
Thread-Topic: [PATCH 3/3] soc: fsl: FSL_MC_DPIO selects directly FSL_GUTS
Thread-Index: AQHVMa+L6jLIgK/rPECnX4ICjDsk6Q==
Date:   Fri, 16 Aug 2019 14:56:41 +0000
Message-ID: <VE1PR04MB64636237CB3B1B2A93E0507786AF0@VE1PR04MB6463.eurprd04.prod.outlook.com>
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com>
 <1562165800-30721-4-git-send-email-ioana.ciornei@nxp.com>
 <CADRPPNT9LGdMWuBcBnvWXhD8Q-qbTNOzbYp1dRrt0NXb2DBgDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df5c9a7d-ea99-4ac6-e9c0-08d72259f2bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6589;
x-ms-traffictypediagnostic: VE1PR04MB6589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6589E25BF22B3CF5C4D1609986AF0@VE1PR04MB6589.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(66476007)(52536014)(66066001)(486006)(5660300002)(446003)(81166006)(91956017)(478600001)(186003)(44832011)(229853002)(71200400001)(26005)(316002)(476003)(6636002)(6436002)(71190400001)(66556008)(305945005)(76116006)(81156014)(6506007)(74316002)(66946007)(7696005)(33656002)(76176011)(8936002)(14454004)(8676002)(102836004)(64756008)(54906003)(86362001)(2906002)(4326008)(25786009)(3846002)(110136005)(14444005)(6116002)(7736002)(9686003)(66446008)(53936002)(6246003)(256004)(55016002)(99286004)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6589;H:VE1PR04MB6463.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I4EkBKSkaLj6paXk9JlXAEHL5Mt/AG3WDte2V4EFgwIaUK7fvQ3jROkFqo10YHQ15j8XRZr1/eOBvGG7gFoiKS9nk0IdiDH0bI0fiN7kfeILFPMMxGvvW1zcTnjdnU9WO/l6fFXZPQwuAKbxlwL2PAGJcJwBHFnMaUlQH9XHiRbAumZOaZ577TLBKzTwbLL3VcpIs9+ypmUOMc5xRA5M9Qnm32a/HMhz3j8Fb2nU39X3/TkjXeDeqdCiIo2at89Itc1lc5jYA8PU6FFiWpKqtv48/8WELVRQc4cih/RgBjH2ueX6bYqw0mm506hH6HizcVECplhkGpV0i1fRcgqVHVU+QoBQkneDbJtkrfCPRR7ZM12ZZzZBDLs6R0M55di6jLGumpWZA+5IEogxTq9U1ZjHa+CtXYSPAkYT6be73iM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5c9a7d-ea99-4ac6-e9c0-08d72259f2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 14:56:41.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXdrbc/1eludVsrG4vs1BmmvA4ORnTE1M5T9bmZ4/YPU9a3zkoDqMyLn85XbF5NwZtUR41XfDvfSbSZJkBdUsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/2019 7:09 PM, Li Yang wrote:=0A=
> On Wed, Jul 3, 2019 at 9:58 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrot=
e:=0A=
>> Make FSL_MC_DPIO select directly FSL_GUTS. Without this change we could=
=0A=
>> be in a situation where both FSL_MC_DPIO and SOC_BUS are enabled but=0A=
>> FSL_GUTS is not.=0A=
>>=0A=
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>=0A=
>> ---=0A=
>>  drivers/soc/fsl/Kconfig | 2 +-=0A=
>>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig=0A=
>> index b6804c04e96f..7e62c1d0aee7 100644=0A=
>> --- a/drivers/soc/fsl/Kconfig=0A=
>> +++ b/drivers/soc/fsl/Kconfig=0A=
>> @@ -22,7 +22,7 @@ config FSL_GUTS=0A=
>>  config FSL_MC_DPIO=0A=
>>          tristate "QorIQ DPAA2 DPIO driver"=0A=
>>          depends on FSL_MC_BUS=0A=
>> -        select SOC_BUS=0A=
>> +        select FSL_GUTS=0A=
> NACK.  Although DPIO only exists on SoCs with the GUTS block for now.=0A=
> There is no direct dependency between the two IPs.  I don't think we=0A=
There isn't a hardware dependency but the DPIO driver does call=0A=
soc_device_match().  If FSL_GUTS isn't present we can't distinguish=0A=
which SoC is being used and the driver isn't able to setup the correct=0A=
stashing destinations.  Is there another mechanism we should be using to=0A=
get this information?=0A=
> should add this dependency to make FSL_GUTS not configurable.  Here is=0A=
> some explaination from kernel documentation:=0A=
>=0A=
>         select should be used with care. select will force=0A=
>         a symbol to a value without visiting the dependencies.=0A=
>         By abusing select you are able to select a symbol FOO even=0A=
>         if FOO depends on BAR that is not set.=0A=
>         In general use select only for non-visible symbols=0A=
>         (no prompts anywhere) and for symbols with no dependencies.=0A=
>         That will limit the usefulness but on the other hand avoid=0A=
>         the illegal configurations all over.=0A=
>=0A=
> We probably shouldn't let it select SOC_BUS either from the beginning,=0A=
> as the basic feature of DPIO should still work without defining=0A=
> SOC_BUS.=0A=
>=0A=
> Regards,=0A=
> Leo=0A=
>=0A=
>>          help=0A=
>>           Driver for the DPAA2 DPIO object.  A DPIO provides queue and=
=0A=
>>           buffer management facilities for software to interact with=0A=
>> --=0A=
>> 1.9.1=0A=
>>=0A=
=0A=
