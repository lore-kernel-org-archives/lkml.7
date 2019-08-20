Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3613EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5D120656
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mNiM6P4a";
	dkim=temperror (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gp/3Ulfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfHTU2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:28:44 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40898 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566332920; x=1597868920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vXFbIxfXHxY6V6vbwEVERjWGb8ao8+gvkUXsX9msfgk=;
  b=mNiM6P4aC1l03a1mqwkE18UF5l8od9pRZBZ7Ymj4Vdg5vYox1aqOLjC9
   GNfQ4KJFScB29+2O+SuoXtqnv65x+diAau5OD5NCjAVuCFewvC6HKzOST
   sMNuUunAgecozJDgVDZhvVU+wMhRuHXWV00vTmyhUIU0s40uAwMpd8DHa
   AI6b/TtzfwMiR/og3jQnVVQj5RDL0k+Ru2+Ie445T1PSnwGOt6SWfXeSA
   Q0mUEgTF0RXjql9CS38itAS23dxrGDDR3G6fKd632mYRHPahsgLGdNAb0
   aueeTdq/vkRz6SVk04hgT6dNR50ZmTtNwTEkLaeYhGq/0v2CYLAs33M9L
   g==;
IronPort-SDR: nYK9g8F/C/aIozDRL6a8K3XTEThFLb95Kz1t/JahcEBgRHQOrph0GEQa+r3Yjk4KZrzn+DdeWQ
 7TZjy/Q+21n1JFYW4FGsA5HX9BSWLLOIgUopgP0pMrIGNcYcxIbiZQq5IviaN3w/PXqFe8eexT
 9PpYTqn8Y80AYqcf5XYj3odSqZXrhRqFvNod0BZlb5zrL+g9ZgxwmLBPZwJvf7hqTj17CwR5lj
 x8iJjr3k9+wfb6YInkH8Jp0AiyyrwsExxtRp7IZDY/ByZCLEXJVfxWZTXjf5op+HSNHLXxnmSV
 8rA=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="117212158"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 04:28:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gI2Y28iZM7glFZpcfTxb/mGawnwfuFh25Aywdj74+ZWqn3gYMmiDEEkJfX2xciXyV6f8CS0HJbHN3q8NLKFaOenuxQxqnqPFeEox81TqFsMdv4kOwFIU2fmYllgQ53cEie/oGEcNzpRGjwaGLBNW5koRyBZI6ZOmRrngYgDDdA3vTIKRAkQj7r1+SRcvTSOAKv4zRivP300wz5uIr2g9DtwU59LO9wdRiWod9ZbW2WT4IUHney4GR6bQZIDcJ0Zo7zcbf80h77H7Mk3UR3XQwQEWFL+X5+dkXLAzDHbLCg+Wlx/JOnPRJhkfFjyqfhqKyS4SGw1fx0p6si2yasYeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXFbIxfXHxY6V6vbwEVERjWGb8ao8+gvkUXsX9msfgk=;
 b=CRCXEvz4x/DuuKQIctWH9wc65srXVf6TfsiTvpGF6s1OcRJeAfVciPN9H6qXaoG5JyHZcxl1DHsF4Ad9G6m/abC4bZ/jF7cvlJK2FzsLOG4CyEWI0M8RCdIYIlo9cw1fxb9XWaDkWiVjrDnLjDMsJzfL5qjnkF9iELKGx0/8GSk3xqKpf0XxfZJn5Yg6VTHd795Z0jsGRCyy4IZB/MpTNZuG2fFzrphHdAthdvWrzle4wmQtH1LNmZqhugYq1SnEfIFSh/wJlf/epzQhWCTsjcH7OJaat6pnAExkWL1XO6nKT6E19q4xIHnO4Ub8HdO3A1G7UyD6QHoPZV0Mh4LhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXFbIxfXHxY6V6vbwEVERjWGb8ao8+gvkUXsX9msfgk=;
 b=Gp/3UlfavxrWBsY/Jmor4rtH4VmBGw++f8L2rCxB0Z+7ADuDU9C9Z7f+DTRTubGfKSG//FuCyhJdInEAA0eAlMesWysl4Xmjth8Bn0/IQ++dXU60RtMs998k/hHDLYdMFds2h7WxeOtVXtwu19QWVmUj/EPfUlj9i+ctSOWNDVo=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5864.namprd04.prod.outlook.com (20.179.59.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 20:28:36 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 20:28:36 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Topic: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Index: AQHVVvDfUBJCIAOoL0y7jXfLdcYugacDqN07gAAPmgCAAAsggIAAujWA
Date:   Tue, 20 Aug 2019 20:28:36 +0000
Message-ID: <76467815b464709f4c899444c957d921ebac87db.camel@wdc.com>
References: <20190820004735.18518-1-atish.patra@wdc.com>
         <mvmh86cl1o3.fsf@linux-m68k.org>
         <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
         <20190820092207.GA26271@infradead.org>
In-Reply-To: <20190820092207.GA26271@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95748c52-16ef-42cf-669c-08d725acfa88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5864;
x-ms-traffictypediagnostic: BYAPR04MB5864:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB58645E999DEBA94537155289FAAB0@BYAPR04MB5864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(25786009)(966005)(476003)(2616005)(81166006)(2351001)(6246003)(2501003)(1730700003)(76176011)(6916009)(81156014)(14454004)(4326008)(229853002)(8936002)(99286004)(3846002)(316002)(2906002)(54906003)(305945005)(6116002)(71200400001)(71190400001)(66556008)(66476007)(26005)(86362001)(64756008)(76116006)(486006)(66946007)(6436002)(66066001)(186003)(478600001)(446003)(5660300002)(7736002)(11346002)(53936002)(118296001)(6486002)(102836004)(6306002)(5640700003)(6512007)(6506007)(36756003)(256004)(66446008)(8676002)(562404015);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5864;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VuoDyGS73IpbDrAgZyopH5oNqOF38w6fnjWfyZofEJo1+alCVUlf112XRugovfoyKky6MFfUFfxUa7NXzr1gzmiznEk2MEc0VCIlhFMi3189iNjPXSjyc4lfm/50+qtTcBN5bgPINN4PYfc2JjrbbdoCdsCpb11MQEYhn1+ZdLmWa2ImUigp7sRgcv/5XM1/6Uy6O9RsfD/vQmvq1BUtOz85Y20VuOQ+SqfIRRDS3QIE1GKXV4mK8JZBSRbeCjbH19nT5yVUjVpXwt3WyPiSpvVeGhQDhetBfCsxeld01w/KEFXT9wZqcj2XpRXwfaQs1cVOI1w0xRAa+DRquzM5zZACOrxn8cU6Efiuhp2rdFKYrJJXSDLVXTtAKTbGNTzlnI2hYVdReXzogCcH6ZY6vNPW1X+3FB15PgfOrC9OtQw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D822BBE7C813344882B138958EBA68F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95748c52-16ef-42cf-669c-08d725acfa88
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 20:28:36.3510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQIphuMEkt5TFD98gQhYlVrNBSZmwbC7FbW2uQzma5TVJ424F0gYSYgKXpqXcnuSYyYSRxwrselvtdGdOGcRNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTIwIGF0IDAyOjIyIC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMjAsIDIwMTkgYXQgMDg6NDI6MTlBTSArMDAwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gY21hc2sgTlVMTCBpcyBwcmV0dHkgY29tbW9uIGNhc2UgYW5kIHdlIHdv
dWxkICBiZSB1bm5lY2Vzc2FyaWx5DQo+ID4gZXhlY3V0aW5nIGJ1bmNoIG9mIGluc3RydWN0aW9u
cyBldmVyeXRpbWUgd2hpbGUgbm90IHNhdmluZyBtdWNoLg0KPiA+IEtlcm5lbA0KPiA+IHN0aWxs
IGhhdmUgdG8gbWFrZSBhbiBTQkkgY2FsbCBhbmQgT3BlblNCSSBpcyBkb2luZyBhIGxvY2FsIGZs
dXNoDQo+ID4gYW55d2F5cy4NCj4gPiANCj4gPiBMb29raW5nIGF0IHRoZSBjb2RlIGFnYWluLCBJ
IHRoaW5rIHdlIGNhbiBqdXN0IHVzZSBjcHVtYXNrX3dlaWdodA0KPiA+IGFuZA0KPiA+IGRvIGxv
Y2FsIHRsYiBmbHVzaCBvbmx5IGlmIGxvY2FsIGNwdSBpcyB0aGUgb25seSBjcHUgcHJlc2VudC4g
DQo+ID4gDQo+ID4gT3RoZXJ3aXNlLCBpdCB3aWxsIGp1c3QgZmFsbCB0aHJvdWdoIGFuZCBjYWxs
DQo+ID4gc2JpX3JlbW90ZV9zZmVuY2Vfdm1hKCkuDQo+IA0KPiBNYXliZSBpdCBpcyBqdXN0IHRp
bWUgdG8gc3BsaXQgdGhlIGRpZmZlcmVudCBjYXNlcyBhdCBhIGhpZ2hlciBsZXZlbC4NCj4gVGhl
IGlkZWEgdG8gbXVsdGlwbGUgZXZlcnl0aGluZyBvbnRvIGEgc2luZ2xlIGZ1bmN0aW9uIGFsd2F5
cyBzZWVtZWQNCj4gb2RkIHRvIG1lLg0KPiANCj4gRllJLCBoZXJlIGlzIHdoYXQgSSBkbyBmb3Ig
dGhlIElQSSBiYXNlZCB0bGJmbHVzaCBmb3IgdGhlIG5hdGl2ZSBTLQ0KPiBtb2RlDQo+IGNsaW50
IHByb3RvdHlwZSwgd2hpY2ggc2VlbXMgbXVjaCBlYXNpZXIgdG8gdW5kZXJzdGFuZDoNCj4gDQo+
IGh0dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy91c2Vycy9oY2gvcmlzY3YuZ2l0L2NvbW1pdGRpZmYv
ZWE0MDY3YWU2MWUyMGZjZmNmNDZhNmY2YmQxY2MyNTcxMGNlM2FmZQ0KDQpUaGlzIGRvZXMgc2Vl
bSBhIGxvdCBjbGVhbmVyIHRvIG1lLiBXZSBjYW4gcmV1c2Ugc29tZSBvZiB0aGUgY29kZSBmb3IN
CnRoaXMgcGF0Y2ggYXMgd2VsbC4gQmFzZWQgb24gTkFUSVZFX0NMSU5UIGNvbmZpZ3VyYXRpb24s
IGl0IHdpbGwgc2VuZA0KYW4gSVBJIG9yIFNCSSBjYWxsLg0KDQpJIGNhbiByZWJhc2UgbXkgcGF0
Y2ggb24gdG9wIG9mIHlvdXJzIGFuZCBJIGNhbiBzZW5kIGl0IHRvZ2V0aGVyIG9yIHlvdQ0KY2Fu
IGluY2x1ZGUgaW4geW91ciBzZXJpZXMuDQoNCkxldCBtZSBrbm93IHlvdXIgcHJlZmVyZW5jZS4N
Cg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
