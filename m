Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F94C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0314B206E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ITfSLdwo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="H8UrHg3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKMTPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:15:11 -0500
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:36302 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbfKMTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:15:10 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 86580C03F3;
        Wed, 13 Nov 2019 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573672510; bh=DIl9H5Fk744n5/OAOuKsaeIKxiRwDqprcKs7fsognXk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ITfSLdwoYoLzFcBhecTZvX4TKt9FKezlCLQDTkog73MC3s1J6p6ck3oLVIviX1Z08
         oIlQ3OEXCmGGFaRD2vnUwHrbXMDsQrlJRQG27XmPapbuH9UEZ0c3ZCxxK25TbYT/u3
         2qudPJMZCP7yD7p+GNYFoldU+Pd6GB6MX/filMsshZlFbDWqsJCYK30VLATvRieCPO
         ArIcvO6qCzmnDttdfE9v5vgntMXzcByS1Qj0KiZy5rwz5exNDlJIslSz9T0KfEUNlG
         05xgLMeNCPg9nlKKIguJtox4abhpj9gnWHFNBbfYuRXN/T/Al6N86D+fGg8H15Ch5I
         TUmleOQRdODdQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 22553A0079;
        Wed, 13 Nov 2019 19:15:07 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Nov 2019 11:15:01 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 13 Nov 2019 11:15:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmGCBDhyFc4Ib5tS4C7rVacxCsz9P/DVRj63bdd7KZlYVXVWfcxDp19pUngodGz3OxR18vx7Y+KdS/p/LA0WhnLGU2lJDkgNeTaEMqoc86grv1ksL4SnsellGaWOVft5+3/HDr3rZaIT9Xc2bGgY3dAPhhd/ZVXcIL1tXTDKQ4lXHSlra+uZeKRJGk1zjcW62eAxotFusMjkFUbwITb2w6nBr1gMN87vfGABwCz3bUQHV6YRS+V5eT2G8Yy7EFkT7cY7TfVxPa9ODYKCL8fIgGT7qsdqtzzXM1TJ++0WCjaus28RX3Z9bGwwooMLirhuOgRmzRjCsVoDoM46B8flbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIl9H5Fk744n5/OAOuKsaeIKxiRwDqprcKs7fsognXk=;
 b=S8mIf9+ajDaxOl3rXBTmmgkscmue+xztSD8QJ4ZvRxAsxfFvGi1gfmCO1yYY3MtH5jXnEdoJb2M+Perc3NIYcWqu60kDvCjdIsG4N2P1M9GU/0apcxX53cPSb5x4IHoAeHvlTZ9z7dlsIV7r+mzNPsU4Xwglx5zt82idXGzIoQatqQ5OnYNdTEruYNDaLoSiKWBSRFZ6Riws+eDMZ8gz2PPplkKe2dunEPW3Un8HCyNJAjQTg+i1fAfSlJ5/duf++uL9ko6v42F6QHXpAZAgLsJsgnvxkv15rwmTjAwOvrvqfv2Z/jqZ+7puoPg4rWUy9+v511AE0iRcx8eVORO4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIl9H5Fk744n5/OAOuKsaeIKxiRwDqprcKs7fsognXk=;
 b=H8UrHg3fIgQjHPhXwtS1od77r+0AqDMfuaODrQ0x8vTjVL9U4oPlTPkvgzIL3kwg76fksrRsZdPiHa17WRoAlq0NanpYDr4bKP7xzYMvbQJCg87IRaZSBveKa8D368CWW99gdxed23DI6RE2XHn3w8T7UkNv8DBtoo71ByMGJ0A=
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com (10.172.78.22) by
 CY4PR1201MB0150.namprd12.prod.outlook.com (10.174.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Wed, 13 Nov 2019 19:15:00 +0000
Received: from CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3]) by CY4PR1201MB0037.namprd12.prod.outlook.com
 ([fe80::cdbe:cf8c:dfb7:68d3%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 19:15:00 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Michael Olbrich <m.olbrich@pengutronix.de>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: restart the transfer if a isoc
 request is queued too late
Thread-Index: AQHVmKSAwOKFEHeaw0mottJUNN0pEqeIevUAgABCiACAAII+gIAAPESA
Date:   Wed, 13 Nov 2019 19:14:59 +0000
Message-ID: <587b0adf-b71d-6fde-407b-46089ed5d695@synopsys.com>
References: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911131036340.1558-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b9faa83-b6ad-4f20-8aca-08d7686dc749
x-ms-traffictypediagnostic: CY4PR1201MB0150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB015032A9C0D75B39C2E3C756AA760@CY4PR1201MB0150.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(256004)(186003)(2171002)(6436002)(5660300002)(6246003)(66066001)(8676002)(81156014)(6506007)(2906002)(4326008)(102836004)(81166006)(8936002)(7736002)(86362001)(76176011)(14444005)(6116002)(3846002)(11346002)(66556008)(305945005)(66446008)(31686004)(31696002)(26005)(64756008)(66476007)(76116006)(6512007)(316002)(446003)(99286004)(66946007)(110136005)(54906003)(229853002)(14454004)(6486002)(36756003)(486006)(71190400001)(476003)(71200400001)(478600001)(2616005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0150;H:CY4PR1201MB0037.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vk/rynmVFl+yU2tk1zlYdHNnD5Me2lNgq/bYDHvxkZB4uWiSg0D37r6vyMQdq+S5Q5bnHA5rcZGhkqwHL1G+bRpca/1VPRQroYMZ/aFVHuTyZbEKu67Haz0ag1wpeJBnpaot/RZHdFov3tpmJbQ50KwLVmHgQs+zhibThpia/HdN5l2R/homRl3uthLeCjUTsgJy6CNllpCkZ3QsnqYjipG8zMtpIKko8dLl7JsHkdcUYvxRyByQ/Mpha+xHfOOuki3fUfIhSKUBEsUgcrz41S8tXfnjSOLK7kNB8X4WJqejjPWwzs3UW98C26sHe3GgY9tCN7M+B1FV+UP+yZ/5GtrkS4e+qn0GGgV4QRWVZWcCjrfbMfv8x73RiHVRvpH/2FkI+YlTOFYHh+JVn2Que7vFWk4cOiEpb2qg8i0aODnn9kzBTOH6NwxcAZNh9gWP
Content-Type: text/plain; charset="utf-8"
Content-ID: <B95AF2A00D030B408FA8A64263ABE303@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9faa83-b6ad-4f20-8aca-08d7686dc749
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 19:14:59.8415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkz6tsUVb6iUV67YCqj/2hCfvZTP4MJeK2IdUbly72iZJDoRL79HaBu5fRgzpT3WpZthescUqO1Ro9G0pPBzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0150
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbCwNCg0KQWxhbiBTdGVybiB3cm90ZToNCj4gT24gV2VkLCAxMyBOb3YgMjAxOSwg
TWljaGFlbCBPbGJyaWNoIHdyb3RlOg0KPg0KPj4gT24gV2VkLCBOb3YgMTMsIDIwMTkgYXQgMDM6
NTU6MDFBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+IE1pY2hhZWwgT2xicmljaCB3
cm90ZToNCj4+Pj4gQ3VycmVudGx5LCBtb3N0IGdhZGdldCBkcml2ZXJzIGhhbmRsZSBpc29jIHRy
YW5zZmVycyBvbiBhIGJlc3QgZWZmb3J0DQo+Pj4+IGJhc2VzOiBJZiB0aGUgcmVxdWVzdCBxdWV1
ZSBydW5zIGVtcHR5LCB0aGVuIHRoZXJlIHdpbGwgc2ltcGx5IGJlIGdhcHMgaW4NCj4+Pj4gdGhl
IGlzb2MgZGF0YSBzdHJlYW0uDQo+Pj4+DQo+Pj4+IFRoZSBVVkMgZ2FkZ2V0IGRlcGVuZHMgb24g
dGhpcyBiZWhhdmlvdXIuIEl0IHNpbXBseSBwcm92aWRlcyBuZXcgcmVxdWVzdHMNCj4+Pj4gd2hl
biB2aWRlbyBmcmFtZXMgYXJlIGF2YWlsYWJsZSBhbmQgYXNzdW1lcyB0aGF0IHRoZXkgYXJlIHNl
bnQgYXMgc29vbiBhcw0KPj4+PiBwb3NzaWJsZS4NCj4+Pj4NCj4+Pj4gVGhlIGR3YzMgZ2FkZ2V0
IGN1cnJlbnRseSB3b3JrcyBkaWZmZXJlbnRseTogSXQgYXNzdW1lcyB0aGF0IHRoZXJlIGlzIGEN
Cj4+Pj4gY29udGlndW91cyBzdHJlYW0gb2YgcmVxdWVzdHMgd2l0aG91dCBhbnkgZ2Fwcy4gSWYg
YSByZXF1ZXN0IGlzIHRvbyBsYXRlLA0KPj4+PiB0aGVuIGl0IGlzIGRyb3BwZWQgYnkgdGhlIGhh
cmR3YXJlLg0KPj4+PiBGb3IgdGhlIFVWQyBnYWRnZXQgdGhpcyBtZWFucyB0aGF0IGEgbGl2ZSBz
dHJlYW0gc3RvcHMgYWZ0ZXIgdGhlIGZpcnN0DQo+Pj4+IGZyYW1lIGJlY2F1c2UgYWxsIGZvbGxv
d2luZyByZXF1ZXN0cyBhcmUgbGF0ZS4NCj4+PiBDYW4geW91IGV4cGxhaW4gbGl0dGxlIG1vcmUg
aG93IFVWQyBnYWRnZXQgZmFpbHM/DQo+Pj4gZHdjMyBjb250cm9sbGVyIGV4cGVjdHMgYSBzdGVh
ZHkgc3RyZWFtIG9mIGRhdGEgb3RoZXJ3aXNlIGl0IHdpbGwgcmVzdWx0DQo+Pj4gaW4gbWlzc2Vk
X2lzb2Mgc3RhdHVzLCBhbmQgaXQgc2hvdWxkIGJlIGZpbmUgYXMgbG9uZyBhcyBuZXcgcmVxdWVz
dHMgYXJlDQo+Pj4gcXVldWVkLiBUaGUgY29udHJvbGxlciBkb2Vzbid0IGp1c3QgZHJvcCB0aGUg
cmVxdWVzdCB1bmxlc3MgdGhlcmUncyBzb21lDQo+Pj4gb3RoZXIgZmFpbHVyZS4NCj4+IFVWQyAo
d2l0aCBhIGxpdmUgc3RyZWFtKSBkb2VzIG5vdCBmaWxsIHRoZSBjb21wbGV0ZSBiYW5kd2lkdGgg
b2YgYW4NCj4+IGlzb2Nocm9ub3VzIGVuZHBvaW50LiBMZXQncyBhc3N1bWUgZm9yIHRoZSBleGFt
cGxlIHRoYXQgb25lIHZpZGVvIGZyYW1lDQo+PiBmaWxscyAzIHJlcXVlc3RzLiBCZWNhdXNlIGl0
IGlzIGEgbGl2ZSBzdHJlYW0sIHRoZXJlIHdpbGwgYmUgYSBnYXAgYmV0d2Vlbg0KPj4gdmlkZW8g
ZnJhbWVzLiBUaGlzIGlzIHVuYXZvaWRhYmxlLCBlc3BlY2lhbGx5IGZvciBjb21wcmVzc2VkIHZp
ZGVvLiBTbyB0aGUNCj4+IFVWQyBnYWRnZXQgd2lsbCBoYXZlIHJlcXVlc3RzIGZvciB0aGUgZnJh
bWUgbnVtYmVycyAxIDIgMyA1IDYgNyA5IDEwIDExIDEzIDE0DQo+PiAxNSBhbmQgc28gb24uDQo+
PiBUaGUgZHdjMyBoYXJkd2FyZSB0cmllcyB0byBzZW5kIHRob3NlIHdpdGggZnJhbWUgbnVtYmVy
cyAxIDIgMyA0IDUgNiA3IDggOQ0KPj4gMTAgMTEgMTIuIFNvIGV4Y2VwdCBmb3IgdGhlIGZpc3Qg
ZmV3IHJlcXVlc3RzLCBhbGwgYXJlIGxhdGUgYW5kIHJlc3VsdCBpbiBhDQo+PiBtaXNzZWRfaXNv
Yy4gSSB0cmllZCB0byBqdXN0IGlnbm9yZSB0aGUgbWlzc2VkX2lzb2MgYnV0IHRoYXQgZGlkIG5v
dCB3b3JrDQo+PiBmb3IgbWUuIEkgb25seSByZWNlaXZlZCB0aGUgZmlyc3QgZnJhbWUgYXQgdGhl
IG90aGVyIGVuZC4NCj4+IE1heWJlIEkgbWlzc2luZyBzb21ldGhpbmcgaGVyZSwgaSBkb24ndCBo
YXZlIGFjY2VzcyB0byB0aGUgaGFyZHdhcmUNCj4+IGRvY3VtZW50YXRpb24sIHNvIEkgY2FuIG9u
bHkgZ3Vlc3MgZnJvbSB0aGUgZXhpc3RpbmcgZHJpdmVyLg0KDQpUaGUgcmVhc29uIEkgYXNrZWQg
aXMgYmVjYXVzZSB5b3VyIHBhdGNoIGRvZXNuJ3Qgc2VlbSB0byBhZGRyZXNzIHRoZSANCmFjdHVh
bCBpc3N1ZS4NCg0KRm9yIHRoZSAyIGNoZWNrcyB5b3UgZG8gaGVyZQ0KMS4gVGhlcmUgYXJlIGN1
cnJlbnRseSBubyByZXF1ZXN0cyBxdWV1ZWQgaW4gdGhlIGhhcmR3YXJlDQoyLiBUaGUgY3VycmVu
dCBmcmFtZSBudW1iZXIgcHJvdmlkZWQgYnkgRFNUUyBkb2VzIG5vdCBtYXRjaCB0aGUgZnJhbWUN
CiDCoMKgwqAgbnVtYmVyIHJldHVybmVkIGJ5IHRoZSBsYXN0IHRyYW5zZmVyLg0KDQpGb3IgIzEs
IGl0J3MgYWxyZWFkeSBkb25lIGluIHRoZSBkd2MzIGRyaXZlci4gKGNoZWNrIA0KZHdjM19nYWRn
ZXRfZW5kcG9pbnRfdHJhbnNmZXJfaW5fcHJvZ3Jlc3MoKSkNCkZvciAjMiwgaXQncyB1bmxpa2Vs
eSB0aGF0IERTVFMgY3VycmVudCBmcmFtZSBudW1iZXIgd2lsbCBtYXRjaCB3aXRoIHRoZSANClhm
ZXJOb3RSZWFkeSdzIGZyYW1lIG51bWJlci4gU28gdGhpcyBjaGVjayBkb2Vzbid0IG1lYW4gbXVj
aC4NCg0KU28gSSdtIHN0aWxsIHdvbmRlcmluZyBob3cgZG9lcyB0aGlzIHBhdGNoIGhlbHAgcmVz
b2x2ZSB5b3VyIGlzc3VlLg0KDQo+IEhvdyBhYm91dCBjaGFuZ2luZyB0aGUgZ2FkZ2V0IGRyaXZl
ciBpbnN0ZWFkPyAgRm9yIGZyYW1lcyB3aGVyZSB0aGUgVVZDDQo+IGdhZGdldCBrbm93cyBubyB2
aWRlbyBmcmFtZSBkYXRhIGlzIGF2YWlsYWJsZSAobnVtYmVycyA0LCA4LCAxMiwgYW5kIHNvDQo+
IG9uIGluIHRoZSBleGFtcGxlIGFib3ZlKSwgcXVldWUgYSB6ZXJvLWxlbmd0aCByZXF1ZXN0LiAg
VGhlbiB0aGVyZQ0KPiB3b24ndCBiZSBhbnkgZ2FwcyBpbiB0aGUgaXNvY2hyb25vdXMgcGFja2V0
IHN0cmVhbS4NCj4NCj4gQWxhbiBTdGVybg0KDQpXaGF0IEFsYW4gc3VnZ2VzdHMgbWF5IHdvcmsu
IEhhdmUgeW91IHRyaWVkIHRoaXM/DQoNCkJSLA0KVGhpbmgNCg==
