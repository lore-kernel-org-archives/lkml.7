Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD42EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9063E20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="d75TDpEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfCYRVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:21:04 -0400
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:37958
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfCYRVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuxdgdOwrVRlzLb/8EsQ/M0KbqmBLZ9JPyFfDdIEMxg=;
 b=d75TDpEFpCfhSxA67LyIjLX2hhrd8TxIFrckqnraQvOjaMZfwKB3bxEj2NpZz30gAGJ8q1NyhVmGFkbSpUFwvEMPDY+YJtH1ig2pmdGc2nTsOvak5F7RO1QOMi+p3PBK4VjNSOa2PHquuJ9aOQ1TFy0HAbcB6Agl9kmH+VVopcc=
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com (52.134.26.12) by
 VI1PR03MB4718.eurprd03.prod.outlook.com (20.177.51.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Mon, 25 Mar 2019 17:20:54 +0000
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::3cea:32aa:784e:f484]) by VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::3cea:32aa:784e:f484%4]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:20:54 +0000
From:   =?utf-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@nextfour.com>
To:     Christian Brauner <christian@brauner.io>,
        "jannh@google.com" <jannh@google.com>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>,
        "luto@kernel.org" <luto@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "bl0pbl33p@gmail.com" <bl0pbl33p@gmail.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "nagarathnam.muthusamy@oracle.com" <nagarathnam.muthusamy@oracle.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "dancol@google.com" <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidctl()
Thread-Topic: [PATCH 2/4] pid: add pidctl()
Thread-Index: AQHU4ybX4/0thVFPBU6Qo9fd2t9MEaYcl+EA
Date:   Mon, 25 Mar 2019 17:20:54 +0000
Message-ID: <071b12db-f84e-8666-d70a-1b6cce71f9c0@nextfour.com>
References: <20190325162052.28987-1-christian@brauner.io>
 <20190325162052.28987-3-christian@brauner.io>
In-Reply-To: <20190325162052.28987-3-christian@brauner.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0011.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::21) To VI1PR03MB3775.eurprd03.prod.outlook.com
 (2603:10a6:803:34::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.193.232.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29068c79-570a-4775-be9f-08d6b1463c98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR03MB4718;
x-ms-traffictypediagnostic: VI1PR03MB4718:
x-microsoft-antispam-prvs: <VI1PR03MB4718AEC2F4FEA422BEAA46B7835E0@VI1PR03MB4718.eurprd03.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39830400003)(189003)(199004)(4326008)(81166006)(508600001)(66066001)(386003)(11346002)(446003)(99286004)(6486002)(106356001)(26005)(6506007)(81156014)(486006)(86362001)(105586002)(6436002)(31686004)(2501003)(2201001)(2616005)(102836004)(186003)(476003)(14454004)(8676002)(6512007)(5660300002)(8936002)(68736007)(31696002)(316002)(7736002)(52116002)(85182001)(6116002)(229853002)(3846002)(305945005)(6246003)(53936002)(76176011)(7416002)(2906002)(71190400001)(25786009)(14444005)(256004)(97736004)(71200400001)(54906003)(36756003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR03MB4718;H:VI1PR03MB3775.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fT4ZRVSsCDu4cEzhTi2Hyh8BxifmmvBKzjUEuLanWk2SG1+Dl4r86Uqyhe3ALw7ltzP3ThM88EEAQEvehSCwsRVMyGiO5JVGGGincskoBO2a1BcNGeen7WvD0KLAs7XA3uJU/35uHDs5EloNxMM9Vpd0gCnjPfmbwSkf6GQWu8vGRTu/oSXnSd8y2p+iy7e28TfZ+BfEMdfdWS1GRvuPwEQ42JEH0hhoi02flh6XLb72uURkkfjCD2u2LXkfzWLoLJJ89s/1DjBpUupJlxnA/hTxZW+C35ImMtyKTrgq+jjVYqcVTp2h1iqhMF65F781zaqiH18GqCQaF3Hq0ZhnExpq9WFewqa1Tfl99n2FVY4yu60xd3iWzK5szOuxB2cCAaWnQSYrR5Lg1dXjk+/rVTbvZBjlFSv4paqFCXrVj/I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68237FF34021B848A408F67553864965@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29068c79-570a-4775-be9f-08d6b1463c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:20:54.4075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCg0KPiArU1lTQ0FMTF9ERUZJTkU1KHBpZGN0bCwgdW5zaWduZWQgaW50LCBjbWQsIHBp
ZF90LCBwaWQsIGludCwgc291cmNlLCBpbnQsIHRhcmdldCwNCj4gKwkJdW5zaWduZWQgaW50LCBm
bGFncykNCj4gK3sNCj4gKwlzdHJ1Y3QgcGlkX25hbWVzcGFjZSAqc291cmNlX25zID0gTlVMTCwg
KnRhcmdldF9ucyA9IE5VTEw7DQo+ICsJc3RydWN0IHBpZCAqc3RydWN0X3BpZDsNCj4gKwlwaWRf
dCByZXN1bHQ7DQo+ICsNCj4gKwlzd2l0Y2ggKGNtZCkgew0KPiArCWNhc2UgUElEQ01EX1FVRVJZ
X1BJRE5TOg0KPiArCQlpZiAocGlkICE9IDApDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJ
cGlkID0gMTsNCj4gKwkJLyogZmFsbCB0aHJvdWdoICovDQo+ICsJY2FzZSBQSURDTURfUVVFUllf
UElEOg0KPiArCQlpZiAoZmxhZ3MgIT0gMCkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQli
cmVhazsNCj4gKwljYXNlIFBJRENNRF9HRVRfUElERkQ6DQo+ICsJCWlmIChmbGFncyAmIH5QSURD
VExfQ0xPRVhFQykNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQlicmVhazsNCj4gKwlkZWZh
dWx0Og0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsJfQ0KPiArDQo+ICsJc291cmNlX25z
ID0gZ2V0X3BpZF9uc19ieV9mZChzb3VyY2UpOw0KPiArCXJlc3VsdCA9IFBUUl9FUlIoc291cmNl
X25zKTsNCj4gKwlpZiAoSVNfRVJSKHNvdXJjZV9ucykpDQo+ICsJCWdvdG8gZXJyX3NvdXJjZTsN
Cj4gKw0KPiArCXRhcmdldF9ucyA9IGdldF9waWRfbnNfYnlfZmQodGFyZ2V0KTsNCj4gKwlyZXN1
bHQgPSBQVFJfRVJSKHRhcmdldF9ucyk7DQo+ICsJaWYgKElTX0VSUih0YXJnZXRfbnMpKQ0KPiAr
CQlnb3RvIGVycl90YXJnZXQ7DQo+ICsNCj4gKwlpZiAoY21kID09IFBJRENNRF9RVUVSWV9QSURO
Uykgew0KPiArCQlyZXN1bHQgPSBwaWRuc19yZWxhdGVkKHNvdXJjZV9ucywgdGFyZ2V0X25zKTsN
Cj4gKwl9IGVsc2Ugew0KPiArCQlyY3VfcmVhZF9sb2NrKCk7DQo+ICsJCXN0cnVjdF9waWQgPSBm
aW5kX3BpZF9ucyhwaWQsIHNvdXJjZV9ucyk7DQo+ICsJCXJlc3VsdCA9IHN0cnVjdF9waWQgPyBw
aWRfbnJfbnMoc3RydWN0X3BpZCwgdGFyZ2V0X25zKSA6IC1FU1JDSDsNCg0KU2hvdWxkIHlvdSBk
byBnZXRfcGlkKHN0cnVjdF9waWQpIGhlcmUgdG8ga2VlcCBpdCBhbGl2ZSB0aWxsIA0KcGlkZmRf
Y3JlYXRlX2ZkKCkgPw0KDQo+ICsJCXJjdV9yZWFkX3VubG9jaygpOw0KPiArDQo+ICsJCWlmIChj
bWQgPT0gUElEQ01EX0dFVF9QSURGRCkgew0KPiArCQkJaW50IGNsb2V4ZWMgPSAoZmxhZ3MgJiBQ
SURDVExfQ0xPRVhFQykgPyBPX0NMT0VYRUMgOiAwOw0KPiArCQkJaWYgKHJlc3VsdCA+IDApDQo+
ICsJCQkJcmVzdWx0ID0gcGlkZmRfY3JlYXRlX2ZkKHN0cnVjdF9waWQsIGNsb2V4ZWMpOw0KPiAr
CQkJZWxzZSBpZiAocmVzdWx0ID09IDApDQo+ICsJCQkJcmVzdWx0ID0gLUVOT0VOVDsNCj4gKwkJ
fQ0KPiArCX0NCj4gKw0KPiArCWlmICh0YXJnZXQpDQo+ICsJCXB1dF9waWRfbnModGFyZ2V0X25z
KTsNCj4gK2Vycl90YXJnZXQ6DQo+ICsJaWYgKHNvdXJjZSkNCj4gKwkJcHV0X3BpZF9ucyhzb3Vy
Y2VfbnMpOw0KPiArZXJyX3NvdXJjZToNCj4gKwlyZXR1cm4gcmVzdWx0Ow0KPiArfQ0KPiArDQo+
ICB2b2lkIF9faW5pdCBwaWRfaWRyX2luaXQodm9pZCkNCj4gIHsNCj4gIAkvKiBWZXJpZnkgbm8g
b25lIGhhcyBkb25lIGFueXRoaW5nIHNpbGx5OiAqLw0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3Bp
ZF9uYW1lc3BhY2UuYyBiL2tlcm5lbC9waWRfbmFtZXNwYWNlLmMNCj4gaW5kZXggYWE2ZTcyZmI3
YzA4Li4xYzg2M2ZiM2Q1NWEgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9waWRfbmFtZXNwYWNlLmMN
Cj4gKysrIGIva2VybmVsL3BpZF9uYW1lc3BhY2UuYw0KPiBAQCAtNDI5LDYgKzQyOSwzMSBAQCBz
dGF0aWMgc3RydWN0IG5zX2NvbW1vbiAqcGlkbnNfZ2V0X3BhcmVudChzdHJ1Y3QgbnNfY29tbW9u
ICpucykNCj4gIAlyZXR1cm4gJmdldF9waWRfbnMocGlkX25zKS0+bnM7DQo+ICB9DQo+ICANCj4g
Ky8qKg0KPiArICogcGlkbnNjbXAgLSBEZXRlcm1pbmUgaWYgQGFuY2VzdG9yIGlzIGFuY2VzdG9y
IG9mIEBkZXNjZW5kYW50DQo+ICsgKiBAYW5jZXN0b3I6ICAgcGlkbnMgc3VzcGVjdGVkIHRvIGJl
IHRoZSBhbmNlc3RvciBvZiBAZGVzY2VuZGFudA0KPiArICogQGRlc2NlbmRhbnQ6IHBpZG5zIHN1
c3BlY3RlZCB0byBiZSB0aGUgZGVzY2VuZGFudCBvZiBAYW5jZXN0b3INCj4gKyAqDQo+ICsgKiBS
ZXR1cm5zIC0xIGlmIEBhbmNlc3RvciBpcyBub3QgYW4gYW5jZXN0b3Igb2YgQGRlc2NlbmRhbnQs
DQo+ICsgKiAwIGlmIEBhbmNlc3RvciBpcyB0aGUgc2FtZSBwaWRucyBhcyBAZGVzY2VuZGFudCwg
MSBpZiBAYW5jZXN0b3INCj4gKyAqIGlzIGFuIGFuY2VzdG9yIG9mIEBkZXNjZW5kYW50Lg0KPiAr
ICovDQo+ICtpbnQgcGlkbnNjbXAoc3RydWN0IHBpZF9uYW1lc3BhY2UgKmFuY2VzdG9yLCBzdHJ1
Y3QgcGlkX25hbWVzcGFjZSAqZGVzY2VuZGFudCkNCj4gK3sNCj4gKwlpZiAoYW5jZXN0b3IgPT0g
ZGVzY2VuZGFudCkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlmb3IgKDs7KSB7DQo+ICsJCWlm
ICghZGVzY2VuZGFudCkNCj4gKwkJCXJldHVybiAtMTsNCj4gKwkJaWYgKGRlc2NlbmRhbnQgPT0g
YW5jZXN0b3IpDQo+ICsJCQlicmVhazsNCj4gKwkJZGVzY2VuZGFudCA9IGRlc2NlbmRhbnQtPnBh
cmVudDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHN0
cnVjdCB1c2VyX25hbWVzcGFjZSAqcGlkbnNfb3duZXIoc3RydWN0IG5zX2NvbW1vbiAqbnMpDQo+
ICB7DQo+ICAJcmV0dXJuIHRvX3BpZF9ucyhucyktPnVzZXJfbnM7DQo=
