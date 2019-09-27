Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F2AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1077207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 10:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hIxanbaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfI0KaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 06:30:19 -0400
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:41053
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfI0KaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 06:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HegDtwI6eGb4Q+oAKa6v91JTsK6jckplEoSEhsmeJ+z6TldtGrYlviz3tp9zIJvsPWBxwh9QvW7l4et0DtaofmQd6MTBDia9lJC2c1CpeUC+RhwYAxRByi5/+N1Y1ZVd0A/RtVqlzIHOPMLbnlUYxGB4W19wg4RQ0kZMVtylBO+2LL7iXPZ2wCJHASq2hKdTg4ikHuD/N4urPFDNJQCAq5d08g3KacAQ3oUpkcO5dUX5EB3cx8g9Js2i0Vq4aCr9ykjhMl8l2qxO4Aurp1DIAuQvHlGDbOwwcrRwiaMpiTZ+g5x9xIpmK+w9Bw6pMtxxrHhIsKIHdhg/JDeErvAqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu9nG0z3MrJAwMXdfdakabonTNBsgha3Jrpg2TT4xHY=;
 b=TNAl1M8+PG8AR6Rt2OZhzurtfiD/eRmXgnxJPts6TassVEGS89UycpU7btcq/pGpi9b9y0DDye+y9mFFa5nxNZrxzoqfH0gN426VmOrFOPO2OHYi1lkTD6Y6AYzzSaypKfB9VFLyGXDlUK+pktEQtBTYBlYpVKL8lFxgJ2HcWGv7NcwFLbjwaJBX7NlWFGYSEgKHralz6tK8MAocPQtmjJTfDWaY4Kz1Ph4LQ4uPY3ppcv4ChhzDfHQSGQuAW2dOCJe/iX2Kcxjp9WfAWXS0bSEy6WUMViUmvTSb3QD4i4mwq/gMF97om6GWdi3gfjWtCiEWnkDj7TVBS9ZchPs1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu9nG0z3MrJAwMXdfdakabonTNBsgha3Jrpg2TT4xHY=;
 b=hIxanbaGA+zl0TjdbQDZez3TqVkomYbdctybWE0WYjBI57lXD33ZzICK80zCoeGgVGSB/Fp2reKKAOTmU6pZQI/66mTe+4cEQzg48XTeRLh48fg2IK/1JK+vMEuq+uRkL1n02WWz5Mv4wTKfavATWsWwYV9zkXWy2z0zLhI+LMQ=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (52.132.197.151) by
 SN1PR12MB2478.namprd12.prod.outlook.com (52.132.196.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Fri, 27 Sep 2019 10:30:16 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::cca6:20d4:7aee:2aaf]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::cca6:20d4:7aee:2aaf%3]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 10:30:16 +0000
From:   "Shah, Nehal-bakulchandra" <nbshah@amd.com>
To:     Kurt Garloff <kurt@garloff.de>, Joerg Roedel <joro@8bytes.org>,
        Jiri Kosina <jikos@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>
Subject: Re: IOMMU vs Ryzen embedded EMMC controller
Thread-Topic: IOMMU vs Ryzen embedded EMMC controller
Thread-Index: AQHVb7hsQOyE/u2Eok64rlGlf/1aqKc1tHeAgAbXlwCAAAROAIACwXIAgAALx4A=
Date:   Fri, 27 Sep 2019 10:30:16 +0000
Message-ID: <63913cd8-a0c5-61e3-2f52-139bade01afc@amd.com>
References: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de>
 <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de>
 <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm>
 <20190925154256.GB4643@8bytes.org>
 <70b2d326-6257-025c-5ffa-1f543a900073@garloff.de>
In-Reply-To: <70b2d326-6257-025c-5ffa-1f543a900073@garloff.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::33) To SN1PR12MB2575.namprd12.prod.outlook.com
 (2603:10b6:802:2b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63e4d5a8-a70b-4f78-9f26-08d74335afd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN1PR12MB2478;
x-ms-traffictypediagnostic: SN1PR12MB2478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB24788DBE89F6826D49EA4F08A0810@SN1PR12MB2478.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(52116002)(71190400001)(81156014)(2906002)(76176011)(99286004)(102836004)(186003)(26005)(5024004)(25786009)(66574012)(386003)(8676002)(3846002)(53546011)(6506007)(6116002)(14454004)(81166006)(6512007)(7736002)(66066001)(8936002)(305945005)(66476007)(6486002)(31686004)(256004)(316002)(2616005)(11346002)(476003)(64756008)(486006)(66446008)(4326008)(6246003)(110136005)(6436002)(66946007)(229853002)(71200400001)(66556008)(54906003)(478600001)(5660300002)(31696002)(36756003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2478;H:SN1PR12MB2575.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1n7Pqrj86JOXjBsTGEwC1U7ndGu67p3tmpNx4eGRdraj0U425o2NGw25/+Siu8ZxOX5/ekGu6SBPmGGVsl7JS8fneI+N2az/XUmh9yC1VPDPaoqq4ywMT6i+Z9N1XbXG7UxRcu9Ff5/+s6e33jqDQcGCLzCM6jXSqbXhLd+hWc2tXAYwpz7fZbcU7lN6DRQYGEvuSBpX31bQCbYFJksGpxI6twS+/rmiVWrCWwp9IIWciejtybKN1E3MJcMkmnEnkepdUy0LfO3PTcvkp6VVc5AJKqvahydgGfqHMHmTywRoxr76yNXZUaNPoAlC35ZHdoxmee2kApwO7qf5QZsz9hOQP8qP1ACjE9IgNWShCUW7VBYdgr5aHQd03gjCCd00clj3HHXSYEX8P5e9u2yq2fwTzjP3GJRlu1VdjAuRZE0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8932311EF966594BA61991E8ED4FB8B9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e4d5a8-a70b-4f78-9f26-08d74335afd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 10:30:16.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Abvj8h4HhQxDQCP2Mu2qtC3e57kHW5HsON7NtCz3bobO7rnbgRjGLCHl7qPN+jc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3VyZg0KDQpPbiA5LzI3LzIwMTkgMzoxNyBQTSwgS3VydCBHYXJsb2ZmIHdyb3RlOg0KPiBI
aSBKw7ZyZywNCj4gDQo+IE9uIDI1LzA5LzIwMTkgMTc6NDIsIEpvZXJnIFJvZWRlbCB3cm90ZToN
Cj4+IE9uIFdlZCwgU2VwIDI1LCAyMDE5IGF0IDA1OjI3OjMyUE0gKzAyMDAsIEppcmkNCj4+IEtv
c2luYSB3cm90ZToNCj4+PiBPbiBTYXQsIDIxIFNlcCAyMDE5LCBLdXJ0IEdhcmxvZmYgd3JvdGU6
DQo+Pj4+IFsxMjkxNi43NDAyNzRdIG1tYzA6IHNkaGNpOg0KPj4+PiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4+PiBbMTI5MTYuNzQwMzM3XSBtbWMwOiBl
cnJvciAtNSB3aGlsc3QNCj4+Pj4gaW5pdGlhbGlzaW5nIE1NQyBjYXJkDQo+Pj4gRG8geW91IGhh
dmUgQkFSIG1lbW9yeSBhbGxvY2F0aW9uIGZhaWx1cmVzIGluDQo+Pj4gZG1lc2cgd2l0aCBJT01N
VSBvbj8NCj4gDQo+IE5vLiBUaGUgZGV2aWNlIGlzICpub3QqIHRyZWF0ZWQgYXMgUENJIGRldmlj
ZSBhbmQNCj4gSSBzdGlsbCB0aGluayB0aGF0IHRoaXMgaXMgdGhlIHNvdXJjZSBvZiB0aGUgZXZp
bC4NCj4gDQo+Pj4gQWN0dWFsbHksIHNoYXJpbmcgYm90aCB3b3JraW5nIGFuZCBub24td29ya2lu
Zw0KPj4+IGRtZXNnLCBhcyB3ZWxsIGFzDQo+Pj4gL3Byb2MvaW9tZW0gY29udGVudHMsIHdvdWxk
IGJlIGhlbHBmdWwuDQo+PiBZZXMsIGNhbiB5b3UgcGxlYXNlIGdyYWIgZG1lc2cgZnJvbSBhIGJv
b3Qgd2l0aA0KPj4gaW9tbXUgZW5hYmxlZCBhbmQgYWRkDQo+PiAnYW1kX2lvbW11X2R1bXAnIHRv
IHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lPw0KPj4gVGhhdCBzaG91bGQgZ2l2ZSBzb21lIGhpbnRz
DQo+PiBvbiB3aGF0IGlzIGdvaW5nIG9uLg0KPiANCj4gRm9yIG5vdyBJIGF0dGFjaCBhIGRtZXNn
IGFuZCBpb21lbSBmcm9tIHRoZSBib290DQo+IHdpdGggSU9NTVUgZW5hYmxlZC4NCj4gTm90aGlu
ZyBtdWNoIGludGVyZXN0aW5nIHdpdGhvdXQgSU9NTVUsIHNkaGNpLWFjcGkNCj4gdGhlcmUganVz
dCB3b3JrcyAtLSBsZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgd2FudA0KPiBtZSB0byBzZW5kIHRo
ZSBrZXJuZWwgbXNnLg0KPiANCj4gVGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcyENCj4gDQoN
CkkgaGF2ZSBhZGRlZCBTdXJhdmVlIGZyb20gQU1EIGluIHRoZSBtYWlsIGxvb3AuIEhlDQp3b3Jr
cyBvbiBJT01NVSBwYXJ0LiBBcyBwZXIgbXkgdW5kZXJzdGFuZGluZywgaXQNCm5lZWRzIGEgcGF0
Y2ggaW4gSU9NTVUgZHJpdmVyIGZvciBhZGRpbmcgc3VwcG9ydA0Kb2YgRU1NQy4gTm90ZSB0aGF0
IG9uIFJ5emVuIHBsYXRmb3JtIHdlIGhhdmUgRU1NQw0KNS4wIGFzIEFDUEkgZGV2aWNlLg0KDQpU
aGFua3MNCg0KTmVoYWwgU2hhaA0K
