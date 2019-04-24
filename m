Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D29CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4AB208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="oFPPXYeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDXWai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:30:38 -0400
Received: from mail-eopbgr750111.outbound.protection.outlook.com ([40.107.75.111]:12351
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfDXWai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF1EMoGsJj/vdH2szJkWXiOHpPwfEoI5SfXGFZfWsJY=;
 b=oFPPXYeqdNaBtv33oNnHxxUAIP64vJtfMA3qTyhANUuROWV9ANCTgBfp3WxBxC6lHdPlwRCOgUCNudLvthW6JN+1ll1YoJCZp2sw3/HzUhb+8Jtz/nl7Q3HZZMhVnwvJis4Avs/W8y6kNbpdnHBKRRFZDotLsjbYWCexKFF+hdY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1038.namprd22.prod.outlook.com (10.174.167.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Wed, 24 Apr 2019 22:30:34 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 22:30:34 +0000
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
Subject: Re: [PATCH 01/12] mips: Make sure kernel .bss exists in boot mem pool
Thread-Topic: [PATCH 01/12] mips: Make sure kernel .bss exists in boot mem
 pool
Thread-Index: AQHU+ibOG+PsMBZAKUiYJPpqSM8lrKZL5lUA
Date:   Wed, 24 Apr 2019 22:30:34 +0000
Message-ID: <MWHPR2201MB1277E5898485758E08C6AD95C13C0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190423224748.3765-2-fancer.lancer@gmail.com>
In-Reply-To: <20190423224748.3765-2-fancer.lancer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b16e16ab-b88d-4bc1-fd70-08d6c9047792
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1038;
x-ms-traffictypediagnostic: MWHPR2201MB1038:
x-microsoft-antispam-prvs: <MWHPR2201MB1038CD01DC96C66FD18FBAC6C13C0@MWHPR2201MB1038.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39850400004)(136003)(189003)(199004)(8676002)(7416002)(102836004)(7696005)(52116002)(4326008)(76176011)(7736002)(6506007)(54906003)(305945005)(99286004)(316002)(6246003)(386003)(53936002)(2906002)(14454004)(97736004)(25786009)(74316002)(9686003)(55016002)(478600001)(6116002)(3846002)(66556008)(256004)(4744005)(66446008)(66066001)(446003)(81156014)(6436002)(26005)(6916009)(42882007)(68736007)(81166006)(73956011)(66946007)(66476007)(71190400001)(71200400001)(44832011)(52536014)(186003)(8936002)(229853002)(486006)(476003)(5660300002)(64756008)(11346002)(33656002)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1038;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B9fQG92x46c1hWRI1KJp/nCCFZY0PWYitFdayrluhGYYl8bT9Lcs1qk6M0j7GkG2ouCXVx08IQn5tEg+O/xRDDrEtGIkTXAuc5ZUQmf354ClITBvJE/KIOGcMAihRMuDkhNkQJ78/WAshNAue1Kuv/VHtwju/kht1jfR+IKIDBrxlq7iGRnylvKQzJe6dAfV+5GYvqEcGBm4AZICOmO4IDnht9JB+bR7zPmADH28T3atBAEq+VgzXkx9L1zAUEhEpiAiJYReYul/YfnOs47DsFBypIyzLxtleF7kWpkLHNauSSWA2eB9Wwbusb2/aJ3kfmN5ZP3mVNabCm+jGyPIyKbGXnseyVHRVUkoC1rp0nEO9G//SPZm9eKYrvsME97/5ZLOzBn7kF7Y06gTFKbyUZYHZUMAv2HluuZb2O8dgnY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16e16ab-b88d-4bc1-fd70-08d6c9047792
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:30:34.4819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClNlcmdlIFNlbWluIHdyb3RlOg0KPiBDdXJyZW50IE1JUFMgcGxhdGZvcm0gY29k
ZSBtYWtlcyBzdXJlIHRoZSBrZXJuZWwgdGV4dCwgZGF0YSBhbmQgaW5pdA0KPiBzZWN0aW9ucyBh
cmUgYWRkZWQgdG8gdGhlIGJvb3QgbWVtb3J5IG1hcCBwb29sIHJpZ2h0IGFmdGVyIHRoZQ0KPiBh
cmNoLXNwZWNpZmljIG1lbW9yeSBzZXR1cCBtZXRob2QgaGFzIGJlZW4gZXhlY3V0ZWQuIEJ1dCBm
b3Igc29tZSByZWFzb24NCj4gdGhlIE1JUFMgcGxhdGZvcm0gY29kZSBza2lwcGVkIHRoZSBrZXJu
ZWwgLmJzcyBzZWN0aW9uLCB3aGljaCBkZWZpbml0ZWx5DQo+IHNob3VsZCBiZSBpbiB0aGUgYm9v
dCBtZW0gcG9vbCBhcyB3ZWxsIGluIGFueSBjYXNlLiBMZXRzIGZpeCB0aGlzIGp1c3QgYmUNCj4g
YWRkaW5nIHRoZSBzcGFjZSBiZXR3ZWVuIF9fYnNzX3N0YXJ0IGFuZCBfX2Jzc19zdG9wLg0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IE1hdHQgUmVkZmVhcm4gPG1hdHQucmVkZmVhcm5AbWlwcy5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCg0K
QXBwbGllZCB0byBtaXBzLW5leHQuDQoNClRoYW5rcywNCiAgICBQYXVsDQoNClsgVGhpcyBtZXNz
YWdlIHdhcyBhdXRvLWdlbmVyYXRlZDsgaWYgeW91IGJlbGlldmUgYW55dGhpbmcgaXMgaW5jb3Jy
ZWN0DQogIHRoZW4gcGxlYXNlIGVtYWlsIHBhdWwuYnVydG9uQG1pcHMuY29tIHRvIHJlcG9ydCBp
dC4gXQ0K
