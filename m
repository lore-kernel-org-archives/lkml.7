Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44639C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AC8216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X83p9wUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfD2UQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:16:15 -0400
Received: from mail-eopbgr740059.outbound.protection.outlook.com ([40.107.74.59]:8064
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbfD2UQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjlt7RzPUuqBckWwabpVXR9LkefqkI32/qBmJ3lvNZI=;
 b=X83p9wUO6le772fkSOaN8J/rdrkrAmtqkF3Ti2AvRc+ANmag3nmS9eSzOcHDT4+p1ajJUu2jDXNa9jKkE2K/GAsGN00bc0CY++8Q50jtILbUEo/RrxTHm5GsdgYakIb7QR72deYqnMUCRB8trzCPzr8sdhuXOUNWIWG2ScstVBY=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1578.namprd12.prod.outlook.com (10.172.39.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 20:16:07 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc%11]) with mapi id 15.20.1835.016; Mon, 29 Apr
 2019 20:16:07 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Topic: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
Thread-Index: AQHU6yS/AQVIYa78D0OsnFnDJRviWKYsd26AgAWzsICAAFczgIAAHL8AgAAHagCAG7QAgIAAaEKAgAT3uYA=
Date:   Mon, 29 Apr 2019 20:16:07 +0000
Message-ID: <1beb4b7b-a4c1-0f60-3aa8-640754e30137@amd.com>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
 <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
 <20190408190800.GL15689@zn.tnic>
 <b0ee2570-c9ba-2a7c-2a8b-0dfa46685e62@amd.com>
 <20190426162425.GI4608@zn.tnic>
In-Reply-To: <20190426162425.GI4608@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d238fae-94d9-47e7-de18-08d6ccdf833e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1578;
x-ms-traffictypediagnostic: DM5PR12MB1578:
x-microsoft-antispam-prvs: <DM5PR12MB1578D49DA5D0CFABFF1189F8FD390@DM5PR12MB1578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(446003)(11346002)(66066001)(2616005)(14454004)(72206003)(54906003)(478600001)(256004)(14444005)(4744005)(73956011)(66446008)(64756008)(66556008)(66476007)(476003)(66946007)(31686004)(52116002)(71200400001)(486006)(99286004)(71190400001)(8936002)(81166006)(97736004)(93886005)(6436002)(8676002)(81156014)(36756003)(3846002)(2906002)(229853002)(6916009)(6486002)(6116002)(76176011)(25786009)(305945005)(316002)(186003)(53546011)(6506007)(386003)(102836004)(7736002)(26005)(6246003)(53936002)(5660300002)(68736007)(31696002)(4326008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1578;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nn6KDu0g6lCNJzLp3H4jgVA8nL/vFZ43VBk3anMyuQWpoCkc32s9s65zETodfrysBUnXw+dU1mJFw94sA3NcFyaiHNhgWVe+zDLQbMs3MG31wxM3vfn8j67+FM5S7w/GN8hLacQHYBdhy+tVNeGgzYOXQKA5ElxEtyelWra7GLpHhDl3VOHr9R2M0InBLRrkr3fITVJjIFQJ1DMlS/gWLq2LR8BzHWciQyjeo0VugU2XQ/q9YRQufgYd3+rxHolPiOg7nvC5vNU7P6IcRViriMpufeGiimJQlUkyoYCaABIjs1h/4jl7u7sarN2rvm4cuOsfjB5BRPHXOSFOsQrx5wymOMMPl4kEjmygH0ahoJdVJsn1v4O9fm/Z7dNOL5eiNPxsQDt6PLHeIPxTFFOxL+z+W2/2mZtilCK8QinF8l4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <701D58980C9B4E45B3235FA7F410D1EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d238fae-94d9-47e7-de18-08d6ccdf833e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 20:16:07.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNi8xOSAxMToyNCBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBGcmksIEFw
ciAyNiwgMjAxOSBhdCAwMzoxMToxN1BNICswMDAwLCBHYXJ5IFIgSG9vayB3cm90ZToNCj4+IDIp
IFR1cm4gb2ZmIGluc3RydW1lbnRhdGlvbiBmb3IgbGliL2NtZGxpbmUuYy4gVGhlIHJpc2sgaXMg
dGhhdCBhbnkNCj4+ICAgICAgY2hhbmdlcyB0byBpdHMgY29kZSB3b3VsZCBub3QgZW5qb3kgdGhl
IGJlbmVmaXRzIG9mIEtBU0FOL2V0YyB0ZXN0aW5nDQo+PiAgICAgIChpZiBlbmFibGVkKS4NCj4g
DQo+IFdoYXQgaGFwcGVuZWQgdG8gVGhvbWFzJyBzdWdnZXN0aW9uIHRvIHR1cm4gb2ZmIGluc3Ry
dW1lbnRhdGlvbiBmb3INCj4gdGhvc2UgZmlsZXMgb25seSB3aGVuIENPTkZJR19BTURfTUVNX0VO
Q1JZUFQ9eT8NCj4gDQo+IFdoaWNoIGlzIGEgdmFyaWFudCBvZiAyKSBhYm92ZSB3aXRoIGlmZGVm
ZmVyeS4NCj4gDQoNCkFoLCB2ZXJ5IGdvb2QuIFRoYXQgb25lIGVzY2FwZWQgbXkgbGlzdC4NCg0K
WWVzLCBvcHRpb24gNCB3b3VsZCBiZSBhIGNvbWJpbmF0aW9uIG9mIHVzaW5nIGEgbG9jYWwgY29w
eSBvZiBzdHJuY21wKCkgDQphbmQgZGlzYWJsaW5nIGluc3RydW1lbnRhdGlvbiAoS0FTQU4sIEtD
T1YsIHdoYXRldmVyKSBmb3IgDQphcmNoL3g4Ni9saWIvY21kbGluZS5jIHdoZW4gU01FIGlzIGVu
YWJsZWQuDQoNCkkgaGF2ZSBhbnkvYWxsIG9mIHRoZXNlIHJlYWR5IHRvIHJlcG9zdCBhcyBhIHZl
cnNpb24gMiBvZmZlcmluZy4gV2hhdCANCnNheSB5b3U/DQoNCmdyaA0K
