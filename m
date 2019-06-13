Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B495BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB702147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="chmHWZKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfFMStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:49:53 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:21977
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbfFMStw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OU9lSJh/MxSCvU+b6GGHMrg9xf+VVbINT732NyM6cw=;
 b=chmHWZKa4pBSsNbHBGClGU0dpXxYwij/A97inb2cLY+48SrROPn5zPuqIbD6JnU57hqZhoo+cybb3NKZutB07kfqeLV68Ma1ia8vp+BEl1p4Abt0ik2rNCPdZ2o6LgTGFXPnic9LenJS3mLlu4Jt6WMh53ZRjYsxg3AOoPSUQZ4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5334.namprd05.prod.outlook.com (20.177.127.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 18:49:49 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::134:af66:bedb:ead9%3]) with mapi id 15.20.1987.008; Thu, 13 Jun 2019
 18:49:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] x86/percpu semantics and fixes
Thread-Topic: [PATCH v2 0/5] x86/percpu semantics and fixes
Thread-Index: AQHVIe/qgqliRoqpQ0u4SMIVKzs9OKaZ7awA
Date:   Thu, 13 Jun 2019 18:49:49 +0000
Message-ID: <ED22D686-D425-43B9-A3FB-ED4A54B1C4DF@vmware.com>
References: <20190613135445.318096781@infradead.org>
In-Reply-To: <20190613135445.318096781@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4adc7644-03f6-4e98-be3f-08d6f02fe9d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5334;
x-ms-traffictypediagnostic: BYAPR05MB5334:
x-microsoft-antispam-prvs: <BYAPR05MB5334A8288A9A9018136BFEE1D0EF0@BYAPR05MB5334.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(53754006)(189003)(199004)(4326008)(99286004)(11346002)(446003)(71200400001)(5660300002)(54906003)(53546011)(71190400001)(6506007)(2616005)(6116002)(36756003)(316002)(3846002)(76176011)(476003)(66946007)(102836004)(6916009)(6246003)(478600001)(81156014)(81166006)(66476007)(64756008)(66556008)(66066001)(14454004)(14444005)(26005)(86362001)(76116006)(6436002)(305945005)(8936002)(486006)(66446008)(256004)(8676002)(53936002)(6486002)(2906002)(6512007)(33656002)(25786009)(68736007)(186003)(7736002)(229853002)(73956011)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5334;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X9xbAM8TY2YqRluYEplpgpS8aa8oPKUdUOGSDcR0yHi0B6Tv0v4PLG8XYZMe0e6q3jgXW1897mPF5tn0aswCXAJGeIlB5qguyo7zB7ZxkWDk7+hifAE8rDLfrciCEi/o/iePbq80qiEg23kVaIrz7tncEYYizXGkHEoiA8DzHtnXEYKT2bzg911+PWw0nxg5dpKqipWIH65baVu/uH3ttPNFe5aVt3AAglb2xZ/f9RVekbHtEmsdr4zfGNtNLWm5uK9DKiQ3+9VqjVG4RV+RytHU6cNzt2oXL/oFWSQkiBaTAle3ej7he+5NxYJJ2OhN+//htCoI+M2ON+GdP2lLw3uEqrqIbXMf+09hOOXSTtxbFUV2B4OC/ia/daQQP2Pq4OXKQOTyxBGw05QDs/PotG9Pf5NlAL1Zo0DoUzdA4OY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F8BE0D0342E97449AD54323C5522FB9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adc7644-03f6-4e98-be3f-08d6f02fe9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 18:49:49.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdW4gMTMsIDIwMTksIGF0IDY6NTQgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBJIHN0aWxsIGhhdmUgdGhl
c2UgcGF0Y2hlcyBzaXR0aW5nIGluIG15IHF1ZXVlIGFuZCBmaWd1cmVkIEknZCByZXBvc3QgdGhl
bS4NCj4gDQo+IExhc3QgdGltZSBMaW51cyBwcm9wb3NlZCBhICIrbSIgYWx0ZXJuYXRpdmUgYXBw
cm9hY2gsIGJ1dCB0aGF0IGdlbmVyYXRlcyBmYXINCj4gZmFyIHdvcnNlIGNvZGUgKEkndmUgbG9z
dCB0aGUgcGF0Y2ggYW5kIG5vdCByZS1yYW4gdGhvc2UgbnVtYmVycywgYnV0IEkgc3VwcG9zZQ0K
PiBJIGNhbiByZWRvIGlmIGZvdW5kIGltcG9ydGFudCkuDQoNCkkgcmVtZW1iZXIgSSB0cmllZCBp
dCBhcyB3ZWxsIGFuZCBnb3QgdGhlIHNhbWUgcmVzdWx0cy4NCg0KPiBUaGVzZSBwYXRjaGVzIGhh
dmUgYmVlbiB0aHJvdWdoIDBkYXkgZm9yIGEgd2hpbGUuDQoNCkZpbmFsbHksIEkgd291bGQgbm90
IG5lZWQgdG8gY2FjaGUgc21wX3Byb2Nlc3Nvcl9pZCgpIG9uIHRoZSBzdGFjayB3aGVuIGl0DQpp
cyB1c2VkIG11bHRpcGxlIHRpbWVz4oCm
