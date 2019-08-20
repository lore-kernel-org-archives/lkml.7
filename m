Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ECF22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gDIez0Su";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fQ+pwtoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfHTVYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:24:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18329 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566336243; x=1597872243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bP4qBRGapV4ymu3uf0w1jeMF96Qmio3sLxjMEhqISSY=;
  b=gDIez0SuoeBYh13v9fqMzfjWiddGm5JyDbUWgc+qPsh5rYaKXuCLuu7W
   twHOO3ppVCjCpphdjIpT6XQVXJezVu/si3Ntucl5yJLcgQpArI3QlpVWX
   LEZF653mBazwE7OqXcrwEyF+GIB38HPCFeXwPCGOIjZx7tlNE/tZDbA81
   Twc1XuKXPEVEtif4mH/D2t13OMR7lb9Aat2YZiXO7gYLNRa4+wpUynOFl
   OWot0ZlKRjA01Na7RsDRZkxzrZXmJgw1W4SXRiwiWRhOemdp32Kuv2mzv
   69EQWScTYPVvZoYKMiRWczUNWbtWiegtrXXBVR/QaJ2V0qdRM743/737J
   g==;
IronPort-SDR: NcuzmsV02Jo2MVkV6KxNqmlFwsQOtP6/1u47GWhFIV3S41DMEfB03eZRZ8K5MWIghl3aT3NOV3
 JTnOfw2X/ZVwTJWRZ9LJ/rUOrswsWF0sYig1HMlGRyJnsmrViOo1GZzR+nD/RQ7Z3SedclK8Hv
 6qrafM8qMk8TVSV1zkssDtCaDhXzDJ7m73d6NRYBBbr5raTv46/RkqiWIc2C/RHP8HclgHdTma
 FzHCO92L9eYpiwsIoSIHFEOvve31/t6v4uR0FuEqdgfFDSdWgQh7CfEFzuWGQMmkvizV3k9B3s
 YyA=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="116279683"
Received: from mail-sn1nam02lp2054.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.54])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 05:06:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEM5AGADuGRZennoeZe/MoSg9k2qgYrEzYkWp11y304V6jHZ9C+MlqPvjW8fkKepsP6RSXjWTTDiJFtK/29j00pSW/SOS1qiNoVrCLuabt87sXMPWC5dg2JbZgJ5RXF+lwX60a3YL0ZrIuAwS/UpCBdl+ox5kn9yIFDJ/KSAS6wOer60G1Zm11n4RGF5B9rj1JwdEVDu3BKulzlBc8C+24DxsAB8J7AXchPpTckvJYr1T3OocZQCj3zFWW0ni4TQHmDov78vNUkblrv9KFmbxmq77d3s+oUFIsvdO32fIwBM0Odu5QSMrLAUIBN3TdrYaXn8rwg/1FtilbQHVmtF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP4qBRGapV4ymu3uf0w1jeMF96Qmio3sLxjMEhqISSY=;
 b=HJtIOWj0HQdMqp59PnllPZ7zVVcgdZu12HTKg6VmHEGT3CPnzySCje0QDlujuKWCXo1z9zidHrEGf5FQrdHGt0yI6n7N4MlCEiO5uaWNiDNTEoEeWa3MMZVpne+T7OzHGr03zhet9YrXFD+fs2SGFsyvVkVdyAjmpXX69rAu0GhT5Z3hG8cVlpfa4nmGanKC2InYaBHfRPvr0w/gFER4EwT1uDO9YYEXOtpG7P9BAF3ooovS8YUZ5BYiG+VXMnq12iEBGXI5hT/WyElwjFiirMIVSHUxbRIG0N18XKILX5KrBOI+Wm8kr4eXy3jftSXvvR6A+IyW5jsBEFkG7b+9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP4qBRGapV4ymu3uf0w1jeMF96Qmio3sLxjMEhqISSY=;
 b=fQ+pwtoOBXdkftdobR6ilbXizkz9vXuA5vIVf5h+T1n2VvYRTvWLzZQxVmbSgyZD1h40w774tY8XkalmMLBzSG5RCr13sdKX5uaiXjFgznhkoHQNApkQJe2PwGCjxwQOMcpkaW5IJmziDwPi/gfUfE1dmSNoR0VDHegU7HW1JZI=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5558.namprd04.prod.outlook.com (20.178.232.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 21:05:59 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 21:05:59 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/15] riscv: poison SBI calls for M-mode
Thread-Topic: [PATCH 10/15] riscv: poison SBI calls for M-mode
Thread-Index: AQHVUe6aQdQDddvuSUq1rKYnjWwlLKcEkkMA
Date:   Tue, 20 Aug 2019 21:05:59 +0000
Message-ID: <5d45577f9e2a0368a03760ef181266931f21c0d0.camel@wdc.com>
References: <20190813154747.24256-1-hch@lst.de>
         <20190813154747.24256-11-hch@lst.de>
In-Reply-To: <20190813154747.24256-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dcff183-38c5-42ed-18ba-08d725b23373
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5558;
x-ms-traffictypediagnostic: BYAPR04MB5558:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB555880F1DDB8A6CCFBE1E995FAAB0@BYAPR04MB5558.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(189003)(66066001)(14454004)(76176011)(2201001)(2501003)(6246003)(36756003)(86362001)(54906003)(66556008)(66946007)(110136005)(66476007)(81166006)(64756008)(66446008)(4744005)(99286004)(81156014)(316002)(53936002)(6116002)(76116006)(3846002)(71200400001)(8676002)(4326008)(71190400001)(229853002)(118296001)(256004)(186003)(14444005)(6506007)(8936002)(486006)(476003)(478600001)(7736002)(5660300002)(6436002)(6486002)(6512007)(25786009)(11346002)(26005)(305945005)(102836004)(446003)(2906002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5558;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +898yo+WO7ozFTVUTmhA6WSXPkyQNVNS7q9I1I6fjyU8t49xnWARFwuYMRdF0eGNKtTE+5LwS2+7YbBmgvezmUAafbuLd8vYjWGk8kRY/YcEqx9cqAcu19OKSP1NNLLuX+vRI7SvyAjabhF7FmygKBpuMYur3Z5ni8tGp151BcYHd3bUbKD9G7cTh6X8m8zELNJpARBpoti6zFhbJFzj1c29RDnQRtAhPbYukUt9Oqp34rl+XwBei6DMcEuIHFpXRJ0Vxu6wzAQCgLD3XA7/xPgkho5SxdF7eGk2buZWaKyZoEgU3LjauDFHcGVB0ls4YK9vqdTa5QXGAky1XjuM80a7UrRn93AUKB6FFj47jNHN/iElCkCR7YpsilG5YasEEh+RdKOoEuBA7+4gp44b1t8e/UaOeVydEfEHlWkmHAE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76FCE82106630048BD11578FACFCEF03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcff183-38c5-42ed-18ba-08d725b23373
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 21:05:59.3282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlHy6Q1BRpVDbESzHN0Y9hE8BbdY4EOECJ0z+vpjRMPmmaIQwPO0cqjxG0i90Az/lNy9sU4TqPUaPGpJynnAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5558
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDE3OjQ3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gVGhlcmUgaXMgbm8gU0JJIHdoZW4gd2UgcnVuIGluIE0tbW9kZSwgc28gZmFpbCB0aGUg
Y29tcGlsZSBmb3IgYW55DQo+IGNvZGUNCj4gdHJ5aW5nIHRvIHVzZSBTQkkgY2FsbHMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+
ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NiaS5oIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS9zYmkuaA0KPiBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc2Jp
LmgNCj4gaW5kZXggMjExMzRiM2VmNDA0Li4xZTE3ZjA3ZWFkYWYgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vc2JpLmgNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9zYmkuaA0KPiBAQCAtOCw2ICs4LDcgQEANCj4gIA0KPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVz
Lmg+DQo+ICANCj4gKyNpZm5kZWYgQ09ORklHX01fTU9ERQ0KPiAgI2RlZmluZSBTQklfU0VUX1RJ
TUVSIDANCj4gICNkZWZpbmUgU0JJX0NPTlNPTEVfUFVUQ0hBUiAxDQo+ICAjZGVmaW5lIFNCSV9D
T05TT0xFX0dFVENIQVIgMg0KPiBAQCAtOTQsNCArOTUsNSBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
c2JpX3JlbW90ZV9zZmVuY2Vfdm1hX2FzaWQoY29uc3QNCj4gdW5zaWduZWQgbG9uZyAqaGFydF9t
YXNrLA0KPiAgCVNCSV9DQUxMXzQoU0JJX1JFTU9URV9TRkVOQ0VfVk1BX0FTSUQsIGhhcnRfbWFz
aywgc3RhcnQsIHNpemUsDQo+IGFzaWQpOw0KPiAgfQ0KPiAgDQo+IC0jZW5kaWYNCj4gKyNlbmRp
ZiAvKiBDT05GSUdfTV9NT0RFICovDQo+ICsjZW5kaWYgLyogX0FTTV9SSVNDVl9TQklfSCAqLw0K
DQpSZXZpZXdlZC1ieTogQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+DQoNCi0tIA0K
UmVnYXJkcywNCkF0aXNoDQo=
