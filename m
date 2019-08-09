Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B534C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD38A21743
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfHITwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:52:12 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45550 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfHITwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:52:12 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79JpGgd022894;
        Fri, 9 Aug 2019 19:51:56 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com with ESMTP id 2u9ecx8b8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Aug 2019 19:51:56 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 97B288D;
        Fri,  9 Aug 2019 19:51:47 +0000 (UTC)
Received: from G4W9335.americas.hpqcorp.net (16.208.33.85) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 9 Aug 2019 19:51:21 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G4W9335.americas.hpqcorp.net (2002:10d0:2155::10d0:2155) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Fri, 9 Aug 2019 19:51:21 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 9 Aug 2019 19:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSrAeyRg8LrGhqZ7CVKIy+bW0iUJ1H0t793MPWQo/xv2UAyFxXBXRJdIfWE0N95bKNvj6tlQ21UivwiSuQpYyXrrnW2ySt9Ii5KGuwiQ4SsVL9kW/iV3eh/xOO0NdK/kSJGnqBRqGGprjqBwKtQdaE0JuioCO7cH+ZS7/R15C8g3RUwLYFEY21gFm8TNk/flYo9CyvzvetXsAp7xEzaDuRqW2nAa1zWXNauRR1dqFcrEaReycT53ydAx1qYSrAwJI4fX3cJGTldUmBbY1g3fIX47hcqF1jAZjwcpoPbtH7WuJnLzS7YMK9v+3qp2qnWeSOX9oLq23zoUTY1aiuFRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdDigpzb0QWPV7tjL2qpLZee/jU4jhPGu7+QZHuoUeA=;
 b=AMxVjMdoTlz+Jy7rbtXQK5lieWVQjfZzdk5oIhOWGocBQNi7nJ+cnKEW3SuBxCxHHrre28SCoRAwO8WOc8JNWsXdm5YIM8DahUeZFEK7786WrwrORM5wh6Ww3+PX2qnPn+0H4i3WskHCUZG+RP48Tchvffdxc/1wmaVFNWUUfycXmJEpCjg6dMHnUAf7HJRgq44GrVmjEZRbeRCqbwDV9bkZ4eBt0UfoRQHT1vgzLmxSlLmbKmTUJNEF/1TrZMX5axDA5iRodE88uMO+bzXWmd3+MWQ24uIhNQk+DqDxbQKG1MGhBZVWJJj0B8tuIuHpZFFb98CVhIT/b9fH+otDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM (10.169.44.19) by
 TU4PR8401MB0413.NAMPRD84.PROD.OUTLOOK.COM (10.169.43.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Fri, 9 Aug 2019 19:51:17 +0000
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9cc4:8a7f:f761:f990]) by TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9cc4:8a7f:f761:f990%11]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 19:51:17 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fei1.li@intel.com" <fei1.li@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Thread-Topic: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Thread-Index: AQHVTmYqsSEI/GfXwEqOxUs01+wmX6byZTeAgADT14A=
Date:   Fri, 9 Aug 2019 19:51:17 +0000
Message-ID: <3355d77da5e094ad1d3149b9236cdd204486fd69.camel@hpe.com>
References: <cover.1565300606.git.isaku.yamahata@gmail.com>
         <20190809070647.GA2152@zn.tnic>
In-Reply-To: <20190809070647.GA2152@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.219.163.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 074fc8b0-3437-4ded-6fa1-08d71d02f1ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0413;
x-ms-traffictypediagnostic: TU4PR8401MB0413:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TU4PR8401MB04130F26B283D4E1D79C1FCB82D60@TU4PR8401MB0413.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(71200400001)(118296001)(71190400001)(305945005)(229853002)(7736002)(8676002)(14444005)(256004)(36756003)(102836004)(2906002)(3846002)(6116002)(99286004)(186003)(6506007)(26005)(966005)(14454004)(478600001)(6246003)(446003)(486006)(476003)(2616005)(81166006)(11346002)(25786009)(81156014)(2501003)(8936002)(6306002)(6512007)(53936002)(86362001)(110136005)(5660300002)(316002)(6436002)(66946007)(66066001)(66556008)(66446008)(76116006)(64756008)(6486002)(54906003)(66476007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0413;H:TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /zdGGbIppAytn83di0duNqqFV0bms+CQVpXhdtJ+MVIIquf4IYEUn0sjZd3gNnLQd3BZHXZtiIKS3vmJBlVvdjGOk/548ufsnPO7ewmZHi9vwatOtJwrA6eGxkUnozr+fDb1h2esFMN7JUrX5zDNdbyQ/Md471GWbzzrON2twAm8SGzv/0NqloufZCsoh8jXageyZ4Z0+F3xd6cLaaUJcuSnl/rpTWViQlrY6XlqyXP051bzlZjTTQR3hCz1CWJ9PfsITst+Q/GkPqUelmqEzhmVMxhzzK7cKYvJYMfoFDa2CLkaJeC7QMSqOfF7E4PfXqEVpeAmefqxtLvRspiT9XB+h/Kqd8/cbnYqyA5PohnLh9qs3xu12BgwuAUtqJu0BOr1uhX+f6fTSby8kVVOVGszzRfrM0pzEAxG5FDLmzQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <528CA9DAEB99514EBB209FE89CF12429@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-Network-Message-Id: 074fc8b0-3437-4ded-6fa1-08d71d02f1ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 19:51:17.7174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFNEIVaJ+EyhWVPNi+MJes5FfMLewAI7UQEjDawLjBppiezrUNNb2/E/3h3Yji6dSK1Sv+pSkgjXjdvqPU0PUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0413
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=468 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTA5IGF0IDA5OjA2ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDA4LCAyMDE5IGF0IDA4OjU0OjE3UE0gLTA3MDAsIElzYWt1IFlhbWFo
YXRhIHdyb3RlOg0KPiA+IE1ha2UgUEFUKFBhZ2UgQXR0cmlidXRlIFRhYmxlKSBpbmRlcGVuZGVu
dCBmcm9tDQo+ID4gTVRSUihNZW1vcnkgVHlwZSBSYW5nZSBSZWdpc3RlcikuDQo+ID4gU29tZSBl
bnZpcm9ubWVudHMgKG1haW5seSB2aXJ0dWFsIG9uZXMpIHN1cHBvcnQgb25seSBQQVQsIGJ1dCBu
b3QgTVRSUg0KPiA+IGJlY2F1c2UgUEFUIHJlcGxhY2VzIE1UUlIuDQo+ID4gSXQncyB0cmlja3kg
YW5kIG5vIGdhaW4gdG8gc3VwcG9ydCBib3RoIE1UUlIgYW5kIFBBVCBleGNlcHQgY29tcGF0aWJp
bGl0eS4NCj4gPiBTbyBzb21lIFZNIHRlY2hub2xvZ2llcyBkb24ndCBzdXBwb3J0IE1UUlIsIGJ1
dCBvbmx5IFBBVC4NCg0KSSBkbyBub3QgdGhpbmsgaXQgaXMgdGVjaG5pY2FsbHkgY29ycmVjdCBv
biBiYXJlIG1ldGFsLiAgQUZBSUssIE1UUlIgaXMNCnN0aWxsIHRoZSBvbmx5IHdheSB0byBzZXR1
cCBjYWNoZSBhdHRyaWJ1dGUgaW4gcmVhbC1tb2RlLCB3aGljaCBCSU9TIFNNSQ0KaGFuZGxlciBy
ZWxpZXMgb24gaW4gU01NLg0KDQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgbWFrZXMgUEFUIGF2YWls
YWJsZSBvbiBzdWNoIGVudmlyb25tZW50cyB3aXRob3V0IE1UUlIuDQo+IA0KPiBBbmQgdGhpcyAi
anVzdGlmaWNhdGlvbiIgaXMgbm90IGV2ZW4gdHJ5aW5nLiBXaGljaCAiVk0gdGVjaG5vbG9naWVz
IiBhcmUNCj4gdGhvc2U/IFdoeSBkbyB3ZSBjYXJlPyBXaGF0J3MgdGhlIGltcGFjdD8gV2h5IGRv
IHdlIHdhbnQgdGhpcz8NCj4gDQo+IFlvdSBuZWVkIHRvIHNlbGwgdGhpcyBwcm9wZXJseS4NCg0K
QWdyZWVkLiAgSWYgdGhlIHNpdHVhdGlvbiBpcyBzdGlsbCB0aGUgc2FtZSwgWGVuIGRvZXMgbm90
IHN1cHBvcnQgTVRSUiwNCmFuZCB0aGUga2VybmVsIHNldHMgdGhlIFBBVCB0YWJsZSB0byB0aGUg
QklPUyBoYW5kLW9mZiBzdGF0ZSB3aGVuIE1UUlINCmlzIGRpc2FibGVkLiAgVGhlIGNoYW5nZSBi
ZWxvdyBhY2NvbW1vZGF0ZWQgdGhlIGZhY3QgdGhhdCBYZW4gaHlwZXJ2aXNvcg0KZW5hYmxlcyBX
QyBiZWZvcmUgaGFuZC1vZmYsIHdoaWNoIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBkZWZhdWx0IEJJ
T1MNCmhhbmQtb2ZmIHN0YXRlLiAgVGhlIGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IHNldHRpbmcg
UEFUIHdoZW4gTVRSUiBpcw0KZGlzYWJsZWQgZHVlIHRvIHRoZSBkZXBlbmRlbmN5IElzYWt1IG1l
bnRpb25lZC4NCg0KDQpodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL2xpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcvbXNnMTEwNzA5NC5odG1sDQoNCg0KLVRvc2hpDQoNCg==
