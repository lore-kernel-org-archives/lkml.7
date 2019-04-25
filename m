Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C2DC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6114820652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 02:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hYmqS3Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbfDYCPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 22:15:54 -0400
Received: from mail-eopbgr800040.outbound.protection.outlook.com ([40.107.80.40]:15714
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388648AbfDYCPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 22:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz02FmCrzCCRb1GiImEKt5HL8poGfyuZSGG0jb0VOwM=;
 b=hYmqS3SgNXGKEIuPIN68hWPbzT4xrATMd0ApuawnlAGayX+zls6xhRuAsUhel3ngZuKMD47e4+CqnHBjAS7aEFekWm5ezSVsPKgb+WNNK9z0Uc26i4243EWh4RPeYkGYr6xkApoWq+WuSVjdjXozE7c6YnpQXrbO0v7731bsLN8=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3289.namprd12.prod.outlook.com (20.179.106.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 25 Apr 2019 02:15:49 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9183:846f:a93e:9a43]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::9183:846f:a93e:9a43%5]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 02:15:49 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     Steve Rutherford <srutherford@google.com>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 00/10] Add AMD SEV guest live migration support
Thread-Topic: [RFC PATCH v1 00/10] Add AMD SEV guest live migration support
Thread-Index: AQHU+rgpwai7tJB3uUaULXjJMShjVaZLrqMAgAAmZACAAC5kAIAAIMyA
Date:   Thu, 25 Apr 2019 02:15:49 +0000
Message-ID: <329c5293-4b29-8392-2124-13f3093eda19@amd.com>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
 <CABayD+eYsqT49-Smp0a9OGRt2or_L7LNKHpe-iraM62XzGq5_g@mail.gmail.com>
 <eee5e112-89bd-331b-6875-34c0712de4cb@amd.com>
 <CABayD+fy5+QNU8YWsVrfd6jyvPo3AWCBgR-V8iWKzZkWxQY=zA@mail.gmail.com>
In-Reply-To: <CABayD+fy5+QNU8YWsVrfd6jyvPo3AWCBgR-V8iWKzZkWxQY=zA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0024.prod.exchangelabs.com (2603:10b6:804:2::34)
 To DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [70.112.153.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a2c6d9d-3844-47bb-d17c-08d6c923ee9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3289;
x-ms-traffictypediagnostic: DM6PR12MB3289:
x-microsoft-antispam-prvs: <DM6PR12MB3289E2315EEB11F65BD8F70FE53D0@DM6PR12MB3289.namprd12.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(186003)(36756003)(8676002)(478600001)(102836004)(81166006)(81156014)(4326008)(14444005)(3846002)(6916009)(26005)(71190400001)(71200400001)(6116002)(256004)(31696002)(31686004)(99286004)(52116002)(76176011)(486006)(6506007)(386003)(6436002)(53546011)(68736007)(4744005)(8936002)(14454004)(97736004)(66946007)(305945005)(316002)(53936002)(6512007)(66066001)(66446008)(54906003)(6246003)(86362001)(7736002)(6486002)(66476007)(64756008)(66556008)(7416002)(2906002)(5660300002)(2616005)(93886005)(476003)(73956011)(25786009)(11346002)(446003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3289;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i3HOdmiKst/dRWbUfEbrx0FR7up9BAz+p8QccOuFCd06MPlTxRFH0krKCTFAzKpDZDYZF1uwFyg8bEXUA06c+y4WjgJw0/u2JllbY5v9UCfRdGGKBMSwEG+03ciYPQTcVzfRP5v8TTb4GinHwI4aQ8xKDq/8oIA79UCDqBWmZmQD5B1l1kKCUsKdlTUng63pvFyqq2tEFh+VbysNuF0iaOfOHTwCULW3qt66pZaks/hOJydmZtzQrz8hxd6qvzKq13aEPVD0F+sc9jt1WygWaWrbr8ihcv7x4yTG8bljN5l9zwEWALnntD0NqaZRAJoP6gYZ5Y3clpIcDR0UcNNT3lcIGjZTjCie2dfhRMpNdbzJSaFZZwOPiuuGHLkm5JKA3PgIeypLA6yp1rL27RmZplo4Z0wsXblG7ziu3DG9ZzU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED9CCEF63AB03A48A5711DE9DE877353@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2c6d9d-3844-47bb-d17c-08d6c923ee9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 02:15:49.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA0LzI0LzE5IDc6MTggUE0sIFN0ZXZlIFJ1dGhlcmZvcmQgd3JvdGU6DQo+IERvIHlvdSBt
ZWFuIE1pQi9zLCBNQi9zIG9yIE1iL3M/IFNpbmNlIHlvdSBhcmUgdGFsa2luZyBhYm91dCBuZXR3
b3JrDQo+IHNwZWVkcywgc29tZXRpbWVzIHRoZXNlIGdldCBjb25mbGF0ZWQuDQoNCkl0J3MgbWVn
YWJpdHMvc2VjLiBUaGUgUU1QIHF1ZXJ5LW1pZ3JhdGlvbiBjb21tYW5kIHNob3dzIHRoZSB0aHJv
dWdocHV0DQppbiBNYml0cy9zLiBJdCBpbmNsdWRlcyBQU1AgY29tbWFuZCBleGVjdXRpb24gYW5k
IHRoZSBuZXR3b3JrIHdyaXRlLg0KTW9zdCBvZiB0aGUgdGltZSBpcyBzcGVudCBpbiBQU1AgRlcu
IEkgaGF2ZSBub3QgcGVyZm9ybWVkIHJhdyBQU1ANCmNvbW1hbmQgYmVuY2htYXJrIHlldCBidXQg
SSBiZWxpZXZlIFNFViBGVyAwLjE3IG1heSByZXByb2R1Y2UgdXAgdG8NCjEyTWJpdHMvcy4gSSB3
aWxsIHVwZGF0ZSB0aHJlYWQgYWZ0ZXIgSSBmaW5pc2ggdGhlIGZ1cnRoZXIgcGVyZm9ybWFuY2UN
CmJyZWFrZG93bi4NCg0KLUJyaWplc2gNCg0K
