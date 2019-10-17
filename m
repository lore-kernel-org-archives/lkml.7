Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F097CFA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8920869
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cBp8zqu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408448AbfJQJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:26:50 -0400
Received: from mail-eopbgr690078.outbound.protection.outlook.com ([40.107.69.78]:59960
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732676AbfJQJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:26:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKAdGZFjXSKevQNzr+M1PycqcVPXYWjyxV0hr3I4PnFwfjNmfqHDl/96pmR2fFHeOPBtHV/oF40FLbzWSKF3G193BQMsbAGbYTNFd1nnsThwSk0ZX58RvxCz4vSBFCbxcxOXCTeR3vGf6zUx6pj0K6J1al8uDcFBKzzg3bM0vG95uyGdmUJwd7KpjObZjQRC5Rq1z5+wGtGdwX2cxozCXgRGNaZcehFKxLPr15VOr7ts4jh5bd2XC8awrih2KJvbfp3iiqVPpbM95mnQBHRYJIyAGqX+pxrItpHa2T9KlG3qWkw1K6GDTWHB4dxdg9FdVdhYeqwHXJlSegoZSLHIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebgojj5lmzkjXyBQkywOKrjP11zL1M6jDKVkZzVDaIo=;
 b=CwmD/7bJPqGr1vofl7eFS9NseVJPhzWNh/i/qbLY4IDKubr4xmSMpZtuWzkLglbYBf4VafGQWcwgm5K63/Dthy2gj8Ck9eLZZysqNR51j9+krlhUlKAT2Mp8jCMYmgM5b832Oq1fUeKoYCJVRkQO//JcVk6MsugIiW2/a1bVWQmAnBvFNCTUHf0e/u0BE0zIRctQrWhNYWyUsTsaioL0lgF1fY/+NYLPZUhx8WPa2QPvXYMhDpIaURxmUmAmsBzGCqcIGjKhJvHoO/wOz/ufHdKAJU9u7umypm84BnSI1c7Q0vHFH5x6N8+aegGfpmZLHRocWUufdP344tWMSNZUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebgojj5lmzkjXyBQkywOKrjP11zL1M6jDKVkZzVDaIo=;
 b=cBp8zqu1NfRTPQEH2yVJ5QKZOA8Gdr8dxxXGbSqKAkAzkJMJDZNaM0V/okELnczvIWLQcHrrMHQaz/zK+wktjMFX7hRIc3dVnovmHXHmuP5kVjcGhiCTLlQG7CnOH94tFSzmR06kowqzsxAjYcLS3X3elQGo7a7MWK6ByD7erPs=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB3033.namprd12.prod.outlook.com (20.178.30.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 09:26:40 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 09:26:39 +0000
From:   vishnu <vravulap@amd.com>
To:     Lee Jones <lee.jones@linaro.org>,
        "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
 framework
Thread-Topic: [PATCH 2/7] ASoC: amd: Registering device endpoints using MFD
 framework
Thread-Index: AQHVd5gysBGn4q83rEe097OrmwWXeadFWHuAgADs8gD//2r6AIAAc1YAgAEphICAAAlmgIAABseAgAyKavCABePhAIAFlW4A
Date:   Thu, 17 Oct 2019 09:26:39 +0000
Message-ID: <ca3d7434-e15e-b701-8a42-3d9eadacf227@amd.com>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569891524-18875-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191001064539.GB11769@dell> <2ff13a61-a346-4d49-ab3a-da5d2126727c@amd.com>
 <20191001120020.GC11769@dell>
 <BN6PR12MB180930BD7D03FD7DEB14D7C1F79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191002123759.GD11769@dell>
 <BN6PR12MB1809451A3152488F3D8D1371F79C0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191002133553.GA21172@dell>
 <DM6PR12MB3868561CDEEF9D21940E8F57E7940@DM6PR12MB3868.namprd12.prod.outlook.com>
 <20191014070318.GC4545@dell>
In-Reply-To: <20191014070318.GC4545@dell>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR0101CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::17) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88c61541-ce33-4d31-e558-08d752e41d67
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM6PR12MB3033:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3033FF3DA04CAF085A5D8C2EE76D0@DM6PR12MB3033.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(81156014)(99286004)(486006)(6306002)(316002)(31686004)(6512007)(71200400001)(71190400001)(11346002)(446003)(81166006)(26005)(52116002)(8676002)(31696002)(256004)(53546011)(76176011)(6246003)(102836004)(6506007)(8936002)(66946007)(2616005)(4326008)(476003)(66476007)(64756008)(186003)(2906002)(3846002)(66446008)(14454004)(25786009)(386003)(6486002)(6636002)(6116002)(5660300002)(66066001)(66556008)(478600001)(54906003)(110136005)(7736002)(229853002)(305945005)(36756003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3033;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66An7w43HP0b048ZwTCRr2uSsnBAa43sWmBwrm2+rvnofSO70auqk7sPEIL774M3HL+6ty7iYcLtFGwCGP3OAujUsIu1UDVVrQDENBbaSZPQMZm6me3rUob4N1HVXHXYeIdKJgTLe5tEsxGfnSk+oAomuRAGK5934eP4KqbxrsYTjTWVklY7jX6Wmc35oPYG5qZ1YRYTkHWotaw9ZXrlQpymRSIuEeEiErLeqUTg0CD4IWMBHXWsNkvCNjSBGnI/G5jXU5lCiVBV4JYL7LSkorc51d5FsgyWKGSKPBPsxBpcNdja9ZgL25fUji5wmwP5+V7A2WJa53U6UqibF1vSj2uUs8ZRd9w4/885MRPHZcdcWgP+xDIfw8lp4u4M5Coat7z09fRtmNKZYZUV4Nom0jXGYHYUMkTuEvymAOHiWnw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B026E4F768F0C642A15381F8EE109635@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c61541-ce33-4d31-e558-08d752e41d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 09:26:39.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rb5kMJuBApSZ3ZCntMmUJ9KelmFsUgYZP8AL1bRZbKyhLviSjtipAYFl/l61YP2H4ump9nao8OcbAmZub5csEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLA0KDQpPa2F5LldlIHdpbGwgcHJvY2VlZCB3aXRoIGV4aXN0aW5nIHBsYXRmb3JtIGRl
dmljZSBtb2RlbC4NCg0KTWFyaywNCg0KSSB3aWxsIHJlc2VuZCB0aGUgcGF0Y2hlcyB3aXRoIHRo
ZSByZXZpZXcgY29tbWVudHMgYWRkcmVzc2VkLg0KDQoNClRoYW5rcywNClZpc2hudQ0KDQpPbiAx
NC8xMC8xOSAxMjozMyBQTSwgTGVlIEpvbmVzIHdyb3RlOg0KPiBPbiBUaHUsIDEwIE9jdCAyMDE5
LCBSQVZVTEFQQVRJLCBWSVNITlUgVkFSREhBTiBSQU8gd3JvdGU6DQo+IA0KPj4gSGkgTGVlLA0K
Pj4NCj4+IFdlIGhhdmUgdHdvIGluc3RhbmNlcyBCVCBhbmQgSTJTLg0KPj4gV2UgbmVlZCB0byBj
cmVhdGUgZGV2aWNlcyB3aXRoIHNhbWUgbmFtZSBhZGRlZCB3aXRoIG51bWJlciBvZiBkZXZpY2UN
Cj4+IGxpa2UgZXhhbXBsZToNCj4+IGFjcDN4X2kyc19wbGF5Y2FwLjEuYXV0bzxodHRwOi8vMS5h
dXRvPg0KPj4gYWNwM3hfaTJzX3BsYXljYXAuMi5hdXRvPGh0dHA6Ly8yLmF1dG8+DQo+Pg0KPj4g
YnkgdXNpbmcgTUZEIHdlIGNhbiBtYWtlIGl0IGhhcHBlbiBhdXRvbWF0aWNhbGx5IGJ5IGdpdmlu
Zw0KPj4gImFjcDN4X2kyc19wbGF5Y2FwIiBhbmQgb3RoZXIgZXh0ZW5zaW9uIHdpbGwgYmUgYWRk
ZWQgYnkgTUZEIGFkZCBkZXZpY2UgQVBJLg0KPiANCj4gVGhlIGF1dG8gZXh0ZW5zaW9uIGlzIGhh
bmRlZCBieSB0aGUgcGxhdGZvcm1fZGVpdmNlX2FsbG9jKCkgQVBJLg0KPiANCj4gICAgcGxhdGZv
cm1fZGV2aWNlX2FsbG9jKCJhY3AzeF9pMnNfcGxheWNhcCIsIFBMQVRGT1JNX0RFVklEX0FVVE8p
Ow0KPiANCj4+IFRoaXMgaGVscHMgdXMgYnkgcmVjdGlmeWluZyB0aGUgcmVuYW1pbmcgaXNzdWUg
d2hpY2ggd2UgZ2V0IGJ5IHVzaW5nDQo+PiBQbGF0Zm9ybV9kZXZfY3JlYXRlIEFQSWBzLklmIHdl
IGhhdmUgdG8gdXNlIHBsYXRmb3JtIHJlbGF0ZWQgQVBJcyB0aGVuDQo+PiB3ZSBuZWVkIHRvIGdp
dmUgZGlmZmVyZW50IG5hbWluZyBjb252ZW50aW9ucyB3aGlsZSBjcmVhdGluZyB0aGUgZGV2aWNl
cw0KPj4gYW5kIGNhbnQgdXNlIGl0IGluIGxvb3AgYXMgd2UgaGF2ZSAzIGRldmljZXMgd2UgbmVl
ZCB0byBjYWxsIHRocmVlDQo+PiBleHBsaWNpdGx5LlRoaXMgbWFrZSBvdXIgY29kZSBsZW5ndGh5
Lg0KPj4gSWYgd2UgdXNlIE1GRCBpdCB3b3VsZCBoZWxwIHVzIGEgbG90Lg0KPj4NCj4+IFBsZWFz
ZSBzdWdnZXN0IHVzIGhvdyBjYW4gd2UgcHJvY2VlZC4NCj4gDQo+IFlvdSBoYXZlIDIgY2hvaWNl
cyBhdmFpbGFibGUgdG8geW91IGJhc2VkIG9uIHdoZXRoZXIgeW91ciBkZXZpY2UgaXMgYW4NCj4g
TUZEIG9yIG5vdDoNCj4gDQo+IElmIHllcywgbW92ZSBpdCAob3IgYSBwYXJ0IG9mIGl0KSB0byBk
cml2ZXJzL21mZC4NCj4gSWYgbm8sIHRoZW4gdXNlIHRoZSBwbGF0Zm9ybV9kZXZpY2VfKigpIEFQ
SS4NCj4gDQo=
