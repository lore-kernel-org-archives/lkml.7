Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7AAC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F27206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XLK3v3Ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfFSSk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:40:59 -0400
Received: from mail-eopbgr800045.outbound.protection.outlook.com ([40.107.80.45]:20864
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfFSSk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kewHDYIRwD32zYeo43fq9HtXTj1ixZNJj2PUYwiYkPo=;
 b=XLK3v3MsIkALZoJuJXaTfEaGYNEZUhJJyUhVV2mJUDMDrtlBNQ/zi/rm2pzSXigrLrEwJ1URPF5lKbmgWljG8v5m8dleYitb6X6fKlrewIsaging8XXj/Jjyv5kGJ5bX0OzMPeMjOAB3kJgOgw2Wo7zIw40bEexv8NCc3sq2rF8=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3274.namprd12.prod.outlook.com (20.179.106.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 18:40:55 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::bcaf:86d4:677f:9555%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 18:40:55 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 0/2] x86: SME: Kexec/kdump memory loading fix
Thread-Topic: [PATCH v3 0/2] x86: SME: Kexec/kdump memory loading fix
Thread-Index: AQHVJs6HMv6S8YYMRUStXel/QAO2ZA==
Date:   Wed, 19 Jun 2019 18:40:55 +0000
Message-ID: <cover.1560969363.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: DM5PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:4:15::25) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fac0c566-b269-4199-cfde-08d6f4e5a908
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3274;
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-microsoft-antispam-prvs: <DM6PR12MB3274D9288137447D988B8AD3ECE50@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(189003)(199004)(66556008)(2906002)(53936002)(99286004)(3846002)(52116002)(6116002)(386003)(6506007)(2501003)(68736007)(66946007)(73956011)(66476007)(64756008)(81156014)(478600001)(8676002)(81166006)(72206003)(8936002)(86362001)(50226002)(66066001)(25786009)(4326008)(14454004)(6486002)(66446008)(6436002)(7736002)(36756003)(305945005)(102836004)(5660300002)(6512007)(256004)(476003)(486006)(2616005)(54906003)(110136005)(316002)(14444005)(186003)(71190400001)(71200400001)(26005)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3274;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0f1FjeUgs1Y0p7eNDKR1kClxmkXf3JZ+M3VedDhkM07ndtMxBf7vA+3ERrwKkvpKxw9wFrScfhYyNpSWpy8yl63AlE8kIR5mBhrs10gMTC+yjhwU9CV532/noBUBFOAbFaE8wvjEeGuoFNx3d2AALeHFxm5MbVh3wuOdNtPEZcPd8hbmuc6p2XfB7RNvtSHhIK4g3rL4OIvk9dqazLlvVKAE0RebrOfBJo4pbzPCpSnsI2WqCibDnZUGSytZCBfwBz4fPpkdTdfQPEyIJ8Tm1/NSjHY2UvHlhYXDDfIAL5muYhALt0JhWTZBkEZ97lO2FmWGQi0Uhn6rq2LvTX/DX/sB8FImT2qlPMDquQoxMz2bO54sbJneKAyjzp8gc584+7dJpeqtVAIpwXy5nXy3+oBD7HGTDVEgYp2Q6ycHhX8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac0c566-b269-4199-cfde-08d6f4e5a908
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 18:40:55.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcmVzc2VzIGFuIGlzc3VlIHJlbGF0ZWQgdG8ga2V4ZWMva2R1bXAgd2hl
biBTTUUgaXMgYWN0aXZlLg0KVGhlIFNNRSBzdXBwb3J0IHVzZXMgYSB3b3JrYXJlYSBsb2NhdGVk
IGFmdGVyIHRoZSBlbmQgb2YgdGhlIGtlcm5lbCB0bw0KcGVyZm9ybSAiaW4tcGxhY2UiIGVuY3J5
cHRpb24gb2YgdGhlIGtlcm5lbC4gV2hlbiBrZXhlYy9rZHVtcCBpcyB1c2VkLCBpdA0KaXMgcG9z
c2libGUgdGhhdCBzb21lIG90aGVyIGRhdGEgdXNlZCBieSBrZXhlYy9rZHVtcCBjb3VsZCBiZSBp
biB0aGlzIGFyZWENCm9mIG1lbW9yeSB3aGljaCB3b3VsZCBjYXVzZSB0aGUga2V4ZWMva2R1bXAg
b2YgdGhlIGtlcm5lbCB0byBmYWlsLg0KDQpDcmVhdGUgYSB3b3JrYXJlYSBzZWN0aW9uIGZvciB1
c2UgYnkgU01FIGluIHZtbGludXgubGRzLlMgdGhhdCBpcw0KcG9zaXRpb25lZCBhZnRlciAiX2Vu
ZCIsIHNvIHRoYXQgdGhlIG1lbW9yeSBpdCBvY2N1cGllcyB3aWxsIGJlIHJlY2xhaW1lZA0KYWZ0
ZXIgaXRzIHVzZSBkdXJpbmcgYm9vdC4gU2luY2UgaXQgaXMgcGFydCBvZiB0aGUga2VybmVsIGlt
YWdlLCB0aGVyZSBpcw0Kbm8gd29ycnkgbm93IHRoYXQga2V4ZWMva2R1bXAgd2lsbCBwbGFjZSBk
YXRhIGluIHRoZSBTTUUgd29ya2FyZWEgd2hlbg0KaW5zdGFsbGluZyB0aGUga2V4ZWMva2R1bXAg
a2VybmVsLiBBcyBwYXJ0IG9mIHRoaXMgZml4LCBjbGFyaWZ5IHdoYXQNCm9jY3VwaWVkIGtlcm5l
bCBtZW1vcnkgaXMgcmVzZXJ2ZWQgYW5kIHdoYXQgcGFydHMgb2YgdGhlIGtlcm5lbCBtZW1vcnkg
YXJlDQpkaXNjYXJkZWQuDQoNClRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBhcmUgaW5jbHVkZWQ6DQot
IElkZW50aWZ5IGFuZCBkb2N1bWVudCB3aGF0IHBhcnRzIG9mIHRoZSBrZXJuZWwgaW1hZ2UgYXJl
IHJlc2VydmVkDQogIChzYXZlZCkgYW5kIHdoYXQgaXMgZGlzY2FyZGVkLg0KLSBDcmVhdGUgYSBu
ZXcgc2VjdGlvbiB0aGF0IGxpdmVzIG91dHNpZGUgb2YgdGhlIGtlcm5lbCBwcm9wZXIsIHNvIHRo
YXQgaXQNCiAgd2lsbCBiZSByZWNsYWltZWQgYXMgYXZhaWxhYmxlIG1lbW9yeSBkdXJpbmcgYm9v
dCwgdGh1cyBhbGxvd2luZyBpdCB0bw0KICBiZSB1c2VkIGFzIGEgd29ya2FyZWEgYnkgU01FIGZv
ciBrZXJuZWwgaW4tcGxhY2UgZW5jcnlwdGlvbiBkdXJpbmcgZWFybHkNCiAgYm9vdC4uDQoNClRo
aXMgcGF0Y2ggc2VyaWVzIGlzIGJhc2VkIG9uIHRpcC9tYXN0ZXIuDQoNCi0tLQ0KDQpDaGFuZ2Vz
IGZyb20gdjI6DQotIEdyYW1tYXIgZml4ZXMNCi0gQSBtb3JlIGdlbmVyaWMgbmFtaW5nIG9mIHRo
ZSBzY3JhdGNoL3dvcmthcmVhIHNlY3Rpb24gdG8gaW5kaWNhdGUgaXQNCiAgaXMgbm90IHJlc3Ry
aWN0ZWQgdG8gU01FIHVzYWdlDQoNCkNoYW5nZXMgZnJvbSB2MToNCi0gQ2xhcmlmeSBob3cgYW5k
IHdoZXJlIHRoZSBrZXJuZWwgc2VjdGlvbnMvbWVtb3J5IGlzIHJlc2VydmVkLg0KLSBBZGQgYW4g
ZXhwbGljaXQgc3ltYm9sLCBfX2VuZF9vZl9rZXJuZWxfcmVzZXJ2ZSwgZm9yIHJlc2VydmluZyB0
aGUNCiAga2VybmVsIG1lbW9yeSByYXRoZXIgdGhhbiB1c2luZyBfX2Jzc19zdG9wLg0KDQoNClRv
bSBMZW5kYWNreSAoMik6DQogIHg4Ni9tbTogSWRlbnRpZnkgdGhlIGVuZCBvZiB0aGUga2VybmVs
IGFyZWEgdG8gYmUgcmVzZXJ2ZWQNCiAgeDg2L21tOiBDcmVhdGUgYSB3b3JrYXJlYSBpbiB0aGUg
a2VybmVsIGZvciBTTUUgZWFybHkgZW5jcnlwdGlvbg0KDQogYXJjaC94ODYvaW5jbHVkZS9hc20v
c2VjdGlvbnMuaCAgICB8ICAyICsrDQogYXJjaC94ODYva2VybmVsL3NldHVwLmMgICAgICAgICAg
ICB8ICA4ICsrKysrKy0NCiBhcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUyAgICAgIHwgMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogYXJjaC94ODYvbW0vbWVtX2VuY3J5cHRf
aWRlbnRpdHkuYyB8IDIyICsrKysrKysrKysrKysrKysrLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDYy
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xNy4xDQoNCg==
