Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067FDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA35E20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="R/oUhVh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKGhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:37:52 -0500
Received: from mail-eopbgr50096.outbound.protection.outlook.com ([40.107.5.96]:57825
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfKKGhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:37:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYcZ0ZH5Tj+jf2OONw10E34Mdv4AVPKMv0IKYXsuHEkMGsT8yHx8xXMng4x8AFqsPxv4GUVRuo42CBcJ25ZFdD5SMjs/uA7CpteOP5WZaMlgu+NciMbWnUDwdcHc0RzI9Wff7sMT8EReehsWFw40N2iFGzuLbMhk9niGdYB5igg2T9pnrC8yxWFjo50owbUe4oEtayR7Edk4+STTqaWJvghpepbIgPu4R+mk8qtT/yZyLZIdzhMc1ykAP+1dvlQGd18ZLtWZ2ru9gKLX1OH3spDhuHECtL0SrJ4z2JJjRQzICEhynupx0/7/xsbcHdcyIlklVzq3OKGpdt8Oxj6HFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CtufMuaVEoYWsC9mcaC2GcEi75R+wcQzHmwC2KFiok=;
 b=GV1lcxDQqHUHhqH32VxfscVRSAKbuc3y1Q02nL8euiKMoG/H3zxmO/5Z1G6sLvIx14gtaDs6F8SC7N6S3usIPviNXwSPiGi7iwadA5T/KhE8MyRGAXrNM6NygvwHJKqhdK26Z/CaPzTH9mgMsYdTofCXq5di7YZ662PvuGwpRvFYCte68XrpirdlQAicf75uEM0NfQ+wdSPef8RFAquGy0XGtfgtJR5Vn1pLeWXqwKAx8+uWuWFO/Z6pJaC2ssP7389y2Zr093lvT6U3c/jOFNoWR5X2XVGuVDdgaJx+0sPnuyTjHfkzdygKdtYfD6ALxev+I9gtwSGOBcJEMN2h4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CtufMuaVEoYWsC9mcaC2GcEi75R+wcQzHmwC2KFiok=;
 b=R/oUhVh3jnYleUg5lh1U5wFzLXak2GvNoFQfAitCD12WHLFF8Ms1jBWmdAkImmGDa2y+OF+A8UpvXKC/Ik4MjVk19hbjkib4aNgq/Wm9O4splfYw52vmFxuX1JesN1H4CP2FqsRuRx6HKtqNdOVXbBILSTuzfNmweq7u9rVOI/k=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3302.eurprd02.prod.outlook.com (52.133.29.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 06:37:46 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 06:37:46 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Topic: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Index: AQHViKI2kzFSWJT/Dk6DGcovF5gSd6dn9PuAgABElLCAAMnygIAAXYCggBxBjzA=
Date:   Mon, 11 Nov 2019 06:37:46 +0000
Message-ID: <AM6PR0202MB3382873276C63BDED4B91256B8740@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191022063028.9030-1-oshpigelman@habana.ai>
 <20191023092035.GA12222@infradead.org>
 <AM6PR0202MB3382B554A4C7F0F677A804D7B86B0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
 <20191024012849.GB32358@infradead.org>
 <AM6PR0202MB3382CAB4D348F568EFBAC237B86A0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
In-Reply-To: <AM6PR0202MB3382CAB4D348F568EFBAC237B86A0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.8.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09cd12c8-e876-4115-713b-08d76671a9cc
x-ms-traffictypediagnostic: AM6PR0202MB3302:
x-microsoft-antispam-prvs: <AM6PR0202MB3302187CBF2CA6FEA69A5FDAB8740@AM6PR0202MB3302.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39840400004)(396003)(346002)(366004)(189003)(199004)(53546011)(6116002)(6506007)(71200400001)(2906002)(71190400001)(66066001)(478600001)(3846002)(33656002)(6916009)(446003)(11346002)(76176011)(4326008)(476003)(102836004)(26005)(7696005)(256004)(6246003)(486006)(14454004)(186003)(25786009)(81166006)(81156014)(66476007)(64756008)(76116006)(66946007)(305945005)(66446008)(66556008)(8936002)(55016002)(99286004)(8676002)(7736002)(74316002)(229853002)(316002)(86362001)(5660300002)(52536014)(4744005)(6436002)(9686003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3302;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RvrqLyNTrbaPImvq+UJi5Wwdsjgb8VgmKO9os+TsvP8EAejxe1m18cCHN4GS8XkbX+ZQlIZ+3loocTSY9VT8xoUpHEQf7VH4ya+jWfcZkoz9jXieB5AQwpEodpEhSvGn9h046WRgz6KQ+04xSLrsG1WYyLIrdNUMcc7ez7trYfa1p0LnO1yAQbhnLXyY9zTxiYe1l7LTtWc7gnUO+ydUbXdZOVx+VpzgKbNG5DptybFomaNsC2CTG3pGau1a6Dl67+WLDAejkYe2X+1C4QWjX3nJArBe+Ckwe6KjNwsYE9/3y69Q7jfOUIwL+2SPhCLr7OqGOTGzyj/EghaqKYjT/CTRySrZff2c6DbjT4qidz72eg0uJlCD6YOWkQ0/CaCoCxCYbKVptWlSC6UMfUc5+F+zvrXAlhKVJw7Qyu4lvB6Gnw/eybys+Tu0lWo8MVP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cd12c8-e876-4115-713b-08d76671a9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:37:46.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /etCUQ0BoN20U+uezxVmyMlBxexXilYRsoyNAhaTAQPXTBCOek3r9i8p+X0R6+dT/RsSg3YyZIiO6Hw4gRMGiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBPY3QgMjQsIDIwMTkgYXQgMDE6MzkgUE0sIE9tZXIgU2hwaWdlbG1hbiB3cm90ZToN
Cj4gT24gVGh1LCBPY3QgMjQsIDIwMTkgYXQgMDQ6MjkgQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPg0KPiB3cm90ZToNCj4gPiBPbiBXZWQsIE9jdCAyMywgMjAxOSBhdCAw
MTozOTo0MVBNICswMDAwLCBPbWVyIFNocGlnZWxtYW4gd3JvdGU6DQo+ID4gPiBJJ20gbm90IHN1
cmUgSSB1bmRlcnN0YW5kLiBDYW4geW91IHBsZWFzZSBwaW4gcG9pbnQgdGhlIHByb2JsZW1hdGlj
IGxpbmU/DQo+ID4NCj4gPiBFdmVyeSBsaW5lIHlvdSB0b3VjaCBhZGRyIGZpZWxkIGJhc2ljYWxs
eS4gIElmIHlvdSBoYXZlIGEga2VybmVsDQo+ID4gYWRkcmVzcyBwbGVhc2Ugc3RvcmUgaXQgaW4g
YW4gYWN0dWFsIEMgcG9pbnRlciB0eXBlLCBub3QgaW4gYSB1NjQgdG8NCj4gPiBlbnN1cmUgdGhh
dCB0aGUgY29tcGlsZXIgY2FuIGRvIHByb3BlciB0eXBlIGNoZWNraW5nLg0KPiANCj4gSSBzZWUg
eW91ciBwb2ludC4gSSdsbCBzZXBhcmF0ZSB0aGUgY29kZSBzbyB0aGUga2VybmVsIGFkZHJlc3Mg
cGF0aCB3aWxsIHVzZSBhDQo+IHBvaW50ZXIgdHlwZSByYXRoZXIgdGhhbiB1NjQuDQoNCkR1ZSB0
byBhIGNoYW5nZSBpbiB0aGUgcmVxdWlyZW1lbnRzIGZvciBmdXR1cmUgQVNJQ3Mgc3VwcG9ydCwg
dGhlcmUgaXMgbm8gbmVlZCBpbiBtYXBwaW5nIHZtYWxsb2MgbWVtb3J5Lg0KQXMgYSByZXN1bHQg
dGhpcyBwYXRjaCBpcyBkaXNjYXJkZWQuDQo=
