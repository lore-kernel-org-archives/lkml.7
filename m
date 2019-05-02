Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D80C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895E62075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jR1jMCtj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C9GEZdbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfEBFCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:02:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39259 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfEBFCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556773352; x=1588309352;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=JCJLG/kg5ol/IyFGoBXS5qz9YmBN5nMfmWI+NFAdTAI=;
  b=jR1jMCtjBiEkOZ9U+96MRQEHLDuvqXCD1q4+GfnDzgJ3g9T6GVxSAAJ5
   snAJRjd6jmS5st2Rl5tOK/0YQeZGBqbUuk94DuI2tZ4yK/ULVDKecGkrI
   eYXFQMflEPvS/pawCYv4hWZF9aPxXxEdc88Wcoxajdd2JPMMSpBjJEXSq
   +uYF7/BBHwd7ymYO9ih01c8hxXDjoc4uzVQpfAC/hloTEKSAudQ5jT4+5
   dh8MH11Nruf9Fr53Uj/Uvg2UOlLRm7SFeaCMs3zbxHOQdbqVwLUCOb0LI
   jiTt/lIiOzSTb5ONC5ubeKD98olTr+ymdNYOT3E6G4ntcVIiWQudaGegO
   A==;
X-IronPort-AV: E=Sophos;i="5.60,420,1549900800"; 
   d="scan'208";a="213245483"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2019 13:02:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCJLG/kg5ol/IyFGoBXS5qz9YmBN5nMfmWI+NFAdTAI=;
 b=C9GEZdbnYCM2S0DBFJM6Adj+XxuBaEzCwpHNb08GT185n9fq3wdxBl5gU+EOuuDvou8wS414bDVSPBhvMxqDAM9DWgaohjL6H/4ymYJiPz1GI9vM9r05zibcel2h5Itn+/nRFuuHd4mgJMZvhLUra05ynMTKBeSOS80Ih1S0cjA=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5582.namprd04.prod.outlook.com (20.178.248.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 05:02:29 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::c500:5fd2:9194:e38]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::c500:5fd2:9194:e38%3]) with mapi id 15.20.1835.015; Thu, 2 May 2019
 05:02:29 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 0/2] Two-stagged initial page table setup
Thread-Topic: [PATCH v4 0/2] Two-stagged initial page table setup
Thread-Index: AQHVAKQ9pUYUirKbmUWBsUMaMukDWw==
Date:   Thu, 2 May 2019 05:02:29 +0000
Message-ID: <20190502050206.23373-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0049.namprd07.prod.outlook.com
 (2603:10b6:a03:60::26) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f87ee622-b327-419e-0537-08d6cebb600e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB5582;
x-ms-traffictypediagnostic: MN2PR04MB5582:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB55826C3C814D3B8C0280630B8D340@MN2PR04MB5582.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(5660300002)(1076003)(6436002)(486006)(305945005)(66066001)(476003)(71200400001)(71190400001)(26005)(44832011)(81156014)(86362001)(81166006)(8676002)(102836004)(54906003)(2171002)(25786009)(186003)(110136005)(316002)(6486002)(386003)(50226002)(72206003)(6506007)(8936002)(53936002)(256004)(73956011)(36756003)(3846002)(6116002)(2906002)(4326008)(68736007)(2616005)(66946007)(99286004)(7736002)(14454004)(6512007)(478600001)(66446008)(64756008)(66556008)(66476007)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5582;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bC26Y8avk1eQvdQs4H+OH42SIeWx9we5LtNpb9nYAzdynyOuPKWk0hxOssCWRIHNDTBt3fJx2i/UpLR7LwUyZgy8RFGxpnT/TWGYLFThhxD2eT5f+7pkywhicGbzUcJNFL+Okh1LBdg9z3X8EvHUwDlRp0bs0yqL2cFEQdGGWbXUvbyfohgmc3sNiOpwX63XruUBWOWkYkpT9yxRoaYA7XF4xbxC35dPTLo3o0vkEjKa1pCZ09joEhJ93H+sS2Y1nBv21O7UKKDdKWVBH+5EYy95Q17hxiQMmnxXsUYH7jjtoaHeDSq/NieUPOzeih61mXIOOFJKSlPdoLXWiaUsR02SxexoTjaHzlIckxtSgh0tYCMVAKlUNYybA2heh00krN2xcj43frOMa+GG9qEKan4aAc2YfVU/z4lmxPIRIuk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87ee622-b327-419e-0537-08d6cebb600e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 05:02:29.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIHR3by1zdGFnZ2VkIGluaXRpYWwgcGFnZSB0YWJsZSBz
ZXR1cCB1c2luZyBmaXhtYXANCnRvIGF2b2lkIG1hcHBpbmcgbm9uLWV4aXN0ZW50IFJBTSBhbmQg
YWxzbyByZWR1Y2UgaGlnaF9tZW1vcnkgY29uc3VtZWQgYnkNCmluaXRpYWwgcGFnZSB0YWJsZXMu
DQoNClRoZSBwYXRjaHNldCBpcyBiYXNlZCBvbiBMaW51eC01LjEtcmM3IGFuZCB0ZXN0ZWQgb24g
U2lGaXZlIFVubGVhc2hlZCBib2FyZA0KYW5kIFFFTVUgdmlydCBtYWNoaW5lLg0KDQpUaGVzZSBw
YXRjaGVzIGNhbiBiZSBmb3VuZCBpbiByaXNjdl9zZXR1cF92bV92NCBicmFuY2ggb2YNCmh0dHBz
Ly9naXRodWIuY29tL2F2cGF0ZWwvbGludXguZ2l0DQoNCkNoYW5nZXMgc2luY2UgdjM6DQotIENo
YW5nZWQgcGF0Y2ggc2VyaWVzIHN1YmplY3QuDQotIERyb3BwZWQgUEFUQ0gxIGJlY2F1c2UgaXQn
cyBhbHJlYWR5IG1lcmdlZA0KLSBEcm9wcGVkIFBBVENIMyBiZWNhdXNlIHRyYW1wb2xpbmUgcGFn
ZSB0YWJsZSBoYW5kbGVzIGEgY29ybmVyIGNhc2UNCiAgZm9yIDMyYml0IHN5c3RlbXMgd2hlcmUg
bG9hZCBhZGRyZXNzIHJhbmdlIG92ZXJsYXBzIGtlcm5lbCB2aXJ0dWFsDQogIGFkZHJlc3MgcmFu
Z2UNCi0gUmV2YW1wZWQgUEFUQ0ggZm9yIDRLIGFsaWduZWQgYm9vdGluZyBpbnRvIHR3by1zdGFn
Z2VkIGluaXRpYWwgcGFnZQ0KICB0YWJsZSBzZXR1cA0KDQpDaGFuZ2VzIHNpbmNlIHYyOg0KLSBE
cm9wcGVkIFBBVENIMiBiZWNhdXNlIHdlIGhhdmUgc2VwYXJhdGUgZml4IGZvciBMaW51eC01LjEt
cmNYDQotIE1vdmVkIFBBVENINSB0byBQQVRDSDINCi0gTW92ZWQgUEFUQ0g0IHRvIFBBVENIMw0K
LSBUaGUgIkJvb3Rpbmcga2VybmVsIGZyb20gYW55IDRLQiBhbGlnbmVkIGFkZHJlc3MiIGlzIG5v
dyBQQVRDSDQNCg0KQ2hhbmdlcyBzaW5jZSB2MToNCi0gQWRkIGtjb25maWcgb3B0aW9uIEJPT1Rf
UEFHRV9BTElHTkVEIHRvIGVuYWJsZSA0S0IgYWxpZ25lZCBib290aW5nDQotIEltcHJvdmVkIGlu
aXRpYWwgcGFnZSB0YWJsZSBzZXR1cCBjb2RlIHRvIHNlbGVjdCBiZXN0L2JpZ2dlc3QNCiAgcG9z
c2libGUgbWFwcGluZyBzaXplIGJhc2VkIG9uIGxvYWQgYWRkcmVzcyBhbGlnbm1lbnQNCi0gQWRk
ZWQgUEFUQ0g0IHRvIHJlbW92ZSByZWR1bmRhbnQgdHJhbXBvbGluZSBwYWdlIHRhYmxlDQotIEFk
ZGVkIFBBVENINSB0byBmaXggbWVtb3J5IHJlc2VydmF0aW9uIGluIHNldHVwX2Jvb3RtZW0oKQ0K
DQpBbnVwIFBhdGVsICgyKToNCiAgUklTQy1WOiBGaXggbWVtb3J5IHJlc2VydmF0aW9uIGluIHNl
dHVwX2Jvb3RtZW0oKQ0KICBSSVNDLVY6IFNldHVwIGluaXRpYWwgcGFnZSB0YWJsZXMgaW4gdHdv
IHN0YWdlcw0KDQogYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9maXhtYXAuaCAgICAgfCAgIDUgKw0K
IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0YWJsZS02NC5oIHwgICA1ICsNCiBhcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICB8ICAgNyArDQogYXJjaC9yaXNjdi9rZXJuZWwvaGVh
ZC5TICAgICAgICAgICAgfCAgMTcgKy0NCiBhcmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5jICAgICAg
ICAgICB8ICAgNCArLQ0KIGFyY2gvcmlzY3YvbW0vaW5pdC5jICAgICAgICAgICAgICAgIHwgMzI3
ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCiA2IGZpbGVzIGNoYW5nZWQsIDI4OSBpbnNl
cnRpb25zKCspLCA3NiBkZWxldGlvbnMoLSkNCg0KLS0NCjIuMTcuMQ0K
