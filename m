Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E54FC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B627206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="GCHI+aRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDDQRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:17:03 -0400
Received: from mail-eopbgr770053.outbound.protection.outlook.com ([40.107.77.53]:51214
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726888AbfDDQRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EymxYHaPeDUTlBmeSEpaYNBSRYwM8425vz9VnIsMfuo=;
 b=GCHI+aRl3Q4f+TM+3Np06qlfofZgFav7BOrCaP28zrsKeoZmJvmtfguNBGOim6ZVX6aaLJCkte/H//yYC9JvPY+4QpBRtppuRS4LDz8DEaiITAdPlvJgEmrep6fLVNkGS1oY+LWdN/nIMuC4RUtTIap4gXP31jvmhaU6quJJCTM=
Received: from MWHPR0501MB3772.namprd05.prod.outlook.com (10.167.163.156) by
 MWHPR0501MB3772.namprd05.prod.outlook.com (10.167.163.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.6; Thu, 4 Apr 2019 16:16:58 +0000
Received: from MWHPR0501MB3772.namprd05.prod.outlook.com
 ([fe80::b9a6:ba16:fc53:bb41]) by MWHPR0501MB3772.namprd05.prod.outlook.com
 ([fe80::b9a6:ba16:fc53:bb41%5]) with mapi id 15.20.1771.007; Thu, 4 Apr 2019
 16:16:57 +0000
From:   Slavomir Kaslev <kaslevs@vmware.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 5.0 047/246] fs: Make splice() and tee() take into account
 O_NONBLOCK flag on pipes
Thread-Topic: [PATCH 5.0 047/246] fs: Make splice() and tee() take into
 account O_NONBLOCK flag on pipes
Thread-Index: AQHU6sY2Pn205P5KREilSENlZa0YQqYsLhWA
Date:   Thu, 4 Apr 2019 16:16:57 +0000
Message-ID: <3fa8b886ccb1ea2229344091be9ac769021f69a4.camel@vmware.com>
References: <20190404084619.236418459@linuxfoundation.org>
         <20190404084620.671108728@linuxfoundation.org>
In-Reply-To: <20190404084620.671108728@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kaslevs@vmware.com; 
x-originating-ip: [213.145.108.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d79d41e1-fea3-4ac6-1f64-08d6b918f622
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR0501MB3772;
x-ms-traffictypediagnostic: MWHPR0501MB3772:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR0501MB37723E4E69E9D7952DC3FC4CDA500@MWHPR0501MB3772.namprd05.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(5660300002)(2906002)(86362001)(76176011)(14454004)(105586002)(106356001)(6512007)(36756003)(4326008)(6306002)(71190400001)(71200400001)(25786009)(6506007)(6246003)(99286004)(68736007)(102836004)(8936002)(66066001)(53936002)(7736002)(305945005)(486006)(478600001)(26005)(256004)(11346002)(476003)(2501003)(446003)(966005)(2616005)(8676002)(229853002)(110136005)(81166006)(54906003)(118296001)(81156014)(6436002)(6116002)(186003)(316002)(3846002)(6486002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0501MB3772;H:MWHPR0501MB3772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PlKbPsI1pnpav5Aprig+b7BNM7gbzGtB6FxyqrCO0q1wJA8FXy4avLM4jogEzuyqkaMzV/3Vl1VGRPY6NBj/LDQvYKz7E0bhVTYwh4L8uElH6Bc7zYBk3OF3hPJXpsvAdNbPEypUBarV5KOM+F7tOkSK49UpfDhh8i/H0rJFXG7PUMdItxXpMtP2w3w++BDeemK96XFQ08xehputQX9kUYiiyFQc2p81KvM5SiI668iVgWlilJLgXZw9dU4YTSC0nH930E59PfjXf40reJKUhXl27mTPu5Rs932ePrjvFBor2KyfpvtU46CM3zEgqCMWUnQPdJQxvhMna0IWmr1aHGWcmqRC+H1gRoHxxTb217VenZCRTKRmyJkTP7BIEFc6Hw9dU9VTDdPD3MOsjT12RTricfd7zbE/u0XSSx/Baw0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F2D8C722AD3A5449E6415395A804657@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79d41e1-fea3-4ac6-1f64-08d6b918f622
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 16:16:57.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0501MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA0LTA0IGF0IDEwOjQ1ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IDUuMC1zdGFibGUgcmV2aWV3IHBhdGNoLiAgSWYgYW55b25lIGhhcyBhbnkgb2JqZWN0
aW9ucywgcGxlYXNlIGxldCBtZQ0KPiBrbm93Lg0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tDQo+
IA0KPiBbIFVwc3RyZWFtIGNvbW1pdCBlZTVlMDAxMTk2ZDEzNDViOGZlZTI1OTI1ZmY1ZjFkNjc5
MzYwODFlIF0NCj4gDQo+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHNwbGljZSgpIGFu
ZCB0ZWUoKSBpZ25vcmVzIE9fTk9OQkxPQ0sNCj4gc2V0DQo+IG9uIHBpcGUgZmlsZSBkZXNjcmlw
dG9ycyBhbmQgY2hlY2tzIG9ubHkgdGhlIFNQTElDRV9GX05PTkJMT0NLIGZsYWcNCj4gZm9yDQo+
IGJsb2NraW5nIG9uIHBpcGUgYXJndW1lbnRzLiAgVGhpcyBpcyBpbmNvbnNpc3RlbnQgc2luY2Ug
c3BsaWNlKCktaW5nDQo+IGZyb20vdG8gbm9uLXBpcGUgZmlsZSBkZXNjcmlwdG9ycyBkb2VzIHRh
a2UgT19OT05CTE9DSyBpbnRvDQo+IGNvbnNpZGVyYXRpb24uDQo+IA0KPiBGaXggdGhpcyBieSBw
cm9tb3RpbmcgT19OT05CTE9DSywgd2hlbiBzZXQgb24gYSBwaXBlLCB0bw0KPiBTUExJQ0VfRl9O
T05CTE9DSy4NCg0KWy4uLl0NCg0KPiBUaGlzIGNoYW5nZSBkb2VzIGhhdmUgcG90ZW50aWFsIG9m
IGJyZWFraW5nIHVzZXJzIHdobyBkb24ndCBleHBlY3QNCj4gRUFHQUlOIGZyb20gc3BsaWNlKCkg
d2hlbiBTUExJQ0VfRl9OT05CTE9DSyBpcyBub3Qgc2V0LiAgT1RPSA0KPiBwcm9ncmFtcw0KPiB0
aGF0IHNldCBPX05PTkJMT0NLIGFuZCBkb24ndCBhbnRpY2lwYXRlIEVBR0FJTiBhcmUgYXJndWFi
bHkNCj4gYnVnZ3lbMl0uDQoNCkhpIEdyZWcsDQoNCkNhbiB5b3UgZHJvcCB0aGlzIG9uZSBmcm9t
IHRoZSBzdGFibGUgcXVldWVzPyBXZSBkaXNjdXNzZWQgaXQgd2l0aA0KU2FzaGFbMV0gYWxyZWFk
eSBpbiB0aGUgYXV0b3NlbCBwYXRjaGVzIHRocmVhZC4NCg0KWzFdIGh0dHBzOi8vbGttbC5vcmcv
bGttbC8yMDE5LzQvMy84MTENCg0KLS0gU2xhdmkNCg==
