Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D694AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A48217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AikgcJLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfCOOG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:06:56 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:9952
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728914AbfCOOG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvwGEw1dw9jmmMiFejFsjbIrwYf4JclzysSrku9NfYk=;
 b=AikgcJLanMva6Pr+7q5rCzc675VYsgkHBeSnfUSU2qUH0n/weOTCK1F51Jw4QBhyFE3AzTO6LnZ/qoiWTiaMKhcmfaUAxDTbNvHhrtCeBso0TOVKHZ22aTZMCVBydi95wCodd+hHKS8NmNj1U3aQxBCd9VYMwlQz9IyVti7Xm7E=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3545.namprd12.prod.outlook.com (20.179.106.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 14:06:52 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 14:06:52 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Topic: [RFC PATCH 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Thread-Index: AQHU2CpKo7pHNnmOoEW3d1kfA2KibqYMiVwAgAA29oA=
Date:   Fri, 15 Mar 2019 14:06:52 +0000
Message-ID: <41b30e9d-dcfe-ccae-8cd4-e88df8e4cb9c@amd.com>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292270.21417.18139649076000959940.stgit@tlendack-t1.amdoffice.net>
 <20190315105004.GW5996@hirez.programming.kicks-ass.net>
In-Reply-To: <20190315105004.GW5996@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0060.namprd02.prod.outlook.com
 (2603:10b6:803:20::22) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b3e8d9a-348a-41f6-bcdb-08d6a94f7910
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3545;
x-ms-traffictypediagnostic: DM6PR12MB3545:
x-microsoft-antispam-prvs: <DM6PR12MB3545AB912DAE2729B4DCD516EC440@DM6PR12MB3545.namprd12.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(366004)(346002)(51914003)(189003)(199004)(256004)(6506007)(53546011)(486006)(86362001)(316002)(305945005)(5660300002)(476003)(81156014)(66066001)(6436002)(81166006)(76176011)(102836004)(6116002)(36756003)(7416002)(229853002)(3846002)(6486002)(31696002)(52116002)(71200400001)(2906002)(71190400001)(72206003)(68736007)(186003)(26005)(105586002)(8676002)(6916009)(7736002)(14454004)(386003)(11346002)(478600001)(25786009)(2616005)(99286004)(446003)(54906003)(31686004)(8936002)(53936002)(106356001)(97736004)(6246003)(4326008)(6512007)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3545;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6XnYUA5cTiRnPnamgyYf+HCoFjpTVnukSUSCMwEwgViBrk2EGm8EM8BH99piwvJhKjip7BJgVhxeEm7X/bz7qMrMvAOFfoivckWwcaqp19RRrqHqoipmiHUeUXs6xrZkBIFmFIsfSD+r2qYoecmpEvWjUIp/Qs4ijtGmJI/OivCuOolLK24XNdIevRDYZpmbcotpPwOwiXwaL001A6uvrtZJBY6eXn7tAq3s4CyET8Y/RQ3cfnP3S5SFWCRgaeI5q6xvcMG6wUsRdWmTOUNTUJrzgZYfiRGRxm2DMy41K6ocxs+JI423hI9VcLrlbZfn8dFvd0jFApw/brjq/ksGaBg9eH8F5jqgNjri2aZI45F/yONydW/v4AbXizRRSuw4iL0RI1nLLMujygedYQYPXUgpePKC+jfDXaAsIxQl/7Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2563188D702994C97FA63FADAEC9CB8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3e8d9a-348a-41f6-bcdb-08d6a94f7910
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 14:06:52.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNS8xOSA1OjUwIEFNLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gTW9uLCBNYXIg
MTEsIDIwMTkgYXQgMDQ6NDg6NDRQTSArMDAwMCwgTGVuZGFja3ksIFRob21hcyB3cm90ZToNCj4+
IE9uIEFNRCBwcm9jZXNzb3JzLCB0aGUgZGV0ZWN0aW9uIG9mIGFuIG92ZXJmbG93ZWQgY291bnRl
ciBpbiB0aGUgTk1JDQo+PiBoYW5kbGVyIHJlbGllcyBvbiB0aGUgY3VycmVudCB2YWx1ZSBvZiB0
aGUgY291bnRlci4gU28sIGZvciBleGFtcGxlLCB0bw0KPj4gY2hlY2sgZm9yIG92ZXJmbG93IG9u
IGEgNDggYml0IGNvdW50ZXIsIGJpdCA0NyBpcyBjaGVja2VkIHRvIHNlZSBpZiBpdA0KPj4gaXMg
MSAobm90IG92ZXJmbG93ZWQpIG9yIDAgKG92ZXJmbG93ZWQpLg0KPj4NCj4+IFRoZXJlIGlzIGN1
cnJlbnRseSBhIHJhY2UgY29uZGl0aW9uIHByZXNlbnQgd2hlbiBkaXNhYmxpbmcgYW5kIHRoZW4N
Cj4+IHVwZGF0aW5nIHRoZSBQTUMuIEluY3JlYXNlZCBOTUkgbGF0ZW5jeSBpbiBuZXdlciBBTUQg
cHJvY2Vzc29ycyBtYWtlcyB0aGlzDQo+PiByYWNlIGNvbmRpdGlvbiBtb3JlIHByb25vdW5jZWQu
DQo+IA0KPiBJbmNyZWFzZWQgTk1JIGxhdGVuY3kgYWxzbyBtYWtlcyB0aGUgcmVzdWx0cyBsZXNz
IHVzZWZ1bCA6LyBXaGF0IGFtb3VudA0KPiBvZiBza2lkIGFyZSB3ZSB0YWxraW5nIGFib3V0LCBh
bmQgaXMgdGhlcmUgYW55dGhpbmcgQU1EIGlzIGdvaW5nIHRvIGRvDQo+IGFib3V0IHRoaXM/DQoN
CkkgaGF2ZW4ndCBsb29rZWQgaW50byB0aGUgYW1vdW50IG9mIHNraWQsIGJ1dCwgeWVzLCB0aGUg
aGFyZHdhcmUgdGVhbSBpcw0KbG9va2luZyBhdCB0aGlzLg0KDQo+IA0KPj4gSWYgdGhlIGNvdW50
ZXIgdmFsdWUgaGFzIG92ZXJmbG93ZWQsIGl0IGlzDQo+PiBwb3NzaWJsZSB0byB1cGRhdGUgdGhl
IFBNQyB2YWx1ZSBiZWZvcmUgdGhlIE5NSSBoYW5kbGVyIGNhbiBydW4uDQo+IA0KPiBBcmd1YWJs
eSB0aGUgV1JNU1Igc2hvdWxkIHN5bmMgYWdhaW5zdCB0aGUgUE1JLiBUaGF0IGlzIHRoZSBiZWFo
dmlvdXINCj4gb25lIHdvdWxkIGV4cGVjdC4NCj4gDQo+IElzbid0IHRoYXQgc29tZXRoaW5nIHlv
dSBjYW4gZml4IGluIHVjb2RlPyBBbmQgY291bGQgeW91IHZlcnkgcGxlYXNlDQo+IHRlbGwgdGhl
IGhhcmR3YXJlIHBlb3BsZSB0aGlzIGlzIGRpc2d1aXN0aW5nPw0KDQpDdXJyZW50bHksIHRoZXJl
J3Mgbm90aGluZyB0aGV5J3ZlIGZvdW5kIHRoYXQgY2FuIGJlIGRvbmUgaW4gdWNvZGUgZm9yDQp0
aGlzLiBCdXQsIHllcywgdGhleSBrbm93IGl0J3MgYSBwcm9ibGVtIGFuZCB0aGV5J3JlIGxvb2tp
bmcgYXQgd2hhdCB0aGV5DQpjYW4gZG8uDQoNCj4gDQo+PiBUaGUgdXBkYXRlZCBQTUMgdmFsdWUg
aXMgbm90IGFuIG92ZXJmbG93ZWQgdmFsdWUsIHNvIHdoZW4gdGhlIHBlcmYgTk1JDQo+PiBoYW5k
bGVyIGRvZXMgcnVuLCBpdCB3aWxsIG5vdCBmaW5kIGFuIG92ZXJmbG93ZWQgY291bnRlci4gVGhp
cyBtYXkNCj4+IGFwcGVhciBhcyBhbiB1bmtub3duIE5NSSByZXN1bHRpbmcgaW4gZWl0aGVyIGEg
cGFuaWMgb3IgYSBzZXJpZXMgb2YNCj4+IG1lc3NhZ2VzLCBkZXBlbmRpbmcgb24gaG93IHRoZSBr
ZXJuZWwgaXMgY29uZmlndXJlZC4NCj4+DQo+PiBUbyBlbGltaW5hdGUgdGhpcyByYWNlIGNvbmRp
dGlvbiwgdGhlIFBNQyB2YWx1ZSBtdXN0IGJlIGNoZWNrZWQgYWZ0ZXINCj4+IGRpc2FibGluZyB0
aGUgY291bnRlciBpbiB4ODZfcG11X2Rpc2FibGVfYWxsKCksIGFuZCwgaWYgb3ZlcmZsb3dlZCwg
bXVzdA0KPj4gd2FpdCBmb3IgdGhlIE5NSSBoYW5kbGVyIHRvIHJlc2V0IHRoZSB2YWx1ZSBiZWZv
cmUgY29udGludWluZy4gQWRkIGEgbmV3LA0KPj4gb3B0aW9uYWwsIGNhbGxhYmxlIGZ1bmN0aW9u
IHRoYXQgY2FuIGJlIHVzZWQgdG8gdGVzdCBmb3IgYW5kIHJlc29sdmUgdGhpcw0KPj4gY29uZGl0
aW9uLg0KPj4NCj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA0LjE0LngtDQo+PiBT
aWduZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KPiAN
Cj4+ICtzdGF0aWMgdm9pZCBhbWRfcG11X3dhaXRfb25fb3ZlcmZsb3coaW50IGlkeCwgdTY0IGNv
bmZpZykNCj4+ICt7DQo+PiArCXVuc2lnbmVkIGludCBpOw0KPj4gKwl1NjQgY291bnRlcjsNCj4+
ICsNCj4+ICsJLyoNCj4+ICsJICogV2Ugc2hvdWxkbid0IGJlIGNhbGxpbmcgdGhpcyBmcm9tIE5N
SSBjb250ZXh0LCBidXQgYWRkIGEgc2FmZWd1YXJkDQo+PiArCSAqIGhlcmUgdG8gcmV0dXJuLCBz
aW5jZSBpZiB3ZSdyZSBpbiBOTUkgY29udGV4dCB3ZSBjYW4ndCB3YWl0IGZvciBhbg0KPj4gKwkg
KiBOTUkgdG8gcmVzZXQgYW4gb3ZlcmZsb3dlZCBjb3VudGVyIHZhbHVlLg0KPj4gKwkgKi8NCj4+
ICsJaWYgKGluX25taSgpKQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBJ
ZiB0aGUgaW50ZXJydXB0IGlzbid0IGVuYWJsZWQgdGhlbiB3ZSB3b24ndCBnZXQgdGhlIE5NSSB0
aGF0IHdpbGwNCj4+ICsJICogcmVzZXQgdGhlIG92ZXJmbG93IGNvbmRpdGlvbiwgc28gcmV0dXJu
Lg0KPj4gKwkgKi8NCj4+ICsJaWYgKCEoY29uZmlnICYgQVJDSF9QRVJGTU9OX0VWRU5UU0VMX0lO
VCkpDQo+PiArCQlyZXR1cm47DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIFdhaXQgZm9yIHRoZSBj
b3VudGVyIHRvIGJlIHJlc2V0IGlmIGl0IGhhcyBvdmVyZmxvd2VkLiBUaGlzIGxvb3ANCj4+ICsJ
ICogc2hvdWxkIGV4aXQgdmVyeSwgdmVyeSBxdWlja2x5LCBidXQganVzdCBpbiBjYXNlLCBkb24n
dCB3YWl0DQo+PiArCSAqIGZvcmV2ZXIuLi4NCj4+ICsJICovDQo+PiArCWZvciAoaSA9IDA7IGkg
PCBPVkVSRkxPV19XQUlUX0NPVU5UOyBpKyspIHsNCj4+ICsJCXJkbXNybCh4ODZfcG11X2V2ZW50
X2FkZHIoaWR4KSwgY291bnRlcik7DQo+PiArCQlpZiAoY291bnRlciAmICgxVUxMIDw8ICh4ODZf
cG11LmNudHZhbF9iaXRzIC0gMSkpKQ0KPj4gKwkJCWJyZWFrOw0KPj4gKw0KPj4gKwkJLyogTWln
aHQgYmUgaW4gSVJRIGNvbnRleHQsIHNvIGNhbid0IHNsZWVwICovDQo+PiArCQl1ZGVsYXkoMSk7
DQo+PiArCX0NCj4+ICt9DQo+IA0KPiBBcmdoLi4gdGhhdCdzIGhvcnJpYmxlLCBhcyBJJ20gc3Vy
ZSB5b3UgZnVsbHkgYXBwcmVjaWF0ZSA6Lw0KDQpZZWFoLi4uDQoNCj4gDQo+PiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvZXZlbnRzL2NvcmUuYyBiL2FyY2gveDg2L2V2ZW50cy9jb3JlLmMNCj4+IGlu
ZGV4IGI2ODRmMDI5NGYzNS4uZjFkMmY3MDAwMGNkIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYv
ZXZlbnRzL2NvcmUuYw0KPj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL2NvcmUuYw0KPj4gQEAgLTYw
Niw2ICs2MDYsOSBAQCB2b2lkIHg4Nl9wbXVfZGlzYWJsZV9hbGwodm9pZCkNCj4+ICAgCQkJY29u
dGludWU7DQo+PiAgIAkJdmFsICY9IH5BUkNIX1BFUkZNT05fRVZFTlRTRUxfRU5BQkxFOw0KPj4g
ICAJCXdybXNybCh4ODZfcG11X2NvbmZpZ19hZGRyKGlkeCksIHZhbCk7DQo+PiArDQo+PiArCQlp
ZiAoeDg2X3BtdS53YWl0X29uX292ZXJmbG93KQ0KPj4gKwkJCXg4Nl9wbXUud2FpdF9vbl9vdmVy
ZmxvdyhpZHgsIHZhbCk7DQo+PiAgIAl9DQo+PiAgIH0NCj4gDQo+IE9uZSBhbHRlcm5hdGl2ZSBp
cyBhZGRpbmcgYW1kX3BtdV9kaXNhYmxlX2FsbCgpIHRvIGFtZC9jb3JlLmMgYW5kIHVzaW5nDQo+
IHRoYXQuIFRoZW4geW91IGNhbiBhbHNvIGNoYW5nZSB0aGUgbG9vcCB0byBkbyB0aGUgd2FpdCBh
ZnRlciBhbGwgdGhlDQo+IFdSTVNScywgaWYgdGhhdCBoZWxwcyB3aXRoIGxhdGVuY3kuDQoNCkkg
dGhvdWdodCBhYm91dCB0aGF0IGZvciBib3RoIHRoaXMgYW5kIHRoZSBuZXh0IHBhdGNoLiBCdXQg
c2luY2UgaXQgd291bGQNCmJlIGR1cGxpY2F0aW5nIGFsbCB0aGUgY29kZSBJIHdlbnQgd2l0aCB0
aGUgYWRkZWQgY2FsbGJhY2tzLiBJdCBtaWdodCBiZQ0Kd29ydGggaXQgZm9yIHRoaXMgcGF0Y2gg
dG8gaGF2ZSBhbiBBTUQgZGlzYWJsZV9hbGwgY2FsbGJhY2sgc2luY2UgaXQncw0Kbm90IGEgbG90
IG9mIGNvZGUgdG8gZHVwbGljYXRlIGNvbXBhcmVkIHRvIGhhbmRsZV9pcnEgYW5kIEkgbGlrZSB0
aGUgaWRlYQ0Kb2YgZG9pbmcgdGhlIG92ZXJmbG93IGNoZWNrIGFmdGVyIGFsbCB0aGUgV1JNU1Jz
Lg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcsIFBldGVyLg0KDQpUb20NCg0KPiANCg==
