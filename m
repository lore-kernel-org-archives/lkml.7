Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA40C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04662175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="khYLCWZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfEWOpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:45:17 -0400
Received: from mail-eopbgr750089.outbound.protection.outlook.com ([40.107.75.89]:41087
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730782AbfEWOpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpHLKOEdVlPj+NQ3TNHxcauYJcMH2k9HEHQs413Xc08=;
 b=khYLCWZ7KurjlubHoGudxf9cMusOUUtKftaGen70EUA56bm8Iqs3A2zzmUGs4GxbBmY1i4tVGjH/1urIxlbXzga2G/ADZlyIl/ua5yUcHsQ0xf2j0qfAd3/IDdFhpbE5I6ZL/TzuvgdIIDQtY4FBSUJmb6zCXuN0GvC7z3hJcrM=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2809.namprd12.prod.outlook.com (20.176.117.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 23 May 2019 14:45:12 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 14:45:12 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Lianbo Jiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "don.brace@microsemi.com" <don.brace@microsemi.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "esc.storagedev@microsemi.com" <esc.storagedev@microsemi.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Subject: Re: [PATCH] scsi: smartpqi: properly set both the DMA mask and the
 coherent DMA mask in pqi_pci_init()
Thread-Topic: [PATCH] scsi: smartpqi: properly set both the DMA mask and the
 coherent DMA mask in pqi_pci_init()
Thread-Index: AQHVESu1VkC12Yqcb0iDmGzQpM2cbaZ4yeYA
Date:   Thu, 23 May 2019 14:45:12 +0000
Message-ID: <c5d45523-43f5-d2fd-01ac-85f285146ecd@amd.com>
References: <20190523055212.23568-1-lijiang@redhat.com>
In-Reply-To: <20190523055212.23568-1-lijiang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0031.namprd05.prod.outlook.com
 (2603:10b6:803:40::44) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adc336ea-c483-48e8-19e7-08d6df8d42cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2809;
x-ms-traffictypediagnostic: DM6PR12MB2809:
x-microsoft-antispam-prvs: <DM6PR12MB28094DB59D99539657D8AA0BEC010@DM6PR12MB2809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(6486002)(305945005)(53546011)(26005)(6246003)(110136005)(478600001)(31686004)(229853002)(102836004)(2906002)(99286004)(76176011)(81156014)(81166006)(2501003)(256004)(52116002)(66066001)(7736002)(72206003)(6116002)(68736007)(71190400001)(6512007)(14444005)(6436002)(14454004)(386003)(6506007)(3846002)(11346002)(446003)(71200400001)(8676002)(53936002)(2616005)(5660300002)(476003)(86362001)(316002)(31696002)(66556008)(64756008)(66446008)(66476007)(486006)(66946007)(73956011)(25786009)(54906003)(186003)(36756003)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2809;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: awvSOTsTzsOAHCVj58Ua3XZrz3HgVjMLkTjLGK0/lzxrBPoNFe2pGgYkQoTWuoo/xF2GK2tIAsQj2oKR7ugw7/X2N9ukBYNeXYYE5ItPVfeqAshI1xPIlJTF3Lo3A5RyzpsCVcYiScX7oeIfYz1Ss04GG7XWU04OLs/Uar/JJur5IqWEweZ6r2+S1UGu/23xQ/+sOBEJOstWO8GBUvkAKSXd60xHtilCS3cCl7Ks/d7a5EekirBVVfROmHu01lcPHLNSdrK625ejKpxCrrZURBnKndS5G8M2kfc5pfDpY9xnaOM0lgkl5S9ogeammB4rY0LDM7Ubk7MgSSLUWrPxB9KjaLB0V4S5M9rkRfqcuGYTgTb8MysZ/VwzZy8Y9sfOy7Z4E8sbLB2vtMwX/N5UpjjtANFEOIbZ/6mS0EFf08E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BA16298E5669743908BA574047E8C3B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc336ea-c483-48e8-19e7-08d6df8d42cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 14:45:12.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yMy8xOSAxMjo1MiBBTSwgTGlhbmJvIEppYW5nIHdyb3RlOg0KPiBXaGVuIFNNRSBpcyBl
bmFibGVkLCB0aGUgc21hcnRwcWkgZHJpdmVyIHdvbid0IHdvcmsgb24gdGhlIEhQIERMMzg1DQo+
IEcxMCBtYWNoaW5lLCB3aGljaCBjYXVzZXMgdGhlIGZhaWx1cmUgb2Yga2VybmVsIGJvb3QgYmVj
YXVzZSBpdCBmYWlscw0KPiB0byBhbGxvY2F0ZSBwcWkgZXJyb3IgYnVmZmVyLiBQbGVhc2UgcmVm
ZXIgdG8gdGhlIGtlcm5lbCBsb2c6DQo+IC4uLi4NCj4gWyAgICA5LjQzMTc0OV0gdXNiY29yZTog
cmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1YXMNCj4gWyAgICA5LjQ0MTUyNF0gTWlj
cm9zZW1pIFBRSSBEcml2ZXIgKHYxLjEuNC0xMzApDQo+IFsgICAgOS40NDI5NTZdIGk0MGUgMDAw
MDowNDowMC4wOiBmdyA2LjcwLjQ4NzY4IGFwaSAxLjcgbnZtIDEwLjIuNQ0KPiBbICAgIDkuNDQ3
MjM3XSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6IE1pY3Jvc2VtaSBTbWFydCBGYW1pbHkgQ29udHJv
bGxlciBmb3VuZA0KPiAgICAgICAgICBTdGFydGluZyBkcmFjdXQgaW5pdHF1ZXVlIGhvb2suLi4N
Cj4gWyAgT0sgIF0gU3RhcnRlZCBTaG93IFBseW1vdXRoIEJvb3QgU2NyZVsgICAgOS40NzE2NTRd
IEJyb2FkY29tIE5ldFh0cmVtZS1DL0UgZHJpdmVyIGJueHRfZW4gdjEuOS4xDQo+IGVuLg0KPiBb
ICBPSyAgXSBTdGFydGVkIEZvcndhcmQgUGFzc3dvcmQgUmVxdWVzdHMgdG8gUGx5bW91dGggRGly
ZWN0b3J5IFdhdGNoLg0KPiBbWzA7WyAgICA5LjQ4NzEwOF0gc21hcnRwcWkgMDAwMDoyMzowMC4w
OiBmYWlsZWQgdG8gYWxsb2NhdGUgUFFJIGVycm9yIGJ1ZmZlcg0KPiAuLi4uDQo+IFsgIDEzOS4w
NTA1NDRdIGRyYWN1dC1pbml0cXVldWVbOTQ5XTogV2FybmluZzogZHJhY3V0LWluaXRxdWV1ZSB0
aW1lb3V0IC0gc3RhcnRpbmcgdGltZW91dCBzY3JpcHRzDQo+IFsgIDEzOS41ODk3NzldIGRyYWN1
dC1pbml0cXVldWVbOTQ5XTogV2FybmluZzogZHJhY3V0LWluaXRxdWV1ZSB0aW1lb3V0IC0gc3Rh
cnRpbmcgdGltZW91dCBzY3JpcHRzDQo+IA0KPiBGb3IgY29ycmVjdCBvcGVyYXRpb24sIGxldHMg
Y2FsbCB0aGUgZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudCgpIHRvDQo+IHByb3Blcmx5IHNldCB0
aGUgbWFzayBmb3IgYm90aCBzdHJlYW1pbmcgYW5kIGNvaGVyZW50LCBpbiBvcmRlciB0bw0KPiBp
bmZvcm0gdGhlIGtlcm5lbCBhYm91dCB0aGUgZGV2aWNlcyBETUEgYWRkcmVzc2luZyBjYXBhYmls
aXRpZXMuDQoNCllvdSBzaG91bGQgcHJvYmFibHkgZXhwYW5kIG9uIHRoaXMgYSBiaXQuLi4gIEJh
c2ljYWxseSwgdGhlIGZhY3QgdGhhdA0KdGhlIGNvaGVyZW50IERNQSBtYXNrIHZhbHVlIHdhc24n
dCBzZXQgY2F1c2VkIHRoZSBkcml2ZXIgdG8gZmFsbCBiYWNrDQp0byBTV0lPVExCIHdoZW4gU01F
IGlzIGFjdGl2ZS4gSSdtIG5vdCBzdXJlIGlmIHRoZSBmYWlsdXJlIHdhcyBmcm9tDQpydW5uaW5n
IG91dCBvZiBTV0lPVExCIG9yIGV4Y2VlZGluZyB0aGUgbWF4aW11bSBhbGxvY2F0aW9uIHNpemUg
Zm9yDQpTV0lPVExCLg0KDQpJIGJlbGlldmUgdGhlIGZpeCBpcyBwcm9wZXIsIGJ1dCBJJ2xsIGxl
dCB0aGUgZHJpdmVyIG93bmVyIGNvbW1lbnQgb24NCnRoYXQuDQoNClRoYW5rcywNClRvbQ0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBMaWFuYm8gSmlhbmcgPGxpamlhbmdAcmVkaGF0LmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL3Njc2kvc21hcnRwcWkvc21hcnRwcWlfaW5pdC5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zY3NpL3NtYXJ0cHFpL3NtYXJ0cHFpX2luaXQuYyBiL2RyaXZlcnMv
c2NzaS9zbWFydHBxaS9zbWFydHBxaV9pbml0LmMNCj4gaW5kZXggYzI2Y2FjODE5ZjllLi44YjFm
ZGU2YzdkYWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS9zbWFydHBxaS9zbWFydHBxaV9p
bml0LmMNCj4gKysrIGIvZHJpdmVycy9zY3NpL3NtYXJ0cHFpL3NtYXJ0cHFpX2luaXQuYw0KPiBA
QCAtNzI4Miw3ICs3MjgyLDcgQEAgc3RhdGljIGludCBwcWlfcGNpX2luaXQoc3RydWN0IHBxaV9j
dHJsX2luZm8gKmN0cmxfaW5mbykNCj4gICAgICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICBt
YXNrID0gRE1BX0JJVF9NQVNLKDMyKTsNCj4gDQo+IC0gICAgICAgcmMgPSBkbWFfc2V0X21hc2so
JmN0cmxfaW5mby0+cGNpX2Rldi0+ZGV2LCBtYXNrKTsNCj4gKyAgICAgICByYyA9IGRtYV9zZXRf
bWFza19hbmRfY29oZXJlbnQoJmN0cmxfaW5mby0+cGNpX2Rldi0+ZGV2LCBtYXNrKTsNCj4gICAg
ICAgICBpZiAocmMpIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIoJmN0cmxfaW5mby0+cGNp
X2Rldi0+ZGV2LCAiZmFpbGVkIHRvIHNldCBETUEgbWFza1xuIik7DQo+ICAgICAgICAgICAgICAg
ICBnb3RvIGRpc2FibGVfZGV2aWNlOw0KPiAtLQ0KPiAyLjE3LjENCj4gDQo=
