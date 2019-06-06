Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EA7C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F1C207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 06:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="V7irYQi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfFFGzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 02:55:52 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com ([40.107.0.100]:20593
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfFFGzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 02:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1JoR/QOJ49OomaK/J8xBReE7AbDdT1b3+wHLDbVvPo=;
 b=V7irYQi7k4A6gNyeA/yvd7RRBGrxKF/bNtz7UIdja2Z2BkEMs1y00Cq3ac2KJlfsMvm4T0f/GpuTZAU5QMyb3sv3FBVsrqajM5tSpyxXt896aHQZxHplttrMd2XmxLgRVgbBcFOTDps0nA/+dTPtpm2zUbEkO0+7SPIhcGZ4Ccg=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3626.eurprd07.prod.outlook.com (52.133.6.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.3; Thu, 6 Jun 2019 06:55:48 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::39:cb3e:563f:f6f9]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::39:cb3e:563f:f6f9%3]) with mapi id 15.20.1965.011; Thu, 6 Jun 2019
 06:55:48 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: perf top --stdio, glibc 2.28, stdio EOF sticky
Thread-Topic: perf top --stdio, glibc 2.28, stdio EOF sticky
Thread-Index: AQHVHDTfjRUbbEhTok2DPTKUEST6kQ==
Date:   Thu, 6 Jun 2019 06:55:48 +0000
Message-ID: <dbb3aebe71e057d1104b5f0b809a7ab83a0ac596.camel@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc9d5eb7-b5cd-42e8-bfe4-08d6ea4c0193
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3626;
x-ms-traffictypediagnostic: HE1PR0702MB3626:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <HE1PR0702MB362619C87296C00BC1DE8FD1B4170@HE1PR0702MB3626.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(6436002)(2501003)(118296001)(68736007)(66476007)(66946007)(76116006)(73956011)(5660300002)(8676002)(66446008)(64756008)(66556008)(53936002)(8936002)(6512007)(6306002)(81166006)(81156014)(7736002)(4744005)(305945005)(86362001)(966005)(2201001)(102836004)(110136005)(478600001)(26005)(3846002)(6116002)(25786009)(14454004)(256004)(316002)(99286004)(6506007)(186003)(6486002)(36756003)(66066001)(486006)(476003)(2616005)(2906002)(71200400001)(71190400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3626;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UZFPvbnBLh0SoOJVSOE+Y2O/aj41F++QN8//ROqjYQ4TkMpGUDnIQDIguiBIs4EaDQpOTrzK8VuYhEnfv6UIKBsncoxK4OJC4oGHniejU7MZNkdU5VCAj8mHMlcB490LwVB7js1AMRzc1JSTAi1Tmk7Gh6Mm9v1T9JsH3H2opq0qF/VwBSbjLtJGplT+wn7EctS7Nuzg39OVv5D9XJb49AB+r/oGObZzsHTvhxiaT0a5C31diE3O/7rT777ILUXvPaBBv6f917wPOKsrz7A0LaWY2+oYUY/z1BWj1F8Yex0V5x1FUtDAzsz56J+npVbsJbMphVEJec5O6V948eC1CR0b6S8AHqZizfOEMEiah6yIZdB37eKkTBp5kEeeQKbPmDh+7lRZhrO9MWma4bsO+3ajN/RZTB2UVZOpvBjfO7U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <146003D78199F94A9E9B24D765167591@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9d5eb7-b5cd-42e8-bfe4-08d6ea4c0193
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 06:55:48.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tommi.t.rantala@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCiJwZXJmIHRvcCAtLXN0ZGlvIiAob3IgcGVyZiBrdm0gdG9wIC0tc3RkaW8pIGtl
eWJvYXJkIGhhbmRsaW5nIGRvZXMgbm90DQp3b3JrIHByb3Blcmx5IGZvciBtZS4gSW5zdGVhZCBv
ZiBhY2NlcHRpbmcga2V5IHByZXNzZXMsIGl0IGp1c3QNCmRpc3BsYXlzIHRoZSAiTWFwcGVkIGtl
eXM6IiBoZWxwIG91dHB1dCBhbHdheXMuDQoNClNlZW1zIHRvIGJlIHJlbGF0ZWQgdG8gdGhpcyBn
bGliYyAyLjI4IHN0ZGlvIGNoYW5nZToNCg0KaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9naXQvP3A9
Z2xpYmMuZ2l0O2E9YmxvYjtmPU5FV1MNCg0KKiBBbGwgc3RkaW8gZnVuY3Rpb25zIG5vdyB0cmVh
dCBlbmQtb2YtZmlsZSBhcyBhIHN0aWNreSBjb25kaXRpb24uICBJZg0KeW91DQogcmVhZCBmcm9t
IGEgZmlsZSB1bnRpbCBFT0YsIGFuZCB0aGVuIHRoZSBmaWxlIGlzIGVubGFyZ2VkIGJ5IGFub3Ro
ZXINCiBwcm9jZXNzLCB5b3UgbXVzdCBjYWxsIGNsZWFyZXJyIG9yIGFub3RoZXIgZnVuY3Rpb24g
d2l0aCB0aGUgc2FtZQ0KZWZmZWN0DQogKGUuZy4gZnNlZWssIHJld2luZCkgYmVmb3JlIHlvdSBj
YW4gcmVhZCB0aGUgYWRkaXRpb25hbCBkYXRhLiAgVGhpcw0KIGNvcnJlY3RzIGEgbG9uZ3N0YW5k
aW5nIEM5OSBjb25mb3JtYW5jZSBidWcuICBJdCBpcyBtb3N0IGxpa2VseSB0bw0KYWZmZWN0DQog
cHJvZ3JhbXMgdGhhdCB1c2Ugc3RkaW8gdG8gcmVhZCBpbnRlcmFjdGl2ZSBpbnB1dCBmcm9tIGEg
dGVybWluYWwuDQogKEJ1ZyAjMTE5MC4pDQoNCg0KQWxzbyAicGVyZiB0b3AgPC9kZXYvbnVsbCIg
d2l0aCBvciB3aXRob3V0IC0tc3RkaW8gZG9lcyBub3QgYmVoYXZlIHZlcnkNCndlbGwgZWl0aGVy
Li4uDQoNCi1Ub21taQ0KDQo=
