Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E00C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AACB206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="de4L8RV1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="de4L8RV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfJHCaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 22:30:30 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:61208
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729212AbfJHCaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 22:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo9tMP1LoKiXv8RH6gi8Lld3ch4Wavtz5eGRg3OCE4Q=;
 b=de4L8RV1I5v5BC+iffUe5tcHh5PgVjl/VM4pquwwFUKW7o5jt6GwFQUfdHyWX5DmRA8MWg4D3xzk3jxphIZufa1pQ3jEYKLvO4W2PXqTlnGOSb8XiAPkj7zYsUozALjS0u7bFVFqczz4/uHEV9nX8fQVRqAohuvLNBQ3PfqD6Ho=
Received: from VI1PR08CA0118.eurprd08.prod.outlook.com (2603:10a6:800:d4::20)
 by VI1PR0801MB2079.eurprd08.prod.outlook.com (2603:10a6:800:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 02:30:18 +0000
Received: from VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0118.outlook.office365.com
 (2603:10a6:800:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 8 Oct 2019 02:30:18 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT009.mail.protection.outlook.com (10.152.18.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 02:30:17 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Tue, 08 Oct 2019 02:30:15 +0000
X-CR-MTA-TID: 64aa7808
Received: from cba4b006a3a0.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 04EEDE0E-56ED-4BAD-97FF-23D01500AB5B.1;
        Tue, 08 Oct 2019 02:30:10 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cba4b006a3a0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 08 Oct 2019 02:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgpLu2ej8HM+NzVZw68ah8BHfcAvXjR+WHeIbz3z5nABY1fYWytGX2RFrE/DAh17a+sl00b6E0KQLBAGlW3OkzzN/0Rh9iwoqFK8vnMhtDRAvFAl4d1ez8AGaWNFoezL/xVpq89Fg3bUq34uXp5IAwc9peeLJRNzl97er+yzvm+lRQx9nGH+eTTDG/VVuwcqtPuvg8mVcA0j/W/tqtpwFtJlq/Lu0LD+mBgCSkkL/584vUxjz8HKAqr3/zOU0+S+QQIKp1coQB1KezcHJ4K3JdJa5WgmWBtvw/3okBCzFz19Vg8/CDfW4HFpCPjEEkQ68hh1bzPhooX6w7+a1OWswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo9tMP1LoKiXv8RH6gi8Lld3ch4Wavtz5eGRg3OCE4Q=;
 b=oers6eJYJUCzNyZnXSIF+F+/iCuF2X76RsxzrI3FgMAHOyZAcNC5SAKEsuOTkgvMSyaM24kHEKfZglkRNeKhZBI7Q3znBKvxFIjdDDs1QgJRc6Zl6EI8AwwmW5YVCOo7NxWZ9vg44sjA6zU669MH37WUM96oX5dPzXfKfDI2XH9k3PmB2L11wAFgCPienbYoxyc9s055GYdlTmYd3h8FUJ/vxsZvuvc/yoTVSLzBsk2t0mpx1bbapz/qhtBw/4sNxvm+QE2usjskHsygoGEpw8L+rk4v2k7F/kWgDShwveqWmbypJnGfQLPO5pR3T1hF4Btihxrf3mjPMtLg6680iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo9tMP1LoKiXv8RH6gi8Lld3ch4Wavtz5eGRg3OCE4Q=;
 b=de4L8RV1I5v5BC+iffUe5tcHh5PgVjl/VM4pquwwFUKW7o5jt6GwFQUfdHyWX5DmRA8MWg4D3xzk3jxphIZufa1pQ3jEYKLvO4W2PXqTlnGOSb8XiAPkj7zYsUozALjS0u7bFVFqczz4/uHEV9nX8fQVRqAohuvLNBQ3PfqD6Ho=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3354.eurprd08.prod.outlook.com (52.134.110.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 02:30:07 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0%6]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 02:30:07 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH v10 2/3] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Thread-Topic: [PATCH v10 2/3] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Thread-Index: AQHVdzKGx1YzEK84qECDJFJMWK8dTqdFvzkAgAALrYCACjIy4IAAFPPA
Date:   Tue, 8 Oct 2019 02:30:06 +0000
Message-ID: <DB7PR08MB30821ADF14E35443D0FCEA14F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190930015740.84362-1-justin.he@arm.com>
        <20190930015740.84362-3-justin.he@arm.com>
        <20191001125031.7ddm5dlwss6m3dth@willie-the-truck>
 <20191001143219.018281be@why>
 <DB7PR08MB308265EB3ED2465D2471B492F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
In-Reply-To: <DB7PR08MB308265EB3ED2465D2471B492F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 33ffc2c4-3f30-4163-9612-aa78e6c701de.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ef1ee387-8d4a-4a6b-bf4e-08d74b977523
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DB7PR08MB3354:|DB7PR08MB3354:|VI1PR0801MB2079:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2079E302604FF4CC1C1A6FBCF79A0@VI1PR0801MB2079.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(13464003)(7736002)(25786009)(14444005)(2940100002)(76116006)(102836004)(64756008)(99286004)(66476007)(66946007)(66556008)(305945005)(55236004)(33656002)(74316002)(4326008)(7416002)(6246003)(256004)(66446008)(229853002)(316002)(6506007)(76176011)(53546011)(14454004)(52536014)(186003)(6436002)(11346002)(26005)(9686003)(81156014)(8676002)(81166006)(71200400001)(71190400001)(54906003)(110136005)(66066001)(6116002)(478600001)(6306002)(5660300002)(3846002)(476003)(446003)(7696005)(486006)(55016002)(86362001)(8936002)(966005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3354;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Pkg4Ofp7A49PSe/0Opi5dnVet9FIMvoo7zFWnyK1BbTS0r8bkdgRr1+DDxB9nXrdzm7Xw2Qgq7xj6qU3XEP2sZR6ZmctIUQhc16UPFkqOpcyB5K5nMyqfrpcneVWW/KAenyyFWjldCqhJAiewsau9rgI7PBhfECQloenamhziipNbqd6UxVHjuRMak9QBfvQSwVLSjopye+oWKnGw9Ut+1wcJMaIqAc5woz1pGzfAiicZ5IEMy9zpGnv9sv639E5P90EXKoagp+bKO5jWWjUkdo0WQzFG4pGuD4vEzo3e6pMjgZFmHjKu+Ub2n9da9aCmei4s9qCudyq5DOiNGFAgqV6ZLt39wYK/fG2lX98iiiOZST2RqIipxN6Fp+P5Fhm7I88i7w1cFXg9UHrZD6CemEfChjO6d7naJWL4zaEZxNYMOMGZE0Q+XrHSZYCg53fwLYmpgLbKDpVBQsHqPetrQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3354
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(13464003)(189003)(199004)(76176011)(9686003)(186003)(6306002)(99286004)(7696005)(7736002)(446003)(63350400001)(229853002)(48336001)(966005)(11346002)(26005)(486006)(25786009)(22756006)(478600001)(102836004)(54906003)(126002)(70586007)(26826003)(76130400001)(4326008)(47136003)(23696002)(305945005)(6246003)(70206006)(316002)(6506007)(47776003)(53546011)(81156014)(5660300002)(52536014)(110136005)(36906005)(8676002)(6116002)(3846002)(50466002)(8936002)(81166006)(336012)(436003)(33656002)(74316002)(14454004)(66066001)(356004)(86362001)(2940100002)(2906002)(14444005)(476003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2079;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 17415548-a14b-44a3-e765-08d74b976f20
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkoaDZ+PUc0Iaw9j8N2FkeCXf3tf4s03O9S1cLg+d1Cl13ouaHCE0FKfcr4mCCxEnuxYfKFJuCagkANLJHHyt9pI9rvvKoqHvL/csYKFqoo0fF25OuUnAhYFcH2pdvxpOUxX8mODhfUM2i99MxFnhQ4KGnIeOtfJW8cL1dsLw5Yc+xIBc5n3tp4QnIuzWAoSdm8MlsfNkjQGsNTn5eKWVTgj1NSPx8XNgVi0q4n/uGO6OCGTH1obWf6crDP6aAZcwhESnEUruhof3gUfOWoNLNKc0LavySu/+ZfOBx0l5osATH2ZJdEaG0E9MC1GKrKdo/KpxjFERjUtDYkqzMEOerkxtv8fMNtqnQNWlIl0usytCrhJWvC7PXmZdcWNaAP115pj70gELAC5iRK4eQ+bFh0BAbK4+RiaNyzY1F2HUx0rTYI3uG8tc9vmbNlQs590/QjuLn9SD1lKGpomqBM+2g==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 02:30:17.2555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1ee387-8d4a-4a6b-bf4e-08d74b977523
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVzdGluIEhlIChBcm0g
VGVjaG5vbG9neSBDaGluYSkNCj4gU2VudDogMjAxOcTqMTDUwjjI1SA5OjU1DQo+IFRvOiBNYXJj
IFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4N
Cj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyBNYXJrIFJ1
dGxhbmQNCj4gPE1hcmsuUnV0bGFuZEBhcm0uY29tPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1vcnNl
QGFybS5jb20+Ow0KPiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEtpcmls
bCBBLiBTaHV0ZW1vdg0KPiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT47IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBQdW5pdCBBZ3Jhd2FsDQo+IDxwdW5pdGFncmF3
YWxAZ21haWwuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Ow0KPiBB
bmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgaGVqaWFuZXRAZ21haWwu
Y29tOyBLYWx5DQo+IFhpbiAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxLYWx5LlhpbkBhcm0uY29t
PjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEwIDIvM10gYXJtNjQ6
IG1tOiBpbXBsZW1lbnQNCj4gYXJjaF9mYXVsdHNfb25fb2xkX3B0ZSgpIG9uIGFybTY0DQo+IA0K
PiBIaSBXaWxsIGFuZCBNYXJjDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gRnJvbTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCj4gPiBTZW50OiAyMDE5xOox
MNTCMcjVIDIxOjMyDQo+ID4gVG86IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ID4g
Q2M6IEp1c3RpbiBIZSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxKdXN0aW4uSGVAYXJtLmNvbT47
IENhdGFsaW4NCj4gPiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJtLmNvbT47IE1hcmsgUnV0
bGFuZA0KPiA+IDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47IEphbWVzIE1vcnNlIDxKYW1lcy5Nb3Jz
ZUBhcm0uY29tPjsNCj4gPiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEtp
cmlsbCBBLiBTaHV0ZW1vdg0KPiA+IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPjsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgUHVuaXQgQWdyYXdhbA0KPiA+IDxw
dW5pdGFncmF3YWxAZ21haWwuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+Ow0KPiA+IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBoZWpp
YW5ldEBnbWFpbC5jb207DQo+IEthbHkNCj4gPiBYaW4gKEFybSBUZWNobm9sb2d5IENoaW5hKSA8
S2FseS5YaW5AYXJtLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCAyLzNdIGFybTY0
OiBtbTogaW1wbGVtZW50DQo+ID4gYXJjaF9mYXVsdHNfb25fb2xkX3B0ZSgpIG9uIGFybTY0DQo+
ID4NCj4gPiBPbiBUdWUsIDEgT2N0IDIwMTkgMTM6NTA6MzIgKzAxMDANCj4gPiBXaWxsIERlYWNv
biA8d2lsbEBrZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+ID4gT24gTW9uLCBTZXAgMzAsIDIw
MTkgYXQgMDk6NTc6MzlBTSArMDgwMCwgSmlhIEhlIHdyb3RlOg0KPiA+ID4gPiBPbiBhcm02NCB3
aXRob3V0IGhhcmR3YXJlIEFjY2VzcyBGbGFnLCBjb3B5aW5nIGZyb211c2VyIHdpbGwgZmFpbA0K
PiA+IGJlY2F1c2UNCj4gPiA+ID4gdGhlIHB0ZSBpcyBvbGQgYW5kIGNhbm5vdCBiZSBtYXJrZWQg
eW91bmcuIFNvIHdlIGFsd2F5cyBlbmQgdXAgd2l0aA0KPiA+IHplcm9lZA0KPiA+ID4gPiBwYWdl
IGFmdGVyIGZvcmsoKSArIENvVyBmb3IgcGZuIG1hcHBpbmdzLiB3ZSBkb24ndCBhbHdheXMgaGF2
ZSBhDQo+ID4gPiA+IGhhcmR3YXJlLW1hbmFnZWQgYWNjZXNzIGZsYWcgb24gYXJtNjQuDQo+ID4g
PiA+DQo+ID4gPiA+IEhlbmNlIGltcGxlbWVudCBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlIG9uIGFy
bTY0IHRvIGluZGljYXRlIHRoYXQNCj4gaXQNCj4gPiBtaWdodA0KPiA+ID4gPiBjYXVzZSBwYWdl
IGZhdWx0IHdoZW4gYWNjZXNzaW5nIG9sZCBwdGUuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBD
YXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS5oIHwgMTQgKysrKysrKysrKysr
KysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiA+
IGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiA+ID4gaW5kZXggNzU3NmRm
MDBlYjUwLi5lOTZmYjgyZjYyZGUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvaW5j
bHVkZS9hc20vcGd0YWJsZS5oDQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20v
cGd0YWJsZS5oDQo+ID4gPiA+IEBAIC04ODUsNiArODg1LDIwIEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCB1cGRhdGVfbW11X2NhY2hlKHN0cnVjdA0KPiA+IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ID4g
PiA+ICAjZGVmaW5lIHBoeXNfdG9fdHRicihhZGRyKQkoYWRkcikNCj4gPiA+ID4gICNlbmRpZg0K
PiA+ID4gPg0KPiA+ID4gPiArLyoNCj4gPiA+ID4gKyAqIE9uIGFybTY0IHdpdGhvdXQgaGFyZHdh
cmUgQWNjZXNzIEZsYWcsIGNvcHlpbmcgZnJvbSB1c2VyIHdpbGwNCj4gZmFpbA0KPiA+IGJlY2F1
c2UNCj4gPiA+ID4gKyAqIHRoZSBwdGUgaXMgb2xkIGFuZCBjYW5ub3QgYmUgbWFya2VkIHlvdW5n
LiBTbyB3ZSBhbHdheXMgZW5kIHVwDQo+ID4gd2l0aCB6ZXJvZWQNCj4gPiA+ID4gKyAqIHBhZ2Ug
YWZ0ZXIgZm9yaygpICsgQ29XIGZvciBwZm4gbWFwcGluZ3MuIFdlIGRvbid0IGFsd2F5cyBoYXZl
IGENCj4gPiA+ID4gKyAqIGhhcmR3YXJlLW1hbmFnZWQgYWNjZXNzIGZsYWcgb24gYXJtNjQuDQo+
ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX2ZhdWx0c19vbl9v
bGRfcHRlKHZvaWQpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJV0FSTl9PTihwcmVlbXB0aWJsZSgp
KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiAhY3B1X2hhc19od19hZigpOw0KPiA+ID4g
PiArfQ0KPiA+ID4NCj4gPiA+IERvZXMgdGhpcyB3b3JrIGNvcnJlY3RseSBpbiBhIEtWTSBndWVz
dD8gKGkuZS4gaXMgdGhlIE1NRlIgc2FuaXRpc2VkIGluDQo+ID4gdGhhdA0KPiA+ID4gY2FzZSwg
ZGVzcGl0ZSBub3QgYmVpbmcgdGhlIGNhc2Ugb24gdGhlIGhvc3Q/KQ0KPiA+DQo+ID4gWXVwLCBh
bGwgdGhlIDY0Yml0IE1NRlJzIGFyZSB0cmFwcGVkIChIQ1JfRUwyLlRJRDMgaXMgc2V0IGZvciBh
bg0KPiA+IEFBcmNoNjQgZ3Vlc3QpLCBhbmQgd2UgcmV0dXJuIHRoZSBzYW5pdGlzZWQgdmVyc2lv
bi4NCj4gVGhhbmtzIGZvciBNYXJjJ3MgZXhwbGFuYXRpb24uIEkgdmVyaWZpZWQgdGhlIHBhdGNo
IHNlcmllcyBvbiBhIGt2bSBndWVzdCAoLQ0KPiBNIHZpcnQpDQo+IHdpdGggc2ltdWxhdGVkIG52
ZGltbSBkZXZpY2UgY3JlYXRlZCBieSBxZW11LiBUaGUgaG9zdCBpcyBUaHVuZGVyWDINCj4gYWFy
Y2g2NC4NCj4gDQo+ID4NCj4gPiBCdXQgdGhhdCdzIGFuIGludGVyZXN0aW5nIHJlbWFyazogd2Un
cmUgbm93IHRyYWRpbmcgYW4gZXh0cmEgZmF1bHQgb24NCj4gPiBDUFVzIHRoYXQgZG8gbm90IHN1
cHBvcnQgSFdBRkRCUyBmb3IgYSBndWFyYW50ZWVkIHRyYXAgZm9yIGVhY2ggYW5kDQo+ID4gZXZl
cnkgZ3Vlc3QgdW5kZXIgdGhlIHN1biB0aGF0IHdpbGwgaGl0IHRoZSBDT1cgcGF0aC4uLg0KPiA+
DQo+ID4gTXkgZ3V0IGZlZWxpbmcgaXMgdGhhdCB0aGlzIGlzIGdvaW5nIHRvIGJlIHByZXR0eSB2
aXNpYmxlLiBKaWEsIGRvIHlvdQ0KPiA+IGhhdmUgYW55IG51bWJlcnMgZm9yIHRoaXMga2luZCBv
ZiBiZWhhdmlvdXI/DQo+IEl0IGlzIG5vdCBhIGNvbW1vbiBDT1cgcGF0aCwgYnV0IGEgQ09XIGZv
ciBQRk4gbWFwcGluZyBwYWdlcyBvbmx5Lg0KPiBJIGFkZCBhIGdfY291bnRlciBiZWZvcmUgcHRl
X21reW91bmcgaW4gZm9yY2VfbWt5b3VuZ3t9IHdoZW4gdGVzdGluZw0KPiB2bW1hbGxvY19mb3Jr
IGF0IFsxXS4NCj4gDQo+IEluIHRoaXMgdGVzdCBjYXNlLCBpdCB3aWxsIHN0YXJ0IE0gZm9yayBw
cm9jZXNzZXMgYW5kIE4gcHRocmVhZHMuIFRoZSBkZWZhdWx0IGlzDQo+IE09MixOPTQuIHRoZSBn
X2NvdW50ZXIgaXMgYWJvdXQgMjQxLCB0aGF0IGlzIGl0IHdpbGwgaGl0IG15IHBhdGNoIHNlcmll
cyBmb3INCj4gMjQxDQo+IHRpbWVzLg0KPiBJZiBJIHNldCBNPTIwIGFuZCBOPTQwIGZvciBURVNU
MywgdGhlIGdfY291bnRlciBpcyBhYm91dCAxNDkyLg0KDQpUaGUgdGltZSBvdmVyaGVhZCBvZiB0
ZXN0IHZtbWFsbG9jX2ZvcmsgaXM6DQpyZWFsICAgIDBtNS40MTFzDQp1c2VyICAgIDBtNC4yMDZz
DQpzeXMgICAgIDBtMi42OTlzDQoNCj4gDQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vcG1lbS9w
bWRrL3RyZWUvbWFzdGVyL3NyYy90ZXN0L3ZtbWFsbG9jX2ZvcmsNCj4gDQo+IA0KPiAtLQ0KPiBD
aGVlcnMsDQo+IEp1c3RpbiAoSmlhIEhlKQ0KPiANCg0K
