Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BA5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC7213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="tmug3Ut7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFYWae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:30:34 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:39974
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbfFYWac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector2-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbppUUAYT2AfIAmhAET+jY1XsjbiX6rRh2UHg2M9od0=;
 b=tmug3Ut725wpACc8ydAqEn/tFctxP9ckcgxYgKTDsO92sz7FdLTiIDzgtbCIkboN/JZ3tJaaJ5yIDahgJjqnJHpGJS95sWIzdPoGaaD1tXTIRrhqIbrJ49W7BcCdKiaRuMZuzm02YGl3B3WmSTUfXpn2o2b1H6EAJNX558j1hDY=
Received: from DM6PR01MB4090.prod.exchangelabs.com (20.176.104.151) by
 DM6PR01MB5308.prod.exchangelabs.com (20.177.220.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 22:30:29 +0000
Received: from DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3]) by DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3%7]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 22:30:29 +0000
From:   Hoan Tran OS <hoan@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Hoan Tran OS <hoan@os.amperecomputing.com>
Subject: [PATCH 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Thread-Topic: [PATCH 3/5] x86: Kconfig: Remove CONFIG_NODES_SPAN_OTHER_NODES
Thread-Index: AQHVK6WX71HRsQts10W3HaW79T6UPw==
Date:   Tue, 25 Jun 2019 22:30:29 +0000
Message-ID: <1561501810-25163-4-git-send-email-Hoan@os.amperecomputing.com>
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR22CA0052.namprd22.prod.outlook.com
 (2603:10b6:903:ae::14) To DM6PR01MB4090.prod.exchangelabs.com
 (2603:10b6:5:2a::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [4.28.12.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16a4bc1b-35a8-4854-ac90-08d6f9bcba32
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR01MB5308;
x-ms-traffictypediagnostic: DM6PR01MB5308:
x-microsoft-antispam-prvs: <DM6PR01MB530883287863A748E182FE2DF1E30@DM6PR01MB5308.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39840400004)(346002)(396003)(199004)(189003)(256004)(4326008)(53936002)(14454004)(4744005)(7736002)(52116002)(107886003)(50226002)(6486002)(81156014)(81166006)(64756008)(8936002)(66446008)(8676002)(6436002)(110136005)(26005)(5660300002)(99286004)(66946007)(73956011)(6506007)(76176011)(186003)(386003)(102836004)(66066001)(2906002)(446003)(305945005)(54906003)(2616005)(66556008)(66476007)(11346002)(316002)(476003)(6512007)(1511001)(478600001)(71190400001)(3846002)(71200400001)(7416002)(6116002)(86362001)(25786009)(68736007)(486006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB5308;H:DM6PR01MB4090.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XGqFPyOpimu48tsAkwftSFmED4Px3bP5sV6qJN03m59v8RJn4jMS79/UnHNsZeW4EXKFHP9t9N+pO+r8hq1nOpwO+WsLfsVY6RolBd3Cpcn9CjAB4ohVNIM4ZlzUEtSrjp4K9fW+iSF2OgNm5h9iq2pmulMeD1GBeEcegNJMnJ6iGnz9byQWXpF+vOX358HRhwkj+yWXTeA/83kixGMdJK7ShMTo5eVkt0v6EdFm9PAnbnO8dtaVUBoOI3xYADSwKBqP7o0LCsH7fwuITmByyr0IXdx2VcNH49Qise8qi34VIhHl1acNnK0NR3WLMSQYAw50479HPnNcofF1HdIxTF3PSxhQgVrCRtXFYua39kh9rt6q4nzbW0cLdbS5aK8jcElQvH1KIs76zUukiOEf60CkY/O1mWJSvR17VGjDTF8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a4bc1b-35a8-4854-ac90-08d6f9bcba32
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 22:30:29.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hoan@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCByZW1vdmVzIENPTkZJR19OT0RFU19TUEFOX09USEVSX05PREVTIGFzIGl0J3MN
CmVuYWJsZWQgYnkgZGVmYXVsdCB3aXRoIE5VTUEuDQoNClNpZ25lZC1vZmYtYnk6IEhvYW4gVHJh
biA8SG9hbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPg0KLS0tDQogYXJjaC94ODYvS2NvbmZpZyB8
IDkgLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9LY29uZmlnIGIvYXJjaC94ODYvS2NvbmZpZw0KaW5kZXggMmJiYmQ0ZC4u
ZmE5MzE4YyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L0tjb25maWcNCisrKyBiL2FyY2gveDg2L0tj
b25maWcNCkBAIC0xNTY3LDE1ICsxNTY3LDYgQEAgY29uZmlnIFg4Nl82NF9BQ1BJX05VTUENCiAJ
LS0taGVscC0tLQ0KIAkgIEVuYWJsZSBBQ1BJIFNSQVQgYmFzZWQgbm9kZSB0b3BvbG9neSBkZXRl
Y3Rpb24uDQogDQotIyBTb21lIE5VTUEgbm9kZXMgaGF2ZSBtZW1vcnkgcmFuZ2VzIHRoYXQgc3Bh
bg0KLSMgb3RoZXIgbm9kZXMuICBFdmVuIHRob3VnaCBhIHBmbiBpcyB2YWxpZCBhbmQNCi0jIGJl
dHdlZW4gYSBub2RlJ3Mgc3RhcnQgYW5kIGVuZCBwZm5zLCBpdCBtYXkgbm90DQotIyByZXNpZGUg
b24gdGhhdCBub2RlLiAgU2VlIG1lbW1hcF9pbml0X3pvbmUoKQ0KLSMgZm9yIGRldGFpbHMuDQot
Y29uZmlnIE5PREVTX1NQQU5fT1RIRVJfTk9ERVMNCi0JZGVmX2Jvb2wgeQ0KLQlkZXBlbmRzIG9u
IFg4Nl82NF9BQ1BJX05VTUENCi0NCiBjb25maWcgTlVNQV9FTVUNCiAJYm9vbCAiTlVNQSBlbXVs
YXRpb24iDQogCWRlcGVuZHMgb24gTlVNQQ0KLS0gDQoyLjcuNA0KDQo=
