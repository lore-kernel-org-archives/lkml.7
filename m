Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D88B208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="G6CRq2cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfDZQnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:43:15 -0400
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:41632
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDZQnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLLKAhzdHx7DUdYm/ixbvignsGY2pog+oWt8K53xdOE=;
 b=G6CRq2cvYPDcqznoif5lXD2FoBWbIhBrzH3TNJHAV+1oxm37LjqntTt+xfdFz/n4bOApsZPnhRfOvtReVFRFp+zxQI7e2/tlpTVvoCEEn08OI6WeoUMrzfPa59/1zZiHvrExm/K2BPJThdXo4lM3MrnL0ufX4P0BsMbAXeLZMPg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4903.namprd05.prod.outlook.com (52.135.235.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.6; Fri, 26 Apr 2019 16:43:09 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094%3]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 16:43:09 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v5 14/23] x86/mm/cpa: Add set_direct_map_ functions
Thread-Topic: [PATCH v5 14/23] x86/mm/cpa: Add set_direct_map_ functions
Thread-Index: AQHU/E7LDKApHlfkUkuITMJWRFardKZOpaMA
Date:   Fri, 26 Apr 2019 16:43:09 +0000
Message-ID: <636228FC-71D6-418F-B671-4D6A3B69342C@vmware.com>
References: <20190426001143.4983-1-namit@vmware.com>
 <20190426001143.4983-15-namit@vmware.com>
 <CAADWXX8yZJ9Z4yfqG9wQcb2r+0O7VCk2uQLcOU1=-BOnYhjnow@mail.gmail.com>
In-Reply-To: <CAADWXX8yZJ9Z4yfqG9wQcb2r+0O7VCk2uQLcOU1=-BOnYhjnow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79778191-c6b0-4e1c-eb4a-08d6ca6643f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB4903;
x-ms-traffictypediagnostic: BYAPR05MB4903:
x-microsoft-antispam-prvs: <BYAPR05MB4903D9CE7FDA7C97EA7CB71ED03E0@BYAPR05MB4903.namprd05.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(7416002)(4326008)(7736002)(476003)(66476007)(305945005)(25786009)(6512007)(2906002)(3846002)(6116002)(66066001)(8936002)(446003)(66446008)(186003)(64756008)(486006)(4744005)(66556008)(11346002)(6246003)(2616005)(26005)(53936002)(68736007)(5660300002)(73956011)(256004)(86362001)(66946007)(102836004)(53546011)(6506007)(76116006)(6436002)(54906003)(71200400001)(76176011)(81166006)(83716004)(316002)(99286004)(6916009)(81156014)(97736004)(8676002)(36756003)(6486002)(229853002)(33656002)(71190400001)(82746002)(478600001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4903;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ch5Q0ftsms5PAZYP3L25ycivx2UG2U3d4o7m19Iy/OP40CSsWfsHcpUUdXi9MCzYmwpGGwi1vwR0NLdqooqHVlLTWv+t8ePq5qu8eoBao38U+kz+81lEM95jwcfwKRMRWvOqNto+HVEBgQ4z9/1W241V2aTWioNfAxsyWGSHo06vTtkkdumC1LK+knuW/12aZvfsmgkL+cN4dCRNcHRjI7/JkJlMZXkkhhQcyZMvOTpIN6lm4QQHakJYxaJ5K9mprXnfgZEjxVi9EmL1eXTztnxBbUA5GEqLAHa+J7KyBZFK3RAkrQyd6t7A9g0LZb0yM1THi17z/lQX8EtNs6Qml8+spixG9j7L+2A2i95SqBjyaRBSyKfOgqRu1lyTcrHPjDy+FbOD7X5KYXzYfO8t+TPNfeUh0mRP4zcqhvfqkyo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1C68EF185691D48BD87873B5B102692@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79778191-c6b0-4e1c-eb4a-08d6ca6643f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 16:43:09.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMjYsIDIwMTksIGF0IDk6NDAgQU0sIExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0Bs
aW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBOYWRhdiwNCj4gDQo+IEkgZ2V0DQo+
IA0KPiAgICAgICBkbWFyYz1mYWlsIChwPVFVQVJBTlRJTkUgc3A9Tk9ORSBkaXM9UVVBUkFOVElO
RSkgaGVhZGVyLmZyb209dm13YXJlLmNvbQ0KPiANCj4gZm9yIHRoZXNlIGVtYWlscywgYmVjYXVz
ZSB0aGV5IGxhY2sgdGhlIHZtd2FyZSBES0lNIHNpZ25hdHVyZS4NCj4gDQo+IEl0IGNsZWFybHkg
ZGlkIGdvIHRocm91Z2ggc29tZSB2bXdhcmUgbWFpbCBzZXJ2ZXJzLCBidXQgYXBwYXJlbnRseSBu
b3QNCj4gdGhlICpyaWdodCogZXh0ZXJuYWwgdm13YXJlIFNNVFAgZ2F0ZXdheS4NCj4gDQo+IFBs
ZWFzZSBjaGVjayB3aXRoIHZtd2FyZSBNSVMgd2hhdCB0aGUgcmlnaHQgU01UUCBzZXR1cCBmb3Ig
Z2l0LXNlbmQtZW1haWwgaXMuDQoNCkVyci4uIFNvcnJ5IGZvciB0aGF0LiBGb3IgdGhlIHRpbWUg
YmVpbmcgSeKAmWxsIHVzZSBnbWFpbCBpbnN0ZWFkLg0KDQo=
