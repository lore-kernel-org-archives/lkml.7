Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B22CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528C221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t4cnUSQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406459AbfJYHIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:08:06 -0400
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:19072
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733140AbfJYHIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:08:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHFKkHZaIN3Cq5pgrdZIrE0BnmARgU/PerpgUELaatufv/CO8jn/7KaocsVw29b1V1+LEH6qV0SMqNvlln4yPNwiIzaRSF5RU6VDDy+ruf4wApR+TIgqPsUheSFIYByQVbrsSL9yRuTHDtwnTZO6v0vgpLwC5tAX9G46XjgXrQu31Sr4PhAu4Ghp6dFNt6wl00uvvrptDAmRAEZXZU3Ix5uJbZQuX6IuKvtkblrOzNW3E/CsQNTjASCo2JCQiHMBjafdGY5MZQOYzC20bhqzAZlkfH9m3Zmbw2MrqPII5ajyZySja6X2gxbkDh003K08ppVaxXuf/rSIu8wM4yVAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2oErCeHqGTaVCkywNnp+XsZ3rAVU9iNPBR1kZQynvY=;
 b=k873WVLZga5HoMD8nl/y6HVJMF/1k/ha6JdsS8GB9xTJl0j+6s8RDQQ7eOMrKSss+pg4bSV7AR2Lrira1GmTl6BnJT7ZAhjJh61DbkAYCJUlWe7JEneFZC1ib+q91y2/sGahRAC42ioQ7eHiR21J7K/OQwjYWGhvryzAYGloJKn2skC5uGXidsr4bzrSpYwn94uqru+zdzOP/UxpUqHT3301xH4hCU0yAQFhUFHc+nlYABlrKSyChDNWqF/qMsur2q9EpnYXxs9ftG8Hg28EnJkOIfi0jG3jUkSaXKH1puz9nPdsOzKcRIqysadSkvmNlHVAED96DjqsqcwZ6aV1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2oErCeHqGTaVCkywNnp+XsZ3rAVU9iNPBR1kZQynvY=;
 b=t4cnUSQSOrEip0hPG3BMX9rCKW+KXB6I240O44pz5hwP+qqstgQ9B1SR+9lb2GZWf+VvbT+YVFIGtvRKsaElPq3FcGK1LapM8nYb5T3JqnHVzFFbJMMSLDij08CvfDl2cOEzv24tQ8sIm+OAejS4ZZccD+krbkZY2uNDGlSQlio=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB2747.namprd12.prod.outlook.com (20.176.116.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 07:07:58 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 07:07:58 +0000
From:   vishnu <vravulap@amd.com>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] ASoC: amd: handle ACP3x i2s-sp watermark interrupt.
Thread-Topic: [PATCH 5/7] ASoC: amd: handle ACP3x i2s-sp watermark interrupt.
Thread-Index: AQHVhZzM/IT5SCb7bEWc0HutxlD0F6dq+w+A
Date:   Fri, 25 Oct 2019 07:07:57 +0000
Message-ID: <a4be9768-165d-0a4d-411c-45e80b431cb6@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
In-Reply-To: <1571432760-3008-5-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::19) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3446d718-6b37-42e0-71e5-08d7591a1071
x-ms-traffictypediagnostic: DM6PR12MB2747:|DM6PR12MB2747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB274763DF162EBBE7A0003E43E7650@DM6PR12MB2747.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:232;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(189003)(199004)(52116002)(102836004)(53546011)(71200400001)(386003)(6506007)(486006)(26005)(71190400001)(6862004)(36756003)(229853002)(8936002)(6512007)(81156014)(4326008)(6486002)(6246003)(6436002)(256004)(6636002)(478600001)(99286004)(66446008)(66556008)(76176011)(316002)(8676002)(31686004)(2906002)(64756008)(66476007)(31696002)(66946007)(7736002)(3846002)(186003)(54906003)(37006003)(11346002)(305945005)(2616005)(476003)(446003)(5660300002)(6116002)(66066001)(14454004)(81166006)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2747;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNKjMWzXdlyNCSQKrjfWlU66LzScCitOndUk+g/wv1STtjioomajfo+++x3HRHQ6bcz8ZOP5D/W5XxRndBRPMbrnt0YgKrKqgrfwVzVGz5KC4NXWI95dwDg+wQNxusbPtHLLoV2Pflhk78s3Eqq55t/pNoDtv4DjvAuYZhXhdh+SolqQtBBbjWd7hF/wszbwo4cJS8Meo1gGNhvTRFDi3ae4B4RE6FHu34XAaQhPiveNzHJ121437+xrX1KFiLb0Au4zDDk4M//XAUimKd12NR+ZIuTKBFe52W69+kJKI+27IBJ6Z0WWE8BPQteuvdvnMMczeF6NeIPU+XiTD3ulPRg/G6v+2EJbUvdK4k94VnR8EggdBC83xTOVVPVyYAqNXtik1TOkj+sMO1RrPKk0FEnC9oC/6VbwO4sJRywEguF3hvaUKpTeLRXrXL2RyMYk
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ABA409645FFD6418EE19220B9B57313@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3446d718-6b37-42e0-71e5-08d7591a1071
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 07:07:57.8295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KROeg8gAZQDevbJo68hHXYfvSZS/X+PJpKW/hAXEaXcjFONMPt189Cteou8fNktqZwWo3aECKSDGqrCtBnMTBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCkFueSB1cGRhdGVzIG9uIHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMsDQpWaXNobnUN
Cg0KT24gMTkvMTAvMTkgMjozNSBBTSwgUmF2dWxhcGF0aSBWaXNobnUgdmFyZGhhbiByYW8gd3Jv
dGU6DQo+IHdoZW5ldmVyIGF1ZGlvIGRhdGEgZXF1YWwgdG8gSTJTLVNQIGZpZm8gd2F0ZXJtYXJr
IGxldmVsIGlzDQo+IHByb2R1Y2VkL2NvbnN1bWVkLCBpbnRlcnJ1cHQgaXMgZ2VuZXJhdGVkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUmF2dWxhcGF0aSBWaXNobnUgdmFyZGhhbiByYW8gPFZpc2hu
dXZhcmRoYW5yYW8uUmF2dWxhcGF0aUBhbWQuY29tPg0KPiAtLS0NCj4gICBzb3VuZC9zb2MvYW1k
L3JhdmVuL2FjcDN4LXBjbS1kbWEuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvYW1k
L3JhdmVuL2FjcDN4LXBjbS1kbWEuYyBiL3NvdW5kL3NvYy9hbWQvcmF2ZW4vYWNwM3gtcGNtLWRt
YS5jDQo+IGluZGV4IDRmY2VmM2YuLmEwMDBhYzQgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9h
bWQvcmF2ZW4vYWNwM3gtcGNtLWRtYS5jDQo+ICsrKyBiL3NvdW5kL3NvYy9hbWQvcmF2ZW4vYWNw
M3gtcGNtLWRtYS5jDQo+IEBAIC0xNzYsNiArMTc2LDEzIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBp
MnNfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiAgIAkJc25kX3BjbV9wZXJp
b2RfZWxhcHNlZChydl9pMnNfZGF0YS0+cGxheV9zdHJlYW0pOw0KPiAgIAkJcGxheV9mbGFnID0g
MTsNCj4gICAJfQ0KPiArCWlmICgodmFsICYgQklUKEkyU19UWF9USFJFU0hPTEQpKSAmJg0KPiAr
CQkJCXJ2X2kyc19kYXRhLT5pMnNzcF9wbGF5X3N0cmVhbSkgew0KPiArCQlydl93cml0ZWwoQklU
KEkyU19UWF9USFJFU0hPTEQpLA0KPiArCQkJcnZfaTJzX2RhdGEtPmFjcDN4X2Jhc2UJKyBtbUFD
UF9FWFRFUk5BTF9JTlRSX1NUQVQpOw0KPiArCQlzbmRfcGNtX3BlcmlvZF9lbGFwc2VkKHJ2X2ky
c19kYXRhLT5pMnNzcF9wbGF5X3N0cmVhbSk7DQo+ICsJCXBsYXlfZmxhZyA9IDE7DQo+ICsJfQ0K
PiAgIA0KPiAgIAlpZiAoKHZhbCAmIEJJVChCVF9SWF9USFJFU0hPTEQpKSAmJiBydl9pMnNfZGF0
YS0+Y2FwdHVyZV9zdHJlYW0pIHsNCj4gICAJCXJ2X3dyaXRlbChCSVQoQlRfUlhfVEhSRVNIT0xE
KSwgcnZfaTJzX2RhdGEtPmFjcDN4X2Jhc2UgKw0KPiBAQCAtMTgzLDYgKzE5MCwxMyBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgaTJzX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4g
ICAJCXNuZF9wY21fcGVyaW9kX2VsYXBzZWQocnZfaTJzX2RhdGEtPmNhcHR1cmVfc3RyZWFtKTsN
Cj4gICAJCWNhcF9mbGFnID0gMTsNCj4gICAJfQ0KPiArCWlmICgodmFsICYgQklUKEkyU19SWF9U
SFJFU0hPTEQpKSAmJg0KPiArCQkJCXJ2X2kyc19kYXRhLT5pMnNzcF9jYXB0dXJlX3N0cmVhbSkg
ew0KPiArCQlydl93cml0ZWwoQklUKEkyU19SWF9USFJFU0hPTEQpLA0KPiArCQkJIHJ2X2kyc19k
YXRhLT5hY3AzeF9iYXNlICsgbW1BQ1BfRVhURVJOQUxfSU5UUl9TVEFUKTsNCj4gKwkJc25kX3Bj
bV9wZXJpb2RfZWxhcHNlZChydl9pMnNfZGF0YS0+aTJzc3BfY2FwdHVyZV9zdHJlYW0pOw0KPiAr
CQljYXBfZmxhZyA9IDE7DQo+ICsJfQ0KPiAgIA0KPiAgIAlpZiAocGxheV9mbGFnIHwgY2FwX2Zs
YWcpDQo+ICAgCQlyZXR1cm4gSVJRX0hBTkRMRUQ7DQo+IA0K
