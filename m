Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDCBC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CEF21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oVj5iY6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfDHOMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:12:49 -0400
Received: from mail-eopbgr820047.outbound.protection.outlook.com ([40.107.82.47]:49695
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfDHOMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvkEVfrnTBBRrMeK8iTmuhpGdkqkJRK5MKrLlOAyBNQ=;
 b=oVj5iY6T64XgAZy45JOw5Oc4ngg4nvCyl9wMc5LBxkz0PWeuiMHDaxDK3XTaSJtI/OpYYwvI9CoATcSWKgZTG3IVWs9ww1GHEre/ujusEIZHrqVf9UgqtqraRijnAl2lx08KC16vsd6hQltX3G145L0gOPgDtYvvy7VUck99Q/8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2781.namprd12.prod.outlook.com (52.135.107.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 14:12:15 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 14:12:15 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH RESEND 0/5]  Handle MCA banks in a per_cpu way
Thread-Topic: [PATCH RESEND 0/5]  Handle MCA banks in a per_cpu way
Thread-Index: AQHU7hURS9iA2sGXSkWDm4WK34P/UA==
Date:   Mon, 8 Apr 2019 14:12:15 +0000
Message-ID: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0025.prod.exchangelabs.com (2603:10b6:804:2::35)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c61a07de-2c61-4d87-5275-08d6bc2c33a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2781;
x-ms-traffictypediagnostic: SN6PR12MB2781:
x-microsoft-antispam-prvs: <SN6PR12MB2781B9ED9E9AFD96F23CBFC9F82C0@SN6PR12MB2781.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(51444003)(52116002)(25786009)(478600001)(4326008)(6512007)(2501003)(5640700003)(14454004)(53936002)(97736004)(71200400001)(71190400001)(256004)(50226002)(6486002)(72206003)(6436002)(8936002)(106356001)(105586002)(2351001)(81166006)(1076003)(186003)(81156014)(6916009)(8676002)(6506007)(102836004)(15650500001)(66066001)(5660300002)(386003)(486006)(26005)(68736007)(36756003)(2616005)(7736002)(3846002)(6116002)(316002)(305945005)(99286004)(86362001)(476003)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2781;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qXuxdzc5SWqWtdhSsiipEpYK0bheaQJChxMRjP6UWFeusMWZhltZgzb0xj3MSQPNH+DBTac7GxXc+xRxDBrDKF/gNaB/hvZKQLNJYaDorPDD4TGu95u0nDBdg5pVk8MnlHSV9bwqSyied8+xAb+fweIrB9JXk3TXlnvyCXCCHCigftUf1a1ZJE+6kDQpqXh/dGoVB5SGGcF367Hmgn0hKkDPTPZaLBehpwr6RLQHyC+iQW8oEG0InSrDdpP83BkMRs3/EPSs0r8Bn+CsUuBoBab1f5fjGvP+36Ghmp4CeWT0hjGqeYZw1ajmORwH8ijon2+GJigo4efhR+0KnL3X/bJOFFO06g0Howb85kB4hpp60WHwLIHXICTWK5IZKKNP91dli7mh9+McCwv3oOpkfUVJLR95q1aHcl78qg5WPKc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61a07de-2c61-4d87-5275-08d6bc2c33a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:12:15.3429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgZm9jdXMg
b2YgdGhpcyBwYXRjaHNldCBpcyBkZWZpbmUgYW5kIHVzZSB0aGUgTUNBIGJhbmsgc3RydWN0dXJl
cw0KYW5kIGJhbmsgY291bnQgcGVyIGxvZ2ljYWwgQ1BVLg0KDQpXaXRoIHRoZSBleGNlcHRpb24g
b2YgcGF0Y2ggNCwgdGhpcyBzZXQgYXBwbGllcyB0byBzeXN0ZW1zIGluIHByb2R1Y3Rpb24NCnRv
ZGF5Lg0KDQpQYXRjaCAxOg0KTW92ZXMgdGhlIGRlY2xhcmF0aW9uIG9mIHN0cnVjdCBtY2VfYmFu
a3NbXSB0byB0aGUgb25seSBmaWxlIGl0J3MgdXNlZC4NCg0KUGF0Y2ggMjoNClNwbGl0cyBzdHJ1
Y3QgbWNlX2JhbmsgaW50byBhIHN0cnVjdHVyZSBmb3IgZmllbGRzIGNvbW1vbiB0byBNQ0EgYmFu
a3MNCm9uIGFsbCBDUFVzIGFuZCBhbm90aGVyIHN0cnVjdHVyZSB0aGF0IGNhbiBiZSB1c2VkIHBl
cl9jcHUuDQoNClBhdGNoIDM6DQpCcmluZ3MgZnVsbCBjaXJjbGUgdGhlIHNhZ2Egb2YgdGhlIHRo
cmVzaG9sZCBibG9jayBhZGRyZXNzZXMgb24gU01DQQ0Kc3lzdGVtcy4gQWZ0ZXIgdGFraW5nIGEg
c3RlcCBiYWNrIGFuZCByZXZpZXdpbmcgdGhlIEFNRCBkb2N1bWVudGF0aW9uLCBJDQp0aGluayB0
aGF0IHRoaXMgaW1wbGltZW50YXRpb24gaXMgdGhlIHNpbXBsZXN0IGFuZCBtb3JlIHJvYnVzdCB3
YXkgdG8NCmZvbGxvdyB0aGUgc3BlYy4NCg0KUGF0Y2ggNDoNClNhdmVzIGFuZCB1c2VzIHRoZSBN
Q0EgYmFuayBjb3VudCBhcyBhIHBlcl9jcHUgdmFyaWFibGUuIFRoaXMgaXMgdG8NCnN1cHBvcnQg
c3lzdGVtcyB0aGF0IGhhdmUgTUNBIGJhbmsgY291bnRzIHRoYXQgYXJlIGRpZmZlcmVudCBiZXR3
ZWVuDQpsb2dpY2FsIENQVXMuDQoNClBhdGNoIDU6DQpNYWtlcyBzdXJlIHRoYXQgc3lzZnMgcmVw
b3J0cyB0aGUgTUNBX0NUTCB2YWx1ZSBhcyBzZXQgaW4gaGFyZHdhcmUuIFRoaXMNCmlzIG5vdCBz
b21ldGhpbmcgcmVsYXRlZCB0byBtYWtpbmcgdGhpbmdzIHBlcl9jcHUgYnV0IHJhdGhlciBqdXN0
DQpzb21ldGhpbmcgSSBub3RpY2VkIHdoaWxlIHdvcmtpbmcgb24gdGhlIG90aGVyIHBhdGNoZXMu
DQoNClRoYW5rcywNCllhemVuDQoNCllhemVuIEdoYW5uYW0gKDUpOg0KICB4ODYvTUNFOiBNYWtl
IHN0cnVjdCBtY2VfYmFua3NbXSBzdGF0aWMNCiAgeDg2L01DRTogSGFuZGxlIE1DQSBjb250cm9s
cyBpbiBhIHBlcl9jcHUgd2F5DQogIHg4Ni9NQ0UvQU1EOiBEb24ndCBjYWNoZSBibG9jayBhZGRy
ZXNzZXMgb24gU01DQSBzeXN0ZW1zDQogIHg4Ni9NQ0U6IE1ha2UgbnVtYmVyIG9mIE1DQSBiYW5r
cyBwZXJfY3B1DQogIHg4Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0aGF0IGdldCBzZXQg
aW4gaGFyZHdhcmUNCg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jICAgICAgfCAgODcg
KysrKysrKysrLS0tLS0tLS0tDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jICAgICB8
IDEzOCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUv
bWNlL2luamVjdC5jICAgfCAgIDcgKy0NCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9pbnRlcm5h
bC5oIHwgIDEyICstLQ0KIDQgZmlsZXMgY2hhbmdlZCwgMTM3IGluc2VydGlvbnMoKyksIDEwNyBk
ZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
