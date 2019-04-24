Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D575F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="KVNM243R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfDXWam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:30:42 -0400
Received: from mail-eopbgr750111.outbound.protection.outlook.com ([40.107.75.111]:12351
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfDXWaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72Tw1zzJdCHUrBG7HPZTycTaz6pOpioofLHaBGaemMU=;
 b=KVNM243Ry39gJBL3Z698Fl+UgyfERjQDiCAAbhC89l7vJ3gdheiRtDa2eW6WaK8s0SYHmpJuVFOm2gP1wsElNtvdPyARBDoVGxHzPcjTm5r7snae/G8Pah7WOuGTnV71Ra8tPO2PdZL2oUUXzMohl6IrdhbDs8HzGU5936ebcBI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1038.namprd22.prod.outlook.com (10.174.167.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Wed, 24 Apr 2019 22:30:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 22:30:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 02/12] mips: Discard rudiments from bootmem_init
Thread-Topic: [PATCH 02/12] mips: Discard rudiments from bootmem_init
Thread-Index: AQHU+ibPJx/995poAk2Zs09GW4PaOaZL5l2A
Date:   Wed, 24 Apr 2019 22:30:36 +0000
Message-ID: <MWHPR2201MB12776A057ABA75850F66771DC13C0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190423224748.3765-3-fancer.lancer@gmail.com>
In-Reply-To: <20190423224748.3765-3-fancer.lancer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0035.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 116a36ca-a2c9-4504-ab65-08d6c90478c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1038;
x-ms-traffictypediagnostic: MWHPR2201MB1038:
x-microsoft-antispam-prvs: <MWHPR2201MB1038FFB8DCEC97B8263207DEC13C0@MWHPR2201MB1038.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39850400004)(136003)(189003)(199004)(8676002)(7416002)(102836004)(7696005)(52116002)(4326008)(76176011)(7736002)(6506007)(54906003)(305945005)(99286004)(316002)(6246003)(386003)(53936002)(2906002)(14454004)(97736004)(25786009)(74316002)(9686003)(55016002)(478600001)(6116002)(3846002)(66556008)(256004)(4744005)(66446008)(66066001)(446003)(81156014)(6436002)(26005)(6916009)(42882007)(68736007)(81166006)(73956011)(66946007)(66476007)(71190400001)(71200400001)(44832011)(52536014)(186003)(8936002)(229853002)(486006)(476003)(5660300002)(64756008)(11346002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1038;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eJjcAHYX1P2SSVjw4J2RovDueTVY6wGRrsZ6P7mIhMdIfCclW8ZFYFNynoQSaDGSIdhzMiQ4q9c7dzHh7R4lhlbDBrsxcCc04UnTSAXA/FEp4kjivIHk+ZIusXI8/dvXYKnUUGShryGSds/5r34riYjiPGYzC1FgZT3+2yMiW2NS+Y7WLqp/AjwTgU2P1r7UgEGWkGZLFKqqL1X5hTu2XPFdFS7dBszaHDnmvslBDvotiTUryQ1442JR2ncTPVPbmQ4WGm4gX8/V+Io5+bGvMTfV5ow24bZRFVy1uPO4qRnWN8Q4k8OUGsxkTzff7DyclcgT8nMXuBCx7l/l+zc34VhsBQ0PJpeEkyuQpHZxSgx1rBzJjUDoaR9jJbycSATkgI3SUm16pMWhheTcKd40pVxVzf13FGDsKJqGEQZAB/U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116a36ca-a2c9-4504-ab65-08d6c90478c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:30:36.5386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClNlcmdlIFNlbWluIHdyb3RlOg0KPiBUaGVyZSBpcyBhIHBvaW50bGVzcyBjb2Rl
IGxlZnQgaW4gdGhlIGJvb3RtZW1faW5pdCgpIG1ldGhvZCBzaW5jZQ0KPiB0aGUgYm9vdG1lbSBh
bGxvY2F0b3IgcmVtb3ZhbC4gRmlyc3QgcGFydCByZXNpZGVzIHRoZSBQRk4gcmFuZ2VzDQo+IGNh
bGN1bGF0aW9uIGxvb3AuIFRoZSBjb25kaXRpb25hbCBleHByZXNzaW9ucyBhbmQgY29udGludWUg
b3BlcmF0b3INCj4gYXJlIHVzZWxlc3MgdGhlcmUsIHNpbmNlIG5vdGhpbmcgaXMgZG9uZSBhZnRl
ciB0aGVtLiBTZWNvbmQgcGFydCBpcw0KPiBpbiBSQU0gcmFuZ2VzIGluc3RhbGxhdGlvbiBsb29w
LiBXZSBjYW4gc2ltcGxpZnkgdGhlIGNvbmRpdGlvbnMgY2FzY2FkZQ0KPiBhIGJpdCB3aXRob3V0
IG11Y2ggb2YgdGhlIGxvZ2ljIHJlZGVmaW5pdGlvbiwgc28gdG8gcmVkdWNlIHRoZSBjb2RlDQo+
IGxlbmd0aC4gSW4gcGFydGljdWxhciB0aGUgZW5kIGJvdW5kYXJ5IHZhbHVlIGNhbiBiZSB2ZXJp
ZmllZCBhZnRlcg0KPiB0aGUgcG9zc2libGUgcmVkdWN0aW9uIHRvIGJlIGJlbG93IG1heF9sb3df
cGZuLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21h
aWwuY29tPg0KDQpBcHBsaWVkIHRvIG1pcHMtbmV4dC4NCg0KVGhhbmtzLA0KICAgIFBhdWwNCg0K
WyBUaGlzIG1lc3NhZ2Ugd2FzIGF1dG8tZ2VuZXJhdGVkOyBpZiB5b3UgYmVsaWV2ZSBhbnl0aGlu
ZyBpcyBpbmNvcnJlY3QNCiAgdGhlbiBwbGVhc2UgZW1haWwgcGF1bC5idXJ0b25AbWlwcy5jb20g
dG8gcmVwb3J0IGl0LiBdDQo=
