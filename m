Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B4C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6272A218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KVmad87R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfDXMAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:00:30 -0400
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:22328
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbfDXMAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tjHX9UABZC9haacpiXSf/Xe3MV/UkxW8uGeLtYepvs=;
 b=KVmad87RKmozcePWH5hC5FKqRHEyDCXc0kwcMvIet2km3Z6TVCzIDDNJze/wPqSt9VMvta2avLfRSSjNahJkscZherMcplaMLkqlwC1sVl/9h9X9BjB7H/+sRVv1+VrCXRjWaMJGnK4OBOEBG5pPZi/1Ji4/dEBPyOA4Yy7rs5A=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6272.namprd05.prod.outlook.com (20.178.240.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.6; Wed, 24 Apr 2019 12:00:09 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::441b:ef64:e316:b294%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 12:00:09 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: [PATCH 0/9] Emulated coherent graphics memory v2
Thread-Topic: [PATCH 0/9] Emulated coherent graphics memory v2
Thread-Index: AQHU+pVDiLJKTxq64UuGZc+MbWxAxQ==
Date:   Wed, 24 Apr 2019 12:00:09 +0000
Message-ID: <20190424115918.3380-1-thellstrom@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0208.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::32) To MN2PR05MB6141.namprd05.prod.outlook.com
 (2603:10b6:208:c7::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51640f37-7020-476b-9af6-08d6c8ac6590
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6272;
x-ms-traffictypediagnostic: MN2PR05MB6272:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB6272EE74445CEDC8F7966BF0A13C0@MN2PR05MB6272.namprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(64756008)(66476007)(71200400001)(66446008)(86362001)(66556008)(305945005)(7416002)(14444005)(50226002)(478600001)(256004)(8936002)(81156014)(7736002)(81166006)(2906002)(66066001)(66946007)(71190400001)(8676002)(4326008)(25786009)(1076003)(66574012)(73956011)(186003)(26005)(6116002)(6512007)(486006)(6486002)(53936002)(110136005)(102836004)(6506007)(386003)(316002)(99286004)(54906003)(5660300002)(2616005)(68736007)(14454004)(36756003)(6436002)(476003)(3846002)(52116002)(97736004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6272;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fqOs6Bx0oggKtuzZdNU6iSCsMQOtmULhmKr4Q2GFU/YFKN1hZq9W+ypBKLCW6GmhzHsJ0NCjy7lX/bx0TF8SqDvkfQuAQ8DkgHT2uxYLKxSRNsJMG+nAnLHW2AnqjwsIYM30OdkTBueEp5ZCU1G2GAb9RgBdrT4uz3pZutwjfEEup2CsB7VVZxp8jxlbz53LXtJlzJS3m/pFc9YrUXa3HFDqdSE9PwObSTe8n+qXMEPOgZUFtHTDw5s/R2i541gZprtaw8i/XwCbwwUKKgjKokZ8zRoVVKggcC/XUuadoJBTKzH9A+w5UyESCvXTrbFxlXxR/TAQRgoOcHdlR6kfQ7fHcd0SCt6A+jRMs28pyW1q+yTLQhixfX/RmcPpX/lChWWcvO1iwe0kbtQWD2R5xKyGCA4A5PcdmBnervsT8KY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5BA895B05A624478528F08871895413@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51640f37-7020-476b-9af6-08d6c8ac6590
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:00:09.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JhcGhpY3MgQVBJcyBsaWtlIE9wZW5HTCA0LjQgYW5kIFZ1bGthbiByZXF1aXJlIHRoZSBncmFw
aGljcyBkcml2ZXINCnRvIHByb3ZpZGUgY29oZXJlbnQgZ3JhcGhpY3MgbWVtb3J5LCBtZWFuaW5n
IHRoYXQgdGhlIEdQVSBzZWVzIGFueQ0KY29udGVudCB3cml0dGVuIHRvIHRoZSBjb2hlcmVudCBt
ZW1vcnkgb24gdGhlIG5leHQgR1BVIG9wZXJhdGlvbiB0aGF0DQp0b3VjaGVzIHRoYXQgbWVtb3J5
LCBhbmQgdGhlIENQVSBzZWVzIGFueSBjb250ZW50IHdyaXR0ZW4gYnkgdGhlIEdQVQ0KdG8gdGhh
dCBtZW1vcnkgaW1tZWRpYXRlbHkgYWZ0ZXIgYW55IGZlbmNlIG9iamVjdCB0cmFpbGluZyB0aGUg
R1BVDQpvcGVyYXRpb24gaGFzIHNpZ25hbGVkLg0KDQpQYXJhdmlydHVhbCBkcml2ZXJzIHRoYXQg
b3RoZXJ3aXNlIHJlcXVpcmUgZXhwbGljaXQgc3luY2hyb25pemF0aW9uDQpuZWVkcyB0byBkbyB0
aGlzIGJ5IGhvb2tpbmcgdXAgZGlydHkgdHJhY2tpbmcgdG8gcGFnZWZhdWx0IGhhbmRsZXJzDQph
bmQgYnVmZmVyIG9iamVjdCB2YWxpZGF0aW9uLiBUaGlzIGlzIGEgZmlyc3QgYXR0ZW1wdCB0byBk
byB0aGF0IGZvcg0KdGhlIHZtd2dmeCBkcml2ZXIuDQoNClRoZSBtbSBwYXRjaGVzIGhhcyBiZWVu
IG91dCBmb3IgUkZDLiBJIHRoaW5rIEkgaGF2ZSBhZGRyZXNzZWQgYWxsIHRoZQ0KZmVlZGJhY2sg
SSBnb3QsIGV4Y2VwdCBhIHBvc3NpYmxlIHNvZnRkaXJ0eSBicmVha2FnZS4gQnV0IGFsdGhvdWdo
IHRoZQ0KZGlydHktdHJhY2tpbmcgYW5kIHNvZnRkaXJ0eSBtYXkgd3JpdGUtcHJvdGVjdCBQVEVz
IGJvdGggY2FyZSBhYm91dCwNCnRoYXQgc2hvdWxkbid0IHJlYWxseSBjYXVzZSBhbnkgb3BlcmF0
aW9uIGludGVyZmVyZW5jZS4gSW4gcGFydGljdWxhcg0Kc2luY2Ugd2UgdXNlIHRoZSBoYXJkd2Fy
ZSBkaXJ0eSBQVEUgYml0cyBhbmQgc29mdGRpcnR5IHVzZXMgb3RoZXIgUFRFIGJpdHMuDQoNCkZv
ciB0aGUgVFRNIGNoYW5nZXMgdGhleSBhcmUgaG9wZWZ1bGx5IGluIGxpbmUgd2l0aCB0aGUgbG9u
Zy10ZXJtDQpzdHJhdGVneSBvZiBtYWtpbmcgaGVscGVycyBvdXQgb2Ygd2hhdCdzIGxlZnQgb2Yg
VFRNLg0KDQpUaGUgY29kZSBoYXMgYmVlbiB0ZXN0ZWQgYW5kIGV4Y2VyY2lzZWQgYnkgYSB0YWls
b3JlZCB2ZXJzaW9uIG9mIG1lc2ENCndoZXJlIHdlIGRpc2FibGUgYWxsIGV4cGxpY2l0IHN5bmNo
cm9uaXphdGlvbiBhbmQgYXNzdW1lIGdyYXBoaWNzIG1lbW9yeQ0KaXMgY29oZXJlbnQuIFRoZSBw
ZXJmb3JtYW5jZSBsb3NzIHZhcmllcyBvZiBjb3Vyc2U7IGEgdHlwaWNhbCBudW1iZXIgaXMNCmFy
b3VuZCA1JS4NCg0KQW55IGZlZWRiYWNrIGdyZWF0bHkgYXBwcmVjaWF0ZWQuDQoNCkNoYW5nZXMg
djEtdjI6DQotIEFkZHJlc3NlZCBhIG51bWJlciBvZiB0eXBvcyBhbmQgZm9ybWF0dGluZyBpc3N1
ZXMuDQotIEFkZGVkIGEgdXNhZ2Ugd2FybmluZyBmb3IgYXBwbHlfdG9fcGZuX3JhbmdlKCkgYW5k
IGFwcGx5X3RvX3BhZ2VfcmFuZ2UoKQ0KLSBSZS1ldmFsdWF0ZWQgdGhlIGRlY2lzaW9uIHRvIHVz
ZSBhcHBseV90b19wZm5fcmFuZ2UoKSByYXRoZXIgdGhhbg0KICBtb2RpZnlpbmcgdGhlIHBhZ2V3
YWxrLmMuIEl0IHN0aWxsIGxvb2tzIGxpa2UgZ2VuZXJpY2FsbHkgaGFuZGxpbmcgdGhlDQogIHRy
YW5zcGFyZW50IGh1Z2UgcGFnZSBjYXNlcyByZXF1aXJlcyB0aGUgbW1hcF9zZW0gdG8gYmUgaGVs
ZCBhdCBsZWFzdA0KICBpbiByZWFkIG1vZGUsIHNvIHN0aWNraW5nIHdpdGggYXBwbHlfdG9fcGZu
X3JhbmdlKCkgZm9yIG5vdy4NCi0gVGhlIFRUTSBwYWdlLWZhdWx0IGhlbHBlciB2bWEgY29weSBh
cmd1bWVudCB3YXMgc2NyYXRjaGVkIGluIGZhdm91ciBvZg0KICBhIHBhZ2Vwcm90X3QgYXJndW1l
bnQuDQogIA0KQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpD
YzogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQpDYzogV2lsbCBEZWFjb24g
PHdpbGwuZGVhY29uQGFybS5jb20+DQpDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRl
YWQub3JnPg0KQ2M6IFJpayB2YW4gUmllbCA8cmllbEBzdXJyaWVsLmNvbT4NCkNjOiBNaW5jaGFu
IEtpbSA8bWluY2hhbkBrZXJuZWwub3JnPg0KQ2M6IE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2Uu
Y29tPg0KQ2M6IEh1YW5nIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPg0KQ2M6IFNvdXB0aWNr
IEpvYXJkZXIgPGpyZHIubGludXhAZ21haWwuY29tPg0KQ2M6ICJKw6lyw7RtZSBHbGlzc2UiIDxq
Z2xpc3NlQHJlZGhhdC5jb20+DQpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+DQpDYzogbGludXgtbW1Aa3ZhY2sub3JnDQo=
