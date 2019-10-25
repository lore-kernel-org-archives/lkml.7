Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868ACCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5189F2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v0x5JvxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439252AbfJYKBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:01:42 -0400
Received: from mail-eopbgr720047.outbound.protection.outlook.com ([40.107.72.47]:20832
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733202AbfJYKBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:01:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUVZeMlrMP8HN7lw3rLA4wryym2gUvCQHZ/oKKFSLDGvrskgD1VHBkRbvbchR2qXHoTNB3uLEM44/sSyXYYSQJ6+F9MblsXqDGjiIbedx8am6lw8Yjr5Gc6hylN79hmCeVvTWxnt8IWBuMJuZ8UvNYU4mO5u9/YYpX4JbPzK+3AtDGbeHY7BYEte2NHLhzcFDoCrL+PBIw+O2VeeCowCIUcCVfT2YZ/1XHVQX02qptN68X0mXL/YRTDGo+RLY4honrtj8eSX9Iafg0QtBFokQHkmfiHYyeVn03dDwEPHGxdD3MCZND5p7KlgtlcSoqe4HnVHxwj77lLJLX6TWwGf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kIFRxDZooZmBxlM/uKCVXYKKVoAVftKCAlPo+frV+k=;
 b=ACR2hNPMdupPARKznLyy2ClpDjTiZClnfo8jUihFcaw9Rl+INQogNfeKSk4BFyysQ5pA1JRw9ohQ5/GhwwhfKpzlrtanmYYreNQopoAwTwP98zTz7NF6MqMJt3GYzjozwHHTXCGKx47Svxzwjc0BQCxG6HlkZToKDNBnrNVXGbt8rh2ouiuH0/KiOXjuv2VBmTrVppP/19bduVRynxmHw2qsgfCmQ/rfQKYidELm2BN6yk/uZx82FKGWyEHwnc5f70XdnS3XfZvQwhux4FZu0TqlQM9WRmVqfZ+hK+veka14h8fceIyU27G2A0XdKdr6k8r4hD0kPnO2WBmRwKEbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kIFRxDZooZmBxlM/uKCVXYKKVoAVftKCAlPo+frV+k=;
 b=v0x5JvxIEBIIUws7EQhQeC69d///bBhaALB5BMUtiQaXB5BH6p4Rz+UZUSoN+F0KTl8TwhqnjNAfXnoTc94lRSvyEiUcJdcS6QidFhwNAXgqcoLLBRt8Jzhj65Ep2AlrUoUGUj4B+so6Y32tnFUAdRAqn3JSLaPWZJe33IeYlp8=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB3433.namprd12.prod.outlook.com (20.178.198.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 10:01:37 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 10:01:37 +0000
From:   vishnu <vravulap@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] ASoC: amd: Enabling I2S instance in DMA and DAI
Thread-Topic: [PATCH 3/7] ASoC: amd: Enabling I2S instance in DMA and DAI
Thread-Index: AQHVhZzAolqgi4GOGECgGk2ZKsfX36dptGGAgAGexoD//9ZTgIAAAh2A
Date:   Fri, 25 Oct 2019 10:01:37 +0000
Message-ID: <b020e8fe-d5c1-3544-c2b4-79ff4af3f85e@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191024114015.GG5207@sirena.co.uk>
 <3aed0c75-80e7-cc9d-59f9-6ef29b665efc@amd.com>
 <20191025095537.GB4209@sirena.co.uk>
In-Reply-To: <20191025095537.GB4209@sirena.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::28) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 643451a5-8e62-4a07-8ae5-08d7593252f4
x-ms-traffictypediagnostic: DM6PR12MB3433:|DM6PR12MB3433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB343395E548C73C989EA3A510E7650@DM6PR12MB3433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(4744005)(6246003)(25786009)(486006)(305945005)(31696002)(36756003)(81156014)(6512007)(8936002)(7736002)(14454004)(4326008)(478600001)(6486002)(186003)(2906002)(256004)(66066001)(316002)(54906003)(6916009)(3846002)(31686004)(6436002)(6116002)(64756008)(2616005)(66476007)(66946007)(476003)(5660300002)(11346002)(66446008)(52116002)(76176011)(8676002)(81166006)(446003)(26005)(71200400001)(386003)(71190400001)(102836004)(6506007)(53546011)(99286004)(229853002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3433;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xaDkaE/fcGaBHJql/q02987q3VfmoPNXRBZ7nU3kIcW+Vhgq5d8oNKN/NpI1I5lzTvTNLgUVHPBuUiHJgx3GIsXJJNyPP8HKwpxSiPwC84xwaaOsqoYjIODPZYYVx961+yX/6dD8Mq41mRqa+2K7Vy/DVNYvxqh+rSN16w9J9BP2AmGUATTP7ulNgXjXrtzQP4+w4IFvm2hcmcRUOzpMRBWeULPvSz3ke66IPUxOL6Qm5ji/G+leWWJXfZnCNEd6kwloohHMShhagMr5cLI4whf/PyXpiA1M9jNdKXrpGRHAtIpewAw9nVm8lbw6kXehXQf9vslDVVLlsoGlUh9TVrg4YbTbOKuyWHJS43JhYTp6imsSfqA4HGoTaZKb71jam9ZpDQqVjgBFBW7yIoS3RX7P8Xr85PXgxbH9D4n+88+BFRWw7R0DZMdI05AYpHmL
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <7DE42B7A60651A40BADD3E1F2FAD9C97@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643451a5-8e62-4a07-8ae5-08d7593252f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 10:01:37.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: THG2jr1CpvOqTNeSUf8lB1KBVcrSPvB4IYDisWNj7foZtR4ChVZ5znL61I895phGUC39LXi4GIvaaK8Zq3gXOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/10/19 3:25 PM, Mark Brown wrote:
> On Fri, Oct 25, 2019 at 06:53:16AM +0000, vishnu wrote:
>> On 24/10/19 5:10 PM, Mark Brown wrote:
>>> On Sat, Oct 19, 2019 at 02:35:41AM +0530, Ravulapati Vishnu vardhan rao=
 wrote:
>=20
>>>> +		case I2S_BT_INSTANCE:
>>>> +			val =3D rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
>>>> +			val =3D val | (rtd->xfer_resolution  << 3);
>>>> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
>>>> +		break;
>=20
>>> For some reason the break; isn't indented with the rest of the block.
>>> I'm fairly sure I've mentioned this before...
>=20
>> Sorry for this but I am not able to find indentation.I have tested with
>> scripts/checkpatch.pl. It shows no warnings.
>=20
> The break should be aligned with the rest of the block like I said, an
> extra tab in - you can see lots of examples of break statements in the
> kernel.
>=20
Yes Got it.Thanks for your comments.I will create a separate patch for=20
fixing this issue.

Regards,
Vishnu
