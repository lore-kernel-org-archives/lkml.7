Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AF0206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="hZrxwDex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfDDMYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:24:22 -0400
Received: from mail-eopbgr10099.outbound.protection.outlook.com ([40.107.1.99]:12548
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbfDDMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector2-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gEDc/K4SAQCkputn6kB9zgjzTcxXVZDloIEf1lmnbk=;
 b=hZrxwDex9EhKJ3rU4t4LXOPDXW1oa7RhpY/33u52P7E9+jS99BcSWXA0/Q+0lnY+0THDO5wtaGpngxlI643fQ7oDZrrPtbfoore7uo/0i/ZmepWxm/+SC6P41LR/P1CCl8d9tkETfJlCRgWr0kzq4+pe/rRhT9Dppn9j8OB8+Aw=
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com (20.177.190.218) by
 AM6PR07MB4965.eurprd07.prod.outlook.com (20.177.197.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.11; Thu, 4 Apr 2019 12:24:02 +0000
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825]) by AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825%4]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 12:24:02 +0000
From:   "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
CC:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>,
        "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        Bob Briscoe <research@bobbriscoe.net>,
        Lawrence Brakmo <brakmo@fb.com>,
        Florian Westphal <fw@strlen.de>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Shewmaker <agshew@gmail.com>,
        Glenn Judd <glenn.judd@morganstanley.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Topic: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Index: AQHU6uFJ5qKL9TJ2LUy0DTa6bmxATw==
Date:   Thu, 4 Apr 2019 12:24:02 +0000
Message-ID: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MRXP264CA0038.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::26) To AM6PR07MB4821.eurprd07.prod.outlook.com
 (2603:10a6:20b:3c::26)
x-mailer: git-send-email 2.21.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=olivier.tilmans@nokia-bell-labs.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [135.245.212.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef55d4f-43e5-44bd-15ff-08d6b8f86be3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR07MB4965;
x-ms-traffictypediagnostic: AM6PR07MB4965:
x-microsoft-antispam-prvs: <AM6PR07MB4965CB53D23C582C548C9CB5E0500@AM6PR07MB4965.eurprd07.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(2906002)(26005)(59246006)(81156014)(81166006)(4326008)(6512007)(71200400001)(71190400001)(6436002)(1671002)(53936002)(109986005)(186003)(54906003)(7736002)(8936002)(7416002)(386003)(6506007)(2616005)(305945005)(8676002)(66066001)(476003)(14454004)(25786009)(105586002)(86362001)(68736007)(486006)(5660300002)(106356001)(52116002)(50226002)(6486002)(6116002)(3846002)(1076003)(478600001)(36756003)(102836004)(316002)(99286004)(14444005)(256004)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR07MB4965;H:AM6PR07MB4821.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: nokia-bell-labs.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: z9hgYMjpHlTW2bWllrtGvJMF4ujS5NAFexEIqJH61uSPUFAeglHV/1IDUPyI3Gnb1m6Sj95tnRmeIQbcvBVUPnu/HRbLfXZJkWGNFqL+3MSQPFQUBYspXhfMMda7mnJPZCb0XXRyBMgdm/LC+u+ZZpPmG7zDLhAHpizOtZbbkDm/vpYUz+GHk5rfDO15Qe4GJYOIev68nSM864uYeQkYwJfbsQksceQaKI+cbRDtj0UxJ8OIlp0nSnwUfb7+AcOMrA0teyR6AfsjMYWlYHHQjNxH87VdEGXjc/uFoSNqp4HVW8zZKVbhNA+hjkHpMaXMznkchHw04QYpC0o9Rv0QTfcEPgWA5GI0ymImrHQHs26WERfI7gjRTWMIoT2lqFEM/CzhSFTHf35DLl254FfbzsqoSADCnWfNHEbg1V0r6Ok=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52F3F0EF9A40A940BD88E91F5AB851E8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef55d4f-43e5-44bd-15ff-08d6b8f86be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 12:24:02.5421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB4965
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS29lbiBEZSBTY2hlcHBlciA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMu
Y29tPg0KDQpSRkM4MjU3IMKnMy41IGV4cGxpY2l0bHkgc3RhdGVzIHRoYXQgIkEgRENUQ1Agc2Vu
ZGVyIE1VU1QgcmVhY3QgdG8NCmxvc3MgZXBpc29kZXMgaW4gdGhlIHNhbWUgd2F5IGFzIGNvbnZl
bnRpb25hbCBUQ1AiLg0KDQpDdXJyZW50bHksIExpbnV4IERDVENQIHBlcmZvcm1zIG5vIGN3bmQg
cmVkdWN0aW9uIHdoZW4gbG9zc2VzDQphcmUgZW5jb3VudGVyZWQuIE9wdGlvbmFsbHksIHRoZSBk
Y3RjcF9jbGFtcF9hbHBoYV9vbl9sb3NzIHJlc2V0cw0KYWxwaGEgdG8gaXRzIG1heGltYWwgdmFs
dWUgaWYgYSBSVE8gaGFwcGVucy4gVGhpcyBiZWhhdmlvcg0KaXMgc3ViLW9wdGltYWwgZm9yIGF0
IGxlYXN0IHR3byByZWFzb25zOiBpKSBpdCBpZ25vcmVzIGxvc3Nlcw0KdHJpZ2dlcmluZyBmYXN0
IHJldHJhbnNtaXNzaW9uczsgYW5kIGlpKSBpdCBjYXVzZXMgdW5uZWNlc3NhcnkgbGFyZ2UNCmN3
bmQgcmVkdWN0aW9uIGluIHRoZSBmdXR1cmUgaWYgdGhlIGxvc3Mgd2FzIGlzb2xhdGVkIGFzIGl0
IHJlc2V0cw0KdGhlIGhpc3RvcmljYWwgdGVybSBvZiBEQ1RDUCdzIGFscGhhIEVXTUEgdG8gaXRz
IG1heGltYWwgdmFsdWUgKGkuZS4sDQpkZW5vdGluZyBhIHRvdGFsIGNvbmdlc3Rpb24pLiBUaGUg
c2Vjb25kIHJlYXNvbiBoYXMgYW4gZXNwZWNpYWxseQ0Kbm90aWNlYWJsZSBlZmZlY3Qgd2hlbiB1
c2luZyBEQ1RDUCBpbiBoaWdoIEJEUCBlbnZpcm9ubWVudHMsIHdoZXJlDQphbHBoYSBub3JtYWxs
eSBzdGF5cyBhdCBsb3cgdmFsdWVzLg0KDQpUaGlzIHBhdGNoIHJlcGxhY2UgdGhlIGNsYW1waW5n
IG9mIGFscGhhIGJ5IHNldHRpbmcgc3N0aHJlc2ggdG8NCmhhbGYgb2YgY3duZCBmb3IgYm90aCBm
YXN0IHJldHJhbnNtaXNzaW9ucyBhbmQgUlRPcywgYXQgbW9zdCBvbmNlDQpwZXIgUlRULiBDb25z
ZXF1ZW50bHksIHRoZSBkY3RjcF9jbGFtcF9hbHBoYV9vbl9sb3NzIG1vZHVsZSBwYXJhbWV0ZXIN
CmhhcyBiZWVuIHJlbW92ZWQuDQoNClRoZSB0YWJsZSBiZWxvdyBzaG93cyBleHBlcmltZW50YWwg
cmVzdWx0cyB3aGVyZSB3ZSBtZWFzdXJlZCB0aGUNCmRyb3AgcHJvYmFiaWxpdHkgb2YgYSBQSUUg
QVFNIChub3QgYXBwbHlpbmcgRUNOIG1hcmtzKSBhdCBhDQpib3R0bGVuZWNrIGluIHRoZSBwcmVz
ZW5jZSBvZiBhIHNpbmdsZSBUQ1AgZmxvdyB3aXRoIGVpdGhlciB0aGUNCmFscGhhLWNsYW1waW5n
IG9wdGlvbiBlbmFibGVkIG9yIHRoZSBjd25kIGhhbHZpbmcgcHJvcG9zZWQgYnkgdGhpcw0KcGF0
Y2guIFJlc3VsdHMgdXNpbmcgcmVubyBvciBjdWJpYyBhcmUgZ2l2ZW4gZm9yIGNvbXBhcmlzb24u
DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgTGluayAgIHwgICBSVFQgICAgfCAgICBE
cm9wDQogICAgICAgICAgICAgICAgIFRDUCBDQyAgIHwgIHNwZWVkICB8IGJhc2UrQVFNIHwgcHJv
YmFiaWxpdHkNCiAgICAgICAgPT09PT09PT09PT09PT09PT09fD09PT09PT09PXw9PT09PT09PT09
fD09PT09PT09PT09PQ0KICAgICAgICAgICAgICAgICAgICBDVUJJQyB8ICA0ME1icHMgfCAgNysy
MG1zICB8ICAgIDAuMjElDQogICAgICAgICAgICAgICAgICAgICBSRU5PIHwgICAgICAgICB8ICAg
ICAgICAgIHwgICAgMC4xOSUNCiAgICAgICAgRENUQ1AtQ0xBTVAtQUxQSEEgfCAgICAgICAgIHwg
ICAgICAgICAgfCAgIDI1LjgwJQ0KICAgICAgICAgRENUQ1AtSEFMVkUtQ1dORCB8ICAgICAgICAg
fCAgICAgICAgICB8ICAgIDAuMjIlDQogICAgICAgIC0tLS0tLS0tLS0tLS0tLS0tLXwtLS0tLS0t
LS18LS0tLS0tLS0tLXwtLS0tLS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgQ1VCSUMgfCAx
MDBNYnBzIHwgIDcrMjBtcyAgfCAgICAwLjAzJQ0KICAgICAgICAgICAgICAgICAgICAgUkVOTyB8
ICAgICAgICAgfCAgICAgICAgICB8ICAgIDAuMDIlDQogICAgICAgIERDVENQLUNMQU1QLUFMUEhB
IHwgICAgICAgICB8ICAgICAgICAgIHwgICAyMy4zMCUNCiAgICAgICAgIERDVENQLUhBTFZFLUNX
TkQgfCAgICAgICAgIHwgICAgICAgICAgfCAgICAwLjA0JQ0KICAgICAgICAtLS0tLS0tLS0tLS0t
LS0tLS18LS0tLS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tLS0tLS0tDQogICAgICAgICAgICAgICAg
ICAgIENVQklDIHwgODAwTWJwcyB8ICAgMSsxbXMgIHwgICAgMC4wNCUNCiAgICAgICAgICAgICAg
ICAgICAgIFJFTk8gfCAgICAgICAgIHwgICAgICAgICAgfCAgICAwLjA1JQ0KICAgICAgICBEQ1RD
UC1DTEFNUC1BTFBIQSB8ICAgICAgICAgfCAgICAgICAgICB8ICAgMTguNzAlDQogICAgICAgICBE
Q1RDUC1IQUxWRS1DV05EIHwgICAgICAgICB8ICAgICAgICAgIHwgICAgMC4wNiUNCg0KV2Ugc2Vl
IHRoYXQsIHdpdGhvdXQgaGFsdmluZyBpdHMgY3duZCBmb3IgYWxsIHNvdXJjZSBvZiBsb3NzZXMs
DQpEQ1RDUCBkcml2ZXMgdGhlIEFRTSB0byBsYXJnZSBkcm9wIHByb2JhYmlsaXRpZXMgaW4gb3Jk
ZXIgdG8ga2VlcA0KdGhlIHF1ZXVlIGxlbmd0aCB1bmRlciBjb250cm9sIChpLmUuLCBpdCByZXBl
YXRlZGx5IGZhY2VzIFJUT3MpLg0KSW5zdGVhZCwgaWYgRENUQ1AgcmVhY3RzIHRvIGFsbCBzb3Vy
Y2Ugb2YgbG9zc2VzLCBpdCBjYW4gdGhlbiBiZQ0KY29udHJvbGxlZCBieSB0aGUgQVFNIHVzaW5n
IHNpbWlsYXIgZHJvcCBsZXZlbHMgdGhhbiBjdWJpYyBvciByZW5vLg0KDQpTaWduZWQtb2ZmLWJ5
OiBLb2VuIERlIFNjaGVwcGVyIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBPbGl2aWVyIFRpbG1hbnMgPG9saXZpZXIudGlsbWFuc0Bub2tpYS1i
ZWxsLWxhYnMuY29tPg0KQ2M6IEJvYiBCcmlzY29lIDxyZXNlYXJjaEBib2JicmlzY29lLm5ldD4N
CkNjOiBMYXdyZW5jZSBCcmFrbW8gPGJyYWttb0BmYi5jb20+DQpDYzogRmxvcmlhbiBXZXN0cGhh
bCA8ZndAc3RybGVuLmRlPg0KQ2M6IERhbmllbCBCb3JrbWFubiA8Ym9ya21hbm5AaW9nZWFyYm94
Lm5ldD4NCkNjOiBZdWNodW5nIENoZW5nIDx5Y2hlbmdAZ29vZ2xlLmNvbT4NCkNjOiBOZWFsIENh
cmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4NCkNjOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+DQpDYzogQW5kcmV3IFNoZXdtYWtlciA8YWdzaGV3QGdtYWlsLmNvbT4NCkNj
OiBHbGVubiBKdWRkIDxnbGVubi5qdWRkQG1vcmdhbnN0YW5sZXkuY29tPg0KDQotLS0NCnYxIC0+
IHYyOg0KICAgIC0gUmVtb3ZlIHRoZSBtb2R1bGUgcGFyYW1ldGVyIHRoYXQgd2FzIG1ha2luZyB0
aGUgcmVhY3Rpb24gdG8gbG9zc2VzDQogICAgICBvcHRpb25hbCBhcyBSRkM4MjU3IHNwZWNpZmll
cyB0aGUgYmVoYXZpb3IgYXMgYSBNVVNULg0KLS0tDQogbmV0L2lwdjQvdGNwX2RjdGNwLmMgfCAz
NiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9uZXQvaXB2
NC90Y3BfZGN0Y3AuYyBiL25ldC9pcHY0L3RjcF9kY3RjcC5jDQppbmRleCBjZDQ4MTRmN2U5NjIu
LjM1OWRhNjhkN2MwNiAxMDA2NDQNCi0tLSBhL25ldC9pcHY0L3RjcF9kY3RjcC5jDQorKysgYi9u
ZXQvaXB2NC90Y3BfZGN0Y3AuYw0KQEAgLTY3LDExICs2Nyw2IEBAIHN0YXRpYyB1bnNpZ25lZCBp
bnQgZGN0Y3BfYWxwaGFfb25faW5pdCBfX3JlYWRfbW9zdGx5ID0gRENUQ1BfTUFYX0FMUEhBOw0K
IG1vZHVsZV9wYXJhbShkY3RjcF9hbHBoYV9vbl9pbml0LCB1aW50LCAwNjQ0KTsNCiBNT0RVTEVf
UEFSTV9ERVNDKGRjdGNwX2FscGhhX29uX2luaXQsICJwYXJhbWV0ZXIgZm9yIGluaXRpYWwgYWxw
aGEgdmFsdWUiKTsNCiANCi1zdGF0aWMgdW5zaWduZWQgaW50IGRjdGNwX2NsYW1wX2FscGhhX29u
X2xvc3MgX19yZWFkX21vc3RseTsNCi1tb2R1bGVfcGFyYW0oZGN0Y3BfY2xhbXBfYWxwaGFfb25f
bG9zcywgdWludCwgMDY0NCk7DQotTU9EVUxFX1BBUk1fREVTQyhkY3RjcF9jbGFtcF9hbHBoYV9v
bl9sb3NzLA0KLQkJICJwYXJhbWV0ZXIgZm9yIGNsYW1waW5nIGFscGhhIG9uIGxvc3MiKTsNCi0N
CiBzdGF0aWMgc3RydWN0IHRjcF9jb25nZXN0aW9uX29wcyBkY3RjcF9yZW5vOw0KIA0KIHN0YXRp
YyB2b2lkIGRjdGNwX3Jlc2V0KGNvbnN0IHN0cnVjdCB0Y3Bfc29jayAqdHAsIHN0cnVjdCBkY3Rj
cCAqY2EpDQpAQCAtMTY0LDIxICsxNTksMjMgQEAgc3RhdGljIHZvaWQgZGN0Y3BfdXBkYXRlX2Fs
cGhhKHN0cnVjdCBzb2NrICpzaywgdTMyIGZsYWdzKQ0KIAl9DQogfQ0KIA0KLXN0YXRpYyB2b2lk
IGRjdGNwX3N0YXRlKHN0cnVjdCBzb2NrICpzaywgdTggbmV3X3N0YXRlKQ0KK3N0YXRpYyB2b2lk
IGRjdGNwX3JlYWN0X3RvX2xvc3Moc3RydWN0IHNvY2sgKnNrKQ0KIHsNCi0JaWYgKGRjdGNwX2Ns
YW1wX2FscGhhX29uX2xvc3MgJiYgbmV3X3N0YXRlID09IFRDUF9DQV9Mb3NzKSB7DQotCQlzdHJ1
Y3QgZGN0Y3AgKmNhID0gaW5ldF9jc2tfY2Eoc2spOw0KKwlzdHJ1Y3QgZGN0Y3AgKmNhID0gaW5l
dF9jc2tfY2Eoc2spOw0KKwlzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsNCiANCi0J
CS8qIElmIHRoaXMgZXh0ZW5zaW9uIGlzIGVuYWJsZWQsIHdlIGNsYW1wIGRjdGNwX2FscGhhIHRv
DQotCQkgKiBtYXggb24gcGFja2V0IGxvc3M7IHRoZSBtb3RpdmF0aW9uIGlzIHRoYXQgZGN0Y3Bf
YWxwaGENCi0JCSAqIGlzIGFuIGluZGljYXRvciB0byB0aGUgZXh0ZW5kIG9mIGNvbmdlc3Rpb24g
YW5kIHBhY2tldA0KLQkJICogbG9zcyBpcyBhbiBpbmRpY2F0b3Igb2YgZXh0cmVtZSBjb25nZXN0
aW9uOyBzZXR0aW5nDQotCQkgKiB0aGlzIGluIHByYWN0aWNlIHR1cm5lZCBvdXQgdG8gYmUgYmVu
ZWZpY2lhbCwgYW5kDQotCQkgKiBlZmZlY3RpdmVseSBhc3N1bWVzIHRvdGFsIGNvbmdlc3Rpb24g
d2hpY2ggcmVkdWNlcyB0aGUNCi0JCSAqIHdpbmRvdyBieSBoYWxmLg0KLQkJICovDQotCQljYS0+
ZGN0Y3BfYWxwaGEgPSBEQ1RDUF9NQVhfQUxQSEE7DQotCX0NCisJY2EtPmxvc3NfY3duZCA9IHRw
LT5zbmRfY3duZDsNCisJdHAtPnNuZF9zc3RocmVzaCA9IG1heCh0cC0+c25kX2N3bmQgPj4gMVUs
IDJVKTsNCit9DQorDQorc3RhdGljIHZvaWQgZGN0Y3Bfc3RhdGUoc3RydWN0IHNvY2sgKnNrLCB1
OCBuZXdfc3RhdGUpDQorew0KKwlpZiAobmV3X3N0YXRlID09IFRDUF9DQV9SZWNvdmVyeSAmJg0K
KwkgICAgbmV3X3N0YXRlICE9IGluZXRfY3NrKHNrKS0+aWNza19jYV9zdGF0ZSkNCisJCWRjdGNw
X3JlYWN0X3RvX2xvc3Moc2spOw0KKwkvKiBXZSBoYW5kbGUgUlRPIGluIGRjdGNwX2N3bmRfZXZl
bnQgdG8gZW5zdXJlIHRoYXQgd2UgcGVyZm9ybSBvbmx5DQorCSAqIG9uZSBsb3NzLWFkanVzdG1l
bnQgcGVyIFJUVC4NCisJICovDQogfQ0KIA0KIHN0YXRpYyB2b2lkIGRjdGNwX2N3bmRfZXZlbnQo
c3RydWN0IHNvY2sgKnNrLCBlbnVtIHRjcF9jYV9ldmVudCBldikNCkBAIC0xOTAsNiArMTg3LDkg
QEAgc3RhdGljIHZvaWQgZGN0Y3BfY3duZF9ldmVudChzdHJ1Y3Qgc29jayAqc2ssIGVudW0gdGNw
X2NhX2V2ZW50IGV2KQ0KIAljYXNlIENBX0VWRU5UX0VDTl9OT19DRToNCiAJCWRjdGNwX2VjZV9h
Y2tfdXBkYXRlKHNrLCBldiwgJmNhLT5wcmlvcl9yY3Zfbnh0LCAmY2EtPmNlX3N0YXRlKTsNCiAJ
CWJyZWFrOw0KKwljYXNlIENBX0VWRU5UX0xPU1M6DQorCQlkY3RjcF9yZWFjdF90b19sb3NzKHNr
KTsNCisJCWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJLyogRG9uJ3QgY2FyZSBmb3IgdGhlIHJlc3Qu
ICovDQogCQlicmVhazsNCi0tIA0KMi4yMS4wDQoNCg==
