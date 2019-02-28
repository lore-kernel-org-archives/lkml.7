Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09191C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF232171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="bZzbpj2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfB1NJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:09:37 -0500
Received: from mx08-00287e01.pphosted.com ([62.209.51.156]:13086 "EHLO
        mx07-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726003AbfB1NJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:09:37 -0500
Received: from pps.filterd (m0111316.ppops.net [127.0.0.1])
        by mx07-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SD1J4o007254;
        Thu, 28 Feb 2019 14:09:20 +0100
Received: from eur02-am5-obe.outbound.protection.outlook.com (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59])
        by mx07-00287e01.pphosted.com with ESMTP id 2qtw1ywhmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 14:09:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhmhszxIdTgktboNca/CNxUX7eYs+7oXVPKjirH0Pqw=;
 b=bZzbpj2H4xCoa7+Hex9yS3R2AyWXChQWEE8CYe9xm6+23/wthitr3OqDICZw0Z7IUW1vX83vWPEsCcEAAtaknl/tj4+jrH4F6rBQ0aCGbbPCmgjLhv7y8i+b5crrdI4Xau5EyrYQ4kPKDX+n3Ko/8qJ+cgjKsvlHYlScmQwFLuY=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB5759.eurprd04.prod.outlook.com (20.178.127.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 13:09:18 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec%3]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 13:09:18 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     Erwan Velu <erwanaliasr1@gmail.com>
CC:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <esc.storagedev@microsemi.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Topic: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
Thread-Index: AQHUzrnze9rjAoGyP0WDHT7LWV0vu6X1MCqA
Date:   Thu, 28 Feb 2019 13:09:18 +0000
Message-ID: <7ef24085-2cc1-6271-1b16-cbfa4b0d80f5@criteo.com>
References: <20190227163133.26283-1-e.velu@criteo.com>
In-Reply-To: <20190227163133.26283-1-e.velu@criteo.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0037.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::25) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.199.242.236]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e4a342f-fefa-4cab-8513-08d69d7df275
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5759;
x-ms-traffictypediagnostic: VI1PR04MB5759:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1NzU5OzIzOjk5Z0VMeC9BWjMyOWJKVTFhcU1YVEVCaVBE?=
 =?utf-8?B?UTBRRENmMEJMMVFkdnZnZzdEZklGZUNqSXhWc1p4RldoM1JORXJxMWVva2pn?=
 =?utf-8?B?Z1Vrb3hTcFcyRldxRW9ZQTBmZlRYN0VMVmx0RFBMNXlVYUl1amlDaVA0VWZF?=
 =?utf-8?B?U2d5UHJjQXFGNkVCUlpnWjRmL3g5czgrcFBwdnkrVloraHZKRlhPUitoamZK?=
 =?utf-8?B?ck1jQm53WGlkZ085VnBUTVJ6U3VkMzh4TjBUK054MjFGMHBpVmsveTlkTW80?=
 =?utf-8?B?cUJOUzRROUYyMFNoWEdKM1dGaklBTC9wcGVKWEVJelRvYS9UcUNiRHRQNFpq?=
 =?utf-8?B?bEFwVlBGQ3kwQVhiVmdiL3dGVEFVei84cHk4ZWlLUVJPdUY4N3lteXczMnJO?=
 =?utf-8?B?amNoYXNNTEI2SUxRUGprWVUrT1E4bVhEV1ByenFlbk1KTG5RNTd1R1QvdWh3?=
 =?utf-8?B?MHlIWERFWHl5a3JEV2JFUTUxRUIvYmlWZmdkQitjMks1cWZTTFlUcWYvUWh6?=
 =?utf-8?B?ZmlBRW1nUEgvNXhKVVB4N1RMNHZyZk1KQXVzbnAzcHVTTnRJK1laZjNFREU5?=
 =?utf-8?B?NnVrdkk2TVdJTnlVQmdxOE5FeWFvT2Q1b1Z4RWowVUVwZks1NU1LUVdMazRE?=
 =?utf-8?B?Uy83M3NGRm1BUW9QRjhiTWIvelhYU053ekNocGlkTXZXcVAzS0VZSlprWTds?=
 =?utf-8?B?eHhiMlRqdytvQjE3MlUvZ2dJZ1pWRHZQRngzOEtGUkxLNjY2aGU4UXJiYS8w?=
 =?utf-8?B?OVBBNTZwQ29lR0hhZG9Pa1gveHZNL0JOV0VtdTFpS2Z2Q0FzK3JXS09RejJK?=
 =?utf-8?B?U3dqelowYTVSSElYTjNDazR3SnNFMDJQSFRxby9VTHI2SHVCd3N1TDNaVG94?=
 =?utf-8?B?OWpLUGx6c2R5RmtFWjNja0FpcTBPYkRsT3RxdzRUWmZtNHJYRlVPV1lqWThE?=
 =?utf-8?B?VGlyUjdEM2pCcE1Tb3N2bm45YkFkUE4yTkM2Q0VkZVFxQTVsMWVicm91MWtW?=
 =?utf-8?B?SlF0OWJxNitBVkFaenJONXpsQlRwR1Z5OVVMUXlFb2VnNi90U2dzRlJobTFp?=
 =?utf-8?B?YVBtYitFWjV2dC9ZZHRoN2l1WmxjZTZQVk5QZnFzZ1dmZFdMMkxsWm5YQzh3?=
 =?utf-8?B?UmtDNEUydVp6aFdIU3gvYVZzNWpjNzlZNzFiUHM4Tk5lTkZ1bm5nUklPb0Vn?=
 =?utf-8?B?b3dEbUFhWWY0L0xlWHBKOW1PTWkraXBoQ1FPS2dsNGkzc3RBT0MyZWVwWXI1?=
 =?utf-8?B?Ny8zRk5VU2EyNHRZdkhFTjhPVmpTWXdab3JkOVVpWmF4Qy9Jd0thblZYV0I1?=
 =?utf-8?B?SXI1L2s1aEJrYTl2Z3VCOFZ4UlpQWW9VSmNaQ056NjVlbHJKQlJCU216dmRB?=
 =?utf-8?B?K0JsV3FrNitPMUNKTHQzVW9CcWVXUThUYjZxQmIvT3pDZWRQdTFRaC9oVlhj?=
 =?utf-8?B?c3UvSzI2U2VDckxhTGhlOFZxeTVxcmRndW9MM0xBV3loR3VCUi9iREp3MmV1?=
 =?utf-8?B?c1dkTkdYSWNIak5QdGpERGRHQTRzOC9EZWEwbDAyb1JDTkFiZkpTbXRVcDdk?=
 =?utf-8?B?V0xJTFdFbVNDeTRSQ3F1MVM2M05HeDJ1ZFZiY1NjS3FkVXNBL3VFL2VOSG5Q?=
 =?utf-8?B?bmUzV3kwRGpkWXl6dS93M0luN0tvRTZiQW5jN3N6UEU3ZnJzOUMweHFydnZK?=
 =?utf-8?B?WE9Kck8xN3dYNkJCZnNRTTQ1VVZVWVgzRC9adjlWUENDdUtqQ1VLU2duS1hr?=
 =?utf-8?Q?2rikEi56JiQ7R/DUVotFBqFS3DrNM8fVKXxeM=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB5759569F0562B284F76BDEEFF2750@VI1PR04MB5759.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(316002)(106356001)(1411001)(386003)(4326008)(6506007)(5660300002)(446003)(186003)(36756003)(11346002)(76176011)(102836004)(26005)(6486002)(66066001)(2906002)(478600001)(25786009)(31696002)(229853002)(97736004)(68736007)(8936002)(14454004)(66574012)(54906003)(256004)(105586002)(8676002)(81156014)(6246003)(71200400001)(31686004)(53936002)(52116002)(71190400001)(86362001)(81166006)(6116002)(6436002)(476003)(99286004)(305945005)(14444005)(6916009)(6512007)(2616005)(3846002)(486006)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB5759;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lW5Cdbc2IpyltvaduxjzPFT/i7ePYluok+5/qcff1L9QhqUqv/7V4pk/ugZk4vRIK9qolzS3+kXzCxPfG/6LWnmOTnuIUMN5uDp1vGGWsgsGDLJEgA9vwZk369bhKYWz7bS7C6tM0T5RANJI+LfWpfexCV5E07GeZOgVgPkOhmiXMZGKgyAuLrDBLnh92LifLzSeAkn+6fSBn/WiLU6/3OsobNfbvmm1yOxTzuWy81gcYl3OWvBj5a3ZWQFTATE4KvV0i5ej47qvr9qDQWEILQnlvPzYVnokhUHdbu+wGnmOP+oRGW0EvWwYABb1brEuO3tNDt5R2H2nzs0EbqsVJqzHznr3VSEKtCjAK4MKvLRmUawZY2ZoYBtYhWFl3OP52afXAqOaAOh8jFT8nBfUek0oN89dT0pW5bKq9+nESyI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <909447F61EE9B64F9E2A79900F90B9A6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4a342f-fefa-4cab-8513-08d69d7df275
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 13:09:18.5305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5LA0KDQpUaGF0IG1ha2VzIG1lIHdvbmRlciB3aHkgdGhlIDB4M2UgLyAweDIgaXNuJ3QgaGFu
ZGxlZCBoZXJlIGFrYQ0KDQozRS8wMiBEWlRQUk9NQUVCS1ZGIFRJTUVPVVQgT04gTE9HSUNBTCBV
TklUIElzIGl0IHBvc3NpYmxlIHRoZSANCmNvbnRyb2xsZXIgc2VuZCB0byB0aGUga2VybmVsIHRo
aXMga2luZCBvZiBtZXNzYWdlLCBpZiBzbyBzaG91bGRuJ3Qgd2UgDQpoYW5kbGUgaXQgaGVyZSA/
IEVyd2FuLA0KDQpMZSAyNy8wMi8yMDE5IMOgIDE3OjMxLCBFcndhbiBWZWx1IGEgw6ljcml0wqA6
DQoNCj4gV2hlbiB0aGlzIEhBUkRXQVJFX0VSUk9SLzB4M2UvMHgxIGNhc2UgaXMgdHJpZ2dlcmVk
LCB0aGUgbG9naWNhbCB2b2x1bWUgaXMgb2ZmbGluZWQuDQo+IFdoZW4gcmVhZGluZyB0aGUga2Vy
bmVsIGxvZywgdGhlIGNhdXNlIHdoeSB0aGUgZGV2aWNlIGdvdCBvZmZsaW5lZCBpc24ndCByZXBv
cnRlZCB0byB0aGUgdXNlci4NCj4gVGhpcyBzaXR1YXRpb24gbWFrZXMgZGlmZmljdWx0IGZvciBh
ZG1pbnMgdG8gZXN0aW1hdGUgX3doeV8gdGhlIHZvbHVtZSBnb3Qgb2ZmbGluZWQuDQo+IFJlYWRp
bmcgdGhpcyBwYXJ0IG9mIHRoZSBjb2RlIG1ha2VzIGNsZWFyIHRoaXMgaXMgYmVjYXVzZSBkcml2
ZXIgcmVjZWl2ZWQgYSBIQVJEV0FSRV9FUlJPUi8weDNlLzB4MSB3aGljaCBpcyBhICdsb2dpY2Fs
IHVuaXQgZmFpbHVyZScuDQo+DQo+IFRoaXMgcGF0Y2ggaXMganVzdCBhYm91dCByZXBvcnRpbmcg
dGhhdCBmYWN0IHRvIGhlbHAgYWRtaW5zIG1ha2luZyBhIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRo
aXMgZXZlbnQgYW5kIHRoZSBvZmZsaW5pbmcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEVyd2FuIFZl
bHUgPGUudmVsdUBjcml0ZW8uY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3Njc2kvc21hcnRwcWkv
c21hcnRwcWlfaW5pdC5jIHwgNSArKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zbWFydHBxaS9zbWFydHBxaV9p
bml0LmMgYi9kcml2ZXJzL3Njc2kvc21hcnRwcWkvc21hcnRwcWlfaW5pdC5jDQo+IGluZGV4IGY1
NjRhZjg5NDllOC4uODlmMzdkNzY3MzVjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Njc2kvc21h
cnRwcWkvc21hcnRwcWlfaW5pdC5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS9zbWFydHBxaS9zbWFy
dHBxaV9pbml0LmMNCj4gQEAgLTI3NjQsNiArMjc2NCwxMiBAQCBzdGF0aWMgdm9pZCBwcWlfcHJv
Y2Vzc19yYWlkX2lvX2Vycm9yKHN0cnVjdCBwcWlfaW9fcmVxdWVzdCAqaW9fcmVxdWVzdCkNCj4g
ICAJCQkJc3NoZHIuc2Vuc2Vfa2V5ID09IEhBUkRXQVJFX0VSUk9SICYmDQo+ICAgCQkJCXNzaGRy
LmFzYyA9PSAweDNlICYmDQo+ICAgCQkJCXNzaGRyLmFzY3EgPT0gMHgxKSB7DQo+ICsJCQlzdHJ1
Y3QgcHFpX2N0cmxfaW5mbyAqY3RybF9pbmZvID0gc2hvc3RfdG9faGJhKHNjbWQtPmRldmljZS0+
aG9zdCk7DQo+ICsJCQlzdHJ1Y3QgcHFpX3Njc2lfZGV2ICpkZXZpY2UgPSBzY21kLT5kZXZpY2Ut
Pmhvc3RkYXRhOw0KPiArDQo+ICsJCQlkZXZfZXJyKCZjdHJsX2luZm8tPnBjaV9kZXYtPmRldiwg
InJlY2VpdmVkICdsb2dpY2FsIHVuaXQgZmFpbHVyZScgZnJvbSBjb250cm9sbGVyIGZvciBzY3Np
ICVkOiVkOiVkOiVkXG4iLA0KPiArCQkJCQkJCWN0cmxfaW5mby0+c2NzaV9ob3N0LT5ob3N0X25v
LCBkZXZpY2UtPmJ1cywNCj4gKwkJCQkJCQlkZXZpY2UtPnRhcmdldCwgZGV2aWNlLT5sdW4pOw0K
PiAgIAkJCXBxaV90YWtlX2RldmljZV9vZmZsaW5lKHNjbWQtPmRldmljZSwgIlJBSUQiKTsNCj4g
ICAJCQlob3N0X2J5dGUgPSBESURfTk9fQ09OTkVDVDsNCj4gICAJCX0NCg==
