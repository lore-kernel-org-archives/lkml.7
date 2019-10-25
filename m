Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9534BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A68320867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r4BRloUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393906AbfJYG5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:57:36 -0400
Received: from mail-eopbgr780043.outbound.protection.outlook.com ([40.107.78.43]:55992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733098AbfJYG5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:57:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReRXJu9EO2oFDi5WROqFgoar+TDuEsQUVt9atqt/5DjrVD6n4nbEjn1UgaHjIDnB7sLp5QALpLJqGafNWegRyty55TGlmimKuFxZ1i7ATS+bN0sAbWNWmDSW+PRDQG+zvsS5ah8lzO/FbMawIMh7p6sv2JjYP8b0VEHYokgEyTBcWnb+cmQTst2/ftQIBQJCeqte6TRz88sikoUj26/5067QUNImua5FOF/6CW3sDjqHhDeOZ2zAwfuOJ4D3KOBM0Nxvl6Ipb8zNZKhvJ9z2JdlRbuykiq4UuBcS0hBTNtI0ZZlWag4ckvCUw0eGxtsfl/L4GJWn8kmuAFTh4O5EjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5snZJWHFfExi0pPZMuK1GCHu6OQAH7Cnc69XGuqspU=;
 b=X6Z3lkclmqpS1HiO0hj2t/TSSa5ear+UlUemrBBdenztZutRaK/IVPSgjiFZrVj0anXx3kT0Bg0gkKsriPZh1sk2vgybgiO1Pfg/qlhMkZl8DIbnQKxAYjBiFtkBuo+3ba0hgtoJJwhVPLdvNAaU8KjhRd/uZMTHb3vB7ie4xwyNNB9adcZ5Q+GtKDEacIUefYPzsfuhoFgl1eyeARymjFMBV1gyCXk8eoOHvzpWmNePCCvaD0cxayvVQ0QtdJILvk4ERH+E+sZloFTVES4DKJg2cKORVDLac6dsvjnCWK40y0xg2jS2RfhAwqU868+R3T4QAsT9yRopwoRg+7sEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5snZJWHFfExi0pPZMuK1GCHu6OQAH7Cnc69XGuqspU=;
 b=r4BRloUEtYquI02ZXd0c81lYMzJwvmujsRHSRdQ0tpnVld7pNRMXvPqJkKAn+CgjX6tK+Cbvf5HsAocO9xbu8jxUsdnuhoNXxbQVw5Nv3dLaKWFlUOXg7RGtUTPVVXDZ7oUpuIaAEGFdCqyuaNPXB5eMxe0oLE9ryxDSuNAZw1A=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB3084.namprd12.prod.outlook.com (20.178.30.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 06:57:32 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 06:57:32 +0000
From:   vishnu <vravulap@amd.com>
To:     Mark Brown <broonie@kernel.org>,
        "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
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
Thread-Index: AQHVhZzAolqgi4GOGECgGk2ZKsfX36dptGGAgAFDxQA=
Date:   Fri, 25 Oct 2019 06:57:32 +0000
Message-ID: <151a9040-2839-9368-3b18-64e3462750c7@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191024114015.GG5207@sirena.co.uk>
In-Reply-To: <20191024114015.GG5207@sirena.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86cd48eb-0fef-4989-2906-08d759189bb5
x-ms-traffictypediagnostic: DM6PR12MB3084:|DM6PR12MB3084:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB308499EBE6845A27E6B1E314E7650@DM6PR12MB3084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(66446008)(486006)(66476007)(305945005)(476003)(66556008)(64756008)(446003)(36756003)(2616005)(6486002)(31686004)(6512007)(71190400001)(71200400001)(66946007)(6436002)(2906002)(4326008)(5660300002)(25786009)(478600001)(6116002)(3846002)(66066001)(6246003)(11346002)(14454004)(54906003)(256004)(99286004)(6636002)(110136005)(229853002)(186003)(102836004)(26005)(386003)(76176011)(31696002)(52116002)(53546011)(8676002)(6506007)(8936002)(316002)(81156014)(81166006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3084;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmLEge9cgATayuOeIfhSuEq8kbhtdTycZYRteSM0PHd7txt0Ca/01Kl/oBjxPenCvfnqFNFuKgAM6cngVFXLw95c5QUgpDToNCeBMZHCYxmqVhqUJ7NqOH6pvEZSI/HvyNhema7lDh6Oe1Zv/oisBefKbhbSkmEiXqEn0PpgZGhauagf2umza6CWshKD9DbSA2dT1bgsjArBy+AmOr3rVioEaXkjal4aOW6QOHlJxDEjliLY9PJ7Bo/l42x4WkbRJPYCKb3hq7dR2xS3mFSUBOKHMSdlps9o/bITJTKfpH53wDmAd5wa93ogOGqo8EvHeu7IvP68sF24xhie/4kGUxlt4xIkS/qMazwP8lhVua3k61qAST2vY6QvUiZjf8XZxbDQrl644/iIVDaz11m/BAhglKEtFydixc6mjgTiycAq9ex0LrL4CRdPxBPfpPbZ
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D2D1B0D55694634C904761B3C5E10B58@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cd48eb-0fef-4989-2906-08d759189bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 06:57:32.4301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIuUoDpCDGa71iWq5YHInmuW84nO9cMY/sKFWjYEtpHrpiNlbyd/iJg4Tqa8lrLF3UOX/8P3c6f4YJGN3ralnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,


On 24/10/19 5:10 PM, Mark Brown wrote:
> On Sat, Oct 19, 2019 at 02:35:41AM +0530, Ravulapati Vishnu vardhan rao w=
rote:
>=20
>> +		case I2S_BT_INSTANCE:
>> +			val =3D rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
>> +			val =3D val | (rtd->xfer_resolution  << 3);
>> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
>> +		break;
>=20
> For some reason the break; isn't indented with the rest of the block.
> I'm fairly sure I've mentioned this before...
>=20

Sorry for this but I am not able to find indentation.I have tested with
scripts/checkpatch.pl. It shows no warnings.

>> +		case I2S_SP_INSTANCE:
>> +		default:
>> +			val =3D rv_readl(rtd->acp3x_base + mmACP_I2STDM_ITER);
>> +			val =3D val | (rtd->xfer_resolution  << 3);
>> +			rv_writel(val, rtd->acp3x_base + mmACP_I2STDM_ITER);
>> +		}
>=20
> Missing break; here - again it's normal kernel coding style to include
> it.
>=20

As it is default and last case I thought that break is not required.
I will create a separate patch for rectifying this.Thank you.

>> +	struct snd_soc_pcm_runtime *prtd =3D substream->private_data;
>> +	struct snd_soc_card *card =3D prtd->card;
>> +	struct acp3x_platform_info *pinfo =3D snd_soc_card_get_drvdata(card);
>> +
>> +	if (pinfo) {
>> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
>> +			rtd->i2s_instance =3D pinfo->play_i2s_instance;
>> +		else
>> +			rtd->i2s_instance =3D pinfo->cap_i2s_instance;
>> +	}
>=20
> Looks like you need an error handling case here if pinfo is missing,
> i2s_instance needs to be set.  There are default cases but it's not
> clear that that's a good idea, the intent of the code is clearly that
> there's always platform data.
>=20


Thank you,
Vishnu
