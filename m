Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4B9204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DtQQm8Rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfDBQQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:16:18 -0400
Received: from mail-eopbgr820081.outbound.protection.outlook.com ([40.107.82.81]:36741
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729063AbfDBQQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVaDEc+3tyT8614b0mZI4hTl7dg6Bu7PipswXu+Vj80=;
 b=DtQQm8RfxwSbtFELovXyR1GHMEd3G1nPc83umo87tzs3e9fuIE4QQ9FiJQ6RMp3sf0jvxFojwI/ntebMCCw1lANGgN17AQ4f9wqYxzfQyAdSAdKCZARlRVKh0wzMxniPWpBKwj9V4hiHQ86sVoSjPihchJcKdBOGCcILJdWJRok=
Received: from DM6PR03MB4713.namprd03.prod.outlook.com (20.179.104.87) by
 DM6PR03MB3705.namprd03.prod.outlook.com (20.176.86.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Tue, 2 Apr 2019 16:16:13 +0000
Received: from DM6PR03MB4713.namprd03.prod.outlook.com
 ([fe80::30d4:3641:b834:e94b]) by DM6PR03MB4713.namprd03.prod.outlook.com
 ([fe80::30d4:3641:b834:e94b%5]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 16:16:13 +0000
From:   Christopher Heiny <Cheiny@synaptics.com>
To:     Aaron Ma <aaron.ma@canonical.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Thread-Topic: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Thread-Index: AQHUyTs5Qp0btHE2q0GPqsqH5pp/nqYB8HQAgAEjw4CAHbD4gIAIh1MA
Date:   Tue, 2 Apr 2019 16:16:13 +0000
Message-ID: <f4f7265d9ad06726bb2ef12ab6b7529d2fb06165.camel@synaptics.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
         <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
         <a0f21198-5715-8858-8368-51e43092181e@canonical.com>
         <acd07f4d-1602-46c5-c486-c917f1868b59@canonical.com>
In-Reply-To: <acd07f4d-1602-46c5-c486-c917f1868b59@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [166.171.251.83]
x-clientproxiedby: BYAPR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:a03:40::47) To DM6PR03MB4713.namprd03.prod.outlook.com
 (2603:10b6:5:181::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Cheiny@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac7a40b0-e6b4-4965-a191-08d6b78686c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR03MB3705;
x-ms-traffictypediagnostic: DM6PR03MB3705:
x-microsoft-antispam-prvs: <DM6PR03MB3705566D853F67E3AF4A87B5DD560@DM6PR03MB3705.namprd03.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(52314003)(199004)(189003)(71200400001)(6512007)(71190400001)(36756003)(25786009)(102836004)(106356001)(105586002)(14454004)(316002)(52116002)(50226002)(386003)(6246003)(486006)(53936002)(2616005)(446003)(93886005)(45080400002)(11346002)(476003)(66066001)(76176011)(6436002)(6506007)(2201001)(6486002)(186003)(26005)(229853002)(86362001)(99286004)(14444005)(2501003)(81166006)(81156014)(305945005)(256004)(8676002)(5660300002)(72206003)(7736002)(478600001)(68736007)(110136005)(8936002)(97736004)(3846002)(6116002)(80792005)(2906002)(118296001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3705;H:DM6PR03MB4713.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N1wBzx984Vktwp4smTNotgOPIUfXRDOCJw3X9qYX7XSIhv47RYZBRYnbuoSSgMo2hExBwS3e9pWT9dZH4nFZt48yfxI/GJi1Ch3VmcH6EdRb/224mkMLU66Ju7jAzLe6hKUhZ7SKMUp9Jyo/5aKjkjO9kDWN+0JX9JE94uV98eRusts3h9kKwuj1dXVhuwUqk6Cxr8Bc9oW7e1LV6H/wL7YA3vUtrgPgL6mYYGVszBcfMAhuQZZfLrVM3LsJ4BUGB7cd5jmD/Xorh+oEO3Esac0KTIKMCMeBXp4Hyi5dGX7cwlChbrm8BLX0Lo7WidcdhPglcXtPjLdteTf6V1CobMMbWsfsuo2+DYNtkJFkp3DL6Y1p/rVA6E0S3rCw7hrZQ2vBsTzKydqIZ/v5yayfeQjIJWicaomvoG98KjzMEvY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CBB9A7432A4B94191621205712F8E59@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7a40b0-e6b4-4965-a191-08d6b78686c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 16:16:13.7616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAzLTI4IGF0IDE0OjAyICswODAwLCBBYXJvbiBNYSB3cm90ZToNCj4gSGkg
RG1pdHJ5IGFuZCBDaGlyaXN0b3BoZXI6DQo+IA0KPiBEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlv
biBhYm91dCB0aGVzZSAyIHBhdGNoZXM/DQo+IA0KPiBNYW55IHVzZXJzIGNvbmZpcm1lZCB0aGF0
IHRoZXkgZml4ZWQgaXNzdWVzIG9mIFRyYWNrcG9pbnQvVG91Y2hwYWQNCj4gYWZ0ZXIgUzMuDQo+
IA0KPiBXaWxsIHlvdSBjb25zaWRlciB0aGVtIGJlIGFjY2VwdGVkPw0KDQpIaSBBYXJvbiwNCg0K
U29ycnkgLSBJIHRob3VnaHQgSSdkIHJlcGxpZWQgb24gdGhlIE5PIFNMRUVQIHBvcnRpb24gb2Yg
dGhlc2UgcGF0Y2hlcywNCmJ1dCBsb29raW5nIGJhY2sgSSBkb24ndCBmaW5kIHRoZSBkcmFmdCBv
ciB0aGUgc2VudCBlbWFpbC4gIFNvcnJ5IGFib3V0DQp0aGF0LiAgSSdsbCBzdW1tYXJpemUgaGVy
ZSB3aGF0IEkgd3JvdGUgbGFzdCBtb250aC4NCg0KVGhpcyBpc24ndCBzbyBtdWNoIGEgImZpeCIg
YXMgYSAiaGFja3kgd29ya2Fyb3VuZCIgZm9yIHRoZSBpc3N1ZS4gIEZyb20NCnRoZSBkZXNjcmlw
dGlvbnMgaW4gdGhlIGJ1ZyB5b3UgbGlua2VkIGluIHlvdXIgb3JpZ2luYWwgcGF0Y2gNCnN1Ym1p
c3Npb24sIGl0IGFwcGVhcnMgdGhhdCB0aGUgcm9vdCBjYXVzZSBpcyBzb21ld2hlcmUgaW4gU01C
dXMgc3lzdGVtDQooY291bGQgYmUgU01CdXMgZHJpdmVyLCBTTUJ1cyBoYXJkd2FyZSwgb3IgdGhl
IGRldmljZXMgb24gdGhlIFNNQnVzDQoodG91Y2ggZGV2aWNlcyBvciBvdGhlciBkZXZpY2VzKSAt
IGl0J3MgaGFyZCB0byB0ZWxsIHdpdGggdGhlIGluZm8NCmF2YWlsYWJsZSksIHdoZXJlIHRoZSBT
TUJ1cyBpcyBmYWlsaW5nIHRvIGNvbWUgb25saW5lIGNvcnJlY3RseSBjb21pbmcNCm91dCBvZiBT
MyBzdGF0ZS4gIEFueXdheSwgdGhpcyBwYXRjaCBkb2Vzbid0IGZpeCB0aGUgcm9vdCBjYXVzZSwg
YnV0DQptZXJlbHkgd29ya3MgYXJvdW5kIGl0Lg0KDQpTZXR0aW5nIHRoZSBOTyBTTEVFUCBiaXQg
d2lsbCBmb3JjZSB0aGUgdG91Y2ggc2Vuc29yIHRvIHJlbWFpbiBpbiBhDQpoaWdoIHBvd2VyIGNv
bnN1bXB0aW9uIHN0YXRlIHdoaWxlIHRoZSByZXN0IG9mIHRoZSBzeXN0ZW0gaXMgaW4gUzMuIA0K
V2hpbGUgbm90IGEgbG90IG9mIHBvd2VyIGNvbXBhcmVkIHRvIHRoaW5ncyBsaWtlIHRoZSBDUFUs
IGRpc3BsYXksIGFuZA0Kb3RoZXJzLCBpdCBpcyBzdGlsbCBub24tdHJpdmlhbCBhbmQgd2lsbCBy
ZXN1bHQgaW4gc2hvcnRlciB0aW1lLW9uLQ0KYmF0dGVyeSBjYXBhYmlsaXR5Lg0KDQpJZiB5b3Ug
aGF2ZSBhY2Nlc3MgdG8gdGhlIHBvd2VyIHBpbihzKSBmb3IgdGhlIHRvdWNoIHNlbnNvcihzKS9z
dHlrKHMpLA0KaXQgbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8gdHJ5IHR1cm5pbmcgcG93ZXIgb2Zm
IG9uIGVudGVyaW5nIFMzLCBhbmQNCnJlc3RvcmluZyBpdCBvbiBleGl0LiAgVGhhdCdzIHZlcnkg
aGFja3ksIGFuZCBoYXMgdGhlIHNpZGUgZWZmZWN0IG9mDQpzbGlnaHRseSBkZWxheWluZyB0b3Vj
aHBhZCByZWFkaW5lc3Mgb24gZXhpdCBmcm9tIFMzLiAgUGx1cyB5b3UnbGwgbmVlZA0KdG8gcmVz
dG9yZSB0b3VjaCBzZW5zb3IgY29uZmlndXJhdGlvbiBzZXR0aW5ncyBvbiBleGl0LiAgQnV0IGl0
DQpkZWZpbml0ZWx5IHJlZHVjZXMgcG93ZXIgY29uc3VtcHRpb24uDQoNCg0KU2VwYXJhdGVseSwg
SSBhbSBzdGlsbCBjb25jZXJuZWQgYWJvdXQgdGhlIHBvc3NpYmlsaXR5IG9mIGRyb3BwZWQgdG91
Y2gNCmV2ZW50cyBpbiB0aGUgSVJRIGNsZWFyaW5nLiAgSSdtIG5vdCBjb252aW5jZWQgdGhhdCB0
aGUgY29kZSBpcyBzYWZlDQooYXMgeW91IG1lbnRpb25lZCBpbiB5b3VyIHJlcGx5IHRvIG15IGVh
cmxpZXIgY29tbWVudCksIHNvIEknbGwgaGF2ZSB0bw0Kc3R1ZHkgdGhlIGltcGxlbWVudGF0aW9u
IG1vcmUgY2FyZWZ1bGx5Lg0KDQoJCQkJCUNoZWVycywNCgkJCQkJCUNocmlzDQoNCg0KDQo+IA0K
PiBUaGFua3MsDQo+IEFhcm9uDQoNCg0K
