Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC810C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B538B21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cLxvwFD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390516AbfISNqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:46:11 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:2788
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387417AbfISNqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewTsOKdcMgYg5iWkhDpztZUgiMou/tAcdvcoMLN6EBpYV5yPVo0fVMvqMU5ZMvhgDQ8b86vaOxTittIEqzGXjsUVp3uo7BnnIY0d5lC5lX9gPRNjG7DHexV9tanZMN3SilRd3YFjLsNP1W0Y4IRtoKifaOhzW1HqjhA+tedP0l6n2nSb0dnbOL8BXSMb5yTUvKSofjbndqwCSgTq/V1AnS+F63vBPw9kJZtxh1x0Cpl0qm14kuYO76/FQUtgpzXuaaeBZOFTySbTptFcokJXsfLgdpF4RD/W4De9++PW4J4S4/UKG8ypMe8kMkK0n/IahXo2a+oKwLAt98dTUNChEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCGpWFSrC84MG0ueH1sSuJJGf6dFb5wrSbpdg0kTGTo=;
 b=SjNQuTMb5tAZek1PKZNZA3ezhzU/M4MeBe6u5egm0JofAyPnJF98JRhhZF8UU++2OTjEawNf1I+9iHB2X5bdy5AIZcG8KBQx99AkP8F1ESMvBhDIIJ6Bsp/8qlRWj4V2u2DDG01mHxgD5Mmc/d8JP3+lVmlj87ak/dNCJ+19dLNO6AV+4LOC431boUi1BIjbwhsw6+OWrCWuzpwknHKOC7MtC+wBxbk+o2RsDZblEaF/utZcAcJ8kQbAr8vJZVi1IZ3Shp1Azy99Fz1N0QAwp6uLCH6vopE/fEu9XKM3zVn19ZIj3Vyayq2dQ/rNiumgmW7S+ic64YRbObSl/ZIZuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCGpWFSrC84MG0ueH1sSuJJGf6dFb5wrSbpdg0kTGTo=;
 b=cLxvwFD7Zezgog89E2oi1hSx9AWGQhNUGI2+chDf5B/totZIDdqm8VMG/CJHgQidL7ttpuJA1iAAO3JDZNVYsOc0trajoYhG2h79cape1BmjXMeE4yPcitChA4jVA8z1nJc+83nGFt0IjMmwsoL3MPPc2FcmmvRzT8p9godlCAY=
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0117.namprd12.prod.outlook.com (10.174.53.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Thu, 19 Sep 2019 13:45:28 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::708e:c826:5b05:e3f0]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::708e:c826:5b05:e3f0%11]) with mapi id 15.20.2284.009; Thu, 19 Sep
 2019 13:45:28 +0000
From:   Harry Wentland <hwentlan@amd.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "Zhang, Dingchen (David)" <Dingchen.Zhang@amd.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: hide an unused variable
Thread-Topic: [PATCH] drm/amd/display: hide an unused variable
Thread-Index: AQHVblrid3B5ShlFKUmMmFTt9Dg2L6czBEMA
Date:   Thu, 19 Sep 2019 13:45:28 +0000
Message-ID: <73842ec4-2767-c918-6ede-d05ff653255c@amd.com>
References: <20190918195418.2042610-1-arnd@arndb.de>
In-Reply-To: <20190918195418.2042610-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
x-clientproxiedby: YTXPR0101CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::35) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a7f3074-659b-46b7-b29b-08d73d07a180
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR1201MB0117;
x-ms-traffictypediagnostic: CY4PR1201MB0117:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01175E9E7A4B2771830BA08F8C890@CY4PR1201MB0117.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(81156014)(66446008)(186003)(8936002)(71200400001)(25786009)(71190400001)(476003)(478600001)(486006)(66946007)(8676002)(81166006)(4326008)(6246003)(2616005)(6512007)(26005)(446003)(11346002)(64756008)(31686004)(53546011)(66476007)(58126008)(52116002)(14454004)(6506007)(256004)(7736002)(2906002)(54906003)(66066001)(386003)(3846002)(36756003)(14444005)(6436002)(66556008)(76176011)(229853002)(31696002)(65806001)(305945005)(5660300002)(102836004)(110136005)(99286004)(6116002)(65956001)(316002)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0117;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NHeo4FOH2tsGlGHbBgnuSTSDLiZxVhbJhqBu2sLdiZnFDFvID7EaKujxiIxkSoSsTApOcPvyGxc6MF0a54NkZkd8lNehOd2o+EKcWPD45QhUfXE9nQwWliB1ZygSAcoqI26Oa6sfqKRr63fHi0RIQ8ewvJaQBWDQhyUwto/bMFIWD+ueWYPB6Lv4rr6v6oIOfs5xm2o56n3ID0dycB+FLuxJvH23gjaKa5MRnaUX2nmpSDjYsk2p41OLzBHiYuwqXlORmmU6SJgi2gDf/VyLTTGZX/22oZKxLTDtp3WxoHqNEZa50YhOgfdk18hpfOxvaIf/s56SM8Sp7do9O8RspnTe8xPfSwpOs98BAuLIf7EASCXBxeK+khIfTMd8oO3Jmqx+bnfs2X0zLzYQShBHA3IUJrSpG1hwR79Sqwif7ww=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38226A466B92D14284C17B0056D246D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7f3074-659b-46b7-b29b-08d73d07a180
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:45:28.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAgIt3DItDKgEZOdj96j/z9QBmp777FBFRpAYNCbmdBoROtX7CrZXiW/2A7LsjDRhLlttRo2VuxRZQfbqSz/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wOS0xOCAzOjUzIHAubS4sIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IFdpdGhvdXQg
Q09ORklHX0RFQlVHX0ZTLCB3ZSBnZXQgYSB3YXJuaW5nIGZvciBhbiB1bnVzZWQNCj4gdmFyaWFi
bGU6DQo+IA0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYzo2MDIwOjMzOiBlcnJvcjogdW51c2VkIHZhcmlhYmxlICdzb3VyY2UnIFst
V2Vycm9yLC1XdW51c2VkLXZhcmlhYmxlXQ0KPiANCj4gSGlkZSB0aGUgdmFyaWFibGUgaW4gYW4g
I2lmZGVmIGxpa2UgaXRzIG9ubHkgdXNlcnMuDQo+IA0KPiBGaXhlczogMTRiMjU4NDYzNmM2ICgi
ZHJtL2FtZC9kaXNwbGF5OiBhZGQgZnVuY3Rpb25hbGl0eSB0byBncmFiIERQUlggQ1JDIGVudHJp
ZXMuIikNCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCg0K
UmV2aWV3ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpI
YXJyeQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYw0KPiBpbmRleCBlMWIwOWJiNDMyYmQuLjc0MjUyZjU3YmFmYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jDQo+IEBA
IC02MDE3LDcgKzYwMTcsOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1fZW5hYmxlX2NydGNfaW50
ZXJydXB0cyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LA0KPiAgCXN0cnVjdCBkcm1fY3J0YyAqY3J0
YzsNCj4gIAlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKm9sZF9jcnRjX3N0YXRlLCAqbmV3X2NydGNf
c3RhdGU7DQo+ICAJaW50IGk7DQo+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+ICAJZW51bSBh
bWRncHVfZG1fcGlwZV9jcmNfc291cmNlIHNvdXJjZTsNCj4gKyNlbmRpZg0KPiAgDQo+ICAJZm9y
X2VhY2hfb2xkbmV3X2NydGNfaW5fc3RhdGUoc3RhdGUsIGNydGMsIG9sZF9jcnRjX3N0YXRlLA0K
PiAgCQkJCSAgICAgIG5ld19jcnRjX3N0YXRlLCBpKSB7DQo+IA0K
