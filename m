Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5756FA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7F20663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BOTULZab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405597AbfJQJdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:33:09 -0400
Received: from mail-eopbgr780087.outbound.protection.outlook.com ([40.107.78.87]:15539
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730379AbfJQJdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2EC0L4E3ucE0+lZR6CVZeinYlRHsMNLESOR6GPGZJTV+MRh8/e8+dpzqLdZFaj+NBeAiwWAfo0kF2XOpnWiyMNe74KzqWerbbu8NyOMLWfjHUqExSTC4jLMD/HwiII0pB0fUoTdkzPGDm8XsC+EyVTADQTWiEdmWUKzuw15PhSdR84nhTi+r4GEvPe27WPDLCF8Sk2AXBjiKnWSPeft0crdNQIZl+3TSAXVCZXYw/Gu32EODB2IY7ha5ToGu/IyGh9qtCRblA27/0A5rVSjt2eguZKQDuqnlWO0w6NuV/58M/NoGrEiZoAwZqM7dNl9I/Awe8GaSB0qFsxNVxPE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWow3HfrVKIDprZArFQqovx80ZCZB5a3BFHSA73eCn8=;
 b=MCS3UezBc1ck9IQnbgqY4qj+KXg5gg7DjIqCha2SDVw+F0GRVnBwKud0FtkHMs5UM+sUWpHfjRuyzUpN2kSLYIhr5+DcNtT18ZxLPHl7pfNQBLUf1HsFXMxhmNXAytGFWnGzmEsWjyfXCcc3960DE1beBwu8QOPunGOrXWwwmbiCgd7ZlxOcErEOG18j1Gi0PaU+Bbf4I8l06mZUyWamWsal8A4a16+vDmEjpfJPl/7Mk48+3x9tb5BgTKi0XPOkNo1f0JBTUx9hCSQTgpGSQs9l9zsu5yAovmLt6V545pSYDFDhwGXuMCf2EEx4kJ3UlbShcpYQONWEX6Kigv1nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWow3HfrVKIDprZArFQqovx80ZCZB5a3BFHSA73eCn8=;
 b=BOTULZabuTRLBR15oLPqCXPoXP7U3KsxEwPD5HpdLQBPXVlrShozQ83gQt5IsOflO4k/XRWppwpAqd4qkcObKfQB7HlyXLFtb6M+t//xR7mBtzXsgxQ2wux4V9eHx1LU1wqXKdxeGIxBWgN1q6uNS5hiFbgmrTrAVWpYwiCsuog=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB2889.namprd12.prod.outlook.com (20.179.71.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 09:33:06 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 09:33:06 +0000
From:   vishnu <vravulap@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Thread-Topic: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Thread-Index: AQHVd/NK02/86+8bwUqA0+UYmDRNb6dGCguAgAABq4CADmkpAIAK7WKA
Date:   Thu, 17 Oct 2019 09:33:06 +0000
Message-ID: <76668467-5edf-407a-a063-50f322fe785d@amd.com>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <BN6PR12MB18093C8EDE60811B3D917DEAF79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191001172941.GC4786@sirena.co.uk>
 <f9b1c3d5-6e02-354f-91b6-3b57e2f88bde@amd.com>
In-Reply-To: <f9b1c3d5-6e02-354f-91b6-3b57e2f88bde@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::20) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebdd151c-22e3-43c9-da08-08d752e50403
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB2889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB288917FDC6A7A2DABC1542C9E76D0@DM6PR12MB2889.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(6506007)(76176011)(66066001)(8676002)(14454004)(66556008)(66476007)(31686004)(66946007)(66446008)(64756008)(102836004)(81156014)(81166006)(25786009)(7736002)(386003)(53546011)(316002)(6636002)(305945005)(478600001)(99286004)(5660300002)(31696002)(36756003)(52116002)(71190400001)(71200400001)(186003)(2906002)(26005)(54906003)(110136005)(11346002)(486006)(446003)(6246003)(476003)(4326008)(2616005)(8936002)(229853002)(6486002)(6116002)(3846002)(6436002)(6512007)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2889;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Owyg3vey/bbRRPUuiE4r6gGsNDieu63N8gN+h5DW9+TTzQG9CsKln/ih9mwWXLGWnhlhuj1TEjp30cuFhE2LuqcC0zgGd/0dPYXYUtzOKRsb/lKe5yVSu7kb1/uqi7dqBpKFI2GSNhHjS1p/Vq5s7Ve8nqITOqBDAaSZ3N/woZJyvGEoaBwXVIWlO0G2c3ssJ3gh3Alrk81BwX+FV+1QQ8rzki63mgohTTwWjx+4nKxGMc7EZ87/8ZIiScObMDsZayIfUoGtkM9VDOftiwVAlOpTfatJGhlE1Ze6vVveDtMG3hXgDyRUoHTrI4d1jHlA5zjbE2aAM8aOuPl4szDqcX6oNEhNGUvtL5IHm4YCZfjsAk9qDb8NGcg2TGKrs8MIvd461PjMVNDsnUl9XWtV7RDzrDFR2NzOfJn6WysYTA=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C7CB0298D99CA54F859578B2C90D58F1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdd151c-22e3-43c9-da08-08d752e50403
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 09:33:06.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6L64v7ix7nt9h3njGjGJ/3ghJxcUv3MD1V5D4JVcSU4O0akqffgYeoU5VHWqdSYDcxmx5XshF+bTM0NBsaFZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/19 3:03 AM, vishnu wrote:
> Hi,
> Please find my inline comments.
>=20
> Thanks,
> Vishnu
>=20
> On 01/10/19 10:59 PM, Mark Brown wrote:
>> On Tue, Oct 01, 2019 at 05:23:43PM +0000, Deucher, Alexander wrote:
>>
>>>> ACP-PCI controller driver does not depends msi interrupts.
>>>> So removed msi related pci functions which have no use and does not=20
>>>> impact
>>>> on existing functionality.
>>
>>> In general, however, aren't MSIs preferred to legacy interrupts?
>>
>> As I understand it.=A0 Or at the very least I'm not aware of any situati=
on
>> where they're harmful.=A0 It'd be good to have a clear explanation of wh=
y
>> we're removing the support.
>=20
> Actually our device is audio device and it does not depends on MSI`s.
> So we thought to remove it as it has no purpose or meaning to have
> this code in our audio based ACP-PCI driver.
>=20
>>> Doesn't the driver have to opt into MSI support?=A0 As such, won't
>>> removing this code effectively disable MSI support?
>>
>> Yes.
>=20
>=20

Hi Mark,

Any updates on this patch.

Regards,
Vishnu
