Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F11AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C752178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DnjIXl4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfKFPBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:01:14 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:26498
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727557AbfKFPBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:01:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh1nHwsur2aE5drsb0u1JQJElM49v9TMnVJDYhdQo/L0HNjVJ4mr50oFFArE/gdK2wuHX9R8UbWVrB7IQ7oDGi7AnvD5qH1zqtwK6j0Y/Q+a3Hg67SHQHkRvGBM9G0pZCjSiVpCJkOt5xykUFqRiV0q9hsXfzi+cePPHYijVPVaCgtuqLUl5QseHscicogwXmSGFtccEz4L5YLGK+k/e6XjP0JTMzt/NNWWynvpYwQGsuake181j6c293VqstzPCk1kc7wmyVDfr9VRD23Z2sk+dzOAWjnzHADO73jmfFPjWm+d6qfWC0ykWGCiibRo3C0I2GtkmRJd/UNEYuL9HVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sQ5uReGwBTAE/QciIEkj5OFVBCNo1tzPNkOqKtI6h0=;
 b=WJECdIX7AqpJztL0N15osu8HoubQNi8lWbjcD0nrr5JsNrVqtgM0bOFm959ISRUXKSuXpb7f7HOp5Fc+77SIPKZtRwQ2uMQUz80IU3ds9kc4cUj7vQ9Ovq9544QeT8KvpUyGQiHvKXPa4azzUwXyd2c0VwKcqMuD8UlXh9ss84d8xXq6dHeArpS3zUhoRBlpZ52g3oi+xlKSF1xwwN4VC7RnqVRWCvc5xMPxKB2VWcZYPEZUSMMOpWveBqaK65XDo4XY0s8BLLjhW8GQtsvF0hscFCl6ZxocGmjx1eHth3FKTSHtVomn5NNmFl6W8Qf4Jm/Ofwo5fbW7acFRFZQP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sQ5uReGwBTAE/QciIEkj5OFVBCNo1tzPNkOqKtI6h0=;
 b=DnjIXl4NoM1EvIXLvl9LuQzeG5YXaWnjlrhmRtLkVj9qvjh8MnDk1n98bnBIAaUWQJgoDprbRd00B1pwDcXGDUwFHFTQrLq2gG8cVAtvb7/EpBRM8401tl++ezHS184wKzKtbpVIU01mzG2yO1ckyM0S81khHgq31WrKpgqeO7U=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2677.eurprd05.prod.outlook.com (10.172.225.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 15:01:07 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::99be:5f3a:9871:ecd1%12]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 15:01:07 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     Vijay Khemka <vijaykhemka@fb.com>,
        "minyard@acm.org" <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: RE: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Topic: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Index: AQHVlBIujLLpoJV+NUGR9Gnl5krqyqd9URQAgABlvwCAAIXUEA==
Date:   Wed, 6 Nov 2019 15:01:07 +0000
Message-ID: <DB6PR0501MB2712BEF34969BF377E71B691DA790@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191105194732.1521963-1-vijaykhemka@fb.com>
 <20191106005332.GA2754@minyard.net>
 <63FB7A84-EF61-45CA-9CA7-9564F28B5D42@fb.com>
In-Reply-To: <63FB7A84-EF61-45CA-9CA7-9564F28B5D42@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6404fa18-7361-44fe-b156-08d762ca275c
x-ms-traffictypediagnostic: DB6PR0501MB2677:
x-microsoft-antispam-prvs: <DB6PR0501MB26777857541EF516AA3C8661DA790@DB6PR0501MB2677.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(189003)(199004)(13464003)(9686003)(7416002)(81156014)(66066001)(55016002)(33656002)(74316002)(86362001)(6436002)(11346002)(446003)(14454004)(76176011)(7736002)(53546011)(305945005)(8676002)(478600001)(476003)(80792005)(316002)(229853002)(486006)(4326008)(81166006)(99286004)(25786009)(54906003)(6506007)(256004)(186003)(6246003)(6116002)(102836004)(66946007)(76116006)(64756008)(52536014)(66556008)(5660300002)(66446008)(66476007)(2906002)(2501003)(71200400001)(71190400001)(8936002)(7696005)(110136005)(14444005)(26005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2677;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEnB+zY2Iahx7uEaBSV1lIo7y5DIH7tdkyQqp82W1kxJd/sxMXASMYFyCUziaaRBogwIPD7Up2LMxG5cOiksczcFbuiwPXM5zQd8M5Az3Jwcz+SWto1tt7j57KrplBwNapnXtKmwhb0yVhg/iDxMQeUjvRqtCqvfxlijAAlUIdtEFJO3sjxCGy6YecEh3jkOO2q8+jRHDUkvAAAVxH+vpZxHp/4lmp5ihpEKtJN2R/0eCBKbBNgHTA18FQbfLn81ZscCvLzalZbFaLlVoej0QBfGXAZZCHNeQ49yTddKKpivGZPxy8YXi0DYg3PNxSoNiYpykzA+rdHxOj6hvpdmYwq1Q0WBLhEdazwp8wvgLEDA4nrMgK9t5ZeAEzRxRKcF57f8bsVyWwtm5d+tVmdyaNXylNdhmuFaygcLM/L6wtDI8HV2i3OIPow/PervMP/X
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6404fa18-7361-44fe-b156-08d762ca275c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 15:01:07.8437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2TOzOdSQj7B9qfFRq4K+vGd37nBUWx9BbRXYXGahlvgtfQnajvbxAhM6aVLfBZoxUI/Z3yqzgU51dCHM/fMow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBWaWpheSBLaGVta2EgPHZpamF5
a2hlbWthQGZiLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDYsIDIwMTkgMTo1OCBB
TQ0KVG86IG1pbnlhcmRAYWNtLm9yZw0KQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgb3Blbmlw
bWktZGV2ZWxvcGVyQGxpc3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgY21pbnlhcmRAbXZpc3RhLmNvbTsgQXNtYWEgTW5lYmhpIDxBc21hYUBtZWxsYW5v
eC5jb20+OyBqb2VsQGptcy5pZC5hdTsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IFNh
aSBEYXNhcmkgPHNkYXNhcmlAZmIuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJpdmVyczog
aXBtaTogU3VwcG9ydCBmb3IgYm90aCBJUE1CIFJlcSBhbmQgUmVzcA0KDQoNCg0K77u/T24gMTEv
NS8xOSwgNDo1NCBQTSwgIkNvcmV5IE1pbnlhcmQiIDx0Y21pbnlhcmRAZ21haWwuY29tIG9uIGJl
aGFsZiBvZiBtaW55YXJkQGFjbS5vcmc+IHdyb3RlOg0KDQogICAgT24gVHVlLCBOb3YgMDUsIDIw
MTkgYXQgMTE6NDc6MzFBTSAtMDgwMCwgVmlqYXkgS2hlbWthIHdyb3RlOg0KICAgID4gUmVtb3Zl
ZCBjaGVjayBmb3IgcmVxdWVzdCBvciByZXNwb25zZSBpbiBJUE1CIHBhY2tldHMgY29taW5nIGZy
b20NCiAgICA+IGRldmljZSBhcyB3ZWxsIGFzIGZyb20gaG9zdC4gTm93IGl0IHN1cHBvcnRzIGJv
dGggd2F5IGNvbW11bmljYXRpb24NCiAgICA+IHRvIGRldmljZSB2aWEgSVBNQi4gQm90aCByZXF1
ZXN0IGFuZCByZXNwb25zZSB3aWxsIGJlIHBhc3NlZCB0bw0KICAgID4gYXBwbGljYXRpb24uDQog
ICAgPiANCiAgICA+IFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIu
Y29tPg0KICAgID4gLS0tDQogICAgPiAgZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMg
fCAyOSArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMjggZGVsZXRpb25zKC0pDQogICAgPiANCiAgICA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYyBiL2RyaXZlcnMvY2hhci9pcG1p
L2lwbWJfZGV2X2ludC5jDQogICAgPiBpbmRleCAyODVlMGI4ZjlhOTcuLjcyMDFmZGI1MzNkOCAx
MDA2NDQNCiAgICA+IC0tLSBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jDQogICAg
PiArKysgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gQEAgLTEzMyw5
ICsxMzMsNiBAQCBzdGF0aWMgc3NpemVfdCBpcG1iX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBj
b25zdCBjaGFyIF9fdXNlciAqYnVmLA0KICAgID4gIAlycV9zYSA9IEdFVF83QklUX0FERFIobXNn
W1JRX1NBXzhCSVRfSURYXSk7DQogICAgPiAgCW5ldGZfcnFfbHVuID0gbXNnW05FVEZOX0xVTl9J
RFhdOw0KICAgID4gIA0KICAgID4gLQlpZiAoIShuZXRmX3JxX2x1biAmIE5FVEZOX1JTUF9CSVRf
TUFTSykpDQogICAgPiAtCQlyZXR1cm4gLUVJTlZBTDsNCiAgICA+IC0NCiAgICA+ICAJLyoNCiAg
ICA+ICAJICogc3VidHJhY3QgcnFfc2EgYW5kIG5ldGZfcnFfbHVuIGZyb20gdGhlIGxlbmd0aCBv
ZiB0aGUgbXNnIHBhc3NlZCB0bw0KICAgID4gIAkgKiBpMmNfc21idXNfeGZlcg0KICAgID4gQEAg
LTIwMywyOCArMjAwLDYgQEAgc3RhdGljIHU4IGlwbWJfdmVyaWZ5X2NoZWNrc3VtMShzdHJ1Y3Qg
aXBtYl9kZXYgKmlwbWJfZGV2LCB1OCByc19zYSkNCiAgICA+ICAJCWlwbWJfZGV2LT5yZXF1ZXN0
LmNoZWNrc3VtMSk7DQogICAgPiAgfQ0KICAgID4gIA0KICAgID4gLXN0YXRpYyBib29sIGlzX2lw
bWJfcmVxdWVzdChzdHJ1Y3QgaXBtYl9kZXYgKmlwbWJfZGV2LCB1OCByc19zYSkNCiAgICA+IC17
DQogICAgPiAtCWlmIChpcG1iX2Rldi0+bXNnX2lkeCA+PSBJUE1CX1JFUVVFU1RfTEVOX01JTikg
ew0KICAgID4gLQkJaWYgKGlwbWJfdmVyaWZ5X2NoZWNrc3VtMShpcG1iX2RldiwgcnNfc2EpKQ0K
ICAgID4gLQkJCXJldHVybiBmYWxzZTsNCiAgICANCiAgICBZb3Ugc3RpbGwgbmVlZCB0byBjaGVj
ayB0aGUgbWVzc2FnZSBsZW5ndGggYW5kIGNoZWNrc3VtLCB5b3UganVzdCBuZWVkDQogICAgdG8g
aWdub3JlIHRoZSByZXEvcmVzcCBiaXQuDQpZZXMgeW91IGFyZSByaWdodCwgSSB3YXMgbG9va2lu
ZyBmb3IgY2hlY2tzdW0gY29kZSBhZnRlciByZW1vdmluZyBpdCBfXy4gSSB3aWxsIG1vZGlmeSBp
dC4NCg0KQmVzaWRlcyBDb3JleSdzIGNvbW1lbnQsIGxvb2tzIGdvb2QgdG8gbWUuIFRoZSBsb2dp
YyBzaG91bGQgYmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCnN0YXRpYyBib29sIGlzX2lwbWJfbXNn
KHN0cnVjdCBpcG1iX2RldiAqaXBtYl9kZXYsIHU4IHJzX3NhKQ0KIHsNCiAgICAgICAgIGlmIChp
cG1iX2Rldi0+bXNnX2lkeCA+PSBJUE1CX1JFUVVFU1RfTEVOX01JTikgew0KICAgICAgICAgICAg
ICAgICBpZiAoaXBtYl92ZXJpZnlfY2hlY2tzdW0xKGlwbWJfZGV2LCByc19zYSkpDQogICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICAgICAgfSBlbHNlIHsNCiAgICAg
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICAgICAgfQ0KICAgICAgICAgcmV0dXJuIHRy
dWU7DQp9DQogICAgDQogICAgLWNvcmV5DQogICAgDQogICAgPiAtDQogICAgPiAtCQkvKg0KICAg
ID4gLQkJICogQ2hlY2sgd2hldGhlciB0aGlzIGlzIGFuIElQTUIgcmVxdWVzdCBvcg0KICAgID4g
LQkJICogcmVzcG9uc2UuDQogICAgPiAtCQkgKiBUaGUgNiBNU0Igb2YgbmV0Zm5fcnNfbHVuIGFy
ZSBkZWRpY2F0ZWQgdG8gdGhlIG5ldGZuDQogICAgPiAtCQkgKiB3aGlsZSB0aGUgcmVtYWluaW5n
IGJpdHMgYXJlIGRlZGljYXRlZCB0byB0aGUgbHVuLg0KICAgID4gLQkJICogSWYgdGhlIExTQiBv
ZiB0aGUgbmV0Zm4gaXMgY2xlYXJlZCwgaXQgaXMgYXNzb2NpYXRlZA0KICAgID4gLQkJICogd2l0
aCBhbiBJUE1CIHJlcXVlc3QuDQogICAgPiAtCQkgKiBJZiB0aGUgTFNCIG9mIHRoZSBuZXRmbiBp
cyBzZXQsIGl0IGlzIGFzc29jaWF0ZWQgd2l0aA0KICAgID4gLQkJICogYW4gSVBNQiByZXNwb25z
ZS4NCiAgICA+IC0JCSAqLw0KICAgID4gLQkJaWYgKCEoaXBtYl9kZXYtPnJlcXVlc3QubmV0Zm5f
cnNfbHVuICYgTkVURk5fUlNQX0JJVF9NQVNLKSkNCiAgICA+IC0JCQlyZXR1cm4gdHJ1ZTsNCiAg
ICA+IC0JfQ0KICAgID4gLQlyZXR1cm4gZmFsc2U7DQogICAgPiAtfQ0KICAgID4gLQ0KICAgID4g
IC8qDQogICAgPiAgICogVGhlIElQTUIgcHJvdG9jb2wgb25seSBzdXBwb3J0cyBJMkMgV3JpdGVz
IHNvIHRoZXJlIGlzIG5vIG5lZWQNCiAgICA+ICAgKiB0byBzdXBwb3J0IEkyQ19TTEFWRV9SRUFE
KiBldmVudHMuDQogICAgPiBAQCAtMjczLDkgKzI0OCw3IEBAIHN0YXRpYyBpbnQgaXBtYl9zbGF2
ZV9jYihzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LA0KICAgID4gIA0KICAgID4gIAljYXNlIEky
Q19TTEFWRV9TVE9QOg0KICAgID4gIAkJaXBtYl9kZXYtPnJlcXVlc3QubGVuID0gaXBtYl9kZXYt
Pm1zZ19pZHg7DQogICAgPiAtDQogICAgPiAtCQlpZiAoaXNfaXBtYl9yZXF1ZXN0KGlwbWJfZGV2
LCBHRVRfOEJJVF9BRERSKGNsaWVudC0+YWRkcikpKQ0KICAgID4gLQkJCWlwbWJfaGFuZGxlX3Jl
cXVlc3QoaXBtYl9kZXYpOw0KICAgID4gKwkJaXBtYl9oYW5kbGVfcmVxdWVzdChpcG1iX2Rldik7
DQoNCktlZXAgdGhpcyBsaW5lLg0KICAgID4gIAkJYnJlYWs7DQogICAgPiAgDQogICAgPiAgCWRl
ZmF1bHQ6DQogICAgPiAtLSANCiAgICA+IDIuMTcuMQ0KICAgID4gDQogICAgDQoNCg==
