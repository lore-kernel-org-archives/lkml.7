Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2DFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E3D20867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KV11r/lN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405686AbfJYGxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:53:32 -0400
Received: from mail-eopbgr780047.outbound.protection.outlook.com ([40.107.78.47]:33915
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393177AbfJYGxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:53:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcCUfSG9yHb180xM5kimbpkljq02z3kFtBgC957FR7to0HIZaHCS+ExSbEBUkf1joV9eWreKT366una/jx2Ae0NV1ngEjXJFvOAabPwdFT0NkeTWJHcT7KcYRAvKoiAEFH0yXGntklLQAQFhW9okXHrP1nQRSAbHGqGx97YS0rw2KetR63S62Zi+yObiAK5/Ttzy9/lu6x52VE/xnQrO59cvU754hWj2Xlh/sGLMH83fqN11BURSleVIiRDqzbdjyO1A3CY+fYaYCl8cn3EuFzO8sntm51NCBlfuITMEy8ExAtguzzyq2ZgBatqxwEyltrBbREQtRHzx9YrSo6aoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exd7Dfy1jMmglV5ISmvQmsGPPtMADuyx39KN+il5z2Q=;
 b=FBcj7UPtick9V2gDB1g3uGQpxzhydK+a00HffykD2lfLwhI956sIPCUAuDJU0ILtkKX8BTIC0Nb1JRFa7+cntYknxqgWQdPbNej4LJCUihHsNwSHiAjubCStQd4yUnM2vBO8mH+OqysmPFKfaa+pDDu7f8nXkj3rT5UQ7aIv5aouM+c7RzJOrrARAm3SL9A/c89gCbi6m5ChIezGW+y6vC81TTPcLtwO2RKUotSe5qUFprW+ha9MKFmW2un3kO/FmysNIsqG2g81Cpdduac9Z9mv4L5izUT/gcVGMe6fXL+SNyWOaxL03MwkTiDf97r7NBDlbEI5pq9QOe+TYSYZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exd7Dfy1jMmglV5ISmvQmsGPPtMADuyx39KN+il5z2Q=;
 b=KV11r/lNed+GSkMMNBE9ycMg4yIEbR4MHGL6TWZkBxhNwQ5wRwM4q6cG7NDBGmPs1+H/Q0h9LhVN4trpavkiIKQcesDGjkHIOk4egGO4UvojEbjjCtzfUmCn0iT8aPqwccYiFKdbqr3dy6WqdxYpT6iGhqF7pXjxW8asW9xEZxA=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB3548.namprd12.prod.outlook.com (20.179.106.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Fri, 25 Oct 2019 06:53:16 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 06:53:16 +0000
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
Thread-Index: AQHVhZzAolqgi4GOGECgGk2ZKsfX36dptGGAgAFCkoA=
Date:   Fri, 25 Oct 2019 06:53:16 +0000
Message-ID: <3aed0c75-80e7-cc9d-59f9-6ef29b665efc@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191024114015.GG5207@sirena.co.uk>
In-Reply-To: <20191024114015.GG5207@sirena.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d046e26f-bbd3-4c27-1541-08d7591802dd
x-ms-traffictypediagnostic: DM6PR12MB3548:|DM6PR12MB3548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3548ED02084958C53BA3C973E7650@DM6PR12MB3548.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(14454004)(71200400001)(99286004)(446003)(486006)(8676002)(81166006)(7736002)(8936002)(54906003)(6116002)(81156014)(2616005)(256004)(3846002)(31696002)(476003)(5660300002)(66476007)(64756008)(66556008)(11346002)(66946007)(229853002)(110136005)(6636002)(6512007)(6486002)(6246003)(6436002)(71190400001)(305945005)(53546011)(6506007)(66446008)(186003)(478600001)(386003)(76176011)(31686004)(4326008)(36756003)(26005)(102836004)(25786009)(2906002)(66066001)(316002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3548;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6w53aMNZmCbJm9sfwZWjw777vTLBROWNjOmHeeZOlqgLUFtybuOY7BUqb8atrWz3STUmdBfhBju4Ozynlmc+KHSZtxp8DgObP4ukrgfjlgJcWX/OOjWJL+WkcJLjbOCXlm1IDmZ5PPNND4iopTNJqHUUyVRyNw7wAjA7ymXx2D+xaFa+hmjRlXSQtPzIwyKJ0dfEy78AED1AXJy6bDhWVV0RRoY2BidHnmPkHvZ0DHQRjB3r5sV2XDN84R5tigiqA0g0H736vbgbAsOFGt5Cs/dcsrylsmo2sn/x/3p98QYpeE8K6OzQkB5770rZ7XaIAHh3y9fSag5CxQ525d52p9/DYY9u1AT0r6gJAGhQ+ejc9NrWfDE7pBXGHJhjlp0geaCaJOo2AOFx9WHpZoXbJWmK1VIE3/3uLuIu/j+2vGv1bcdtoWDi//PwAYYUi69
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <428DBF21486B6E489742864E5A1D9524@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d046e26f-bbd3-4c27-1541-08d7591802dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 06:53:16.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAHwRvm9PPZXl479KDGgSpiNCyV92OPRlnoHNGvEx5wICTgwAacX30xDXQ4wjpsiVaoJXX/uPyvrcnc4D7Zleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

My inline responses.

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
Sorry for this but I am not able to find indentation.I have tested with=20
scripts/checkpatch.pl. It shows no warnings.
>=20
>> +		case I2S_SP_INSTANCE:
>> +		default:
>> +			val =3D rv_readl(rtd->acp3x_base + mmACP_I2STDM_ITER);
>> +			val =3D val | (rtd->xfer_resolution  << 3);
>> +			rv_writel(val, rtd->acp3x_base + mmACP_I2STDM_ITER);
>> +		}
>=20
> Missing break; here - again it's normal kernel coding style to include
> it.I will create a separate patch for rectifying this.Thank you.
>=20
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
Yes my intention is It should always have platformdata.

