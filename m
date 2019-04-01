Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0087CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B730B2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kvYbgz3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDAVqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:46:39 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:32768
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfDAVqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fia7FaaUcBN/cDtoTsiCUdGH+wpN7EPSnoNPDgfb5kI=;
 b=kvYbgz3VQM/VXur/uzjAXOn6qLjMQR7bJ3MrQxNe4KENF3MbkW6g/NTHOFXZxEUUZ65cfzFxnu/WGZuO4/1LKeon7SY4iWdCEJoUj7c5uGRCWWAgtoNXusiE1uYL36sa0ZFAUW934Uy8WDSPmubnCN8Ka4WF4VfkCYekls0lPMI=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2970.namprd12.prod.outlook.com (20.178.29.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Mon, 1 Apr 2019 21:46:33 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 21:46:33 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI latency
Thread-Topic: [RFC PATCH v3 0/3] x86/perf/amd: AMD PMC counters and NMI
 latency
Thread-Index: AQHU6NRfaGoIezVhSE2WaOPaqkz+lQ==
Date:   Mon, 1 Apr 2019 21:46:33 +0000
Message-ID: <155415519143.24457.2706922532995302758.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0078.namprd05.prod.outlook.com
 (2603:10b6:803:22::16) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f16cec99-1e0f-48d6-63f0-08d6b6eb81ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2970;
x-ms-traffictypediagnostic: DM6PR12MB2970:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB2970E7CBA1222DD59B838F6EEC550@DM6PR12MB2970.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(478694002)(4326008)(8676002)(71190400001)(66066001)(102836004)(53936002)(6116002)(6306002)(26005)(54906003)(103116003)(81166006)(86362001)(110136005)(25786009)(97736004)(81156014)(316002)(186003)(106356001)(105586002)(7736002)(99286004)(14444005)(486006)(7416002)(305945005)(8936002)(71200400001)(2906002)(256004)(6436002)(2501003)(14454004)(478600001)(52116002)(6506007)(386003)(72206003)(6512007)(966005)(5660300002)(3846002)(9686003)(68736007)(476003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2970;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YbdoT85AS28RYK6B+6YPucrgwQApnt9ZUuUbtzIEazvHQvRv+RMgH955nlO63nXQ7GQpqYlRj7CTLiA/AXDzUS05K1D4Fl0yIMkRCFmdtdYQLv7CTkULyNjeE3492cFdgLp4xWgsoUIPuImFR0fk55CLqWo4r3SIxHS6KDvWKG+F6io9e6KmcdG/8oG7OkoG8yQYPBoKDFOfJWTWCkveEpyzyBHu/eoTFwYz0q4eqdfdsSGSBOeUzbqeNOZowsWoWbB7+qUhS/cwi6oMIP1LxJPLX7ZlhX6cpp67E9KnxXyWFylcAsyjEmJgIxeInuUWMMSdbDOzEAQ/kL2QNe28PypbhfzK2QBPmeooLx6AEM7/DgtPkmstdA+DM1mQDHZzAXz7tOR88A3p98tu0vR/wAYdrwqDnGpRLg/FGftpwH8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1899F99A3C20CB40B4A3D4761EEC8DE3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16cec99-1e0f-48d6-63f0-08d6b6eb81ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 21:46:33.7244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2970
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcmVzc2VzIGlzc3VlcyB3aXRoIGluY3JlYXNlZCBOTUkgbGF0
ZW5jeSBpbiBuZXdlcg0KQU1EIHByb2Nlc3NvcnMgdGhhdCBjYW4gcmVzdWx0IGluIHVua25vd24g
Tk1JIG1lc3NhZ2VzIHdoZW4gUE1DIGNvdW50ZXJzDQphcmUgYWN0aXZlLg0KDQpUaGUgZm9sbG93
aW5nIGZpeGVzIGFyZSBpbmNsdWRlZCBpbiB0aGlzIHNlcmllczoNCg0KLSBSZXNvbHZlIGEgcmFj
ZSBjb25kaXRpb24gd2hlbiBkaXNhYmxpbmcgYW4gb3ZlcmZsb3dlZCBQTUMgY291bnRlciwNCiAg
c3BlY2lmaWNhbGx5IHdoZW4gdXBkYXRpbmcgdGhlIFBNQyBjb3VudGVyIHdpdGggYSBuZXcgdmFs
dWUuDQotIFJlc29sdmUgaGFuZGxpbmcgb2YgYWN0aXZlIFBNQyBjb3VudGVyIG92ZXJmbG93cyBp
biB0aGUgcGVyZiBOTUkNCiAgaGFuZGxlciBhbmQgd2hlbiB0byByZXBvcnQgdGhhdCB0aGUgTk1J
IGlzIG5vdCByZWxhdGVkIHRvIGEgUE1DLg0KLSBSZW1vdmUgZWFybGllciB3b3JrYXJvdW5kIGZv
ciBzcHVyaW91cyBOTUlzIGJ5IHJlLW9yZGVyaW5nIHRoZQ0KICBQTUMgc3RvcCBzZXF1ZW5jZSB0
byBkaXNhYmxlIHRoZSBQTUMgZmlyc3QgYW5kIHRoZW4gcmVtb3ZlIHRoZSBQTUMNCiAgYml0IGZy
b20gdGhlIGFjdGl2ZV9tYXNrIGJpdG1hcC4gQXMgcGFydCBvZiBkaXNhYmxpbmcgdGhlIFBNQywg
dGhlDQogIGNvZGUgd2lsbCB3YWl0IGZvciBhbiBvdmVyZmxvdyB0byBiZSByZXNldC4NCg0KVGhl
IGxhc3QgcGF0Y2ggcmUtd29ya3MgdGhlIG9yZGVyIG9mIHdoZW4gdGhlIFBNQyBpcyByZW1vdmVk
IGZyb20gdGhlDQphY3RpdmVfbWFzay4gVGhlcmUgd2FzIGEgY29tbWVudCBmcm9tIGEgbG9uZyB0
aW1lIGFnbyBhYm91dCBoYXZpbmcNCnRvIGNsZWFyIHRoZSBiaXQgaW4gYWN0aXZlX21hc2sgYmVm
b3JlIGRpc2FibGluZyB0aGUgY291bnRlciBiZWNhdXNlDQp0aGUgcGVyZiBOTUkgaGFuZGxlciBj
b3VsZCByZS1lbmFibGUgdGhlIFBNQyBhZ2Fpbi4gTG9va2luZyBhdCB0aGUNCmhhbmRsZXIgdG9k
YXksIEkgZG9uJ3Qgc2VlIHRoYXQgYXMgcG9zc2libGUsIGhlbmNlIHRoZSByZW9yZGVyaW5nLiBU
aGUNCnF1ZXN0aW9uIHdpbGwgYmUgd2hldGhlciB0aGUgSW50ZWwgUE1DIHN1cHBvcnQgd2lsbCBu
b3cgaGF2ZSBpc3N1ZXMuDQpUaGVyZSBpcyBzdGlsbCBzdXBwb3J0IGZvciB1c2luZyB4ODZfcG11
X2hhbmRsZV9pcnEoKSBpbiB0aGUgSW50ZWwNCmNvcmUuYyBmaWxlLiBEaWQgSW50ZWwgaGF2ZSBh
bnkgaXNzdWVzIHdpdGggc3B1cmlvdXMgTk1JcyBpbiB0aGUgcGFzdD8NClBldGVyIFosIGFueSB0
aG91Z2h0cyBvbiB0aGlzPw0KDQpBbHNvLCBJIGNvdWxkbid0IGNvbXBsZXRlbHkgZ2V0IHJpZCBv
ZiB0aGUgInJ1bm5pbmciIGJpdCBiZWNhdXNlIGl0DQppcyB1c2VkIGJ5IGFyY2gveDg2L2V2ZW50
cy9pbnRlbC9wNC5jLiBBbiBvbGQgY29tbWl0IGNvbW1lbnQgdGhhdA0Kc2VlbXMgdG8gaW5kaWNh
dGUgdGhlIHA0IGNvZGUgc3VmZmVyZWQgdGhlIHNwdXJpb3VzIGludGVycnVwdHM6DQowM2UyMjE5
OGQyMzcgKCJwZXJmLCB4ODY6IEhhbmRsZSBpbiBmbGlnaHQgTk1JcyBvbiBQNCBwbGF0Zm9ybSIp
Lg0KU28gbWF5YmUgdGhhdCBwYXJ0aWFsbHkgYW5zd2VycyBteSBwcmV2aW91cyBxdWVzdGlvbi4u
Lg0KDQotLS0NCg0KQ2hhbmdlcyBmcm9tIHYyIChiYXNlZCBvbiBmZWVkYmFjayBmcm9tIFBldGVy
IFopOg0KLSBTaW1wbGlmaWVkIEFNRCBzcGVjaWZpYyBkaXNhYmxlX2FsbCBjYWxsYmFjayBieSBj
YWxsaW5nIHRoZSBjb21tb24NCiAgeDg2X3BtdV9kaXNhYmxlX2FsbCgpIGZ1bmN0aW9uIGFuZCB0
aGVuIGNoZWNraW5nIGFuZCB3YWl0aW5nIGZvcg0KICByZXNldCBvZiBhbmQgb3ZlcmZsb3dlZCBQ
TUNzLg0KLSBSZW1vdmVkIGVycm9uZW91cyBjaGVjayBmb3Igbm8gYWN0aXZlIGNvdW50ZXJzIGlu
IHRoZSBOTUkgbGF0ZW5jeQ0KICBtaXRpZ2F0aW9uIHBhdGNoLCB3aGljaCBlZmZlY3RpdmVseSBu
dWxsaWZpZWQgY29tbWl0IDYzZTZiZTZkOThlMS4NCi0gUmV3b3JrZWQgeDg2X3BtdV9zdG9wKCkg
aW4gb3JkZXIgdG8gcmVtb3ZlIDYzZTZiZTZkOThlMS4NCg0KQ2hhbmdlcyBmcm9tIHYxIChiYXNl
ZCBvbiBmZWVkYmFjayBmcm9tIFBldGVyIFopOg0KLSBDcmVhdGVkIGFuIEFNRCBzcGVjaWZpYyBk
aXNhYmxlX2FsbCBjYWxsYmFjayBmdW5jdGlvbiB0byBoYW5kbGUgdGhlDQogIGRpc2FibGluZyBv
ZiB0aGUgY291bnRlcnMgYW5kIHJlc29sdmUgdGhlIHJhY2UgY29uZGl0aW9uDQotIENyZWF0ZWQg
YW4gQU1EIHNwZWNpZmljIGhhbmRsZV9pcnEgY2FsbGJhY2sgZnVuY3Rpb24gdGhhdCBpbnZva2Vz
IHRoZQ0KICBjb21tb24geDg2X3BtdV9oYW5kbGVfaXJxKCkgZnVuY3Rpb24gYW5kIHRoZW4gcGVy
Zm9ybXMgdGhlIE5NSSBsYXRlbmN5DQogIG1pdGlnYXRpb24uDQotIFRha2UgaW50byBhY2NvdW50
IHRoZSBwb3NzaWJpbGl0eSBvZiBub24tcGVyZiBOTUkgc291cmNlcyB3aGVuIGFwcGx5aW5nDQog
IHRoZSBtaXRpZ2F0aW9uLg0KDQpUaGlzIHBhdGNoIHNlcmllcyBpcyBiYXNlZCBvZmYgb2YgdGhl
IHBlcmYvY29yZSBicmFuY2ggb2YgdGlwOg0KICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90aXAvdGlwLmdpdCBwZXJmL2NvcmUNCg0KICBDb21taXQgYzk3
OGI5NDYwZmUxICgiTWVyZ2UgdGFnICdwZXJmLWNvcmUtZm9yLW1pbmdvLTUuMS0yMDE5MDIyNScg
b2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FjbWUvbGlu
dXggaW50byBwZXJmL2NvcmUiKQ0K
