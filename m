Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E1C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5733B222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qkwp6KSU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qkwp6KSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfIZJXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:23:44 -0400
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:44560
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726556AbfIZJXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37thVwE+S9rBO9lGoUGnIvDGOxLhXwTZEzmu7cwjd/s=;
 b=qkwp6KSUWilLcoYtLlzx13qEj6532Nhh79CGK22WnSDHAHS5+dH3Y9WT9GUg8NON0kA0+Ck/XAVbw64Sl9aX3j48YEW6jsRUZwLdixDnT9I1oDdaIk9CXZPEyywZIeOhSsXGzu4Xr0eB3XvtYQA4Da9mY1/wl+LkIM4FmeZ5CpQ=
Received: from VI1PR0801CA0074.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::18) by AM6PR08MB4101.eurprd08.prod.outlook.com
 (2603:10a6:20b:a1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21; Thu, 26 Sep
 2019 09:23:38 +0000
Received: from VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by VI1PR0801CA0074.outlook.office365.com
 (2603:10a6:800:7d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 09:23:38 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT033.mail.protection.outlook.com (10.152.18.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 26 Sep 2019 09:23:37 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Thu, 26 Sep 2019 09:23:25 +0000
X-CR-MTA-TID: 64aa7808
Received: from 95f1e2348941.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A92B0CA7-4085-4806-AFFC-806754B1FEC9.1;
        Thu, 26 Sep 2019 09:23:20 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 95f1e2348941.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 26 Sep 2019 09:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyL3yg/rlHtLgGs/W3NBV9BA+sjzNell/TpyPIJs2WVrweHkNUAOahg+LpYswNWd6zVDxm2Xe5h7LXi8VTUNbAE6Zkq+qi/dvHgXsnV/N5xc4iLlXzyOuX2mQIFiCGMZvg42GR0DurSyF/GYCd5N4YXTCROPBGAs6bWaWbh805oRmCiLqTDJXFYwwNtssejDE8X3rPxZ9EyR0ZpWbEHAGwfWQcF1y/PQlURgm6nKqdPWniYUqGTJ168PxGVQ06t5RMAvzeGHqcdgpOztBzGbTUdgzfpYKa0AXucrL+6P2YkM0R+uNXp0JD+wTu1nhIlrXd38FV2Tk+bdZATS/2lJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37thVwE+S9rBO9lGoUGnIvDGOxLhXwTZEzmu7cwjd/s=;
 b=GQIEph3SoXN7FKXftkdarzOGRPeShrjulSjH1USLkYHRsIWWcggj0oTskVlvd4sg95HGvpctJ6YIuerr3VRXQSbFo/uuB3ce72ykxGG0WnpaOPId66y+Iqvv4o+AuYX5YEBIhFFhXAy58TOTzVX+MMY1Q1ybkvsF4nBoEjSeotzummioRr3PWB6Or2JElVxNxw/aygWBwXXhCsO8nlRTuGPkxC3F2ooaAwB9hBkoS3BYbTtxK93W0e0JPTgSF8EZhptLW82WI/KCZFcAt0Ju7NX8zLRcmoX7PpkEQiaxE4045vRi3TKm0/wCHUdhexfemHUcL3kIQJHB4QRXF8tmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37thVwE+S9rBO9lGoUGnIvDGOxLhXwTZEzmu7cwjd/s=;
 b=qkwp6KSUWilLcoYtLlzx13qEj6532Nhh79CGK22WnSDHAHS5+dH3Y9WT9GUg8NON0kA0+Ck/XAVbw64Sl9aX3j48YEW6jsRUZwLdixDnT9I1oDdaIk9CXZPEyywZIeOhSsXGzu4Xr0eB3XvtYQA4Da9mY1/wl+LkIM4FmeZ5CpQ=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3675.eurprd08.prod.outlook.com (20.177.121.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Thu, 26 Sep 2019 09:23:19 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d%5]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 09:23:18 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH v9 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Topic: [PATCH v9 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Index: AQHVc01PrCSsT6adAk60P24ivSFqeKc8dyUAgAE5C+A=
Date:   Thu, 26 Sep 2019 09:23:18 +0000
Message-ID: <DB7PR08MB3082A688BDDD95F179EA388EF7860@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190925025922.176362-1-justin.he@arm.com>
 <20190925025922.176362-2-justin.he@arm.com>
 <20190925143820.GF7042@arrakis.emea.arm.com>
In-Reply-To: <20190925143820.GF7042@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 250c9ef5-f7db-4bd0-8e3e-87b15ffc4664.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: dda214ac-1f23-41e2-39c1-08d742633626
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB3675;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3675:|DB7PR08MB3675:|AM6PR08MB4101:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB410168BB9FBD509354A2C600F7860@AM6PR08MB4101.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:6108;
x-forefront-prvs: 0172F0EF77
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(13464003)(99286004)(52536014)(66446008)(6506007)(102836004)(305945005)(76116006)(55016002)(14454004)(186003)(26005)(33656002)(229853002)(7736002)(8936002)(8676002)(476003)(316002)(2906002)(53546011)(256004)(81166006)(74316002)(66066001)(55236004)(81156014)(478600001)(86362001)(7416002)(71200400001)(11346002)(6862004)(9686003)(446003)(4326008)(66946007)(966005)(6246003)(71190400001)(5660300002)(6116002)(3846002)(6636002)(6436002)(64756008)(7696005)(76176011)(25786009)(66476007)(66556008)(486006)(54906003)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3675;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: fJWFC/OPJJsInO8Yg4Xbw68MmO/d/KfLrlHPvjCqgLFQVMGiiNzGsm8hkdBs3z2yl2n+LnIsVybkHYKf2Fpb+uCQgfbNajE5koENq+1t5XaWYoN6HSu5pLX3+jR4A00wb5IU6GkEcxSpzx6MBJhqelIMjv13N7koUqJSNgt7Mpro2aT9q1fEjYHOY8RCC+Of8SWECqn5+NpQbWh9sIx4mgwBo38NRqv3sZ0nQtcqeDecVHn2c20Nxf9naIQZGzMeEKBWv4KtwRvMIIuulRiRsjFh7b4KbBr02cCpz5QsMdJfkF4i7PCQp/XmqoPpMocARDI10iGhYu82o2RIg5u6Y6jYPMxhd+nKfT2b71u7HD4lmpFd69qr43zGuCu4BCViqD5+eQR8wTB/xV7xB5pJASSisgPmvlO3WUYxGEgzJcdH2rA+mLerZWKHrnze6SzGbWrkof9uKJH6rCVbmLj5VA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3675
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT033.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(13464003)(189003)(199004)(26826003)(55016002)(70206006)(26005)(52536014)(5660300002)(446003)(53546011)(336012)(186003)(6306002)(63350400001)(478600001)(11346002)(3846002)(6116002)(6506007)(476003)(14454004)(74316002)(22756006)(966005)(126002)(486006)(2906002)(305945005)(102836004)(229853002)(436003)(6636002)(7736002)(9686003)(99286004)(81156014)(50466002)(36906005)(76130400001)(76176011)(66066001)(6862004)(47776003)(25786009)(356004)(316002)(81166006)(4326008)(6246003)(33656002)(54906003)(7696005)(8936002)(70586007)(2486003)(86362001)(8676002)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4101;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75a32ba4-e885-4ad2-37de-08d742632b30
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR08MB4101;
NoDisclaimer: True
X-Forefront-PRVS: 0172F0EF77
X-Microsoft-Antispam-Message-Info: lmOfKKBcNXaS70M1smDfz5aaYq63eyPDQZtg1CDzWWzhmtpaDNhPsOUF1IT6yrv6ZPoFBPVga4LjA2XgnOseETizbkBvwrchHipJtJLL7Obq9A3Ft8tAI2o3K4hsgUmeX44KpCTH6YCogxiiUNIHqETJmWWIqo3KklRmltfb87gHq/dJq+4b9sMnhagnMjlnzb7V2CX057vLUPmu3IaWOdvTc8+WsZeF8Vii630nP9xY6sfm4TBXtLmBJgJQme0fHUK30hE+F03rw022DKrANQgxp2oSRTMwC51Y+EBPD5y68NEKcBAPGTzDrcSaH4gj51LiQPNBJ12oR9jPcmVEzpPlGV7QtWPg2rnUNPCEssZYGDbTCNLUbbPvNMRYk9eCN1Xrdo2KU2Et+Vjzq+hH37Cml88I9GOdUgdWqKrW3cv6a2qIL9uAQUqR2GZyi1gzzP1iPk48a1ll2sgh0xNOGw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 09:23:37.2884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda214ac-1f23-41e2-39c1-08d742633626
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2F0YWxpbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENhdGFs
aW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IFNlbnQ6IDIwMTnlubQ55pyI
MjXml6UgMjI6MzgNCj4gVG86IEp1c3RpbiBIZSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxKdXN0
aW4uSGVAYXJtLmNvbT4NCj4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBNYXJr
IFJ1dGxhbmQNCj4gPE1hcmsuUnV0bGFuZEBhcm0uY29tPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1v
cnNlQGFybS5jb20+OyBNYXJjDQo+IFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgTWF0dGhldyBX
aWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+OyBLaXJpbGwgQS4NCj4gU2h1dGVtb3YgPGtpcmls
bC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbW1A
a3ZhY2sub3JnOyBTdXp1a2kgUG91bG9zZSA8U3V6dWtpLlBvdWxvc2VAYXJtLmNvbT47IFB1bml0
DQo+IEFncmF3YWwgPHB1bml0YWdyYXdhbEBnbWFpbC5jb20+OyBBbnNodW1hbiBLaGFuZHVhbA0K
PiA8QW5zaHVtYW4uS2hhbmR1YWxAYXJtLmNvbT47IEFsZXggVmFuIEJydW50DQo+IDxhdmFuYnJ1
bnRAbnZpZGlhLmNvbT47IFJvYmluIE11cnBoeSA8Um9iaW4uTXVycGh5QGFybS5jb20+Ow0KPiBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEFuZHJldyBNb3J0b24gPGFrcG1A
bGludXgtDQo+IGZvdW5kYXRpb24ub3JnPjsgSsOpcsO0bWUgR2xpc3NlIDxqZ2xpc3NlQHJlZGhh
dC5jb20+OyBSYWxwaCBDYW1wYmVsbA0KPiA8cmNhbXBiZWxsQG52aWRpYS5jb20+OyBoZWppYW5l
dEBnbWFpbC5jb207IEthbHkgWGluIChBcm0gVGVjaG5vbG9neQ0KPiBDaGluYSkgPEthbHkuWGlu
QGFybS5jb20+OyBuZCA8bmRAYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSAxLzNd
IGFybTY0OiBjcHVmZWF0dXJlOiBpbnRyb2R1Y2UgaGVscGVyDQo+IGNwdV9oYXNfaHdfYWYoKQ0K
PiANCj4gT24gV2VkLCBTZXAgMjUsIDIwMTkgYXQgMTA6NTk6MjBBTSArMDgwMCwgSmlhIEhlIHdy
b3RlOg0KPiA+IFdlIHVuY29uZGl0aW9uYWxseSBzZXQgdGhlIEhXX0FGREJNIGNhcGFiaWxpdHkg
YW5kIG9ubHkgZW5hYmxlIGl0IG9uDQo+ID4gQ1BVcyB3aGljaCByZWFsbHkgaGF2ZSB0aGUgZmVh
dHVyZS4gQnV0IHNvbWV0aW1lcyB3ZSBuZWVkIHRvIGtub3cNCj4gPiB3aGV0aGVyIHRoaXMgY3B1
IGhhcyB0aGUgY2FwYWJpbGl0eSBvZiBIVyBBRi4gU28gZGVjb3VwbGUgQUYgZnJvbQ0KPiA+IERC
TSBieSBuZXcgaGVscGVyIGNwdV9oYXNfaHdfYWYoKS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBTdXp1a2kgUG91
bG9zZSA8U3V6dWtpLlBvdWxvc2VAYXJtLmNvbT4NCj4gPiBSZXBvcnRlZC1ieToga2J1aWxkIHRl
c3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IA0KPiBXaGljaCBidWcgZGlkIHRoZSBrYnVpbGQg
cm9ib3QgYWN0dWFsbHkgcmVwb3J0PyBJJ2QgZHJvcCB0aGlzIGxpbmUuDQo+IA0KVGhpcyBsaW5l
IGlzIGFkZGVkIGR1ZSB0byBbMV06DQoiSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQg
Zm9sbG93aW5nIHRhZw0KUmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwu
Y29tPiINCg0KWWVzLCBJIGtub3cgeW91ciBjb25jZXJuLCBpdCBpcyBhIGxpdHRsZSBiaXQgY29u
ZnVzaW5nLiBCdXQgSSBkb24ndCBrbm93DQpob3cgdG8gZGlzdGluZ3Vpc2ggdGhlIGNhc2UgYnR3
IGEpIG9yaWdpbmFsIGJ1ZyByZXBvcnQgYikgYnVnIHJlcG9ydA0Kb2YgbXkgcGF0Y2ggaW1wbGVt
ZW50YXRpb24/IFRoYW5rcyBmb3IgYW55IHN1Z2dlc3Rpb24uDQoNClsxXSBodHRwczovL3d3dy5s
a21sLm9yZy9sa21sLzIwMTkvOS8xOC85NDANCg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEg
SGUpDQoNCg0K
