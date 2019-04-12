Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA95C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A802084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YWCXnyT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDLNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:47:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3477 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDLNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:47:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb096ed0000>; Fri, 12 Apr 2019 06:47:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Apr 2019 06:47:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Apr 2019 06:47:42 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 13:47:42 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 12 Apr 2019 13:47:42 +0000
Received: from SN6PR12MB2832.namprd12.prod.outlook.com (20.177.251.139) by
 SN6PR12MB2798.namprd12.prod.outlook.com (52.135.107.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Fri, 12 Apr 2019 13:47:41 +0000
Received: from SN6PR12MB2832.namprd12.prod.outlook.com
 ([fe80::79aa:15cb:b695:a566]) by SN6PR12MB2832.namprd12.prod.outlook.com
 ([fe80::79aa:15cb:b695:a566%5]) with mapi id 15.20.1771.019; Fri, 12 Apr 2019
 13:47:41 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "paul.kocialkowski@bootlin.com" <paul.kocialkowski@bootlin.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "keiichiw@chromium.org" <keiichiw@chromium.org>,
        Bibek Basu <bbasu@nvidia.com>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch V2] v4l2-core: fix use-after-free error
Thread-Topic: [Patch V2] v4l2-core: fix use-after-free error
Thread-Index: AQHU8H/SZDJCniZ62k+fyuUrtflr/6Y4Y1iAgAAlEFA=
Date:   Fri, 12 Apr 2019 13:47:40 +0000
Message-ID: <SN6PR12MB2832D36A4D06668F30DABD12B9280@SN6PR12MB2832.namprd12.prod.outlook.com>
References: <1554998478-30349-1-git-send-email-sumitg@nvidia.com>
 <b4519134-3053-f80a-ac03-3301abd9e63a@xs4all.nl>
In-Reply-To: <b4519134-3053-f80a-ac03-3301abd9e63a@xs4all.nl>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=sumitg@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-04-12T13:47:37.2619342Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic;
 Sensitivity=Unrestricted
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sumitg@nvidia.com; 
x-originating-ip: [121.244.166.165]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a119d93c-9c08-4e67-4fc4-08d6bf4d6eb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:SN6PR12MB2798;
x-ms-traffictypediagnostic: SN6PR12MB2798:
x-microsoft-antispam-prvs: <SN6PR12MB2798EBD0F626F4AEB57DA850B9280@SN6PR12MB2798.namprd12.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(26005)(86362001)(68736007)(14444005)(105586002)(6436002)(8936002)(71190400001)(478600001)(11346002)(99286004)(71200400001)(14454004)(305945005)(53936002)(476003)(2501003)(446003)(486006)(256004)(66066001)(4326008)(229853002)(97736004)(52536014)(74316002)(6506007)(3846002)(6636002)(8676002)(186003)(102836004)(81156014)(2906002)(25786009)(106356001)(9686003)(6246003)(110136005)(2201001)(316002)(5660300002)(81166006)(7696005)(76176011)(33656002)(54906003)(7736002)(55016002)(6116002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2798;H:SN6PR12MB2832.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4AiLIz1MWaRZZep0xbTYBExH7xuFe3fJwthmy/ykr9hBsoTylrE+yk0zEy7gOPra23ZwGXHHaj8VGRqQHYRpMCM9VF3A+rAJHpxQ0r42AYAuCclmt3+KriryAg0NGguByvfTwG5fwbXUIyD8/CCJgnGv3qR2SdgZPK/EuIR3TlbNrcuHe46ao1gQ5fE6d4n1APj1W6EZp0BVc9lV/+GCaUvNgIqqyrGtu86Eua3od8C0tY0aiEpT2i094CxIpnMHj63ujEwIPs0XOMLBEHjh/8712At5T4v+fveNL3UbZyYm4uE0ep0bBwtMUeJQ4pHIM0rT701Pwgsc6jAK8f3xOycwswHAji+SOzoGQ+dqcH5qVQ+9GorSksbGi21t19c3Ql+MriZM77g9Zd205dHEJoBuOYqIxPkWRP0X6Q5Y5xY=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a119d93c-9c08-4e67-4fc4-08d6bf4d6eb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 13:47:40.9137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555076846; bh=TVpxdfsNlP3mc3V5mVU5FtMA/mdAzU+b3a1nd182VEo=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=YWCXnyT3lL0VwSNWvgtHmKNi12HxNgw5bQ/cM+2dAaiEVUHed6hMhaLEuoG1phiMr
         KddybICi9O6Jij2ncH2p9wpnd//1JGrRUG8gwkLyOTYkOx9i+USiKUCgjkP+2rICrM
         rRkWMCHUTA5Q6Cq0jjZrbdabCJUltVSZU2EkmY+g6LALXzbBmsvzyfKJ8XDxvrWRSs
         RX3683ydbn7I+IAwDFMN7XR3EobbCIezf30URupHQDm8ds66oKar+uSfMly9ZAFOtD
         md02qjaybg4ju+0NFp9lwjIz5qwuNiVVaNPTgc8GYtIc6ezK6jdK7bMSzAu4WVftPE
         1rg+0dEJF1sNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzExLzE5IDY6MDEgUE0sIFN1bWl0IEd1cHRhIHdyb3RlOg0KPiBGcm9tOiBzdW1pdGcg
PHN1bWl0Z0BudmlkaWEuY29tPg0KPiANCj4gRml4aW5nIHVzZS1hZnRlci1mcmVlIHdpdGhpbiBf
X3Y0bDJfY3RybF9oYW5kbGVyX3NldHVwKCkuDQo+IE1lbW9yeSBpcyBiZWluZyBmcmVlZCB3aXRo
IGtmcmVlKG5ld19yZWYpIGZvciBkdXBsaWNhdGUgY29udHJvbCANCj4gcmVmZXJlbmNlIGVudHJ5
IGJ1dCBjbHVzdGVyIGlzIHN0aWxsIHJlZmVycmluZyB0byB0aGUgZHVwbGljYXRlIGVudHJ5LiAN
Cj4gQ2hhbmdlIGRvbmUgdG8gdXBkYXRlIGN0cmwtPmNsdXN0ZXIgb25seSB3aGVuIG5ldyBjb250
cm9sIHJlZmVyZW5jZSBpcyANCj4gYWRkZWQuIEFsc28sIGNoZWNraW5nIGlmDQo+IGN0cmwtPm5j
b250cm9scyBpcyBub24temVybyBiZWZvcmUgYWNjZXNzaW5nIGNvbnRyb2xzIGZyb20NCj4gY2x1
c3RlciBwb2ludGVyIHRvIGF2b2lkIGlsbGVnYWwgYWNjZXNzIHdoZW4gY2x1c3RlciBoYXMgemVy
byANCj4gY29udHJvbHMuDQo+IA0KPiAgPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ICBCVUc6IEtBU0FOOiB1c2UtYWZ0
ZXItZnJlZSBpbiBfX3Y0bDJfY3RybF9oYW5kbGVyX3NldHVwKzB4Mzg4LzB4NDI4DQo+ICBSZWFk
IG9mIHNpemUgOCBhdCBhZGRyIGZmZmZmZmMzMjRlNzg2MTggYnkgdGFzayBzeXN0ZW1kLXVkZXZk
LzMxMg0KPiANCj4gIEFsbG9jYXRlZCBieSB0YXNrIDMxMjoNCj4gDQo+ICBGcmVlZCBieSB0YXNr
IDMxMjoNCj4gDQo+ICBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQg
ZmZmZmZmYzMyNGU3ODYwMA0KPiAgIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNhY2hlIGttYWxsb2Mt
NjQgb2Ygc2l6ZSA2NCAgVGhlIGJ1Z2d5IGFkZHJlc3MgDQo+IGlzIGxvY2F0ZWQgMjQgYnl0ZXMg
aW5zaWRlIG9mDQo+ICAgNjQtYnl0ZSByZWdpb24gW2ZmZmZmZmMzMjRlNzg2MDAsIGZmZmZmZmMz
MjRlNzg2NDApICBUaGUgYnVnZ3kgDQo+IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgcGFnZToNCj4g
IHBhZ2U6ZmZmZmZmYmYwYzkzOWUwMCBjb3VudDoxIG1hcGNvdW50OjAgbWFwcGluZzoNCj4gCQkJ
CQkobnVsbCkgaW5kZXg6MHhmZmZmZmZjMzI0ZTc4ZjgwDQo+ICBmbGFnczogMHg0MDAwMDAwMDAw
MDAwMTAwKHNsYWIpDQo+ICByYXc6IDQwMDAwMDAwMDAwMDAxMDAgMDAwMDAwMDAwMDAwMDAwMCBm
ZmZmZmZjMzI0ZTc4ZjgwIA0KPiAwMDAwMDAwMTgwMjAwMDFhDQo+ICByYXc6IDAwMDAwMDAwMDAw
MDAwMDAgMDAwMDAwMDEwMDAwMDAwMSBmZmZmZmZjMzcwNDBmYjgwIA0KPiAwMDAwMDAwMDAwMDAw
MDAwICBwYWdlIGR1bXBlZCBiZWNhdXNlOiBrYXNhbjogYmFkIGFjY2VzcyBkZXRlY3RlZA0KPiAN
Cj4gIE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJlc3M6DQo+ICAgZmZmZmZmYzMy
NGU3ODUwMDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMN
Cj4gICBmZmZmZmZjMzI0ZTc4NTgwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYyBmYyBmYyBm
YyBmYyBmYyBmYyBmYw0KPiAgPmZmZmZmZmMzMjRlNzg2MDA6IGZiIGZiIGZiIGZiIGZiIGZiIGZi
IGZiIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXg0KPiAgIGZmZmZmZmMzMjRlNzg2ODA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIGZjIGZj
IGZjIGZjIGZjIGZjIGZjIGZjDQo+ICAgZmZmZmZmYzMyNGU3ODcwMDogMDAgMDAgMDAgMDAgMDAg
ZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgIA0KPiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gDQo+IFN1
Z2dlc3RlZC1ieTogSGFucyBWZXJrdWlsIDxodmVya3VpbC1jaXNjb0B4czRhbGwubmw+DQo+IFNp
Z25lZC1vZmYtYnk6IFN1bWl0IEd1cHRhIDxzdW1pdGdAbnZpZGlhLmNvbT4NCj4gLS0tDQo+IHYy
Og0KPiAqIHVwZGF0ZSBjdHJsLT5jbHVzdGVyIG9ubHkgd2hlbiBuZXcgY29udHJvbCByZWZlcmVu
Y2UgaXMgYWRkZWQuDQo+ICogY2hlY2sgY3RybC0+bmNvbnRyb2xzIHRvIGF2b2lkIGlsbGVnYWwg
YWNjZXNzIHdoZW4gY2x1c3RlciBoYXMgemVybyBjb250cm9scy4NCj4gDQo+ICBkcml2ZXJzL21l
ZGlhL3Y0bDItY29yZS92NGwyLWN0cmxzLmMgfCA1MyANCj4gKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMjUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUv
djRsMi1jdHJscy5jIA0KPiBiL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY3RybHMuYw0K
PiBpbmRleCA1ZTM4MDZmLi4zZDBhOTUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21lZGlhL3Y0
bDItY29yZS92NGwyLWN0cmxzLmMNCj4gKysrIGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRs
Mi1jdHJscy5jDQo+IEBAIC0yMTU0LDE1ICsyMTU0LDYgQEAgc3RhdGljIGludCBoYW5kbGVyX25l
d19yZWYoc3RydWN0IHY0bDJfY3RybF9oYW5kbGVyICpoZGwsDQo+ICAJaWYgKHNpemVfZXh0cmFf
cmVxKQ0KPiAgCQluZXdfcmVmLT5wX3JlcS5wID0gJm5ld19yZWZbMV07DQo+ICANCj4gLQlpZiAo
Y3RybC0+aGFuZGxlciA9PSBoZGwpIHsNCj4gLQkJLyogQnkgZGVmYXVsdCBlYWNoIGNvbnRyb2wg
c3RhcnRzIGluIGEgY2x1c3RlciBvZiBpdHMgb3duLg0KPiAtCQkgICBuZXdfcmVmLT5jdHJsIGlz
IGJhc2ljYWxseSBhIGNsdXN0ZXIgYXJyYXkgd2l0aCBvbmUNCj4gLQkJICAgZWxlbWVudCwgc28g
dGhhdCdzIHBlcmZlY3QgdG8gdXNlIGFzIHRoZSBjbHVzdGVyIHBvaW50ZXIuDQo+IC0JCSAgIEJ1
dCBvbmx5IGRvIHRoaXMgZm9yIHRoZSBoYW5kbGVyIHRoYXQgb3ducyB0aGUgY29udHJvbC4gKi8N
Cj4gLQkJY3RybC0+Y2x1c3RlciA9ICZuZXdfcmVmLT5jdHJsOw0KPiAtCQljdHJsLT5uY29udHJv
bHMgPSAxOw0KPiAtCX0NCj4gLQ0KPiAgCUlOSVRfTElTVF9IRUFEKCZuZXdfcmVmLT5ub2RlKTsN
Cj4gIA0KPiAgCW11dGV4X2xvY2soaGRsLT5sb2NrKTsNCj4gQEAgLTIxOTUsNiArMjE4NiwxNSBA
QCBzdGF0aWMgaW50IGhhbmRsZXJfbmV3X3JlZihzdHJ1Y3QgdjRsMl9jdHJsX2hhbmRsZXIgKmhk
bCwNCj4gIAloZGwtPmJ1Y2tldHNbYnVja2V0XSA9IG5ld19yZWY7DQo+ICAJaWYgKGN0cmxfcmVm
KQ0KPiAgCQkqY3RybF9yZWYgPSBuZXdfcmVmOw0KPiArCWlmIChjdHJsLT5oYW5kbGVyID09IGhk
bCkgew0KPiArCQkvKiBCeSBkZWZhdWx0IGVhY2ggY29udHJvbCBzdGFydHMgaW4gYSBjbHVzdGVy
IG9mIGl0cyBvd24uDQo+ICsJCSAqIG5ld19yZWYtPmN0cmwgaXMgYmFzaWNhbGx5IGEgY2x1c3Rl
ciBhcnJheSB3aXRoIG9uZQ0KPiArCQkgKiBlbGVtZW50LCBzbyB0aGF0J3MgcGVyZmVjdCB0byB1
c2UgYXMgdGhlIGNsdXN0ZXIgcG9pbnRlci4NCj4gKwkJICogQnV0IG9ubHkgZG8gdGhpcyBmb3Ig
dGhlIGhhbmRsZXIgdGhhdCBvd25zIHRoZSBjb250cm9sLg0KPiArCQkgKi8NCj4gKwkJY3RybC0+
Y2x1c3RlciA9ICZuZXdfcmVmLT5jdHJsOw0KPiArCQljdHJsLT5uY29udHJvbHMgPSAxOw0KPiAr
CX0NCj4gIA0KPiAgdW5sb2NrOg0KPiAgCW11dGV4X3VubG9jayhoZGwtPmxvY2spOw0KDQpUaGlz
IGxvb2tzIGdvb2QuDQoNCj4gQEAgLTI3MjUsMjUgKzI3MjUsMjggQEAgaW50IF9fdjRsMl9jdHJs
X2hhbmRsZXJfc2V0dXAoc3RydWN0IHY0bDJfY3RybF9oYW5kbGVyICpoZGwpDQo+ICAJCWN0cmwt
PmRvbmUgPSBmYWxzZTsNCj4gIA0KPiAgCWxpc3RfZm9yX2VhY2hfZW50cnkoY3RybCwgJmhkbC0+
Y3RybHMsIG5vZGUpIHsNCj4gLQkJc3RydWN0IHY0bDJfY3RybCAqbWFzdGVyID0gY3RybC0+Y2x1
c3RlclswXTsNCj4gLQkJaW50IGk7DQo+IC0NCj4gLQkJLyogU2tpcCBpZiB0aGlzIGNvbnRyb2wg
d2FzIGFscmVhZHkgaGFuZGxlZCBieSBhIGNsdXN0ZXIuICovDQo+IC0JCS8qIFNraXAgYnV0dG9u
IGNvbnRyb2xzIGFuZCByZWFkLW9ubHkgY29udHJvbHMuICovDQo+IC0JCWlmIChjdHJsLT5kb25l
IHx8IGN0cmwtPnR5cGUgPT0gVjRMMl9DVFJMX1RZUEVfQlVUVE9OIHx8DQo+IC0JCSAgICAoY3Ry
bC0+ZmxhZ3MgJiBWNEwyX0NUUkxfRkxBR19SRUFEX09OTFkpKQ0KPiAtCQkJY29udGludWU7DQo+
ICsJCWlmIChjdHJsLT5uY29udHJvbHMpIHsNCj4gKwkJCXN0cnVjdCB2NGwyX2N0cmwgKm1hc3Rl
ciA9IGN0cmwtPmNsdXN0ZXJbMF07DQo+ICsJCQlpbnQgaTsNCj4gKw0KPiArCQkJLyogU2tpcCBp
ZiB0aGlzIGNvbnRyb2wgd2FzIGFscmVhZHkgaGFuZGxlZCBieSBhICovDQo+ICsJCQkvKiBjbHVz
dGVyLiBTa2lwIGJ1dHRvbiBjb250cm9scyBhbmQgcmVhZC1vbmx5ICovDQo+ICsJCQkvKiBjb250
cm9scy4gKi8NCj4gKwkJCWlmIChjdHJsLT5kb25lIHx8IGN0cmwtPnR5cGUgPT0gVjRMMl9DVFJM
X1RZUEVfQlVUVE9OIHx8DQo+ICsJCQkJKGN0cmwtPmZsYWdzICYgVjRMMl9DVFJMX0ZMQUdfUkVB
RF9PTkxZKSkNCj4gKwkJCQljb250aW51ZTsNCj4gIA0KPiAtCQlmb3IgKGkgPSAwOyBpIDwgbWFz
dGVyLT5uY29udHJvbHM7IGkrKykgew0KPiAtCQkJaWYgKG1hc3Rlci0+Y2x1c3RlcltpXSkgew0K
PiAtCQkJCWN1cl90b19uZXcobWFzdGVyLT5jbHVzdGVyW2ldKTsNCj4gLQkJCQltYXN0ZXItPmNs
dXN0ZXJbaV0tPmlzX25ldyA9IDE7DQo+IC0JCQkJbWFzdGVyLT5jbHVzdGVyW2ldLT5kb25lID0g
dHJ1ZTsNCj4gKwkJCWZvciAoaSA9IDA7IGkgPCBtYXN0ZXItPm5jb250cm9sczsgaSsrKSB7DQo+
ICsJCQkJaWYgKG1hc3Rlci0+Y2x1c3RlcltpXSkgew0KPiArCQkJCQljdXJfdG9fbmV3KG1hc3Rl
ci0+Y2x1c3RlcltpXSk7DQo+ICsJCQkJCW1hc3Rlci0+Y2x1c3RlcltpXS0+aXNfbmV3ID0gMTsN
Cj4gKwkJCQkJbWFzdGVyLT5jbHVzdGVyW2ldLT5kb25lID0gdHJ1ZTsNCj4gKwkJCQl9DQo+ICAJ
CQl9DQo+ICsJCQlyZXQgPSBjYWxsX29wKG1hc3Rlciwgc19jdHJsKTsNCj4gKwkJCWlmIChyZXQp
DQo+ICsJCQkJYnJlYWs7DQo+ICAJCX0NCj4gLQkJcmV0ID0gY2FsbF9vcChtYXN0ZXIsIHNfY3Ry
bCk7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlicmVhazsNCj4gIAl9DQo+ICANCj4gIAlyZXR1cm4g
cmV0Ow0KPiANCg0KVGhlc2UgY2hhbmdlcyBzaG91bGRuJ3QgYmUgbmVlZGVkOiB3aGVuIHlvdSBn
ZXQgaGVyZSBhbGwgY29udHJvbHMgYXJlIGd1YXJhbnRlZWQgdG8gaGF2ZSBhIG5vbi0wIG5jb250
cm9scyB2YWx1ZS4NCg0KSWYgaXQgaXMgcG9zc2libGUgdG8gZW5jb3VudGVyIGEgY29udHJvbCB3
aGVyZSBuY29udHJvbHMgPT0gMCwgdGhlbiB0aGF0J3MgYSBidWcgZWxzZXdoZXJlLiBCdXQgYXMg
ZmFyIGFzIEkgY2FuIHRlbGwgdGhhdCBpc24ndCB0aGUgY2FzZS4NCg0KUmVnYXJkcywNCg0KCUhh
bnMNCg0KWWVzLCBJIGFtIGdldHRpbmcgYSBjb250cm9sIHdoZXJlIG5jb250cm9scyBpcyB6ZXJv
IGFzIHByaW50ZWQgYmVsb3cuDQpJdCBjYW4gYmUgYW5vdGhlciBidWcgYXMgeW91IHNhaWQuIEkg
dGhpbmssIGFkZGluZyBjaGVjayBoZXJlIHdpbGwgYmUNCmhlbHBmdWwgdG8gbm90IGNyYXNoIGlu
IHN1Y2ggY2FzZXMuIFBsZWFzZSBzaGFyZSBpZiB5b3UgdGhpbmsgb3RoZXJ3aXNlLA0KdGhlbiB3
aWxsIHJlbW92ZSB0aGUgY2hlY2suDQoNCiAgaW50IF9fdjRsMl9jdHJsX2hhbmRsZXJfc2V0dXAo
c3RydWN0IHY0bDJfY3RybF9oYW5kbGVyICpoZGwpDQogICAgICAgICAgICAgICAgICBjdHJsLT5k
b25lID0gZmFsc2U7DQogDQogICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShjdHJsLCAmaGRs
LT5jdHJscywgbm9kZSkgew0KICArICAgICAgICAgICAgICAgaWYgKGN0cmwtPm5jb250cm9scyA9
PSAwKQ0KICArICAgICAgICAgICAgICAgICAgICAgICBwcl9jcml0KCI8ZnVuYzolcz48Y3RybC0+
bmFtZTolcz48Y3RybC0+bmNvbnRyb2xzOiVkPlxuIiwNCiAgKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBjdHJsLT5uYW1lLCBjdHJsLT5uY29udHJvbHMp
Ow0KDQpMb2c6DQogIFsgICAgOC4zNTQ0NjRdIDxmdW5jOl9fdjRsMl9jdHJsX2hhbmRsZXJfc2V0
dXA+PGN0cmwtPm5hbWU6R3JvdXAgSG9sZD48Y3RybC0+bmNvbnRyb2xzOjA+DQoNCg0KUmVnYXJk
cywNClN1bWl0IEd1cHRhDQoNCg==
