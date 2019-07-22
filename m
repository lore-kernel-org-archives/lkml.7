Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D97C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E6A217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="gyNnb8Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfGVTvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:51:48 -0400
Received: from mail-eopbgr700078.outbound.protection.outlook.com ([40.107.70.78]:54881
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728505AbfGVTvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCSoRZrYjL+/YUK132k6EXBUrhUe7PGo0tocfqVtSPtvw+Qk6Ks9lFXtwkjHfmVmU+L2aeqgMBH7QmI+Vzxs5WbWnmQPJvogk6uNI5r7EM9+JNPHOqAuBmR0vNj4f28hSAeeNw3HOtaVXkLwCU/0l8/Ow2WayM42Po//ZryCDpEFt7uizWqsL26oiov3zE6lm0gYud9XTfGIsBNoMFZTDnq1aBHlQlG2dwUHDrSUAobxAIKEg1MwA6wsPy5edsvyBODJCqa587IWR48hMPqbLXCPQ0SFE1mtW9vlJJR1TyRKlyXvoq3uEkjDpGHYy+RLn6/wnqV6RHNJqM90pCE/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9puGVnZbvFj1f6E2aQY9roiIV/BGcDdqJSYQuke9ek=;
 b=Zp99NfTCpW9ipRhKVSLi0B3almYUBr9qnBAXfNwvA53Oo5GmHwCfE/zDvHM4wnj+rHfOJYXIKNuI88LsyUsEZembq7Q2ed6sC3YsYj2Q0qF0JKJESyERI8Z11Eynb7dmEm5DNxg5v9I5Nty2LWkoQKiz5D45cJ6SJCTX+FkbXkDRBGoIdShKAZU714A00zDDSc3rxisVHOFuY0m5kTvUNqzgPVOfR6EtqErsnsFSbZzDZHawuT+CkDouCoFlvTr4v+D0eBk6emltbMsB3E++4671UH+Wrhe3xLT4xkgT4eI7e0dkC7150cfiQXtUO7pMdylPLLldJGQQYYUdC9gNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9puGVnZbvFj1f6E2aQY9roiIV/BGcDdqJSYQuke9ek=;
 b=gyNnb8Oe5lhHtZev5qUL15L7ElgGpXuFQ23TIeAE5slnPqQyUL1w68auVoI8TV/7VMdHrw3p0MNrF2qmgf11Bv2dRsRm4y8sytU1qcr8Y7OUqLyAgtydWnFWb81RbJpRdusXRbD/PTSEIZByvrHFsPl3I1f5hpsn57zGiDZivvM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6021.namprd05.prod.outlook.com (20.178.53.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.9; Mon, 22 Jul 2019 19:51:40 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e00b:cb41:8ed6:b718%2]) with mapi id 15.20.2115.005; Mon, 22 Jul 2019
 19:51:40 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Topic: [PATCH v3 3/9] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Thread-Index: AQHVPc0s+2522G+J006mLkslhMknOKbXENkAgAABTgA=
Date:   Mon, 22 Jul 2019 19:51:40 +0000
Message-ID: <4B53B286-C718-4ACF-B974-17D700F8D2E1@vmware.com>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-4-namit@vmware.com>
 <40f86e4b-8426-1a71-2ab5-4c5523dba247@rasmusvillemoes.dk>
In-Reply-To: <40f86e4b-8426-1a71-2ab5-4c5523dba247@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ec3d94c-3b10-47e5-b9cd-08d70ede03ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB6021;
x-ms-traffictypediagnostic: BYAPR05MB6021:
x-microsoft-antispam-prvs: <BYAPR05MB6021852D96292A8E6CBF08AED0C40@BYAPR05MB6021.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(66446008)(8936002)(486006)(11346002)(6916009)(76176011)(2906002)(2616005)(476003)(81166006)(81156014)(33656002)(6486002)(99286004)(446003)(4744005)(6436002)(6506007)(14454004)(229853002)(66066001)(53546011)(71200400001)(71190400001)(26005)(102836004)(186003)(4326008)(5660300002)(7416002)(53936002)(36756003)(86362001)(54906003)(3846002)(8676002)(6512007)(316002)(6116002)(68736007)(76116006)(66946007)(7736002)(25786009)(66476007)(6246003)(305945005)(66556008)(478600001)(14444005)(256004)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6021;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IQULxV4iULVL9wX0bcQGhYWY2oTMnWj9ZfOUE/iQzj+UrhCvddzQyVPfZkoe5LXY77DJ2vyZgJuFBzkoVLIC9LhpEHXPgTp0qjjfMcmHqaBg9J7tNCKZg427qCkmPduGhLxDkQZfNfd67mOCzJf6RHlDP7DT3MtgMT9TZOh3Rg/MKfncQHbODY0LPLMaslkuT0XemM5x7Y8oPYIuUBrTbI1KfmJVV9c/4aBnbJnUPRrHTggICnUgNkqJ5JNVTCvO/7iMf/2xLb4e3PSFIU4NjsY1xaZV2kC6QbHcij1moFK1k1Mnid0jCV2CTiA3W6BebA28oqsuyP77ZVb1+BEH2yD628w21V6CjDfYhJ8KMW0dCCsUF/qexdAj23uG+pThnz6Te0I8j9UnbVk/6lowJkXf1JvFpwz85r5ekHNvE1Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FD006B09E679D43839307D6B2A3E00B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec3d94c-3b10-47e5-b9cd-08d70ede03ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 19:51:40.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: namit@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjIsIDIwMTksIGF0IDEyOjQ3IFBNLCBSYXNtdXMgVmlsbGVtb2VzIDxsaW51eEBy
YXNtdXN2aWxsZW1vZXMuZGs+IHdyb3RlOg0KPiANCj4gT24gMTkvMDcvMjAxOSAwMi41OCwgTmFk
YXYgQW1pdCB3cm90ZToNCj4gDQo+PiAvKg0KPj4gQEAgLTg2NSw3ICs4OTMsNyBAQCB2b2lkIGFy
Y2hfdGxiYmF0Y2hfZmx1c2goc3RydWN0IGFyY2hfdGxiZmx1c2hfdW5tYXBfYmF0Y2ggKmJhdGNo
KQ0KPj4gCWlmIChjcHVtYXNrX3Rlc3RfY3B1KGNwdSwgJmJhdGNoLT5jcHVtYXNrKSkgew0KPj4g
CQlsb2NrZGVwX2Fzc2VydF9pcnFzX2VuYWJsZWQoKTsNCj4+IAkJbG9jYWxfaXJxX2Rpc2FibGUo
KTsNCj4+IC0JCWZsdXNoX3RsYl9mdW5jX2xvY2FsKCZmdWxsX2ZsdXNoX3RsYl9pbmZvKTsNCj4+
ICsJCWZsdXNoX3RsYl9mdW5jX2xvY2FsKCh2b2lkICopJmZ1bGxfZmx1c2hfdGxiX2luZm8pOw0K
Pj4gCQlsb2NhbF9pcnFfZW5hYmxlKCk7DQo+PiAJfQ0KPiANCj4gSSB0aGluayB0aGUgY29uZnVz
aW9uIGNvdWxkIGJlIGNsZWFyZWQgdXAgaWYgeW91IG1vdmVkIHRoaXMgaHVuayB0bw0KPiBwYXRj
aCAyIHdoZXJlIGl0IGJlbG9uZ3MgLSBpLmUuIHdoZXJlIHlvdSBjaGFuZ2UgdGhlIHByb3RvdHlw
ZSBvZg0KPiBmbHVzaF90bGJfZnVuY19sb2NhbCgpIGFuZCBoZW5jZSBpbnRyb2R1Y2UgdGhlIHdh
cm5pbmcuDQoNClllcywgdGhlcmUgaXMgYSBzbWFsbCBtZXNzIGhlcmUgLSB0aGUgY29uc3RpZmlj
YXRpb24gc2hvdWxkIGFjdHVhbGx5IGdvDQp0byBhIGRpZmZlcmVudCBwYXRjaOKApiBJ4oCZbGwg
Zml4IGl0Lg==
