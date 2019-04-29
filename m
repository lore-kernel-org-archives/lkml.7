Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DB7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68DE2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rqGugQQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfD2VWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:22:51 -0400
Received: from mail-eopbgr690082.outbound.protection.outlook.com ([40.107.69.82]:13902
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbfD2VWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdV/XHf5mSFFymxalxto1oQDxLRBpY2qvpbOJkyRZV8=;
 b=rqGugQQSbj596ERDiPLZf/PA0QoCjpzvx/sNVLZgyQ4T+1uKNluc/mz+IZ5bLhKIEMwTOdL+R1beQLJvbHBgemISh06mGKrVfSrLFLkhrFPfQ1HBU4szBcTWfgylVkUfwN/1yCQoLOCSVjc2QSyNuS4Waa/6Sy5EDMI1UuGTG/c=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1785.namprd12.prod.outlook.com (10.175.87.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 21:22:48 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc%11]) with mapi id 15.20.1835.016; Mon, 29 Apr
 2019 21:22:48 +0000
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
Thread-Index: AQHU6yS/AQVIYa78D0OsnFnDJRviWKYsd26AgAWzsICAAFczgIAAHL8AgAAHagCAG7QAgIAAaEKAgASj54CAAF3KAIAACKiA
Date:   Mon, 29 Apr 2019 21:22:48 +0000
Message-ID: <3bfae142-7d38-99c5-a086-5d2e79ec586d@amd.com>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
 <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
 <5dfcb133-0a0e-9e07-3774-313e30814e79@amd.com>
 <20190408165835.GJ15689@zn.tnic>
 <8a14050e-2516-5c0f-195d-611c6959b94b@amd.com>
 <20190408190800.GL15689@zn.tnic>
 <b0ee2570-c9ba-2a7c-2a8b-0dfa46685e62@amd.com>
 <20190426162425.GI4608@zn.tnic>
 <1beb4b7b-a4c1-0f60-3aa8-640754e30137@amd.com>
 <20190429205146.GF2324@zn.tnic>
In-Reply-To: <20190429205146.GF2324@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:805:16::45) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e262cf14-2a59-42a6-5c53-08d6cce8d40d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1785;
x-ms-traffictypediagnostic: DM5PR12MB1785:
x-microsoft-antispam-prvs: <DM5PR12MB1785AA727F4193AF6DE580F3FD390@DM5PR12MB1785.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(7736002)(53936002)(305945005)(53546011)(97736004)(11346002)(14454004)(6506007)(66066001)(6246003)(8676002)(25786009)(386003)(72206003)(186003)(81166006)(81156014)(102836004)(99286004)(6436002)(8936002)(229853002)(26005)(52116002)(68736007)(6486002)(36756003)(6916009)(31686004)(4326008)(2616005)(446003)(76176011)(3846002)(6116002)(486006)(6512007)(478600001)(5660300002)(2906002)(4744005)(66446008)(64756008)(256004)(476003)(54906003)(71190400001)(66556008)(71200400001)(66476007)(31696002)(93886005)(66946007)(73956011)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1785;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: INKd+Wp6Fy9imXsqaN1tSOepM6DHtahEZCMj/PNtK88qqPYA9PwT1mdQ/Db2WtZ0GB0KwlfqoxpNrSz+mYpl8hWc87SCGizpZfPrBO+6u5AspFKPXuMSS2X9oMPaSLBFhd3WM1dolh6ge9mq9fF3Dfkp76GBpPjk5AZi7VSoH/AOalCZyWSn5V8d9/jvOxgcyrrvmIBhLQ2XfytutBi8ZsP/1WzMBlAQESpO61v6NQ5xYOyr7nBphtqA1WxIFWLk12r2258N191b/fwKKepdfxWxNZQTzG3/PqrinYt6VxUho2Hghlz/+7oLv+GLqyFrXLg8BxIIbct2q6KTwEkURHuNKLZzW4ypn62pQ0Uiqlkfc3lmb1XmlU52g05+1TpOvp4C7v18qJ5wiKnRcDDLyc7tr0ch+wycIvBXfyiPn+o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85FEE9FB082C3E4F818749DF2863272A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e262cf14-2a59-42a6-5c53-08d6cce8d40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 21:22:48.4560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOS8xOSAzOjUxIFBNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IFtDQVVUSU9OOiBF
eHRlcm5hbCBFbWFpbF0NCj4gDQo+IE9uIE1vbiwgQXByIDI5LCAyMDE5IGF0IDA4OjE2OjA3UE0g
KzAwMDAsIEdhcnkgUiBIb29rIHdyb3RlOg0KPj4gWWVzLCBvcHRpb24gNCB3b3VsZCBiZSBhIGNv
bWJpbmF0aW9uIG9mIHVzaW5nIGEgbG9jYWwgY29weSBvZiBzdHJuY21wKCkNCj4gDQo+IFdoeSB0
aGUgbG9jYWwgY29weT8NCg0KU2VlbWVkIHN1aXRhYmxlLCBzaW5jZSBpdCdzIHRpbnkuIEJ1dCBJ
J20gbm90IG1hcnJpZWQgdG8gdGhlIGlkZWEuDQoNCj4gDQo+PiBhbmQgZGlzYWJsaW5nIGluc3Ry
dW1lbnRhdGlvbiAoS0FTQU4sIEtDT1YsIHdoYXRldmVyKSBmb3INCj4+IGFyY2gveDg2L2xpYi9j
bWRsaW5lLmMgd2hlbiBTTUUgaXMgZW5hYmxlZC4NCj4gDQo+IEkgdGhpbmsgdGhpcyBzaG91bGQg
c3VmZmljZS4gWW91IG9ubHkgZGlzYWJsZSBpbnN0cnVtZW50YXRpb24gd2hlbg0KPiBDT05GSUdf
QU1EX01FTV9FTkNSWVBUPXkgYW5kIG5vdCBkbyBhbnkgbG9jYWwgY29waWVzIGJ1dCB1c2UgdGhl
IGdlbmVyaWMNCj4gZnVuY3Rpb25zLg0KDQpPa2F5LCBzdXBlci4gIEknbGwgcG9zdCBhIHYyIHRo
YXQgZG9lcyB0aGF0Lg0KDQpEbyB3ZSB3YW50IHRvIGRvY3VtZW50IHRoZSBzdWJvcmRpbmF0ZSBm
dW5jdGlvbnMgaW4gdGhlaXIgcmVzcGVjdGl2ZSANCnNvdXJjZSBmaWxlcyBzbyB0aGF0IGEgZnV0
dXJlIGVkaXRvciB3b3VsZCAoaG9wZWZ1bGx5KSBiZSBtYWRlIGF3YXJlIG9mIA0KdGhpcyB1c2U/
DQoNCmdyaA0K
