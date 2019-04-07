Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A7FC282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9B220896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P4RXSex3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfDGXNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 19:13:51 -0400
Received: from mail-eopbgr720042.outbound.protection.outlook.com ([40.107.72.42]:47936
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfDGXNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 19:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvkEVfrnTBBRrMeK8iTmuhpGdkqkJRK5MKrLlOAyBNQ=;
 b=P4RXSex3ZK39pl3K1l0nOCHSRl+Gh2gdRV+Ob3tGIEfn+/kNoF/uR/9epd1WBSskP/7yknTMCaEymnn2TmJNbdZx7Os7CFdlIb9NgVszALHJYjHE/G/HmEgf8wdwRc6w+9oXa5meXFuMSj8ZfO+2UMOgqm12Nx3/BFsS0o3KwLo=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2768.namprd12.prod.outlook.com (52.135.107.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Sun, 7 Apr 2019 23:13:47 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Sun, 7 Apr 2019
 23:13:47 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 0/5] Handle MCA banks in a per_cpu way
Thread-Topic: [PATCH 0/5] Handle MCA banks in a per_cpu way
Thread-Index: AQHU7ZeNFWsrq+YeFEuEvgdR6vlTTQ==
Date:   Sun, 7 Apr 2019 23:13:47 +0000
Message-ID: <20190407231331.52362-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0039.namprd05.prod.outlook.com
 (2603:10b6:803:41::16) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e84ccff-b1d8-4fbc-91a5-08d6bbaeb03f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2768;
x-ms-traffictypediagnostic: SN6PR12MB2768:
x-microsoft-antispam-prvs: <SN6PR12MB276833A37AD688B6F091FD26F8530@SN6PR12MB2768.namprd12.prod.outlook.com>
x-forefront-prvs: 00003DBFE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(51444003)(105586002)(15650500001)(99286004)(14454004)(186003)(72206003)(478600001)(106356001)(53936002)(2351001)(3846002)(1076003)(6116002)(54906003)(316002)(102836004)(5660300002)(2906002)(68736007)(6512007)(50226002)(4326008)(36756003)(6506007)(386003)(66066001)(81166006)(97736004)(52116002)(6486002)(7736002)(476003)(26005)(486006)(2616005)(81156014)(5640700003)(6436002)(8676002)(6916009)(25786009)(86362001)(256004)(71200400001)(2501003)(8936002)(71190400001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2768;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bLhtDOaBLhsPHR26U2ZJzyda9HQPO5IwJnN0qjJihcoNWuqdHzsFHp3/SkMKi1Xrf07lnnGf0Z7YAN/kEhWgpgw9+TWrjPgsOfrrgoThDhXqR4U3AWqMA1ea4DEYIEIZra6rfkBBXRtH7FCk1uHoYJnWY7U0Vu7gUCWcQxQFMo1buMQDYMau5/dxeMsMJXfOPNpl5CEbuZZcmsPlJONDaBtQdw6FAmpzIZeyf7g2RydwLegaA/7pyfCZWQJBtiXZOp5sNAX8k36nc+anEBeqj+Dx/g6RSWumHHr3s1/L5xrqCQSdLMndnFMa+ubgsXRMPorg0Vz/JyaBAd5IHet08aw/iwq0KV6HK1QQhHr2vY39zf5dL7yM8kvMQBTkvYYforwKXELcDPc8PaCu6uc+fveTirs9K2hz5HvkcoYtNp4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e84ccff-b1d8-4fbc-91a5-08d6bbaeb03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2019 23:13:47.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
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
