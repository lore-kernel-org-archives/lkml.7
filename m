Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7712C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D62520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 19:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="s/csDuPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfJJTyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 15:54:12 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com ([40.107.3.104]:60324
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbfJJTyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzfnGH2ujr4RcPT7kiFdIrPNB2IbWzqGy+a8sRj/uzsgO7QRggKAEW4VDgEhQSOiEs73oh5pu0nKiWvONMQTxCnu1/Tai8Xig6nQVDcwehtX2xU6RIwC2zYwaleEVnuqepEqRro1qzRlQOn5emun1YF7Jdop10p5ukvVP25DCQPXbp4QWhBf7YK7EZOVAolBFFMkt3KRrf3xt12mxXlGwXmQ4hBf2s6Qn7DunkZEMppYIfnZoNcFOeXpS45dbkh2jitj+f3gfVquSr7k5I6ZgDzmu7Tg5Id+gSQLdkkmp9TRJemeXC5RVuBRaeji3XIjDB+vax7yDiV7cLF3vZf42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXJ0NYuWjwayicwMzMXkP8zidsEv1CJwJP03AhRpaQI=;
 b=Ew6Bj7q3F007oqSWZGVrPvIArnsjaLgshsuJSnu324VxfMJy2zZXd6CQHzwNvQ+IzRACz+0jdOiJFO2+LHqw/b12PV+4FcxLk62DUwx/z+BHY59Hi9OKBtUcdtdG+G+1JDspvhlNe6wIFUrOmNjopUDw3u6wxVe2PAbcIiwmMRkfIvqA520SCtvvfP2s3XT6TXrRE0YXpe+yax6IWKRq5BCwAjO1d50176BxKWHMKa6Hk1BnQaD7bNoh3yjYbhTtXHDAF0/5S3HD5TrzaU0Bm122c3/vbsFEx+UO0NlV+8z/vO0t6QRy1dNcK2PEBlvYD3KqfyMCwDKTLIcNDVsDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXJ0NYuWjwayicwMzMXkP8zidsEv1CJwJP03AhRpaQI=;
 b=s/csDuPVsz1rFyhyR77EIdZqpqEn9qYiKuasdsONmLmNvL7I1c8sjwcm+TXYazsgXP7EagLT6t/CTD2vNKe5j8ypZ06XaqiSBMKz/t810+O/TgF6n3bVeBtBhJl+n6ck++jLmMv4JxGWOFfEDRBwnO4VBLPTUGyxFl5oekPIeBA=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3446.eurprd02.prod.outlook.com (52.133.27.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Thu, 10 Oct 2019 19:54:07 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251%5]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 19:54:07 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] habanalabs: support vmalloc memory mapping
Thread-Topic: [PATCH 1/2] habanalabs: support vmalloc memory mapping
Thread-Index: AQHVf3PlrNoEOJqtQ0eTOfjIKEa+lKdT6doAgABYVvA=
Date:   Thu, 10 Oct 2019 19:54:07 +0000
Message-ID: <AM6PR0202MB338206146804E2E2BC18C67FB8940@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191010140615.26460-1-oshpigelman@habana.ai>
 <20191010140950.GA27176@infradead.org>
In-Reply-To: <20191010140950.GA27176@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.14.240]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5351650b-4585-4a9a-ba65-08d74dbb9c86
x-ms-traffictypediagnostic: AM6PR0202MB3446:
x-microsoft-antispam-prvs: <AM6PR0202MB3446EE5BE961AD9252F62180B8940@AM6PR0202MB3446.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(376002)(366004)(189003)(199004)(71190400001)(256004)(54906003)(71200400001)(14454004)(33656002)(8676002)(316002)(446003)(66066001)(478600001)(81166006)(305945005)(74316002)(7736002)(6916009)(86362001)(81156014)(14444005)(26005)(186003)(11346002)(8936002)(66946007)(76116006)(102836004)(64756008)(66446008)(476003)(52536014)(66476007)(66556008)(3846002)(6116002)(4326008)(6436002)(99286004)(229853002)(2906002)(55016002)(486006)(6246003)(6506007)(9686003)(76176011)(53546011)(5660300002)(7696005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3446;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpM/qMkvdNJnPHnV/iMJ3DdCJm/3VET2nY1CvHsU82zySfR6L+pbYmxOPSmBX6xzluE7U7/1Ai5II00wLw+lQRqNvGQlDwbcayb9LQ5ri3616K/Y+Yn8347yVd7714ljEvaodkXRsPqsry+l6pi6gQ4+PehK+pUaaHsw500f0cjAodojcrs40B9OE2X6Sf8gkTZvsB6gnojIjtwFWwMDnc1boikeuq5py7H5rhg9O5fmLoUmbOlpbQmKFfpDNLzeXgcYFfwlMpPPjgRHAPv1saiAlhNdym+GNvV+XPjv1d7mWfINSAkNyxxL1sbLzgIPFcUc+qz7XV4udVGnVW/qdapNs6XhnyEl5ocjoRUVsBRB4DnGDbtNeRoev0qePz3wUKtNaNiY/u3fkTYhN4TAq5xJ+/Mu4i5Bv16bubr1iKE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 5351650b-4585-4a9a-ba65-08d74dbb9c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 19:54:07.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YxUWF7iW79K8nTrgzKWvLzuMQJyW22xrGJ1TUt8iUXicrrqEBrH0nIzknBEcgZH7bJFvGIlhyhQ7DjX2SFcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBPY3QgMTAsIDIwMTkgYXQgNToxMCBQTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOiANCj4gT24gVGh1LCBPY3QgMTAsIDIwMTkgYXQgMDI6MDY6MjJQ
TSArMDAwMCwgT21lciBTaHBpZ2VsbWFuIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBw
b3J0IGluIG1hcHBpbmcgb2Ygdm1hbGxvYyBtZW1vcnkuDQo+ID4gSW4gY29udHJhcnkgdG8gdXNl
ciBtZW1vcnksIHZtYWxsb2MgbWVtb3J5IGlzIGFscmVhZHkgcGlubmVkIGFuZCBoYXMNCj4gPiBu
byB2bV9hcmVhIHN0cnVjdHVyZS4gVGhlcmVmb3JlIGEgbmV3IGNhcGFiaWxpdHkgd2FzIG5lZWRl
ZCBpbiBvcmRlcg0KPiA+IHRvIG1hcCB0aGlzIG1lbW9yeS4NCj4gDQo+IFVubGVzcyBJIGFtIG1p
c3Npbmcgc29tZXRoaW5nIHlvdSBtaXggdXNlciBhbmQga2VybmVsIHBvaW50ZXJzIGluIHlvdXIN
Cj4gaXNfdm1hbGxvY19hZGRyIGNoZWNrcy4gIFRoYXQgd2lsbCBicmVhayBvbiB0aG9zZSBhcmNo
aXRlY3R1cmVzIHRoYXQgaGF2ZQ0KPiBzZXBhcmF0ZSBrZXJuZWwgYW5kIHVzZXIgYWRkcmVzcyBz
cGFjZXMuDQoNClRoZSBpc192bWFsbG9jX2FkZHIgY2hlY2tzIGFyZSBmb3IgdXNlciBwb2ludGVy
cyBhbmQgZm9yIG1lbW9yeSB3aGljaCB3YXMgYWxsb2NhdGVkIGJ5IHRoZSBkcml2ZXIgd2l0aCB2
bWFsbG9jX3VzZXIuDQo+IA0KPiA+IE1hcHBpbmcgdm1hbGxvYyBtZW1vcnkgaXMgbmVlZGVkIGZv
ciBHYXVkaSBBU0lDLg0KPiANCj4gSG93IGRvZXMgdGhhdCBBU0lDIHBhc3MgaW4gdGhlIHZtYWxs
b2MgbWVtb3J5PyAgSSBkb24ndCBmdWxseSB1bmRlcnN0YW5kDQo+IHRoZSBjb2RlLCBidXQgaXQg
c2VlbXMgbGlrZSB0aGUgYWRkcmVzc2VzIGFyZSBmZWQgZnJvbSBpb2N0bCwgd2hpY2ggbWVhbnMN
Cj4gdGhleSBvbmx5IGNvbWUgZnJvbSB1c2Vyc3BhY2UuDQoNClRoZSB1c2VyIHBvaW50ZXJzIGFy
ZSBpbmRlZWQgZmVkIGZyb20gaW9jdGwgZm9yIERNQSBwdXJwb3NlLCBidXQgYXMgSSB3cm90ZSBh
Ym92ZSB0aGUgdm1hbGxvYyBtZW1vcnkgaXMgYWxsb2NhdGVkIGJ5IHRoZSBkcml2ZXIgd2l0aCB2
bWFsbG9jX3VzZXIgd2hpY2ggd2lsbCBiZSBtbWFwcGVkIGxhdGVyIG9uIGluIG9yZGVyIHRvIGNy
ZWF0ZSBhIHNoYXJlZCBidWZmZXIgYmV0d2VlbiB0aGUgZHJpdmVyIGFuZCB0aGUgdXNlcnNwYWNl
IHByb2Nlc3MuDQo=
