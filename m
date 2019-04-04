Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC762075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="iOjnoLA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfDDI0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:26:31 -0400
Received: from mail-eopbgr50131.outbound.protection.outlook.com ([40.107.5.131]:27925
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725914AbfDDI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector2-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6pEFEhFae2HH60zsM3hks7GIjyrrGtjiduKfISvERQ=;
 b=iOjnoLA3440b3vHGngkozvxhLFE2g9hUFJE9QUhDlAsPSaGPs7Sqy3LVo1oBe9RMs3awyaiiU9qk+kJTzAQllf7PgB7Zz2Htk2Djbu9H9n88NAMJOgQ0gAOzBcWOsq2Rs2hqW3dLjc5T56+l3wlL5Ibi9yqzg37uqfahT4Hgn0E=
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com (20.177.190.218) by
 AM6PR07MB6104.eurprd07.prod.outlook.com (20.178.95.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.6; Thu, 4 Apr 2019 08:26:25 +0000
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825]) by AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825%4]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 08:26:25 +0000
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
Subject: [PATCH net-next] tcp: Ensure DCTCP reacts to losses
Thread-Topic: [PATCH net-next] tcp: Ensure DCTCP reacts to losses
Thread-Index: AQHU6sAXiVfbhvlD90a/It8eMzIGOQ==
Date:   Thu, 4 Apr 2019 08:26:25 +0000
Message-ID: <20190404082055.8981-1-olivier.tilmans@nokia-bell-labs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To AM6PR07MB4821.eurprd07.prod.outlook.com
 (2603:10a6:20b:3c::26)
x-mailer: git-send-email 2.21.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=olivier.tilmans@nokia-bell-labs.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [135.245.212.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0107b72-09ef-4df2-b23b-08d6b8d739e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR07MB6104;
x-ms-traffictypediagnostic: AM6PR07MB6104:
x-microsoft-antispam-prvs: <AM6PR07MB61049582160D704E243E459EE0500@AM6PR07MB6104.eurprd07.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(53936002)(81166006)(6436002)(316002)(14444005)(109986005)(97736004)(256004)(8676002)(5660300002)(186003)(2616005)(59246006)(476003)(106356001)(1076003)(1671002)(54906003)(50226002)(36756003)(4326008)(105586002)(26005)(486006)(81156014)(66066001)(99286004)(478600001)(68736007)(7736002)(305945005)(7416002)(14454004)(8936002)(86362001)(6486002)(6512007)(2906002)(3846002)(71200400001)(71190400001)(6116002)(386003)(6506007)(102836004)(52116002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR07MB6104;H:AM6PR07MB4821.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: nokia-bell-labs.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4FqvJ/F3KhIzGo7Uerwe4OjZr2PmjePgTAY0hqlvxTggzHkpdUUKqFoCbW01ucRDhCyzaHRJufdbTMQ/B23TT8fF67O0XzDhwN06B9fCiU90pcffV71DIOzrDNhFiGFjtFbefokkHvcB41CDYy2Q1dpaLNuCVNYWbwC+kRHeSXD4e5X9Kv5pFzVYgs+OnO80//3TzFDnASJDZ3uzuU9K7GeZ64LuUOQfUAhTzIYl5obp+VeQ9qDlOzFMIp1BZmWrTUsWHSLeAiTYSBlqPESolduVGtcMmDTXwT2iDtNZfSq36YbQ4/fUDgjYJeH4Rj/6If5CXxfk6GFkiItCQpdeMBIUay74VCro/+k+l9GQknT9iHet/522jFkkiAqozGViRO6nu1JFrJ7DPuCRbjnB3buuplVw0N7xCNDd2YYoSs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10AC70AF9E4FE54BB880A9EB976A9CC8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0107b72-09ef-4df2-b23b-08d6b8d739e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 08:26:25.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB6104
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UkZDODI1NyDCpzMuNSBleHBsaWNpdGx5IHN0YXRlcyB0aGF0IERDVENQIHNob3VsZCAicmVhY3Qg
dG8gbG9zcw0KZXBpc29kZSBpbiB0aGUgc2FtZSB3YXkgdGhhdCBhIGNvbnZlbnRpb25hbCBUQ1Ai
Lg0KVGhpcyBpcyBhbHNvIHRoZSBiZWhhdmlvciBvbiBNUyBXaW5kb3dzLg0KDQpDdXJyZW50bHks
IExpbnV4IERDVENQIHBlcmZvcm1zIG5vIHNzdGhyZXNoIHJlZHVjdGlvbiB3aGVuIGxvc3Nlcw0K
YXJlIGVuY291bnRlcmVkLiBPcHRpb25hbGx5LCB0aGUgZGN0Y3BfY2xhbXBfYWxwaGFfb25fbG9z
cyByZXNldHMNCmFscGhhIHRvIGl0cyBtYXhpbWFsIHZhbHVlIGlmIGEgUlRPIGhhcHBlbnMuIFRo
aXMgYmVoYXZpb3INCmlzIHN1Yi1vcHRpbWFsIGZvciBhdCBsZWFzdCB0d28gcmVhc29uczogaSkg
aXQgaWdub3JlcyBsb3NzZXMNCnRyaWdnZXJpbmcgZmFzdCByZXRyYW5zbWlzc2lvbnM7IGFuZCBp
aSkgaXQgY2F1c2VzIHVubmVjZXNzYXJ5IGxhcmdlDQpjd25kIHJlZHVjdGlvbiBpbiB0aGUgZnV0
dXJlIGlmIHRoZSBsb3NzIHdhcyBpc29sYXRlZCBhcyBpdCByZXNldHMNCnRoZSBoaXN0b3JpY2Fs
IHRlcm0gb2YgRENUQ1AncyBhbHBoYSBFV01BIHRvIGl0cyBtYXhpbWFsIHZhbHVlIChpLmUuLA0K
ZGVub3RpbmcgYSB0b3RhbCBjb25nZXN0aW9uKS4gVGhlIHNlY29uZCByZWFzb24gaGFzIGFuIGVz
cGVjaWFsbHkNCm5vdGljZWFibGUgZWZmZWN0IHdoZW4gdXNpbmcgRENUQ1AgaW4gaGlnaCBCRFAg
ZW52aXJvbm1lbnRzLCB3aGVyZQ0KYWxwaGEgbm9ybWFsbHkgc3RheXMgYXQgbG93IHZhbHVlcy4N
Cg0KVGhpcyBwYXRjaCByZXBsYWNlIHRoZSBjbGFtcGluZyBvZiBhbHBoYSBieSBzZXR0aW5nIHNz
dGhyZXNoIHRvDQpoYWxmIG9mIGN3bmQgZm9yIGJvdGggZmFzdCByZXRyYW5zbWlzc2lvbnMgYW5k
IFJUT3MsIGF0IG1vc3Qgb25jZQ0KcGVyIFJUVC4gVG8gcmVmbGVjdCB0aGUgY2hhbmdlLCB0aGUg
ZGN0Y3BfY2xhbXBfYWxwaGFfb25fbG9zcyBvcHRpb24NCmhhcyBiZWVuIHJlbmFtZWQgdG8gZGN0
Y3BfaGFsdmVfY3duZF9vbl9sb3NzLg0KDQpUaGUgdGFibGUgYmVsb3cgc2hvd3MgZXhwZXJpbWVu
dGFsIHJlc3VsdHMgd2hlcmUgd2UgbWVhc3VyZWQgdGhlDQpkcm9wIHByb2JhYmlsaXR5IG9mIGEg
UElFIEFRTSAobm90IGFwcGx5aW5nIEVDTiBtYXJrcykgYXQgYQ0KYm90dGxlbmVjayBpbiB0aGUg
cHJlc2VuY2Ugb2YgYSBzaW5nbGUgVENQIGZsb3cgd2l0aCBlaXRoZXIgdGhlDQphbHBoYS1jbGFt
cGluZyBvcHRpb24gZW5hYmxlZCBvciB0aGUgY3duZCBoYWx2aW5nIHByb3Bvc2VkIGJ5IHRoaXMN
CnBhdGNoLiBSZXN1bHRzIHVzaW5nIHJlbm8gb3IgY3ViaWMgYXJlIGdpdmVuIGZvciBjb21wYXJp
c29uLg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgIHwgIExpbmsgICB8ICAgUlRUICAgIHwg
ICAgRHJvcA0KICAgICAgICAgICAgICAgICBUQ1AgQ0MgICB8ICBzcGVlZCAgfCBiYXNlK0FRTSB8
IHByb2JhYmlsaXR5DQogICAgICAgID09PT09PT09PT09PT09PT09PXw9PT09PT09PT18PT09PT09
PT09PXw9PT09PT09PT09PT0NCiAgICAgICAgICAgICAgICAgICAgQ1VCSUMgfCAgNDBNYnBzIHwg
IDcrMjBtcyAgfCAgICAwLjIxJQ0KICAgICAgICAgICAgICAgICAgICAgUkVOTyB8ICAgICAgICAg
fCAgICAgICAgICB8ICAgIDAuMTklDQogICAgICAgIERDVENQLUNMQU1QLUFMUEhBIHwgICAgICAg
ICB8ICAgICAgICAgIHwgICAyNS44MCUNCiAgICAgICAgIERDVENQLUhBTFZFLUNXTkQgfCAgICAg
ICAgIHwgICAgICAgICAgfCAgICAwLjIyJQ0KICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS18LS0t
LS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tLS0tLS0tDQogICAgICAgICAgICAgICAgICAgIENVQklD
IHwgMTAwTWJwcyB8ICA3KzIwbXMgIHwgICAgMC4wMyUNCiAgICAgICAgICAgICAgICAgICAgIFJF
Tk8gfCAgICAgICAgIHwgICAgICAgICAgfCAgICAwLjAyJQ0KICAgICAgICBEQ1RDUC1DTEFNUC1B
TFBIQSB8ICAgICAgICAgfCAgICAgICAgICB8ICAgMjMuMzAlDQogICAgICAgICBEQ1RDUC1IQUxW
RS1DV05EIHwgICAgICAgICB8ICAgICAgICAgIHwgICAgMC4wNCUNCiAgICAgICAgLS0tLS0tLS0t
LS0tLS0tLS0tfC0tLS0tLS0tLXwtLS0tLS0tLS0tfC0tLS0tLS0tLS0tLQ0KICAgICAgICAgICAg
ICAgICAgICBDVUJJQyB8IDgwME1icHMgfCAgIDErMW1zICB8ICAgIDAuMDQlDQogICAgICAgICAg
ICAgICAgICAgICBSRU5PIHwgICAgICAgICB8ICAgICAgICAgIHwgICAgMC4wNSUNCiAgICAgICAg
RENUQ1AtQ0xBTVAtQUxQSEEgfCAgICAgICAgIHwgICAgICAgICAgfCAgIDE4LjcwJQ0KICAgICAg
ICAgRENUQ1AtSEFMVkUtQ1dORCB8ICAgICAgICAgfCAgICAgICAgICB8ICAgIDAuMDYlDQoNCldl
IHNlZSB0aGF0LCB3aXRob3V0IGhhbHZpbmcgaXRzIGN3bmQgZm9yIGFsbCBzb3VyY2Ugb2YgbG9z
c2VzLA0KRENUQ1AgZHJpdmVzIHRoZSBBUU0gdG8gbGFyZ2UgZHJvcCBwcm9iYWJpbGl0aWVzIGlu
IG9yZGVyIHRvIGtlZXANCnRoZSBxdWV1ZSBsZW5ndGggdW5kZXIgY29udHJvbCAoaS5lLiwgaXQg
cmVwZWF0ZWRseSBmYWNlcyBSVE9zKS4NCkluc3RlYWQsIGlmIERDVENQIHJlYWN0cyB0byBhbGwg
c291cmNlIG9mIGxvc3NlcywgaXQgY2FuIHRoZW4gYmUNCmNvbnRyb2xsZWQgYnkgdGhlIEFRTSB1
c2luZyBzaW1pbGFyIGRyb3AgbGV2ZWxzIHRoYW4gY3ViaWMgb3IgcmVuby4NCg0KU2lnbmVkLW9m
Zi1ieTogS29lbiBEZSBTY2hlcHBlciA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMu
Y29tPg0KU2lnbmVkLW9mZi1ieTogT2xpdmllciBUaWxtYW5zIDxvbGl2aWVyLnRpbG1hbnNAbm9r
aWEtYmVsbC1sYWJzLmNvbT4NCkNjOiBCb2IgQnJpc2NvZSA8cmVzZWFyY2hAYm9iYnJpc2NvZS5u
ZXQ+DQpDYzogTGF3cmVuY2UgQnJha21vIDxicmFrbW9AZmIuY29tPg0KQ2M6IEZsb3JpYW4gV2Vz
dHBoYWwgPGZ3QHN0cmxlbi5kZT4NCkNjOiBEYW5pZWwgQm9ya21hbm4gPGJvcmttYW5uQGlvZ2Vh
cmJveC5uZXQ+DQpDYzogWXVjaHVuZyBDaGVuZyA8eWNoZW5nQGdvb2dsZS5jb20+DQpDYzogTmVh
bCBDYXJkd2VsbCA8bmNhcmR3ZWxsQGdvb2dsZS5jb20+DQpDYzogRXJpYyBEdW1hemV0IDxlZHVt
YXpldEBnb29nbGUuY29tPg0KQ2M6IEFuZHJldyBTaGV3bWFrZXIgPGFnc2hld0BnbWFpbC5jb20+
DQpDYzogR2xlbm4gSnVkZCA8Z2xlbm4uanVkZEBtb3JnYW5zdGFubGV5LmNvbT4NCi0tLQ0KIG5l
dC9pcHY0L3RjcF9kY3RjcC5jIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwX2RjdGNwLmMgYi9uZXQvaXB2NC90Y3BfZGN0
Y3AuYw0KaW5kZXggY2Q0ODE0ZjdlOTYyLi42MDQxNzI0M2U3ZDcgMTAwNjQ0DQotLS0gYS9uZXQv
aXB2NC90Y3BfZGN0Y3AuYw0KKysrIGIvbmV0L2lwdjQvdGNwX2RjdGNwLmMNCkBAIC02NywxMCAr
NjcsOSBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGRjdGNwX2FscGhhX29uX2luaXQgX19yZWFkX21v
c3RseSA9IERDVENQX01BWF9BTFBIQTsNCiBtb2R1bGVfcGFyYW0oZGN0Y3BfYWxwaGFfb25faW5p
dCwgdWludCwgMDY0NCk7DQogTU9EVUxFX1BBUk1fREVTQyhkY3RjcF9hbHBoYV9vbl9pbml0LCAi
cGFyYW1ldGVyIGZvciBpbml0aWFsIGFscGhhIHZhbHVlIik7DQogDQotc3RhdGljIHVuc2lnbmVk
IGludCBkY3RjcF9jbGFtcF9hbHBoYV9vbl9sb3NzIF9fcmVhZF9tb3N0bHk7DQotbW9kdWxlX3Bh
cmFtKGRjdGNwX2NsYW1wX2FscGhhX29uX2xvc3MsIHVpbnQsIDA2NDQpOw0KLU1PRFVMRV9QQVJN
X0RFU0MoZGN0Y3BfY2xhbXBfYWxwaGFfb25fbG9zcywNCi0JCSAicGFyYW1ldGVyIGZvciBjbGFt
cGluZyBhbHBoYSBvbiBsb3NzIik7DQorc3RhdGljIHVuc2lnbmVkIGludCBkY3RjcF9oYWx2ZV9j
d25kX29uX2xvc3MgX19yZWFkX21vc3RseTsNCittb2R1bGVfcGFyYW0oZGN0Y3BfaGFsdmVfY3du
ZF9vbl9sb3NzLCB1aW50LCAwNjQ0KTsNCitNT0RVTEVfUEFSTV9ERVNDKGRjdGNwX2hhbHZlX2N3
bmRfb25fbG9zcywgImhhbHZlIGN3bmQgaW4gY2FzZSBvZiBsb3NzZXMiKTsNCiANCiBzdGF0aWMg
c3RydWN0IHRjcF9jb25nZXN0aW9uX29wcyBkY3RjcF9yZW5vOw0KIA0KQEAgLTE2NCwyMSArMTYz
LDIzIEBAIHN0YXRpYyB2b2lkIGRjdGNwX3VwZGF0ZV9hbHBoYShzdHJ1Y3Qgc29jayAqc2ssIHUz
MiBmbGFncykNCiAJfQ0KIH0NCiANCi1zdGF0aWMgdm9pZCBkY3RjcF9zdGF0ZShzdHJ1Y3Qgc29j
ayAqc2ssIHU4IG5ld19zdGF0ZSkNCitzdGF0aWMgdm9pZCBkY3RjcF9yZWFjdF90b19sb3NzKHN0
cnVjdCBzb2NrICpzaykNCiB7DQotCWlmIChkY3RjcF9jbGFtcF9hbHBoYV9vbl9sb3NzICYmIG5l
d19zdGF0ZSA9PSBUQ1BfQ0FfTG9zcykgew0KLQkJc3RydWN0IGRjdGNwICpjYSA9IGluZXRfY3Nr
X2NhKHNrKTsNCisJc3RydWN0IGRjdGNwICpjYSA9IGluZXRfY3NrX2NhKHNrKTsNCisJc3RydWN0
IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7DQogDQotCQkvKiBJZiB0aGlzIGV4dGVuc2lvbiBp
cyBlbmFibGVkLCB3ZSBjbGFtcCBkY3RjcF9hbHBoYSB0bw0KLQkJICogbWF4IG9uIHBhY2tldCBs
b3NzOyB0aGUgbW90aXZhdGlvbiBpcyB0aGF0IGRjdGNwX2FscGhhDQotCQkgKiBpcyBhbiBpbmRp
Y2F0b3IgdG8gdGhlIGV4dGVuZCBvZiBjb25nZXN0aW9uIGFuZCBwYWNrZXQNCi0JCSAqIGxvc3Mg
aXMgYW4gaW5kaWNhdG9yIG9mIGV4dHJlbWUgY29uZ2VzdGlvbjsgc2V0dGluZw0KLQkJICogdGhp
cyBpbiBwcmFjdGljZSB0dXJuZWQgb3V0IHRvIGJlIGJlbmVmaWNpYWwsIGFuZA0KLQkJICogZWZm
ZWN0aXZlbHkgYXNzdW1lcyB0b3RhbCBjb25nZXN0aW9uIHdoaWNoIHJlZHVjZXMgdGhlDQotCQkg
KiB3aW5kb3cgYnkgaGFsZi4NCi0JCSAqLw0KLQkJY2EtPmRjdGNwX2FscGhhID0gRENUQ1BfTUFY
X0FMUEhBOw0KLQl9DQorCWNhLT5sb3NzX2N3bmQgPSB0cC0+c25kX2N3bmQ7DQorCXRwLT5zbmRf
c3N0aHJlc2ggPSBtYXgodHAtPnNuZF9jd25kID4+IDFVLCAyVSk7DQorfQ0KKw0KK3N0YXRpYyB2
b2lkIGRjdGNwX3N0YXRlKHN0cnVjdCBzb2NrICpzaywgdTggbmV3X3N0YXRlKQ0KK3sNCisJaWYg
KGRjdGNwX2hhbHZlX2N3bmRfb25fbG9zcyAmJiBuZXdfc3RhdGUgPT0gVENQX0NBX1JlY292ZXJ5
ICYmDQorCSAgICBuZXdfc3RhdGUgIT0gaW5ldF9jc2soc2spLT5pY3NrX2NhX3N0YXRlKQ0KKwkJ
ZGN0Y3BfcmVhY3RfdG9fbG9zcyhzayk7DQorCS8qIFdlIGhhbmRsZSBSVE8gaW4gZGN0Y3BfY3du
ZF9ldmVudCB0byBlbnN1cmUgdGhhdCB3ZSBwZXJmb3JtIG9ubHkNCisJICogb25lIGxvc3MtYWRq
dXN0bWVudCBwZXIgUlRULg0KKwkgKi8NCiB9DQogDQogc3RhdGljIHZvaWQgZGN0Y3BfY3duZF9l
dmVudChzdHJ1Y3Qgc29jayAqc2ssIGVudW0gdGNwX2NhX2V2ZW50IGV2KQ0KQEAgLTE5MCw2ICsx
OTEsMTAgQEAgc3RhdGljIHZvaWQgZGN0Y3BfY3duZF9ldmVudChzdHJ1Y3Qgc29jayAqc2ssIGVu
dW0gdGNwX2NhX2V2ZW50IGV2KQ0KIAljYXNlIENBX0VWRU5UX0VDTl9OT19DRToNCiAJCWRjdGNw
X2VjZV9hY2tfdXBkYXRlKHNrLCBldiwgJmNhLT5wcmlvcl9yY3Zfbnh0LCAmY2EtPmNlX3N0YXRl
KTsNCiAJCWJyZWFrOw0KKwljYXNlIENBX0VWRU5UX0xPU1M6DQorCQlpZiAoZGN0Y3BfaGFsdmVf
Y3duZF9vbl9sb3NzKQ0KKwkJCWRjdGNwX3JlYWN0X3RvX2xvc3Moc2spOw0KKwkJYnJlYWs7DQog
CWRlZmF1bHQ6DQogCQkvKiBEb24ndCBjYXJlIGZvciB0aGUgcmVzdC4gKi8NCiAJCWJyZWFrOw0K
LS0gDQoyLjIxLjANCg0K
