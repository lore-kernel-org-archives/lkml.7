Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384EBC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B87248EA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o/MqGP32";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z78VKoHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfFCIhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:37:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33412 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559551065; x=1591087065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G3EqpvrsZnf71aKcQlZmFfnzV9YwKkAvrY7Gko34YAU=;
  b=o/MqGP32UcjYTTjRaRlzO0ZAE1lRRKDQPwZEGlBhs5Rg8uqDL0Gpv5Ec
   h4zB5KTDe6tp6CLOpSUjYQ1HjZ8u+4zrtzJ5IR5TRMhwuVOxFPTLo9IoW
   Nchmoj3uOoIKytMdSEAnJ6RAmeGGjOSqxk3n8AHIKIP6ENTmAYqRfFfLK
   Ex5kRRCcR7SkzCpdZqzgOJL3+/OkVQvtrnBt/OJrqEMfhbOTBiQ7rPOfq
   h/pldwQtt56Dj+QYrBoJvjWPPCqKSzeA70CuGyJrDNShRY8+APceBKTd9
   KJ5ymYqP6ifoM0i+SRdHyRvdzmYzEXHOct+uQ/clilhGsMyr/CgbWxXbT
   A==;
X-IronPort-AV: E=Sophos;i="5.60,546,1549900800"; 
   d="scan'208";a="215918448"
Received: from mail-by2nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.59])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2019 16:37:44 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3EqpvrsZnf71aKcQlZmFfnzV9YwKkAvrY7Gko34YAU=;
 b=z78VKoHRANESauTXOTdRGCUQ4f/ERIpLbuBurbasAtSK0abf3PvkCzGTvvhr13K6DAfEA7fQLV7DNKMYft9X0T5pYaXTnEAqNHuSd3hXfwB3gRkSlSEdbP+4LnmgCRYDox90iG4q2dYeOxYFImDDpnFVVp3VJpIx3H7/KY1m3FU=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4845.namprd04.prod.outlook.com (52.135.122.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Mon, 3 Jun 2019 08:37:42 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::6d99:14d9:3fa:f530%6]) with mapi id 15.20.1922.025; Mon, 3 Jun 2019
 08:37:42 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
CC:     Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: RE: [PATCH] scsi: ufs: Check that space was properly alloced in
 copy_query_response
Thread-Topic: [PATCH] scsi: ufs: Check that space was properly alloced in
 copy_query_response
Thread-Index: AQHVD66+VoVF/V50TUe/Iwn1Wgv+/6Z/9mgAgAm2n5A=
Date:   Mon, 3 Jun 2019 08:37:42 +0000
Message-ID: <SN6PR04MB492583D987B1F25A0541EBAFFC140@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <CGME20190521082527epcas1p44fe0c4659549ae265c9d59ef7844e57e@epcas1p4.samsung.com>
        <1558427062-5084-1-git-send-email-avri.altman@wdc.com>
 <cd9f0d7b-8ce6-e432-e1df-c4316b191156@samsung.com>
In-Reply-To: <cd9f0d7b-8ce6-e432-e1df-c4316b191156@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be856d8c-1e0e-4fac-8f88-08d6e7febe92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4845;
x-ms-traffictypediagnostic: SN6PR04MB4845:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB48459AA86B40C2E69BCCF369FC140@SN6PR04MB4845.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(14444005)(256004)(86362001)(110136005)(66446008)(64756008)(73956011)(66946007)(66476007)(66556008)(102836004)(2201001)(76116006)(6116002)(3846002)(54906003)(11346002)(2906002)(446003)(26005)(6246003)(66066001)(81166006)(81156014)(8676002)(25786009)(476003)(68736007)(305945005)(7736002)(186003)(53936002)(33656002)(4326008)(71190400001)(2501003)(8936002)(71200400001)(9686003)(229853002)(7696005)(486006)(55016002)(316002)(76176011)(14454004)(6436002)(74316002)(72206003)(53546011)(99286004)(6506007)(478600001)(52536014)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4845;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z5jfNpOuGjd7idCT6bh2/wrIZMtfmWjbg+Jo/4vpdZQhFhMFMnYzHFdDoexPoqXWFFPQh3h7DQTu7ZgB81DMWYi48ceR7iBBYTiMYWTNquhNfP5zDgXXppC8B0svqxre9Xep//6ZHo3AcWXil3I1DhvJpBfXDyHUpH0bN88W7oQAqBnUlYOjLDkoVq4sIVqSyO3Hr/s7L1bINjyReOssqxOpbNQCiFjzj+/MJY0hBE0i1YLQ1r5UjBd7gStrn3+C/BAbWUHlL/BImyNJnAlxROIKLywpMvJLIYdZ9Pqjgq5utVbblN0J8Cht0868cAp6qQw1xOJj9HgbXMsQccQwU8CvfZm0n0AFZZj0mvsigyHotKRkoufH1533hJGyyQ7J+DEAMv5MdaxN9aOa6q0IqCAMdItQzb/YiittrU9gnjE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be856d8c-1e0e-4fac-8f88-08d6e7febe92
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 08:37:42.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxpbSwNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcuDQpTb3JyeSBmb3IgdGhlIGxhdGUg
cmVzcG9uc2UgLSBJIHdhcyBhd2F5IGZvciBhIGNvdXBsZSBvZiB3ZWVrcy4NCg0KVGhhbmtzLA0K
QXZyaQ0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNjc2k6IHVmczogQ2hlY2sgdGhhdCBzcGFj
ZSB3YXMgcHJvcGVybHkgYWxsb2NlZCBpbg0KPiBjb3B5X3F1ZXJ5X3Jlc3BvbnNlDQo+IA0KPiBI
aSBBdnJpDQo+IA0KPiBPbiA1LzIxLzE5IDE6NTQgUE0sIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+
IHN0cnVjdCB1ZnNfZGV2X2NtZCBpcyB0aGUgbWFpbiBjb250YWluZXIgdGhhdCBzdXBwb3J0cyBk
ZXZpY2UgbWFuYWdlbWVudA0KPiA+IGNvbW1hbmRzLiBJbiB0aGUgY2FzZSBvZiBhIHJlYWQgZGVz
Y3JpcHRvciByZXF1ZXN0LCB3ZSBhc3N1bWUgdGhhdCB0aGUNCj4gPiBwcm9wZXIgc3BhY2Ugd2Fz
IGFsbG9jYXRlZCBpbiBkZXZfY21kIHRvIGhvbGQgdGhlIHJldHVybmluZyBkZXNjcmlwdG9yLg0K
PiA+DQo+ID4gVGhpcyBpcyBubyBsb25nZXIgdHJ1ZSwgYXMgdGhlcmUgYXJlIGZsb3dzIHRoYXQg
ZG9lc24ndCB1c2UgZGV2X2NtZA0KPiA+IGZvciBkZXZpY2UgbWFuYWdlbWVudCByZXF1ZXN0cywg
YW5kIHdhcyB3cm9uZyBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+ID4NCj4gQ2FuIHlvdSBwbGVhc2Ug
cHV0IHNvbWUgbGlnaHQgb24gdGhvc2UgZmxvd3M/IEFyZSB0aG9zZSBwbGF0Zm9ybQ0KPiBzcGVj
aWZpYz8gSnVzdCBjdXJpb3VzLg0KTm8sIGFjdHVhbGx5IGl0cyBxdWl0ZSBzaW1wbGlzdGljLg0K
X191ZnNoY2RfcXVlcnlfZGVzY3JpcHRvciBzZXQgZGV2X2NtZC5xdWVyeS5kZXNjcmlwdG9yIA0K
dG8gcG9pbnQgdG8gaXRzIGRlc2lnbmF0ZWQgc3BhY2UgYmVmb3JlIHNlbmRpbmcgdGhlIHJlYWQg
ZGVzY3JpcHRvciBxdWVyeSwNCmFuZCB0byBudWxsIG9uY2UgaXQncyBkb25lLg0KQnV0IGl0IGRv
ZXNuJ3QgY2hlY2sgaXQgaW4gdWZzaGNkX2NvcHlfcXVlcnlfcmVzcG9uc2Ugd2hlbiB0aGUgcXVl
cnkNCnJldHVybnMgZnJvbSB0aGUgZGV2aWNlLCB3aGljaCBpdCBzaG91bGQsIGFzIEkgaW5kaWNh
dGVkIGluIHRoZSBjb21taXQgbG9nLg0KDQoNCj4gVGhpcyBjaGFuZ2UgbG9va3Mgb2sgdG8gbWUu
IEkgaG9wZSB5b3UgaGF2ZSB0ZXN0ZWQgdGhpcyBwYXRjaC4NClllcyBJIGRpZC4NCg0KPiBSZXZp
ZXdlZC1ieTogQWxpbSBBa2h0YXIgPGFsaW0uYWtodGFyQHNhbXN1bmcuY29tPg0KDQo=
