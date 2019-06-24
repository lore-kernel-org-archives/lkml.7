Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88996C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4736020665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Vd/Fux5c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="MZFKcOED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfFXTNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:13:47 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:54650 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfFXTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:13:46 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6837AC016F;
        Mon, 24 Jun 2019 19:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1561403625; bh=IyQcSOT5phDqPIxpqTAJLZWOKuI5yxfsa6BkTsQXkpE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Vd/Fux5cMf3TkVNXFGODYhjzaOew3Z7Nm2z+74S8qfpqPLW+e+h14kjL8eYPqmJUL
         HCqWcsm/GZd/L8giNDm2RmO+l84ZkgxcFI8JmcHWhm7kZZa5NRXbjUnjKZKYA9297I
         lAGnLxMjFPvUxeVBPEzRa8dRCp+E1YSmT9p6gLBGJ5NzcrAEFjP8Ha0gb3KLgaGQR/
         Rx8ShrdibRw1qZgP1V+pUl1LMkb9ouYUdEd94MwQiHh1lrzTnBmDK1i8RD8LeYnOmT
         v9nbp1nyplCDShm0RLXoVWPm/sS070aVOm1WQJV6sR3Dasfpsm8TmVnnN8roNCncqt
         BawwuYcdoU3XA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D5776A0096;
        Mon, 24 Jun 2019 19:13:43 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 24 Jun 2019 12:13:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 24 Jun 2019 12:13:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyQcSOT5phDqPIxpqTAJLZWOKuI5yxfsa6BkTsQXkpE=;
 b=MZFKcOED8DPBn+ydGCyMPh0pj/Oa7kOV0EuvmcuxyaBDDOOgewPfnzyWxFRQwU20byUZvL6aviK+ZyW2keGrKjCkGx8Dp4iv/2JUpevaj/zlMI2+y2NcGOSTfp/GVihHFiIBz9t/JhV6qfUgtQBcw/slnkOwkNHkMG23FEBoEe0=
Received: from SN6PR12MB2670.namprd12.prod.outlook.com (52.135.103.23) by
 SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 19:13:17 +0000
Received: from SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495]) by SN6PR12MB2670.namprd12.prod.outlook.com
 ([fe80::bd34:8d2b:911e:e495%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 19:13:17 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "hch@lst.de" <hch@lst.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 7/7] arc: use the generic remapping allocator for coherent
 DMA allocations
Thread-Topic: [PATCH 7/7] arc: use the generic remapping allocator for
 coherent DMA allocations
Thread-Index: AQHVIsAMmlRh09Vs6Ea+qlthrKcWyaabcdSAgADzXACADnLDgIAAZD4A
Date:   Mon, 24 Jun 2019 19:13:17 +0000
Message-ID: <d9ed8f6a82801b94d1d7792eb74effdbce09ce51.camel@synopsys.com>
References: <20190614144431.21760-1-hch@lst.de>
         <20190614144431.21760-8-hch@lst.de>
         <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
         <20190615083554.GC23406@lst.de> <20190624131417.GA10593@lst.de>
In-Reply-To: <20190624131417.GA10593@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9bf598d-5d1a-4ac0-430b-08d6f8d8038d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR12MB2800;
x-ms-traffictypediagnostic: SN6PR12MB2800:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2800D1C5DE499564F45D549ADEE00@SN6PR12MB2800.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(6506007)(186003)(6486002)(8676002)(966005)(118296001)(36756003)(26005)(2501003)(71200400001)(71190400001)(25786009)(86362001)(5660300002)(73956011)(66446008)(66556008)(4326008)(478600001)(14454004)(66946007)(76116006)(91956017)(64756008)(66476007)(68736007)(81156014)(81166006)(486006)(476003)(3846002)(102836004)(256004)(6116002)(229853002)(446003)(11346002)(305945005)(2616005)(7736002)(8936002)(2906002)(316002)(54906003)(66066001)(110136005)(99286004)(6246003)(107886003)(76176011)(53936002)(6436002)(6306002)(6512007)(2201001)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2800;H:SN6PR12MB2670.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iJ00g2zT/4WhtbWYRO981jCmUehKik1S1XFkB9HJQGGcK95tVTzVfBQNZLobYZ8zhzgJjVXLEiaDth6my/r3oYrXJXo/24LiZpw3wfuCFbkKb6gJNWKx8Ttgy6X1XhFqE78PYHqUWojTGu9V0k9i+W4AfI9Rc9FCELfjTnL+jdXD5OVs4EDJ0XiM5IOpcoBIjDBRqJ04OlpLZB8wxT6P2wvMdx8AOlEmbAJrPnl++7HkS3ncI8c0VjL/gWTU3y6jQ22GRNBb3dPvilvFuVr3KZV/Pa+Zd7uRH+Zk5E/vkt7GDzdW+Cdjk4OYPmw2Ld5cumswQla+lF0r2VRx4KrW/B23elVDn4ymvWLeySeq2Mdy9aj+ec9b2BovBpMD+RAgS1huJqyvD69bLWKGzLME7lxsqBZlPYBU6QNYA1OxLps=
Content-Type: text/plain; charset="utf-8"
Content-ID: <023BB888034E2E4CB28D67BF3924C4C3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bf598d-5d1a-4ac0-430b-08d6f8d8038d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 19:13:17.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paltsev@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2800
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpZZXAgSSd2ZSByZXZpZXdlZCBhbmQgdGVzdGVkIGl0IGZvciBib3Ro
IGNhc2VzOg0KLSBjb2hlcmVudC9ub25jb2hlcmVudCBkbWENCi0gYWxsb2NhdGlvbiBmcm9tIGF0
b21pY19wb29sL3JlZ3VsYXIgYWxsb2NhdGlvbg0KDQpldmVyeXRoaW5nIHdvcmtzIGZpbmUgZm9y
IEFSQy4NCg0KU28sDQoNClJldmlld2VkLWJ5OiBFdmdlbml5IFBhbHRzZXYgPHBhbHRzZXZAc3lu
b3BzeXMuY29tPg0KVGVzdGVkLWJ5OiBFdmdlbml5IFBhbHRzZXYgPHBhbHRzZXZAc3lub3BzeXMu
Y29tPg0KDQpmb3IgYm90aA0KW1BBVENIIDIvN10gYXJjOiByZW1vdmUgdGhlIHBhcnRpYWwgRE1B
X0FUVFJfTk9OX0NPTlNJU1RFTlQgc3VwcG9ydA0KW1BBVENIIDcvN10gYXJjOiB1c2UgdGhlIGdl
bmVyaWMgcmVtYXBwaW5nIGFsbG9jYXRvciBmb3IgY29oZXJlbnQgRE1BIGFsbG9jYXRpb25zDQoN
Cg0KT24gTW9uLCAyMDE5LTA2LTI0IGF0IDE1OjE0ICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0K
PiBPbiBTYXQsIEp1biAxNSwgMjAxOSBhdCAxMDozNTo1NEFNICswMjAwLCBoY2hAbHN0LmRlIHdy
b3RlOg0KPiA+IE9uIEZyaSwgSnVuIDE0LCAyMDE5IGF0IDA2OjA1OjAxUE0gKzAwMDAsIEV1Z2Vu
aXkgUGFsdHNldiB3cm90ZToNCj4gPiA+IEhpIENocmlzdG9waCwNCj4gPiA+IA0KPiA+ID4gUmVn
dWxhciBxdWVzdGlvbiAtIGRvIHlvdSBoYXZlIGFueSBwdWJsaWMgZ2l0IHJlcG9zaXRvcnkgd2l0
aCBhbGwgdGhpcyBkbWEgY2hhbmdlcz8NCj4gPiA+IEkgd2FudCB0byB0ZXN0IGl0IGZvciBBUkMu
DQo+ID4gPiANCj4gPiA+IFByZXR0eSBzdXJlIHRoZQ0KPiA+ID4gIFtQQVRDSCAyLzddIGFyYzog
cmVtb3ZlIHRoZSBwYXJ0aWFsIERNQV9BVFRSX05PTl9DT05TSVNURU5UIHN1cHBvcnQNCj4gPiA+
IGlzIGZpbmUuDQo+ID4gPiANCj4gPiA+IE5vdCBzbyBzdXJlIGFib3V0DQo+ID4gPiAgW1BBVENI
IDcvN10gYXJjOiB1c2UgdGhlIGdlbmVyaWMgcmVtYXBwaW5nIGFsbG9jYXRvciBmb3IgY29oZXJl
bnQgRE1BIGFsbG9jYXRpb25zDQo+ID4gPiA6KQ0KPiA+IA0KPiA+ICAgIGdpdDovL2dpdC5pbmZy
YWRlYWQub3JnL3VzZXJzL2hjaC9taXNjLmdpdCBkbWEtbm90LWNvbnNpc3RlbnQtY2xlYW51cA0K
PiA+IA0KPiA+IEdpdHdlYjoNCj4gPiANCj4gPiAgICANCj4gPiBodHRwczovL3VybGRlZmVuc2Uu
cHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cC0zQV9fZ2l0LmluZnJhZGVhZC5vcmdfdXNlcnNf
aGNoX21pc2MuZ2l0X3Nob3J0bG9nX3JlZnNfaGVhZHNfZG1hLTJEbm90LTJEY29uc2lzdGVudC0y
RGNsZWFudXAmZD1Ed0lCQWcmYz1EUEw2X1hfNkprWEZ4N0FYV3FCMHRnJnI9WmxKTjFNcmlQVVRr
QktDclBTeDY3R21hcGxFVUdjQUVrOXlQdENMZFVYSSZtPWlwWUFtWDNyd0x4RElkWFV6dFRNWUJa
a0tGR1pCWTl2eWtKVkJ3cV9LWEUmcz11UldLUW9EVDhwUEtSUFlDQjZrNG9PM210UkZSTnlMb2xS
RGVCQklWdE5RJmU9DQo+ID4gIA0KPiANCj4gRGlkIHlvdSBnZXQgYSBjaGFuY2UgdG8gbG9vayBp
bnRvIHRoZXNlIHBhdGNoZXM/DQotLSANCiBFdWdlbml5IFBhbHRzZXYNCg==
