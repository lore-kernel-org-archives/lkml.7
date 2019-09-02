Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8830C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DBC2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Jp99hTKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfIBHsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:48:10 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:59230
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729382AbfIBHsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:48:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTRCwYRbRBw1OkVZFfe2IH5FkBofCPG/bsT7G6DiLpr61XYAEvGzGc+4WN8z8wKb2/9NmWW6lxeMd4n72vdVEAdONM3nvQsmZu868Hb+mDTh0ovTHTh3pP0x5K2pFG6lxDVOhvkr0STAmHMeypf0QXFvlbOXHe7FMkLWajz9utwGyI5lW19xQbizqaMaAdjh/BdkUzj3h9LJDXVYcKrZD7tBh78l+uHRCx+TbkE3DE16y02KVs+jZjVctFfxz4Bhw4J+mpitf39vXOrdA+ODGZmeybsKNzGOxDvJPGlFlLyjQ40cf4pGEKYBJaMQNobE25yN4EVFzdOijU9FkXPMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBMHkxNCV4BE3zQIpRuAzHh6YAd+r+bd7//VdgLt2Eg=;
 b=NV05lg7CIj59lYjRQ0jPr/F8AtO8fdj3BbL8ychjsQmRJtg8fBM4vlln8IdKQgbUKMmWBiOE4/v+FfX0hQQ9oaSov7VAP/As/tDMALNSpzm0DzmdVhyYef3aUuN6IhAkkXNIF1GY4s+dYbw9NKcL1YGoLKhK/MnSohmkNbDQR2eUF8RVNrdLLKonPjju+X8L4klaHU6B26DHrETR6tMUbK1HJEZMZb/udz/rjnnT4Za05pNLvsv6i/XVF0HYcREMC83U7IVBVEdiT+cpKU1CuJtSwGqBtg8PuoKE6560ufFJCURyHi+SwsEcDSYL2iEo7FQ8nNLl5znFWE11dYjMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBMHkxNCV4BE3zQIpRuAzHh6YAd+r+bd7//VdgLt2Eg=;
 b=Jp99hTKAwwUh20QKltQA240Lt/Knxp4IJP9Mra+vODvBrG0M/k64CadwjvY7OZJKRMpDVOBRpNT/0IycVb2ggRH3fjcjelamvLzbRkIvzV45kJhcBx1SjqJWHcb6z2BAUolpOIYxP15KTBa56UVbTOWX2nVbXwQwsnLOC+7ocxM=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3271.eurprd02.prod.outlook.com (52.133.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 2 Sep 2019 07:48:07 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 07:48:07 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/2] habanalabs: add uapi to retrieve aggregate H/W events
Thread-Topic: [PATCH 2/2] habanalabs: add uapi to retrieve aggregate H/W
 events
Thread-Index: AQHVXyGqC//w0xh63EGrqfFS7VsZ6KcYBvhQ
Date:   Mon, 2 Sep 2019 07:48:07 +0000
Message-ID: <AM6PR0202MB3382DF354FBA6628EBDB5270B8BE0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190830105700.8781-1-oded.gabbay@gmail.com>
 <20190830105700.8781-2-oded.gabbay@gmail.com>
In-Reply-To: <20190830105700.8781-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b045447-0bc5-479e-dc72-08d72f79e4ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3271;
x-ms-traffictypediagnostic: AM6PR0202MB3271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB327155A3666E3ED6A8EAF2CCB8BE0@AM6PR0202MB3271.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39840400004)(366004)(396003)(376002)(199004)(189003)(6436002)(6506007)(76176011)(8676002)(81156014)(81166006)(14454004)(99286004)(186003)(110136005)(9686003)(25786009)(316002)(4744005)(33656002)(55016002)(52536014)(7696005)(11346002)(446003)(6246003)(53936002)(102836004)(4326008)(478600001)(26005)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(2501003)(86362001)(3846002)(6116002)(2906002)(66066001)(476003)(486006)(74316002)(7736002)(305945005)(5660300002)(256004)(229853002)(71200400001)(71190400001)(8936002)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3271;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y7Pa1Z1TmI5FxDDHF0PUKTZ31GevZ7StOXkEErWMD0ic43Cjk76QgR08Z0eIEH01oFso1EvyW8TWgKGRxaQxXuuagDMvODPzopaz9a5sx6yzcUVJNANg/zjP2jOjGtBoRjL2osSA8w7HM/cN1GBlusxw0G+i3ZDXpAhNru6xSf/xMFbQ1XPbbkSayAPUbrguwAFpCp5yPE28ChX6MfmBy1qhPOrMx2dpD9X4ppYnNzc3ZYS60g0lauyMlF0n7rcOOEBImOFk2FZSJka4L69R/bAvM+so2DSkRLFhyRngYxbHwc8KYHy2XEefnH3lqMU9BSgLDZI6uBgH2yRzcBnhRm05CpbnATbVu+RId5E0dztrfiX/6gzH7YWYo7S08jLD1Zaa8a6b2GQqZ4DI/fjIA5mTRM5Rg73VYn1IF4EYaCY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b045447-0bc5-479e-dc72-08d72f79e4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 07:48:07.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xt46f7FQk3RzmTNHwtSyptOTjlmnmtViRnwdsuy+/Ac8sFV2QoJeyGIdFKZ1uqmd8KI5j/0Rm1DtQXVOEGiV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IEZyaWRheSwg
MzAgQXVndXN0IDIwMTkgMTM6NTcNCg0KPiBBZGQgYSBuZXcgb3Bjb2RlIHRvIElORk8gSU9DVEwg
dG8gcmV0cmlldmUgYWdncmVnYXRlIEgvVyBldmVudHMuIGkuZS4gdGhlDQo+IGV2ZW50cyBjb3Vu
dGVycyBhcmUgTk9UIGNsZWFyZWQgdXBvbiBkZXZpY2UgcmVzZXQsIGJ1dCBjb3VudCBmcm9tIHRo
ZQ0KPiBsb2FkaW5nIG9mIHRoZSBkcml2ZXIuDQo+IA0KPiBBZGQgdGhlIGNvZGUgdG8gc3VwcG9y
dCBpdCBpbiB0aGUgZGV2aWNlIGV2ZW50IGhhbmRsaW5nIGZ1bmN0aW9uLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IE9tZXIgU2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
