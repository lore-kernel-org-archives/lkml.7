Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FBC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68D20883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="Rl/Q2B6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfFYWa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:30:27 -0400
Received: from mail-eopbgr720105.outbound.protection.outlook.com ([40.107.72.105]:12896
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbfFYWa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector2-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3rqni2+BLAWAkiseDRe74ptX2Ks3iYXUV0ZtHgUjrU=;
 b=Rl/Q2B6BOJG/TkTKCuTvKS9PnTIms5jlnCSKlNJViSOyYTR0d7HNFJKbBSVsSYLtMkSGiOsVS3mBoLv9iHKCSXds5zA3AsiZ28xPJaeRxWgIWJiinHC/EHHCMnCqTeugbnthjhkOS4rK++ELOGHkH6Ue5IJYSkScbD06F/qfJkA=
Received: from DM6PR01MB4090.prod.exchangelabs.com (20.176.104.151) by
 DM6PR01MB5308.prod.exchangelabs.com (20.177.220.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 22:30:22 +0000
Received: from DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3]) by DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::f0f2:16e1:1db7:ccb3%7]) with mapi id 15.20.2008.017; Tue, 25 Jun 2019
 22:30:22 +0000
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
Subject: [PATCH 0/5] Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
Thread-Topic: [PATCH 0/5] Enable CONFIG_NODES_SPAN_OTHER_NODES by default for
 NUMA
Thread-Index: AQHVK6WT5IKFNhd5LECqV06L4uyCQA==
Date:   Tue, 25 Jun 2019 22:30:22 +0000
Message-ID: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
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
x-ms-office365-filtering-correlation-id: 8a4e6c9e-b057-4523-802f-08d6f9bcb5ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR01MB5308;
x-ms-traffictypediagnostic: DM6PR01MB5308:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR01MB530847C909F7927B6CFFC24BF1E30@DM6PR01MB5308.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(39840400004)(346002)(396003)(199004)(189003)(256004)(4326008)(53936002)(14454004)(4744005)(7736002)(52116002)(107886003)(50226002)(6486002)(6306002)(81156014)(81166006)(64756008)(8936002)(66446008)(8676002)(6436002)(110136005)(26005)(5660300002)(99286004)(66946007)(73956011)(6506007)(186003)(386003)(102836004)(66066001)(2906002)(305945005)(54906003)(2616005)(66556008)(66476007)(316002)(476003)(6512007)(1511001)(478600001)(71190400001)(3846002)(71200400001)(7416002)(6116002)(86362001)(25786009)(966005)(68736007)(486006)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB5308;H:DM6PR01MB4090.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uUWyWIO3XYl/IvqhGgKh6nTelMB7NlG3U9P+7t/Fzet3DEau2Tp6RQicm9gCc0BEfOUGRD7LUZH+rG+CXt4x3s6NDcAOOZZV8Pq43tM6Wa0M8effNoHH13mDx3vEFWBKtoQdMSIF+RqUFM5nA1Gr6TcOU9hZwjc/TtU05ojcgkxryqgFALIFwgHH+28HH71OBd01tDTpXmKrBDjqmudCSddlB3eSnGu2kYQPT5c7Own1/wiIp3A9rdNQGIH9UVFfLK5MiNVwWbybI7FemNcIXkUEk7WjktOMEfB9S+vX2H/oeuwSlWx8OT0VLgfsBO6qKojsyBJz8ieZioaIZzXp7pazfx1vlA3nnBxrwo9+fclLsCYkfvodEjli3BCfNpIEK8103V8p33PbjGXN/xgbH2swQSa/7HoIyvvkyEbEuhk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4e6c9e-b057-4523-802f-08d6f9bcb5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 22:30:22.4354
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

VGhpcyBwYXRjaCBzZXQgZW5hYmxlcyBDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RFUyBieSBk
ZWZhdWx0DQpmb3IgTlVNQS4NCg0KVGhlIG9yaWdpbmFsIHBhdGNoIFsxXQ0KWzFdIGFybTY0OiBL
Y29uZmlnOiBFbmFibGUgTk9ERVNfU1BBTl9PVEhFUl9OT0RFUyBjb25maWcgZm9yIE5VTUENCmh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2FybS1rZXJuZWwvbXNnNzM3MzA2Lmh0bWwNCg0K
SG9hbiBUcmFuICg1KToNCiAgbW06IEVuYWJsZSBDT05GSUdfTk9ERVNfU1BBTl9PVEhFUl9OT0RF
UyBieSBkZWZhdWx0IGZvciBOVU1BDQogIHBvd2VycGM6IEtjb25maWc6IFJlbW92ZSBDT05GSUdf
Tk9ERVNfU1BBTl9PVEhFUl9OT0RFUw0KICB4ODY6IEtjb25maWc6IFJlbW92ZSBDT05GSUdfTk9E
RVNfU1BBTl9PVEhFUl9OT0RFUw0KICBzcGFyYzogS2NvbmZpZzogUmVtb3ZlIENPTkZJR19OT0RF
U19TUEFOX09USEVSX05PREVTDQogIHMzOTA6IEtjb25maWc6IFJlbW92ZSBDT05GSUdfTk9ERVNf
U1BBTl9PVEhFUl9OT0RFUw0KDQogYXJjaC9wb3dlcnBjL0tjb25maWcgfCA5IC0tLS0tLS0tLQ0K
IGFyY2gvczM5MC9LY29uZmlnICAgIHwgOCAtLS0tLS0tLQ0KIGFyY2gvc3BhcmMvS2NvbmZpZyAg
IHwgOSAtLS0tLS0tLS0NCiBhcmNoL3g4Ni9LY29uZmlnICAgICB8IDkgLS0tLS0tLS0tDQogbW0v
cGFnZV9hbGxvYy5jICAgICAgfCAyICstDQogNSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMzYgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi43LjQNCg0K
