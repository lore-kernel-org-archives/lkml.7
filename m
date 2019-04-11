Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A732FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670A920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xv4nQsrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDKUSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:18:04 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:50208
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfDKUSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s1k/6BOVdZQ46dVCwcXsLghM6pDzemKxDqWc9ZVmMU=;
 b=Xv4nQsrRy53h4Ml5KxpTm0pnrLMYQPMDnDJxOgfNg75IFtzo3k+q+Mjxu+wbFUtnvrKAZggQCXNYiU0V9wViwuuu9sTCyJeNgLiP+LPlSxBNGaWXDfBKrtl5mT4nKHevpmyUQsfjdwQsELixakxFcE0yE1uAsIv33OuicVKtrDY=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 11 Apr 2019 20:18:00 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Thu, 11 Apr 2019
 20:18:00 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v2 0/6] Handle MCA banks in a per_cpu way 
Thread-Topic: [PATCH v2 0/6] Handle MCA banks in a per_cpu way 
Thread-Index: AQHU8KOo3vD8GcKPEEaYFRA1ZoFEBQ==
Date:   Thu, 11 Apr 2019 20:18:00 +0000
Message-ID: <20190411201743.43195-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:805:a2::27) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b03698e5-cdbe-4b58-0235-08d6bebacb0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2688;
x-ms-traffictypediagnostic: SN6PR12MB2688:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB268851057790BC9653223747F82F0@SN6PR12MB2688.namprd12.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(51444003)(2616005)(966005)(256004)(14444005)(4326008)(4743002)(478600001)(66066001)(26005)(5660300002)(53936002)(3846002)(6506007)(72206003)(186003)(6116002)(2906002)(386003)(54906003)(2501003)(102836004)(6916009)(2351001)(97736004)(105586002)(99286004)(6436002)(8936002)(15650500001)(52116002)(50226002)(36756003)(14454004)(106356001)(68736007)(81156014)(81166006)(476003)(6486002)(7736002)(71200400001)(486006)(71190400001)(5640700003)(86362001)(6306002)(316002)(8676002)(1076003)(305945005)(6512007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8wlrTSQ81Vm+FOFlztBugNR4tJ7vrxd3mF7CKLEes6RY67fZpDYGktAaK4vQ6imp3YO+rNatPlja0mXZbpHo6RjT5ssCx0CCV1iLgAhdBO3cdjRcERQKm6JbR77vGfSwuSji4EJM1ENoL6AZbSL2LkWegnJOwb+FDGa7hWns7M97BJwDj2VD9067m1bmwtpujZ3Wy7TaCWtQ6D5psmHDoTCsBbmneWUO7zKdwE6EXQPZPrdTfhsRhg6jJqHzaYybp0a+bM712EWtIQFbLae2hqgbq8JnZ0EA0Jb5MgvoBEN/Qf+fGRhelJLNPUZJtrQxDQqHIzL29E44n0J8rrJmlx+lwPtrxz3xWlyGYNuJMwY35WLMDbzqqUglt2vKJ9LALnpxoVnauGl73XeNAQpo2uWnUaEE0GOtLW2wjJiELvM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03698e5-cdbe-4b58-0235-08d6bebacb0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 20:18:00.2582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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
DQoNClBhdGNoIDY6DQpQcmV2ZW50cyBzeXNmcyBhY2Nlc3MgZm9yIE1DQSBiYW5rcyB0aGF0IGFy
ZSB1bmluaXRpYWxpemVkLg0KDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5
MDQwODE0MTIwNS4xMjM3Ni0xLVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0KDQpUaGFua3MsDQpZYXpl
bg0KDQoNCllhemVuIEdoYW5uYW0gKDYpOg0KICB4ODYvTUNFOiBNYWtlIHN0cnVjdCBtY2VfYmFu
a3NbXSBzdGF0aWMNCiAgeDg2L01DRTogSGFuZGxlIE1DQSBjb250cm9scyBpbiBhIHBlcl9jcHUg
d2F5DQogIHg4Ni9NQ0UvQU1EOiBEb24ndCBjYWNoZSBibG9jayBhZGRyZXNzZXMgb24gU01DQSBz
eXN0ZW1zDQogIHg4Ni9NQ0U6IE1ha2UgbnVtYmVyIG9mIE1DQSBiYW5rcyBwZXJfY3B1DQogIHg4
Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0aGF0IGdldCBzZXQgaW4gaGFyZHdhcmUNCiAg
eDg2L01DRTogVHJlYXQgTUNFIGJhbmsgYXMgaW5pdGlhbGl6ZWQgaWYgY29udHJvbCBiaXRzIHNl
dCBpbiBoYXJkd2FyZQ0KDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvYW1kLmMgICAgICB8ICA4
NyArKysrKysrKystLS0tLS0tLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyAgICAg
fCAxNDYgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCiBhcmNoL3g4Ni9rZXJuZWwvY3B1
L21jZS9pbnRlcm5hbC5oIHwgIDEyICstLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTQ0IGluc2VydGlv
bnMoKyksIDEwMSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
