Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC83C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F24206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IIQ3niDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbfDDS3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:29:20 -0400
Received: from mail-eopbgr780127.outbound.protection.outlook.com ([40.107.78.127]:51648
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfDDS3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWgDzvVIR0DCuAL92CKDh9zuQVcYTYIdUA8e0cvPB0o=;
 b=IIQ3niDrwwAcjH9MtyyAv3oMrwS3aSwKK2xexARhyYkSl+mQOucFWGAavyFSvSvWJZmtWsYeurbmaR4Dr20k5lJXl7kRI8x4GaqmbZ6sya6Bj777bZqKapbwh8K292qEQ5D3UU+ijtuNJtGv8N3Gl6A3S1b2yl23NSu2hP4VLCw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1504.namprd22.prod.outlook.com (10.174.170.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Thu, 4 Apr 2019 18:29:17 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%6]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 18:29:17 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Chuanhong Guo <gch981213@gmail.com>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2] MIPS: ralink: fix cpu clock of mt7621 and add dt clk
  devices
Thread-Topic: [PATCH v2] MIPS: ralink: fix cpu clock of mt7621 and add dt clk
  devices
Thread-Index: AQHU6xRPB6YnA+eZ30OQ9KwkfjNpbA==
Date:   Thu, 4 Apr 2019 18:29:16 +0000
Message-ID: <MWHPR2201MB12772FC62B0F8ED7F2061CEAC1500@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190321144251.28313-1-gch981213@gmail.com>
In-Reply-To: <20190321144251.28313-1-gch981213@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93cf864e-6184-4ab9-3516-08d6b92b71d7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1504;
x-ms-traffictypediagnostic: MWHPR2201MB1504:
x-microsoft-antispam-prvs: <MWHPR2201MB1504B213C70C17BC84641267C1500@MWHPR2201MB1504.namprd22.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(5660300002)(97736004)(53936002)(25786009)(229853002)(14454004)(478600001)(55016002)(6246003)(486006)(3846002)(71190400001)(71200400001)(6116002)(9686003)(446003)(44832011)(476003)(4326008)(11346002)(8936002)(186003)(7696005)(52116002)(7736002)(76176011)(8676002)(81156014)(26005)(305945005)(105586002)(1411001)(102836004)(68736007)(386003)(256004)(6506007)(66066001)(33656002)(74316002)(106356001)(42882007)(316002)(54906003)(52536014)(99286004)(4744005)(6916009)(2906002)(6436002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1504;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sSN/uiUgahQ1TPD5JS8buMQE9pamvxfOfuLs/XApWypC+pra7/d3PVbGdGXofDB5JelkAb7bljq54g3lRzTHm6M9MWWCexK1pXp4iuBMvIReowycFSnaU2OPLw60ppZzMDvkNqFE+LTcDvxt6cFDVvuFoap8HLBsU/UTA7ma7qKCaJAKunybRxIlOC7xfYx2X0S1d8ZLbwNYB0qHoVmDwuU2k058utFFC9nZbWgVxzVhfzw2zipQU9r+dsh1GwUjip4l1soGdmHCSb4A37CS5XFgP75rrJeqKWngNRilE/t5RsP1G699gIWEY5XStbx+KqQx8lQqOqboUi1746cLZOXB/KEzIQT1dnGz+pjT0+Aeif777fjjavke5gSn6DU1FiMMB404CFaFNzUbI5sAcW5PG/ErCp9kv0jo+2Eam00=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cf864e-6184-4ab9-3516-08d6b92b71d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 18:29:16.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkNodWFuaG9uZyBHdW8gd3JvdGU6DQo+IEZvciBhIGxvbmcgdGltZSB0aGUgbXQ3
NjIxIHVzZXMgYSBmaXhlZCBjcHUgY2xvY2sgd2hpY2ggY2F1c2VzIGEgcHJvYmxlbQ0KPiBpZiB0
aGUgY3B1IGZyZXF1ZW5jeSBpcyBub3QgODgwTUh6Lg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0
aGUgY3B1IGNsb2NrIGNhbGN1bGF0aW9uIGFuZCBhZGRzIHRoZSBjcHUvYnVzIGNsa2Rldg0KPiB3
aGljaCB3aWxsIGJlIHVzZWQgaW4gZHRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VpamllIEdh
byA8aGFja3Bhc2NhbEBnbWFpbC5jb20+DQo+IA0KPiBQb3J0ZWQgZnJvbSBPcGVuV3J0Og0KPiBj
N2NhMjI0Mjk5IHJhbWlwczogZml4IGNwdSBjbG9jayBvZiBtdDc2MjEgYW5kIGFkZCBkdCBjbGsg
ZGV2aWNlcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2h1YW5ob25nIEd1byA8Z2NoOTgxMjEzQGdt
YWlsLmNvbT4NCg0KQXBwbGllZCB0byBtaXBzLW5leHQuDQoNClRoYW5rcywNCiAgICBQYXVsDQoN
ClsgVGhpcyBtZXNzYWdlIHdhcyBhdXRvLWdlbmVyYXRlZDsgaWYgeW91IGJlbGlldmUgYW55dGhp
bmcgaXMgaW5jb3JyZWN0DQogIHRoZW4gcGxlYXNlIGVtYWlsIHBhdWwuYnVydG9uQG1pcHMuY29t
IHRvIHJlcG9ydCBpdC4gXQ0K
