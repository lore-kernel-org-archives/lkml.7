Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F8FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE690222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IAUNw1Za";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="B3Hcz+nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKMDzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:55:50 -0500
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:53930 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbfKMDzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:55:50 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2B4D9C0E50;
        Wed, 13 Nov 2019 03:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573617349; bh=mXBD5r3N2O0PiW19XDbQTYtlmzN13qOqwyCrx/d7dnw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=IAUNw1ZaZIzjdbh4sHq1ElqHg3Ha9FfbrvBpGAd3SYAjhvlCSIBAkcEAIBJPEZ4N+
         1V0/EwepEWfUIBaZH6Cr6IjFD9HpUACj18W52xK1TnUYglQRaKmmzcWQM/G5zBAbbX
         y9ENOr+MMJPNI2M+l3X8Sz46A4tlH5KXd61vPB42UpnQ5/URYxlLnFUQLdtmO07pUx
         BQZRlbhHZnR85Rhvmzjzff3hcIaYAgkbGel4WP97QSOOPbRtH4EYcPBswzdWZ9Cqr0
         l67AFgY34uhtfXVHbIF36Pg1Zr+/CerBM6IPlEZlHlX+Z0W+Jr0O16IWUFcZubiW0k
         8lFP9S+RbFSWQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AE880A0085;
        Wed, 13 Nov 2019 03:55:48 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Nov 2019 19:55:04 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 12 Nov 2019 19:55:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQEfJn5B0ezXj3oZlEmj5me2+6fy+2VQyk591Qe9e3SALps8Zg/HLexRtwC3xvvy5X67JZ/VuCLq0qS8Mqb5i1gXLertSYwQXnBDHH0J44maKHYKY06siULRdsJzNHnR2/TXno3pfH2eRa2hItFgqFXaWvTKDCUzm8wepfwRxY1bm2Q6kqcS1oSchRvG7HJaI4rvY48b/LueQfO+wZvlWqKcdLPAOS//9OY0f9laf/eanfl1F//iijCGlYcsh62xWkMUiE5gNDTsjDaa/iUzhLaPxvVvROPtEI8CWz+N/6T4uuldLBBKBtPQqgi1xfn2iEGT1N/aiyTowzSA3pJUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXBD5r3N2O0PiW19XDbQTYtlmzN13qOqwyCrx/d7dnw=;
 b=iIEwmgLxMYBVISnKEPpEM6gxxYhTrIVUCy3A54B2kd3HLN/dK9PKdnGpmUc6E0mgf6ExstnJ0MOLWEC8wBCpKvg7V2ayvk7TofiQO6YSxl0VkJnX0T3k+A54dHqG3s6wXkcRm617tTedGsP5w6xbEEKMo1xRqqNaXW3c0s9QXorIl9Ficgm8/9iXYFrcwTo2tKa7k4jIE5Cq56BgKzUQ7FcUm7UA6nphH60NI7UNDX+WgQhorCQ8ou/BuT4K7n/v6R3mfXZrZlskMGleOhXEOqbPZL/9VsrIX/vEVngNdgiymlzlNgkB+8Znm0iLBBGjvs+9zkHTH/hEdhfLOdh2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXBD5r3N2O0PiW19XDbQTYtlmzN13qOqwyCrx/d7dnw=;
 b=B3Hcz+nPsDYnoPeeMkN1antNz8NgKPAjbAvhmY6fpaNnXgQv91Yvf2YEe2VPfO4CPqRmCVN3GgbUkJdU7GAraWu1/jvsaG5RsIPVBoaBJQ5n93hDd3BKOiSELN67dHc3D//o2eQgjbo5Vh3Jjk1O1ErJAC5fkmJbJOHUwjURrfo=
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com (10.172.78.22) by
 CY4PR1201MB0008.namprd12.prod.outlook.com (10.172.118.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Wed, 13 Nov 2019 03:55:01 +0000
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3]) by CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 03:55:01 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Michael Olbrich <m.olbrich@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Index: AQHVmKSAwOKFEHeaw0mottJUNN0pEqeIevUA
Date:   Wed, 13 Nov 2019 03:55:01 +0000
Message-ID: <45ce4107-7c52-48d2-90d1-dfe835024063@synopsys.com>
References: <20191111152645.13792-1-m.olbrich@pengutronix.de>
 <20191111152645.13792-3-m.olbrich@pengutronix.de>
In-Reply-To: <20191111152645.13792-3-m.olbrich@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 639d07d4-1eb4-47cf-56f4-08d767ed4294
x-ms-traffictypediagnostic: CY4PR1201MB0008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB000872BAF2C791D60FA0D230AA760@CY4PR1201MB0008.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(31696002)(66556008)(14444005)(81156014)(36756003)(8936002)(8676002)(66476007)(316002)(81166006)(99286004)(25786009)(76116006)(110136005)(71190400001)(2501003)(54906003)(71200400001)(66946007)(64756008)(256004)(5660300002)(6246003)(66446008)(4326008)(86362001)(229853002)(11346002)(6506007)(6512007)(446003)(26005)(102836004)(7736002)(14454004)(305945005)(31686004)(6486002)(478600001)(2906002)(186003)(486006)(66066001)(6116002)(2616005)(476003)(6436002)(76176011)(3846002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0008;H:CY4PR1201MB0037.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jm5hsR8taUstadmDF1gHa8WCG404wwqhmbdjipzyq77YbVCwj8Qxkc7fDEETyQDTpGGff4xze6vr+EnNL08q0qZNZ9b+T3pznVexXa6oMMHewg2K3RKKBbGcJ2T8TikAfwoJ5b6XQa5rq+MrtVZm2zMPSnZDA4Fk6pxPS3SucBS7GgyZ/Q+w045sNdCbPR3VxE8jUja8r54cimyxpUC/aTGuMqNlivRlq1dBbluG4ubS5Tyfma6G1fGCcO+uMu/BgDPplWQ0K0KHmyCq3IXtfykgDXaI6mHEwR7my29QhDjLZeDw6dnTLNxoFFezGQONgYmGCFxErEPYYp5T5IgJSpgMxCWHcgXrSKX/f109fULAMGnJBWuz/GQpEL5DgEE1k25GAKBXCEh4oit2Q8OaDnxGb1FM/O4In7NjQrlA2fqHKa9F41KxZgjUUuMwKVAV
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CA405FAF9FB2148A203E1AB27AE6743@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 639d07d4-1eb4-47cf-56f4-08d767ed4294
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 03:55:01.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgyX78dFmTLyUMEsoD2OJ21KHznz9KFWEB4jNgzY2zhCLlRhD57JEle+44A6UZP/IEn/4Y/m4AXyT8opZYIIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0008
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbCwNCg0KTWljaGFlbCBPbGJyaWNoIHdyb3RlOg0KPiBDdXJyZW50bHksIG1vc3Qg
Z2FkZ2V0IGRyaXZlcnMgaGFuZGxlIGlzb2MgdHJhbnNmZXJzIG9uIGEgYmVzdCBlZmZvcnQNCj4g
YmFzZXM6IElmIHRoZSByZXF1ZXN0IHF1ZXVlIHJ1bnMgZW1wdHksIHRoZW4gdGhlcmUgd2lsbCBz
aW1wbHkgYmUgZ2FwcyBpbg0KPiB0aGUgaXNvYyBkYXRhIHN0cmVhbS4NCj4NCj4gVGhlIFVWQyBn
YWRnZXQgZGVwZW5kcyBvbiB0aGlzIGJlaGF2aW91ci4gSXQgc2ltcGx5IHByb3ZpZGVzIG5ldyBy
ZXF1ZXN0cw0KPiB3aGVuIHZpZGVvIGZyYW1lcyBhcmUgYXZhaWxhYmxlIGFuZCBhc3N1bWVzIHRo
YXQgdGhleSBhcmUgc2VudCBhcyBzb29uIGFzDQo+IHBvc3NpYmxlLg0KPg0KPiBUaGUgZHdjMyBn
YWRnZXQgY3VycmVudGx5IHdvcmtzIGRpZmZlcmVudGx5OiBJdCBhc3N1bWVzIHRoYXQgdGhlcmUg
aXMgYQ0KPiBjb250aWd1b3VzIHN0cmVhbSBvZiByZXF1ZXN0cyB3aXRob3V0IGFueSBnYXBzLiBJ
ZiBhIHJlcXVlc3QgaXMgdG9vIGxhdGUsDQo+IHRoZW4gaXQgaXMgZHJvcHBlZCBieSB0aGUgaGFy
ZHdhcmUuDQo+IEZvciB0aGUgVVZDIGdhZGdldCB0aGlzIG1lYW5zIHRoYXQgYSBsaXZlIHN0cmVh
bSBzdG9wcyBhZnRlciB0aGUgZmlyc3QNCj4gZnJhbWUgYmVjYXVzZSBhbGwgZm9sbG93aW5nIHJl
cXVlc3RzIGFyZSBsYXRlLg0KDQpDYW4geW91IGV4cGxhaW4gbGl0dGxlIG1vcmUgaG93IFVWQyBn
YWRnZXQgZmFpbHM/DQpkd2MzIGNvbnRyb2xsZXIgZXhwZWN0cyBhIHN0ZWFkeSBzdHJlYW0gb2Yg
ZGF0YSBvdGhlcndpc2UgaXQgd2lsbCByZXN1bHQgDQppbiBtaXNzZWRfaXNvYyBzdGF0dXMsIGFu
ZCBpdCBzaG91bGQgYmUgZmluZSBhcyBsb25nIGFzIG5ldyByZXF1ZXN0cyBhcmUgDQpxdWV1ZWQu
IFRoZSBjb250cm9sbGVyIGRvZXNuJ3QganVzdCBkcm9wIHRoZSByZXF1ZXN0IHVubGVzcyB0aGVy
ZSdzIHNvbWUgDQpvdGhlciBmYWlsdXJlLg0KDQo+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgYmVo
YXZpb3VyIG9mIHRoZSBkd2MzIGdhZGdldCBkcml2ZXIgdG8gbWF0Y2ggdGhlDQo+IGV4cGVjdGF0
aW9ucy4gSWYgYSByZXF1ZXN0IGFycml2ZXMgdG9vIGxhdGUsIHRoZW4gdGhlIHRyYW5zZmVyIHdp
bGwgYmUNCj4gcmVzdGFydCB0byBjcmVhdGUgdGhlIG5lZWRlZCBnYXAuDQo+DQo+IEEgcmVxdWVz
dCBpcyBsYXRlIGlmOg0KPiAxLiBUaGVyZSBhcmUgY3VycmVudGx5IG5vIHJlcXVlc3RzIHF1ZXVl
ZCBpbiB0aGUgaGFyZHdhcmUNCj4gMi4gVGhlIGN1cnJlbnQgZnJhbWUgbnVtYmVyIHByb3ZpZGVk
IGJ5IERTVFMgZG9lcyBub3QgbWF0Y2ggdGhlIGZyYW1lDQo+ICAgICBudW1iZXIgcmV0dXJuZWQg
YnkgdGhlIGxhc3QgdHJhbnNmZXIuDQo+DQo+IElmIHRoaXMgaGFwcGVucyB0cmFuc2ZlcnMgYXJl
IHN0b3BwZWQuIFRoZSBmb2xsb3dpbmcgWGZlck5vdFJlYWR5IHByb3ZpZGVzDQo+IHRoZSBuZXcg
Y29ycmVjdCBmcmFtZSBudW1iZXIgYW5kIHJlc3RhcnRzIHRoZSB0cmFuc2Zlci4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogTWljaGFlbCBPbGJyaWNoIDxtLm9sYnJpY2hAcGVuZ3V0cm9uaXguZGU+DQo+
IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA4ICsrKysrKysrDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggYWM0
NjczZDkxOTM5Li5lYjdmMDk5MjlmMjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMTQ3Myw2
ICsxNDczLDE0IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9xdWV1ZShzdHJ1Y3QgZHdj
M19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXEpDQo+ICAgCQkJCXJldHVybiBfX2R3
YzNfZ2FkZ2V0X3N0YXJ0X2lzb2MoZGVwKTsNCj4gICAJCQl9DQo+ICAgCQl9DQo+ICsJCWlmICgo
ZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCkgJiYNCj4gKwkJICAgIGxpc3Rf
ZW1wdHkoJmRlcC0+c3RhcnRlZF9saXN0KSAmJg0KPiArCQkgICAgKChkZXAtPmZyYW1lX251bWJl
ciAmIDB4M2ZmZikgIT0NCj4gKwkJICAgIF9fZHdjM19nYWRnZXRfZ2V0X2ZyYW1lKGR3YykpKSB7
DQo+ICsJCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgdHJ1ZSwgdHJ1ZSk7DQo+ICsJ
CQlkZXAtPmZsYWdzID0gRFdDM19FUF9FTkFCTEVEOw0KPiArCQkJcmV0dXJuIDA7DQo+ICsJCX0N
Cj4gICAJfQ0KPiAgIA0KPiAgIAlyZXR1cm4gX19kd2MzX2dhZGdldF9raWNrX3RyYW5zZmVyKGRl
cCwgZmFsc2UpOw0KDQpCUiwNClRoaW5oDQoNCg==
