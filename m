Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5637F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 05:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="miQV/jK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfCFFVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 00:21:01 -0500
Received: from mail-eopbgr700126.outbound.protection.outlook.com ([40.107.70.126]:34944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfCFFVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 00:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UdeMhxSiqLClGbaZ2GCLCY08TlatIdpshbmdCw3pNw=;
 b=miQV/jK6Hwi6EjDg0vuVdQUHOjegBJS3+SHuRb2TisC+oPDuY7JYFKjv3hzmPMJzI0KbxajNjbXlKetOqV08JBkwKZvnkiO5cVGwbOlC7kFj9/pgvez7eSdRFmAuTNvgad4KIczyfjPCXDy066yCLbEN2LF7b5olJa0MaaU8bs8=
Received: from SN6PR2101MB1342.namprd21.prod.outlook.com (20.178.200.80) by
 SN6PR2101MB1327.namprd21.prod.outlook.com (20.178.200.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.3; Wed, 6 Mar 2019 05:20:56 +0000
Received: from SN6PR2101MB1342.namprd21.prod.outlook.com
 ([fe80::250c:9362:8dfe:1673]) by SN6PR2101MB1342.namprd21.prod.outlook.com
 ([fe80::250c:9362:8dfe:1673%4]) with mapi id 15.20.1686.003; Wed, 6 Mar 2019
 05:20:56 +0000
From:   Rui Zhao <ruizhao@microsoft.com>
To:     James Morse <james.morse@arm.com>
CC:     Sasha Levin <sashal@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kernel <linux-kernel@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "okaya@kernel.org" <okaya@kernel.org>
Subject: RE: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Thread-Topic: [PATCH] EDAC, dmc520:: add DMC520 EDAC driver
Thread-Index: AQHUr0oncrkPcrT8ZkiCJkyHP8fACaW5+YsAgAIO9dSAAS4AgIAAJNaggBQ3UwCALMVKkA==
Date:   Wed, 6 Mar 2019 05:20:56 +0000
Message-ID: <SN6PR2101MB1342C26E71FD73BBCBF9E737B3730@SN6PR2101MB1342.namprd21.prod.outlook.com>
References: <20190118162324.17123-1-sashal@kernel.org>
 <0866a996-49f7-1498-4653-20232bef2f46@arm.com>
 <MW2PR2101MB09701C705250DAC025AFC251B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
 <7d404c61-a916-5d5e-35cc-0f6f016cd8a9@arm.com>
 <MW2PR2101MB09708B7F11BDEE6755CC9F03B3990@MW2PR2101MB0970.namprd21.prod.outlook.com>
 <efc7fba8-dbff-844c-2995-28cbd5f015c0@arm.com>
In-Reply-To: <efc7fba8-dbff-844c-2995-28cbd5f015c0@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=ruizhao@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-06T05:20:46.1687082Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d86d1cb5-3a32-4da5-a4ef-14316f14097b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [71.197.180.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae881a80-6822-4543-27be-08d6a1f38309
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1327;
x-ms-traffictypediagnostic: SN6PR2101MB1327:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruizhao@microsoft.com; 
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtTTjZQUjIxMDFNQjEzMjc7MjM6TU5UZ0xZY1U2T1hHaGZHdThxRkFiU3Ja?=
 =?utf-8?B?MTR6dGFjQXptc0lNVGtpOVFhbEhEcnJPclpoQ1kraitGd2Z0bjE4VFhDdXdU?=
 =?utf-8?B?ODF2dUJOc2wrODgzY0NqbWVqUGFpczd5V01oVmNLOVcrV0dJOHArT1ZHSzlK?=
 =?utf-8?B?bXRPRFptQ3dTeEd1WStMenA5VVFyQUF4Q2J1MFRBZGRud2ViVGNMVHhXUWxw?=
 =?utf-8?B?WlZScEp2UjAvWVdDTENOVDVld0VrRHFydGM2eTNIZ0V6ZFYvWmsveGIwL0Vi?=
 =?utf-8?B?bjBCcGdmYWcrQlU5bG5QbnJJb0VKSzU2b1R3c0tzbDdwNUg0UkQ5QTJEZ2x5?=
 =?utf-8?B?dklJeVp4eFhYajFoZTFRZU9qeTVxeTFoOFkrMTZJUjExbFdQMkJaTitNbVZn?=
 =?utf-8?B?TWVkN0RhMlQ2MTl4UzRVNC9lM1lKZ0d6dE56bUd4ZUlQd3NpU3dTYzVxQXdz?=
 =?utf-8?B?anM0ZFZHWTZkRExSZGdqSWxIRVYrdkZWMjM4bUZMT1A2amgzNUt4SEVyMk51?=
 =?utf-8?B?M2tDajduMDk1c2hkSXYvY3ZMRXZyeG85bnM1czlFcE9iV0xMMXdSR3crRGc1?=
 =?utf-8?B?dks1YTlSVGhOS1diSCtmdk1GZHZvbG5iY3VjbXhqRGlQdUh1V1FVb1NuWEJE?=
 =?utf-8?B?K3ZpL3p1ME1HZk5VbmJZK1Rwb0dYaWtVSDVYUlkzSk1mNzN0SlZiV1p6aWJ1?=
 =?utf-8?B?bERPOVkzOGlCYm54UjFMSkVpTFAwTkFudy9hKzZ4Yk1iaTUrVFh4ZWJ3T1Fz?=
 =?utf-8?B?dEVLMUV3QnZhdmhFZTIwSFJPV3lBR1c4dzlxd3dKM0F1a1hXeno4L3Z2RFEz?=
 =?utf-8?B?akxsMjBJYVB2QXBhSWNoNlFQTWhrRXNsN3NkOGhYMWJJOTJHZ01GQUdhek9C?=
 =?utf-8?B?K0lBOEUxUW52OCtzengxam92VDRPVWhkUnVybnBRZDhBMzhiR2ZUb3RCbnFy?=
 =?utf-8?B?K2FEdFEweTY2bzVMb3IwUXZWRnhKQm9aaWV1dXpYNjNNeVhpUFJaaEJLUDBw?=
 =?utf-8?B?MHIwd3laTlN6bzhmc2s2NmcxS3ZmYWJBSUNtNWQ0SDNnMzZYa2VFcFdkb1lj?=
 =?utf-8?B?WU5yTjQzaEs0VUNmNXdmdlhRMTRXTnB4RFNRTlZoUVpSanRpQkxXclVMT0R2?=
 =?utf-8?B?ZGNXbjEzejE1UGdvSjlQbnJNeklKSk85N1Bac2RnSk5MemdCQWVLby95UTNH?=
 =?utf-8?B?aWVURUVwdjNlckRQQ0pIVzlHRUU1WHFSd3BncnBRSGxLUzBMWFJMb0gxdVhp?=
 =?utf-8?B?UzNKdTRqbVBkMnU1bXZrWThPZTI2YWwyMkFJU21GZFFHOUNPenBqaWJ2YWhl?=
 =?utf-8?B?cm1RUk5NSUhlUWZnRTJIT21OTzkyS0F4YTZUS2FkTWRocEhmR3J6YWNpQ0Iv?=
 =?utf-8?B?VlljR2t5d3RDOUw4emljNFpSWGpiMGMyM0s4WGxwTlBYazVkT21mOE9uMElh?=
 =?utf-8?B?M2Iyejlkdjl1UHRjWWNWNWJURytzRDF6MVMxTm9yTmE5R21sYWZhYnBKdjhs?=
 =?utf-8?B?ZnhacTNBZzBrS3VJWHFRaFF4VlpsWTNjaUdybXJkZGN5THlvRFR2NDRyd3Y4?=
 =?utf-8?B?OHFvVGVtZVk2MXgwYWc5ajlhQ0FUVy9nQmdVVDBpMVYwazJRKzFiRE1UQTc4?=
 =?utf-8?B?SXpBVkIrWWZvY1M3empjU2p5OXdDKzM0dVNFaHBKKzdDLzdqbVhGTjNNSjRO?=
 =?utf-8?B?Rkp3Zmd4Si9QTk5BTVpsdlpQdWwwUlk1L3NCWjNPdUNWYi9lc0J1cy9aRDZS?=
 =?utf-8?B?QzlFeDN2cHBLcEFlVzM0QjhXWUFyTmY0QUlqd3BIVldNdWRpeERVYzlJR0RI?=
 =?utf-8?B?eW1QS1Q5anFJRmNsbTVoKzVDMkhBM1l1NzltZEFIUmcrVkdKZWRnRzN4M1dj?=
 =?utf-8?B?d05YT2F4UnpWdGtXK2lidFVINjJZU1VycG9CSDg4OHUxeG1kbFBQT1ZOTHlk?=
 =?utf-8?B?RnpNVnlPaVJRenVnVXlScmxVeHVCV2dSeTJsMjYwZG9URjRjYVhsT1pTVitI?=
 =?utf-8?Q?oI1IbWUv?=
x-microsoft-antispam-prvs: <SN6PR2101MB1327F5DCFDD8293336B1409BB3730@SN6PR2101MB1327.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39860400002)(52254002)(189003)(199004)(3846002)(106356001)(186003)(22452003)(53546011)(6306002)(7736002)(54906003)(6436002)(256004)(81166006)(14444005)(25786009)(66066001)(74316002)(229853002)(486006)(6116002)(7696005)(6506007)(93886005)(86362001)(71190400001)(99286004)(10290500003)(966005)(11346002)(102836004)(71200400001)(5660300002)(55016002)(478600001)(476003)(68736007)(9686003)(316002)(86612001)(446003)(6916009)(2906002)(305945005)(8936002)(8990500004)(33656002)(4326008)(97736004)(14454004)(81156014)(53936002)(10090500001)(76176011)(26005)(52536013)(6246003)(8676002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1327;H:SN6PR2101MB1342.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GxLfJKoJs1uy+q2GiXVVfXcdF0CZ5AfHL/WHvcIyljor8MGE4zUzEwXgf+5ulm2huQWiSu5z4eLmB0Ca4awas8cq70U+yupoyUIsgxsodjMZMPtmdOpul3rHBXS3Z3At33raJvSjMJbp5Bq3yO6Ka1kPEn+VdmJR0cNPlrI8xBCZbF2nBOQueE1gtKZhTnoNlURttsGnMpkef9b2tc/4wL28PaMJ6EroBQ8BQYOfdhonyPMBiOa16+VodFypTjsTwetKV7u/7x8UQGj6znVNbWwlyWd0ktzq76rUtvc8AfUNkTonla00O/LaDBIH2H3xwVKjc0tuCSs9IEFjJ2NsAHOjDkzffUZxOj7kTo72mn4uGUbwO6TpA33in7E1U66hK1TD9j+JOiae5D7hkS0bxYd4QDQZUQtYCSqTAdgNfo8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae881a80-6822-4543-27be-08d6a1f38309
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 05:20:56.5662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNCj4gT24gVHVlc2RheSwgRmVicnVhcnkgNSwgMjAxOSA5OjMxIEFNLCBKYW1l
cyBNb3JzZSB3cm90ZToNCg0KPj4gV2UgaGF2ZSBmaXJtd2FyZSB0byBjb25maWcgdGhlIG1lbW9y
eSBjb250cm9sbGVyIGFuZCB3YW50IHRvIGhhdmUgYW4gRURBQyBkcml2ZXIgdG8gcmVwb3J0IEVD
QyBzdGF0dXMuDQoNCj4+IENvdWxkIHlvdSBwbGVhc2UgZWxhYm9yYXRlIGEgYml0IG9uIHRoZSBz
ZWN1cml0eSBjb25jZXJuIG9uIHRoaXMgDQo+PiBhcHByb2FjaD8gTGlrZSBzb21lIG1hbGljaW91
cyBhcHAvZHJpdmVyIGNhbiBhY2Nlc3MgbWVtb3J5IGNvbnRyb2xsZXIgcmVnaXN0ZXJzIGNhbiBj
YXVzZSBpc3N1ZT8NCg0KPiBJJ20gcmVtZW1iZXJpbmcgdGhpczoNCj4gaHR0cHM6Ly9uYW0wNi5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5r
ZXJuZWwub3JnJTJGbGludXgtYXJtLWtlcm5lbCUyRjliOWM0Y2Q1LTQ0MjgtYzA4ZC1kNGEzLTcz
NTJjNmM4MDU4MyU0MGFybS5jb20lMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q3J1aXpoYW8lNDBtaWNy
b3NvZnQuY29tJTdDMDJmNWIxMmJiZjAxNDUyZjlkMTIwOGQ2OGI4ZmM3NDglN0M3MmY5ODhiZjg2
ZjE0MWFmOTFhYjJkN2NkMDExZGI0NyU3QzElN0MwJTdDNjM2ODQ5ODQ2OTgxNzcyNjAxJmFtcDtz
ZGF0YT1EaHdJUERHQXVjSGlWTiUyQnlmYTEweUhEWno1elp3aTVPbHlyS0hFNEtVTlElM0QmYW1w
O3Jlc2VydmVkPTANCg0KPiBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+IHwgWyBGb3IgYW55b25lIGlu
dGVyZXN0ZWQsIGl0IHB1dHMgdGhlIERSQU0gY29udHJvbGxlciBpbnRvIHNsZWVwIG1vZGUuDQo+
IHwgVGhlIGtlcm5lbCBjYW4ndCBldmVuIHBhbmljIGlmIGFsbCB0aGUgbWVtb3J5IHN1ZGRlbmx5
IGRpc2FwcGVhcnMgOkQgXQ0KDQo+IFRoaXMgd291bGQgYmUgYSBwcm9ibGVtIGlmIHlvdSBuZWVk
IHlvdXIgU2VjdXJlLXdvcmxkIHNvZnR3YXJlIG5lZWRzIHRvIGtlZXAgd29ya2luZywgYW5kIGRl
cGVuZHMgb24gdGhlIG1lbW9yeSBiZWhpbmQgdGhpcyBjb250cm9sbGVyLg0KDQo+IEl0IG1pZ2h0
IGJlIHRoYXQgeW91ciBzZWN1cmUtd29ybGQgc29mdHdhcmUgb25seSB1c2VzIHNvbWUgb3RoZXIg
bWVtb3J5LCBpbiB3aGljaCBjYXNlIHRoaXMgd291bGRuJ3QgbWF0dGVyLg0KPiBJdCBtYXkgYmUg
bGludXggX2lzXyB5b3VyIHNlY3VyZS13b3JsZCBzb2Z0d2FyZSwgaW4gd2hpY2ggY2FzZSBpdCB3
b3VsZG4ndCBtYXR0ZXIgZWl0aGVyLg0KDQpXZSBoYWQgaW50ZXJuYWwgZGlzY3Vzc2lvbiB3aXRo
IG91ciBzZWN1cml0eSB0ZWFtIGFuZCBpbiBvdXIgcHJvZHVjdCB3ZSBkbyB0cnVzdCBMaW51eC4g
SSdsbCBzZW5kIGFuIHVwZGF0ZWQgcGF0Y2ggdG8gbW92ZSBwbGF0Zm9ybSBzcGVjaWZpYyBzZXR0
aW5ncyBsaWtlIGludGVycnVwdCBjb25maWcgdG8gRFQgYW5kIGluY2x1ZGUgRFQgYmluZGluZ3Mg
ZG9jIGZvciB0aGlzIGRyaXZlci4NCg0KVGhhbmtzLA0KUnVpDQo=
