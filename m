Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B23BC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12A820815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HHnJwZWG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o01DBJKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfF0ACw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:02:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25520 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF0ACv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561593789; x=1593129789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WqBpN83LyOFjQvwqlwTcSvuoOJHHok4XS1A9Ium+qpY=;
  b=HHnJwZWGZSHxNDtiwMn5zrR5LeiQ0ufGcaT7EIGNUIzleIg74QwFUhJx
   EmbmwDXh5DIbgg4pQtvmOWhGVuUEiX7F9LwqcZp7mG+EQGoD46IZM7xxP
   n8zOjVDNVyEREs/3MS6UFfd8yILMN4OVK12jbuAtwLPneaOG1PGTBnlcZ
   UaMKg4sUwMK24jkNOOHJq/P5CBfZ9mtNBT9CO4SCoLjNyb2JPSoRoE3Ns
   dSm5KTae/SERY/gKHF6HPWqWi/G8W6utj2LxLLEPQGRuu2kmB5uxBHyjk
   CvUzY3sqOdBHNBPCHrWIxpbGTrBOSHhLZvqBE7l3ugHgtSHa/3A6L8sEI
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="211442148"
Received: from mail-by2nam05lp2057.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.57])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 08:03:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqBpN83LyOFjQvwqlwTcSvuoOJHHok4XS1A9Ium+qpY=;
 b=o01DBJKAA41MKcB1niPgSiMt32aZ6iaTmMDtND1l61cl7kNLAMKUqsErgtCZ0Qd4Q1yklQZQNJ4P+3mgyd+dMCg2KQ092VzlfUe1T6YdN9/0jpDl3HIqaquU4y5olg/7j5ZaG9UDaITHRE8xD8tG8sjn8q6yQIN/fx88E0zg9Lw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5767.namprd04.prod.outlook.com (20.179.58.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 00:02:49 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 00:02:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>
CC:     "keith.busch@intel.com" <keith.busch@intel.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH -next] nvme-pci: Make nvme_dev_pm_ops static
Thread-Topic: [PATCH -next] nvme-pci: Make nvme_dev_pm_ops static
Thread-Index: AQHVK8QyV/HFyY84V0GwUJFDyz2beaauYmqA///IAoA=
Date:   Thu, 27 Jun 2019 00:02:48 +0000
Message-ID: <16F98F71-9186-443A-A787-1F966A3BCC87@wdc.com>
References: <20190626020902.38240-1-yuehaibing@huawei.com>
 <20190626202311.GB4934@minwooim-desktop>
In-Reply-To: <20190626202311.GB4934@minwooim-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1a.0.190609
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:7ce8:bb88:a236:3b7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da475c96-a207-4b5a-3fd2-08d6fa92cabc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5767;
x-ms-traffictypediagnostic: BYAPR04MB5767:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5767CD86FD9FE1A137B7887486FD0@BYAPR04MB5767.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(33656002)(73956011)(36756003)(486006)(66556008)(25786009)(71200400001)(71190400001)(66476007)(5660300002)(68736007)(76116006)(66446008)(66946007)(46003)(54906003)(58126008)(476003)(316002)(110136005)(4326008)(64756008)(11346002)(446003)(14444005)(256004)(6116002)(6246003)(186003)(76176011)(53546011)(6486002)(99286004)(6506007)(2616005)(102836004)(53936002)(72206003)(6436002)(86362001)(478600001)(2906002)(229853002)(6306002)(966005)(8936002)(14454004)(6512007)(81166006)(81156014)(7736002)(8676002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5767;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tyI3tNMdQMPzzigxzPw1NWqjD/+qgJ1V7t7aLNBPNuu03U1BIEhDo2YkL0i1oLlHqZA9i3+ZnjPzrcAHPwhhTlurbZaagYgQ7tLrCHwDfj6w79D06uaXxqoyWINSGzAHYr1HEo4vAlPmPfWG6gjkpoE2KM0Ot64WeJOLVSlNSzevtu2h0zKUSPgPw+cOzfZ3VTz36YHEBImZ3HDhFsUiTFm6gnN7xRusnl+L0CV2Z1hSgMsW7UUVFp/16YN8PNQ7BSlRzCyDe9y91vvoTY77X5P3IyiPbzp06yVktPk6jLuQi4qtaLrH+WTFiH7mYUu4pWD51X01c9yTSNOqtr49GIFhb5QUlVIpIOw/8OqGuBvac5lbp7mQVzUxqk8aEEUunYOVClhmXT767kDapQN883UyPV0za0CcxqU5NP9N9Jw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <700F4F47C515F3488C30827EA840589C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da475c96-a207-4b5a-3fd2-08d6fa92cabc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 00:02:49.0659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlh
Lmt1bGthcm5pQHdkYy5jb20+DQoNCu+7v09uIDYvMjYvMTksIDE6MjMgUE0sICJMaW51eC1udm1l
IG9uIGJlaGFsZiBvZiBNaW53b28gSW0iIDxsaW51eC1udm1lLWJvdW5jZXNAbGlzdHMuaW5mcmFk
ZWFkLm9yZyBvbiBiZWhhbGYgb2YgbWlud29vLmltLmRldkBnbWFpbC5jb20+IHdyb3RlOg0KDQog
ICAgT24gMTktMDYtMjYgMTA6MDk6MDIsIFl1ZUhhaWJpbmcgd3JvdGU6DQogICAgPiBGaXggc3Bh
cnNlIHdhcm5pbmc6DQogICAgPiANCiAgICA+IGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jOjI5MjY6
MjU6IHdhcm5pbmc6DQogICAgPiAgc3ltYm9sICdudm1lX2Rldl9wbV9vcHMnIHdhcyBub3QgZGVj
bGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQogICAgPiANCiAgICA+IFJlcG9ydGVkLWJ5OiBI
dWxrIFJvYm90IDxodWxrY2lAaHVhd2VpLmNvbT4NCiAgICA+IFNpZ25lZC1vZmYtYnk6IFl1ZUhh
aWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGRyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jIHwgMiArLQ0KICAgID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KICAgID4gDQogICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KICAgID4gaW5kZXggMTg5
MzUyMC4uZjUwMDEzMyAxMDA2NDQNCiAgICA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5j
DQogICAgPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KICAgID4gQEAgLTI5MjMsNyAr
MjkyMyw3IEBAIHN0YXRpYyBpbnQgbnZtZV9zaW1wbGVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRl
dikNCiAgICA+ICAJcmV0dXJuIDA7DQogICAgPiAgfQ0KICAgID4gIA0KICAgID4gLWNvbnN0IHN0
cnVjdCBkZXZfcG1fb3BzIG52bWVfZGV2X3BtX29wcyA9IHsNCiAgICA+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGRldl9wbV9vcHMgbnZtZV9kZXZfcG1fb3BzID0gew0KICAgID4gIAkuc3VzcGVuZAk9
IG52bWVfc3VzcGVuZCwNCiAgICA+ICAJLnJlc3VtZQkJPSBudm1lX3Jlc3VtZSwNCiAgICA+ICAJ
LmZyZWV6ZQkJPSBudm1lX3NpbXBsZV9zdXNwZW5kLA0KICAgIA0KICAgIElNSE8sIGl0IHNob3Vs
ZCBiZSBpbiBzdGF0aWMuDQogICAgDQogICAgUmV2aWV3ZWQtYnk6IE1pbndvbyBJbSA8bWlud29v
LmltLmRldkBnbWFpbC5jb20+DQogICAgDQogICAgX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCiAgICBMaW51eC1udm1lIG1haWxpbmcgbGlzdA0KICAgIExp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KICAgIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQ0KICAgIA0KDQo=
