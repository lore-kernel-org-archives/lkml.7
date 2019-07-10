Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EEC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE09B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfGJS3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:29:05 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:42463 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727242AbfGJS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:29:04 -0400
X-Greylist: delayed 1729 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 14:28:58 EDT
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.147) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Wed, 10 Jul 2019 18:28:48 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 10 Jul 2019 17:47:34 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 10 Jul 2019 17:47:34 +0000
Received: from BN6PR18MB1172.namprd18.prod.outlook.com (10.172.207.147) by
 BN6PR18MB1266.namprd18.prod.outlook.com (10.172.210.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 17:47:32 +0000
Received: from BN6PR18MB1172.namprd18.prod.outlook.com
 ([fe80::38f3:d27c:6480:d073]) by BN6PR18MB1172.namprd18.prod.outlook.com
 ([fe80::38f3:d27c:6480:d073%3]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 17:47:31 +0000
From:   Lee Duncan <LDuncan@suse.com>
To:     Yang Bin <yang.bin18@zte.com.cn>
CC:     "open-iscsi@googlegroups.com" <open-iscsi@googlegroups.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "cleech@redhat.com" <cleech@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "wang.liang82@zte.com.cn" <wang.liang82@zte.com.cn>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>
Subject: Re: [PATCH] Check sk before sendpage
Thread-Topic: [PATCH] Check sk before sendpage
Thread-Index: AQHVNvHttUE0icmf0Uic+RrHE7gyJ6bEISiA
Date:   Wed, 10 Jul 2019 17:47:31 +0000
Message-ID: <1bc364ff-5bff-47ac-611a-f75c43f4bd1b@suse.com>
References: <1562743809-31133-1-git-send-email-yang.bin18@zte.com.cn>
In-Reply-To: <1562743809-31133-1-git-send-email-yang.bin18@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR07CA0011.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::21) To BN6PR18MB1172.namprd18.prod.outlook.com
 (2603:10b6:404:eb::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=LDuncan@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [73.25.22.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 556321fc-1cb4-4059-7736-08d7055eaea7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR18MB1266;
x-ms-traffictypediagnostic: BN6PR18MB1266:
x-microsoft-antispam-prvs: <BN6PR18MB1266F6A8BC0BF729D3DB010DDAF00@BN6PR18MB1266.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(68736007)(8676002)(31686004)(316002)(6486002)(478600001)(14454004)(31696002)(186003)(5660300002)(36756003)(4326008)(6916009)(86362001)(25786009)(6436002)(6506007)(80792005)(66556008)(81166006)(26005)(7736002)(81156014)(486006)(2906002)(71200400001)(71190400001)(53546011)(229853002)(446003)(64756008)(76176011)(66946007)(386003)(99286004)(6116002)(54906003)(476003)(102836004)(6512007)(66476007)(6246003)(53936002)(11346002)(8936002)(2616005)(256004)(7416002)(4744005)(52116002)(66066001)(305945005)(66446008)(3846002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR18MB1266;H:BN6PR18MB1172.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LrqtibLnWL2tJF5btRWJ0Cw7rDxKCZNDs9c8kU/nRpW58exwVDexAD0PkRGRFNqDrIOIcgeCYDvVGZmzz8nIAlL/ss4TCCgjly0j4/B/z+Fj/qj/TjA+ocO1a7EuzRkIq9OGvR4xo00qykDorRRO0DxrMrjkcz5PpDCkMV9BL/YzPa3/6ujfqJ4WYkf290/2aRHj3qJcGDlZrDOC7W6x6/EutEsvBxGzDvbPtZn5VypuqJcUSgR5/cALGKn7ib+l5+SUGNzjl4PAIeOM1oLKgTK+VLY0Oy4sk4dt8McCDGcj8tGOld1rm5Jb5zx5/GbWPLvh34oJ1ctCouDPzR0jzl6176ZvEgc+BlfI6VZJBRBCZyb6QogKDvkOFbeQ9rgYb0R6bGI1fmWbjN9lT3ZbJkwgOpfNKLSsXxIAc+t+ccU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3B3AF6B642FCC40B3B4B1F936A8554A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 556321fc-1cb4-4059-7736-08d7055eaea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 17:47:31.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDuncan@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR18MB1266
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMC8xOSAxMjozMCBBTSwgWWFuZyBCaW4gd3JvdGU6DQoNCj4gRnJvbTogIiBZYW5nIEJp
biAiPHlhbmcuYmluMThAenRlLmNvbS5jbj4NCj4NCj4gQmVmb3JlIHhtaXQsaXNjc2kgbWF5IGRp
c2Nvbm5lY3QganVzdCBub3cuDQo+IFNvIG11c3QgY2hlY2sgY29ubmVjdGlvbiBzb2NrIE5VTEwg
b3Igbm90LG9yIGtlcm5lbCB3aWxsIGNyYXNoIGZvcg0KPiBhY2Nlc3NpbmcgTlVMTCBwb2ludGVy
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIEJpbiA8eWFuZy5iaW4xOEB6dGUuY29tLmNuPg0K
PiAtLS0NCj4gIGRyaXZlcnMvc2NzaS9pc2NzaV90Y3AuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvaXNj
c2lfdGNwLmMgYi9kcml2ZXJzL3Njc2kvaXNjc2lfdGNwLmMNCj4gaW5kZXggN2JlZGJlOC4uYTU5
YzQ5ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zY3NpL2lzY3NpX3RjcC5jDQo+ICsrKyBiL2Ry
aXZlcnMvc2NzaS9pc2NzaV90Y3AuYw0KPiBAQCAtMjY0LDYgKzI2NCw5IEBAIHN0YXRpYyBpbnQg
aXNjc2lfc3dfdGNwX3htaXRfc2VnbWVudChzdHJ1Y3QgaXNjc2lfdGNwX2Nvbm4gKnRjcF9jb25u
LA0KPiAgCXVuc2lnbmVkIGludCBjb3BpZWQgPSAwOw0KPiAgCWludCByID0gMDsNCj4gIA0KPiAr
CWlmICghc2spDQo+ICsJCXJldHVybiAtRU5PVENPTk47DQo+ICsNCj4gIAl3aGlsZSAoIWlzY3Np
X3RjcF9zZWdtZW50X2RvbmUodGNwX2Nvbm4sIHNlZ21lbnQsIDAsIHIpKSB7DQo+ICAJCXN0cnVj
dCBzY2F0dGVybGlzdCAqc2c7DQo+ICAJCXVuc2lnbmVkIGludCBvZmZzZXQsIGNvcHk7DQo+DQoN
CklmIHRoZSBzb2NrZXQgY2FuIGJlIGNsb3NlZCByaWdodCBiZWZvcmUgaXNjc2lfc3dfdGNwX3ht
aXRfc2VnbWVudCgpIGlzDQpjYWxsZWQsIGNhbiBpdCBiZSBjYWxsZWQgaW4gdGhlIG1pZGRsZSBv
ZiBzZW5kaW5nIHNlZ21lbnRzPyAoSW4gd2hpY2gNCmNhc2UgdGhlIGNoZWNrIHdvdWxkIGhhdmUg
dG8gYmUgaW4gdGhlIHdoaWxlIGxvb3AuKQ0KDQotLSANCg0KTGVlIER1bmNhbg0KDQo=
