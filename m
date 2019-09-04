Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBB5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE92206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="CGQiTRHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfIDHzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:55:14 -0400
Received: from mail-eopbgr820135.outbound.protection.outlook.com ([40.107.82.135]:7938
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729112AbfIDHzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+GG16NTby8fI5DNFiZXj7WF0/AW4JpeJaissrSlU6SXfrX0VviyD1xBaKxXx13L/UfhGjPuaL8fVWDzc0AtoBZVCNOHv82F15RPeVT1gJuFIYIdAhLGAO5dXVKqw3ftgaStGj/NXeYMN3KS74V2CHhh5QMKCSVGLa3zn6gPUtuTsrtkpQFDPvbtyrXhry8u858yIAf9v8mb4FsFU6YuV8dluDTyhtDCUWYIJSzKPahxdv5rdhwEpctSUNi+omnOe4QWX875iz1NAQhLC+PHY4Nw6M7sTZjD/y6pQ1a0ZDCUXiq46gHyEEzduyEWSviMG9Cs9RCuqDtFJMxJ+DYL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZlFnuweyubWiPbyxYo0coxqv9SyTPtTB0Qsimd2rk4=;
 b=FauuNlNABJRGH8QTmqem06jepOBhKfyL715jIJ4SIkkXCtRzeHpWd+nA9aPHzOJ+6zsO4wH8ZLC76kHK3FkqtzDz1vd3ZQh4LJwJvgWmlWfe/uNaC4iIrpLNa8yrjqbVP83qdv2Yx/My6E7+w8eXp0PrYF8GpCcTjxL681IuoL+M8CnDiSkJIet8XTWxDA/8PzlyXcuW4yuaSy75nl2/UXzcSCditywSP2mNFKu/kx2e/SUPJH7ZCM1H51Au6b1kUWvdiF9qh54E9g+LTRG3wi3TjnXptVdrWsgM3mf1CpfwChRhjttkPQsTH3+BcpNcT+W7ZwhcWg8/lVzQaFA5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 117.103.190.105) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZlFnuweyubWiPbyxYo0coxqv9SyTPtTB0Qsimd2rk4=;
 b=CGQiTRHASEN0j4yIcvuUqc4iIcCr48pMm3QAyvUNe27oUOSao8csD+qiVJHOwCqQcPWt5IoOrDwkJ0Da/E7kCcxeQ4UwscdFFDge7/2S9IzIxyiDLDRxRULuSYtzZAptzvgeUU8FSscPKCa0YcvmAeaL6tbV2gvHkonFimOXwsQ=
Received: from DM5PR1301CA0016.namprd13.prod.outlook.com (2603:10b6:4:2a::29)
 by MWHPR1301MB1967.namprd13.prod.outlook.com (2603:10b6:301:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.4; Wed, 4 Sep
 2019 07:55:11 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM5PR1301CA0016.outlook.office365.com
 (2603:10b6:4:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.12 via Frontend
 Transport; Wed, 4 Sep 2019 07:55:11 +0000
Authentication-Results: spf=pass (sender IP is 117.103.190.105)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=sony.com;
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.105 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.105; helo=ap.sony.com;
Received: from ap.sony.com (117.103.190.105) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Wed, 4 Sep 2019 07:55:10 +0000
Received: from APYOKXHT103.ap.sony.com (117.103.191.216) by
 APYOKXEG101.ap.sony.com (117.103.190.105) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 4 Sep 2019 07:54:58 +0000
Received: from APYOKXMS108.ap.sony.com ([169.254.3.47]) by
 APYOKXHT103.ap.sony.com ([117.103.191.216]) with mapi id 14.03.0468.000; Wed,
 4 Sep 2019 07:54:57 +0000
From:   <Jacky.Cao@sony.com>
To:     <balbi@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Kento.A.Kobayashi@sony.com>,
        <Jacky.Cao@sony.com>
Subject: RE: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Topic: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
Thread-Index: AdVi6+6KAylJ/738T4mObELVKFN3wAACPLWAAAAzp7A=
Date:   Wed, 4 Sep 2019 07:54:57 +0000
Message-ID: <16EA1F625E922C43B00B9D82250220500871C87B@APYOKXMS108.ap.sony.com>
References: <16EA1F625E922C43B00B9D82250220500871C7D7@APYOKXMS108.ap.sony.com>
 <CAH8TKc_XBksJHTue18O7jv7h0WjFSqQkJJ8Hc2aRNZaL3aRfVQ@mail.gmail.com>
In-Reply-To: <CAH8TKc_XBksJHTue18O7jv7h0WjFSqQkJJ8Hc2aRNZaL3aRfVQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [43.82.17.73]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.105;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(199004)(189003)(13464003)(50466002)(47776003)(6246003)(66066001)(3846002)(6116002)(8676002)(316002)(70206006)(70586007)(426003)(107886003)(2351001)(23676004)(11346002)(55016002)(8936002)(86362001)(2906002)(7636002)(7736002)(229853002)(6916009)(478600001)(126002)(33656002)(5660300002)(486006)(76176011)(26005)(55846006)(336012)(186003)(54906003)(2876002)(246002)(7696005)(4326008)(476003)(2486003)(106002)(37786003)(356004)(102836004)(14444005)(53546011)(446003)(436003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB1967;H:ap.sony.com;FPR:;SPF:Pass;LANG:en;PTR:APYOKXEG101.ap.sony.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d49199-c18c-4843-48d5-08d7310d3688
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:MWHPR1301MB1967;
X-MS-TrafficTypeDiagnostic: MWHPR1301MB1967:
X-Microsoft-Antispam-PRVS: <MWHPR1301MB1967598B2962B172C4CAF10487B80@MWHPR1301MB1967.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KuFerUSRe6AuuJnrwa3/JcetBkgJ91IS/LsKrZD3S2v/4hwwLbT1Mu/fRSYE8E7zK+VINOyooxu1F4MsvRTL5xdonbSt3XvLbqBrHgluhlYRoFX1sAMp6pib5Lb8ZsCc4/DqFSqjxzccLCtSiAjdWR8j/KaudTgQs+LuuKag74GpScHQal7wH8SdYwvlngpxORer8BsI0DTzST8fhcToNtuSImDYTOnRJJ8nR/0alAlfYT2tCo6Dd38VbhkMwF6fGh3Aecq2RTK7EU/61OW/qzs9WcJ1wG8IhW+GuayZSZTiN/SwB+ooSBL3fLNUowl8mnvl8hxuziLs8M/ixdIS4qIzqi4s3mWL1pHoAFBjBpgJgq96hGaKR+54zbh4rZNIjhXy0+nt575vzrF/zUC65folTakRN9SBZ0khKKytr0o=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 07:55:10.2301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d49199-c18c-4843-48d5-08d7310d3688
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.105];Helo=[ap.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB1967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KPllvdSBtdXN0IHNlbmQgcGxhaW4vdGV4dCBlbWFpbHMuIEknbSBub3QgcmVjZWl2aW5n
IHRoaXMgdmlhIHRoZSBtYWlsaW5nIGxpc3QuIFBsZWFzZSwgZml4IHlvdXIgZW1haWwgY2xpZW50
IG9yIHVzZSBnaXQgc2VuZC1lbWFpbA0KVGhhbmsgeW91IGZvciB5b3VyIGluZm9ybWF0aW9uLg0K
SSByZXNlbmQgbWFpbCB3aXRoIHRleHQgZm9ybWF0LCB3b3VsZCB5b3Uga2luZCBjb25maXJtIHRo
ZSBwYXRjaCwgdGhhbmsgeW91Lg0KDQpCZXN0IFJlZ2FyZHMNCkphY2t5DQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBGZWxpcGUgQmFsYmkgPGJhbGJpQGtlcm5lbC5vcmc+IA0K
U2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNCwgMjAxOSAzOjQ3IFBNDQpUbzogQ2FvLCBKYWNr
eSA8SmFja3kuQ2FvQHNvbnkuY29tPg0KQ2M6IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnPjsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgS2VybmVsIGRldmVsb3BtZW50IGxp
c3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBLb2JheWFzaGksIEtlbnRvIChTb255
KSA8S2VudG8uQS5Lb2JheWFzaGlAc29ueS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBVU0I6
IGR1bW15LWhjZDogZml4IHBvd2VyIGJ1ZGdldCBmb3IgU3VwZXJTcGVlZCBtb2RlDQoNCkhpLA0K
DQpPbiBXZWQsIFNlcCA0LCAyMDE5IGF0IDk6NDcgQU0gPEphY2t5LkNhb0Bzb255LmNvbT4gd3Jv
dGU6DQo+DQo+IFRoZSBwb3dlciBidWRnZXQgZm9yIFN1cGVyU3BlZWQgbW9kZSBzaG91bGQgYmUg
OTAwIG1BDQo+DQo+IGFjY29yZGluZyB0byBVU0IzLjAgc3BlY2lmaWNhdGlvbiwgc28gc2V0IHRo
ZSBwb3dlcg0KPg0KPiBidWRnZXQgdG8gOTAwIG1BIGZvciBkdW1teV9zdGFydF9zcyB3aGljaCBp
cyBvbmx5IHVzZWQNCj4NCj4gZm9yIFN1cGVyU3BlZWQgbW9kZS4NCj4NCj4NCj4NCj4gSWYgdGhl
IG1heCBwb3dlciBjb25zdW1wdGlvbiBvZiBTdXBlclNwZWVkIGRldmljZSBpcw0KPg0KPiBsYXJn
ZXIgdGhhbiA1MDAgbUEsIGluc3VmZmljaWVudCBhdmFpbGFibGUgYnVzIHBvd2VyDQo+DQo+IGVy
cm9yIGhhcHBlbnMgaW4gdXNiX2Nob29zZV9jb25maWd1cmF0aW9uIGZ1bmN0aW9uDQo+DQo+IHdo
ZW4gdGhlIGRldmljZSBjb25uZWN0cyB0byBkdW1teSBoY2QuDQo+DQo+DQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IEphY2t5IENhbyA8SmFja3kuQ2FvQHNvbnkuY29tPg0KDQpZb3UgbXVzdCBzZW5kIHBs
YWluL3RleHQgZW1haWxzLiBJJ20gbm90IHJlY2VpdmluZyB0aGlzIHZpYSB0aGUgbWFpbGluZyBs
aXN0LiBQbGVhc2UsIGZpeCB5b3VyIGVtYWlsIGNsaWVudCBvciB1c2UgZ2l0IHNlbmQtZW1haWwN
Cg0KLS0NCmJhbGJpDQo=
