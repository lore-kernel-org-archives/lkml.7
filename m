Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6077C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983C72087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2h6cQPiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfECP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:28:31 -0400
Received: from mail-eopbgr780040.outbound.protection.outlook.com ([40.107.78.40]:4116
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbfECP2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aMbIhfW92P1yv+ISnjdXynpGFBYwRr29Jb8cfAXpd4=;
 b=2h6cQPiMxgFPUr5gM2s1zjOvg6GjvuCSmVsbzMynMx5yrJlyacdOFR351GnHage4mVh440T7eKElzDecBT99wUStuoNPYCXFs2Q+yK6ph5o8n2Hf+y9p+CQdsxYIV0yTYzFfNHSbDGX4T8BG8KUxnznEbd3uAr6o1V7rjsAySfs=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2604.namprd12.prod.outlook.com (20.176.116.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Fri, 3 May 2019 15:28:28 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9183:846f:a93e:9a43]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1835.016; Fri, 3 May 2019
 15:28:28 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v3] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Thread-Topic: [PATCH v3] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Thread-Index: AQHU9TP/Qz9k1XJJdk64Ck9W/08KDaZAmmUAgBkE5YA=
Date:   Fri, 3 May 2019 15:28:27 +0000
Message-ID: <10184ec0-008c-f9a5-a043-0fe0ce211e4d@amd.com>
References: <20190417154102.22613-1-brijesh.singh@amd.com>
 <ae2c9081-f61c-a33a-67f0-2e05ef702e61@intel.com>
In-Reply-To: <ae2c9081-f61c-a33a-67f0-2e05ef702e61@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:805::48) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 077acaf4-d178-4820-3cb2-08d6cfdbfd78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2604;
x-ms-traffictypediagnostic: DM6PR12MB2604:
x-microsoft-antispam-prvs: <DM6PR12MB2604D3B52D4878177144B041E5350@DM6PR12MB2604.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(52314003)(476003)(2616005)(4744005)(53936002)(31686004)(110136005)(54906003)(8936002)(81156014)(8676002)(99286004)(6436002)(186003)(446003)(11346002)(486006)(7736002)(53546011)(229853002)(7416002)(14454004)(26005)(386003)(6506007)(86362001)(102836004)(305945005)(5660300002)(6486002)(478600001)(31696002)(316002)(71200400001)(73956011)(81166006)(3846002)(2906002)(6116002)(256004)(66446008)(4326008)(6246003)(71190400001)(25786009)(68736007)(66066001)(64756008)(66556008)(66476007)(66946007)(2501003)(76176011)(36756003)(52116002)(6512007)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2604;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XijH3jCJ5UZBCueDXC6yCiwaO5wF53uf4WdACzRJlOwHQ4tAZadKHqkOeV/oieVw82RjMQs85d0wwEv2PzKTtZwrZ4/flDzqaWp2VBbXaZgR+CuM80Srv7um0+GZzSvZ1mO7TOa0qsqwnyOGZhbR5DBJTFk7sl+NU0BndFnJ6j13Y2A2Ypdu+X7EQSGgZKXSicZopbK+LB4a2x5M4VSDVQaioWVH4dVUIZC1MGOeYF448f1gEXVvwMCVjUbI+8rmnO+k7i/NK5j9bRlf8LIMjzkdbeDJkG1vV6zCpM2UUeq1PTkI4isaRbEFlFzlsPmsy9hFBNuGrMM6PIeXqcZMBQhShBlJ61BkVGPrX5hN754Un80xQz2IjEwyRKXf8P33xwcmD4f5MMZEV3JYYH0sI9ISIYn6FKW3xr1/i0BMR7M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C097527AF9971149883368BB96CC8326@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077acaf4-d178-4820-3cb2-08d6cfdbfd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 15:28:28.0229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCk9uIDQvMTcvMTkgMTI6MjQgUE0sIERhdmUgSGFuc2VuIHdyb3RlOg0KLi4u
DQoNCj4gDQo+IFRoZSBjb21tZW50IGhlcmUgaXMgbWlzc2luZyBvbmUga2V5IHBvaW50Og0KPiBr
ZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19pbml0KCkgY2FuIG9ubHkgYmUgdXNlZCB0byBwb3B1bGF0
ZSBub24tcHJlc2VudA0KPiBlbnRyaWVzLiAgSXQga2luZGEgaW5mZXJzIHRoYXQgZnJvbSAiQ3Jl
YXRlLi4uIiwgYnV0IEkgcmVhbGx5IHRoaW5rIHdlDQo+IG5lZWQgdG8gYmUgZXhwbGljaXQuDQo+
IA0KPiBBbnl3YXksIGl0J3MgYmV0dGVyIHRoYW4gaXQgd2FzLCBhbmQgaXQgZG9lcyBmaXggYSBi
dWcsIHNvOg0KPiANCj4gUmV2aWV3ZWQtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRl
bC5jb20+DQo+IA0KPiBCdXQgcGxlYXNlIGZsZXNoIG91dCB0aGF0IGNvbW1lbnQgaWYgeW91IGRv
IGFub3RoZXIgdmVyc2lvbiBmb3Igc29tZSByZWFzb24uDQo+IA0KDQpDYW4geW91IHBsZWFzZSBw
aWNrIHRoaXMgcGF0Y2g/IE9yIGRvIHlvdSB3YW50IG1lIHRvIHJlc2VuZCBpdCA/DQpJdCdzIGZp
eGluZyBhIGJ1ZyBzZWVuIGluIFNFViBndWVzdC4NCg0KLUJyaWplc2gNCg==
