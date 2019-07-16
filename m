Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C20C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1638820659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MHx4fb8z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="E3MHzowp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfGPUX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:23:28 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:49040 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728575AbfGPUX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:23:27 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 52795C01D7;
        Tue, 16 Jul 2019 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563308604; bh=CG0uLvziQuRhYQEQ927zN/+rv7rwcVJ1fR/mpnS3VyY=;
        h=From:To:CC:Subject:Date:From;
        b=MHx4fb8zzg4KC5QkrxmuqlZJdwAMHQjb6z77U1pO71aHKV/6H7FjwDgnvFBfuVuXt
         GkPTl37ZacwoispME90O4j/ZRRPCWdtgkErnxlzbjYU8r9dqGezeKe/CISRXniIint
         XZzsadxuwGqWlxueBJ3fUIhxob58q2AnCKa6Lzsnz6JCxfLf9Ilms+4udcgMEpJSwx
         3ZILFfIY5yMiUnnEK5RrkijcYob+pgXtAEJ8+Xd8yvpkO2V74j4YSsFsyasek8Ftdf
         dPSt2bnPO7WJGCEPsrb9Yi1MOM39v2GAT2dR7ZL1XwNhCkp8JiWann18yDDhZHylG4
         0JDn8QTNE+3DA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E1A9AA006D;
        Tue, 16 Jul 2019 20:23:11 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 16 Jul 2019 13:23:01 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 16 Jul 2019 13:23:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2J8UNbWTdn2FZuhT+JUAbjkc6cuocDF2jrRYoI8fiBpLi6d6lTgKJ0DhxUlSwieVKcjgpllI+3RihjsGNy+CKaGKDEwxWd0sop+eGCCqoq61WJan0vOpVbBqtTVD3OxAlpPG0R/0hnDINCQGOrkuIHX6xFR2/0bYGdzh1XylARXaKmxqXOBur8cfo8WJ0sWHNrHPli45tsj58yKa2qLDPLTsuO7nE/VLN3g2QH1+dm6c0itbtAZanoVO13GbRzlB2nQseVFdxhe5lMeKSx5tDYfP9pbN/1GaF1ZpYsaNjFuln7TpZfZzK7K2v+dJ4/TieVpnLSuFE9syG03Nzk02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG0uLvziQuRhYQEQ927zN/+rv7rwcVJ1fR/mpnS3VyY=;
 b=ZULAnuPO1gcecWCmcskHtQr40r70yztPmWYN/Pr7d2v26ZTcKPCo5PqUwvY4mAfR5pU/Lm8UTUOOtLMPUIZts+ZqBqFmHYaNInBFt0QrConxOPmCgamxp5hBnaMgWz+bozfs+xFfOY/XbyyvEmVfqnMDQGG1dVkXecbwFBJCVVx2akqt9Axn+yNsqRMFTiMjCw+KOzCFzOBQF4pgUj5dOKCCuPHNQqDlK+U0XbHOYb07Yd1HaQaJ1EHLdRAjAtx0rx4GZlWL6Yq6oSUZN4tdTF/rihf4qToe2ZNaM3muX2xn9xEKA4Ka9KH0q+8IqDkHLuaNKfE9w1G//xEcMZ9zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG0uLvziQuRhYQEQ927zN/+rv7rwcVJ1fR/mpnS3VyY=;
 b=E3MHzowp++e4w2Z5JmSaZvEfwAe2bRvyLQJ+aHZOVhPUU9Y0ZoWBhPmbK3wi+gVr6bQ5HvaRnctW2ohS7AKtqSA79nwgaY+3TaXYICWl4n+R51t4LDon0KDQRA6zC88+98d3MeETVAgpUZXXq1Gg0eAQtJdxbEGUboRGjRrw/Fo=
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com (10.174.238.140) by
 BN6PR1201MB0130.namprd12.prod.outlook.com (10.174.116.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 20:22:58 +0000
Received: from BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c]) by BN6PR1201MB0035.namprd12.prod.outlook.com
 ([fe80::24a0:9726:b1f7:fb3c%11]) with mapi id 15.20.2073.012; Tue, 16 Jul
 2019 20:22:58 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: [GIT PULL] ARC updates for 5.3-rc1
Thread-Topic: [GIT PULL] ARC updates for 5.3-rc1
Thread-Index: AQHVPBRCHpBudYy3jUKEd/4lOklWzg==
Date:   Tue, 16 Jul 2019 20:22:58 +0000
Message-ID: <99fc2ead-d7d8-1c54-b493-02e79e2fc24e@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
x-originating-ip: [198.182.56.5]
x-clientproxiedby: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To BN6PR1201MB0035.namprd12.prod.outlook.com
 (2603:10b6:405:4d::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mozilla-news-host: news://gmane.comp.lib.uclibc.buildroot:119
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dc1aba6-fe58-4c90-4a7b-08d70a2b6491
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR1201MB0130;
x-ms-traffictypediagnostic: BN6PR1201MB0130:
x-microsoft-antispam-prvs: <BN6PR1201MB01303856C7226012CFC42918B6CE0@BN6PR1201MB0130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(5660300002)(65956001)(3846002)(54906003)(6116002)(14454004)(305945005)(66066001)(25786009)(36756003)(65806001)(6916009)(7736002)(68736007)(14444005)(58126008)(256004)(316002)(64756008)(66556008)(31686004)(52116002)(2616005)(66446008)(6506007)(102836004)(386003)(15650500001)(186003)(26005)(66476007)(99286004)(2906002)(65826007)(81166006)(6512007)(81156014)(53936002)(8936002)(71190400001)(478600001)(64126003)(6486002)(476003)(31696002)(66946007)(8676002)(86362001)(4326008)(71200400001)(6436002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR1201MB0130;H:BN6PR1201MB0035.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZiivyXrEGRU46+R9h4Qw6C9Uk8ylK5NY4YpoNwKNPdnOL2v7m73UNQy2/lndYa5u3m9DQWAFE8tX476GsH4CAm00Pl0kI1AmdXY1JUjcnMzKtJQY2QxdSDb93uJWCryY1o19SWyBAN9nCgkmmt1lglvwz9WLklV2sk93K47vyMz/jxC7m43tvURaVcMVU2Uv/zuh0No3oJN3Nj1gKMYOAZOKD7sbbKXaS1XGxTNTvMIoaxJjM+gGoHYuwNtU75r1u7fglm2El4iJ+mG7/uoiFQuSN00HoSfQbNZue3sllI2FvzJiQaxo1MQfqWunZK+Fbtm1kyi19SWCukdyrK+NthJSIZbc/RahV16IrXsJyoKA/5k3gIpTt9TkhV3yQJa9BVfHmq4bLQoyeTFOjTb6LzJglFZpUm5bqOdIB6JWWHg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF1BC1D8C4EED74194E7553D842DD627@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc1aba6-fe58-4c90-4a7b-08d70a2b6491
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 20:22:58.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgupta@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0130
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkJ1bmNoIG9mIGNoYW5nZXMgZm9yIEFSQywgc29tZSBsb25nIGR1ZSwgZm9y
IHRoZSBuZXcgcmVsZWFzZS4gUGxlYXNlIHB1bGwuDQoNClRoeCwNCi1WaW5lZXQNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLT4NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNmZi
YzcyNzVjN2E5YmE5Nzg3NzA1MDMzNWYyOTAzNDFhMWZkOGRiZjoNCg0KICBMaW51eCA1LjItcmM3
ICgyMDE5LTA2LTMwIDExOjI1OjM2ICswODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBnaXQg
cmVwb3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdmd1cHRhL2FyYy5naXQvIHRhZ3MvYXJjLTUuMy1yYzENCg0KZm9yIHlvdSB0byBm
ZXRjaCBjaGFuZ2VzIHVwIHRvIDI0YTIwYjBhNDQzZmQ0ODU4NTJkNTFkMDhlOThiYmQ5ZDIxMmUw
ZWM6DQoNCiAgQVJDOiBbcGxhdC1oc2RrXTogRW5hYmxlIEFYSSBEVyBETUFDIGluIGRlZmNvbmZp
ZyAoMjAxOS0wNy0wOCAwOToyNDo0NyArMDEwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQVJDIHVwZGF0ZXMgZm9y
IDUuMy1yYzENCg0KIC0gbG9uZyBkdWUgcmV3cml0ZSBvZiBkb19wYWdlX2ZhdWx0DQoNCiAtIHJl
ZmFjdG9yaW5nIG9mIGVudHJ5L2V4aXQgY29kZSB0byB1dGlsaXplIHRoZSBkb3VibGUgbG9hZC9z
dG9yZSBpbnN0cnVjdGlvbnMNCg0KIC0gaHNkayBwbGF0Zm9ybSB1cGRhdGVzDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CkFsZXhleSBCcm9ka2luICgxKToNCiAgICAgIEFSQzogW2hhcHNdIEFkZCBWaXJ0aW8gc3VwcG9y
dA0KDQpBcm5kIEJlcmdtYW5uICgxKToNCiAgICAgIEFSQzogaGlkZSB1bnVzZWQgZnVuY3Rpb24g
dW53X2hkcl9hbGxvYw0KDQpFdWdlbml5IFBhbHRzZXYgKDIpOg0KICAgICAgQVJDOiBbcGxhdC1o
c2RrXTogZW5hYmxlIERXIFNQSSBjb250cm9sbGVyDQogICAgICBBUkM6IFtwbGF0LWhzZGtdOiBF
bmFibGUgQVhJIERXIERNQUMgaW4gZGVmY29uZmlnDQoNClZpbmVldCBHdXB0YSAoMTQpOg0KICAg
ICAgQVJDOiBtbTogZG9fcGFnZV9mYXVsdCByZWZhY3RvciAjMTogcmVtb3ZlIGxhYmVsIEBnb29k
X2FyZWENCiAgICAgIEFSQzogbW06IGRvX3BhZ2VfZmF1bHQgcmVmYWN0b3IgIzI6IHJlbW92ZSBz
aG9ydCBsaXZlZCB2YXJpYWJsZQ0KICAgICAgQVJDOiBtbTogZG9fcGFnZV9mYXVsdCByZWZhY3Rv
ciAjMzogdGlkeXVwIHZtYSBhY2Nlc3MgcGVybWlzc2lvbiBjb2RlDQogICAgICBBUkM6IG1tOiBk
b19wYWdlX2ZhdWx0IHJlZmFjdG9yICM0OiBjb25zb2xpZGF0ZSByZXRyeSByZWxhdGVkIGxvZ2lj
DQogICAgICBBUkM6IG1tOiBkb19wYWdlX2ZhdWx0IHJlZmFjdG9yICM1OiBzY29vdCBub19jb250
ZXh0IHRvIGVuZA0KICAgICAgQVJDOiBtbTogZG9fcGFnZV9mYXVsdCByZWZhY3RvciAjNjogZXJy
b3IgaGFuZGxlcnMgdG8gdXNlIHNhbWUgcGF0dGVybg0KICAgICAgQVJDOiBtbTogZG9fcGFnZV9m
YXVsdCByZWZhY3RvciAjNzogZm9sZCB0aGUgdmFyaW91cyBlcnJvciBoYW5kbGluZw0KICAgICAg
QVJDOiBtbTogZG9fcGFnZV9mYXVsdCByZWZhY3RvciAjODogcmVsZWFzZSBtbWFwX3NlbSBzb29u
ZXINCiAgICAgIEFSQ3YyOiBlbnRyeTogY29tbWVudHMgYWJvdXQgaGFyZHdhcmUgYXV0by1zYXZl
IG9uIHRha2VuIGludGVycnVwdHMNCiAgICAgIEFSQ3YyOiBlbnRyeTogcHVzaCBvdXQgdGhlIFog
ZmxhZyB1bmNsb2JiZXIgZnJvbSBjb21tb24gRVhDRVBUSU9OX1BST0xPR1VFDQogICAgICBBUkN2
MjogZW50cnk6IGF2b2lkIGEgYnJhbmNoDQogICAgICBBUkN2MjogZW50cnk6IHJld3JpdGUgdG8g
ZW5hYmxlIHVzZSBvZiBkb3VibGUgbG9hZC9zdG9yZXMgTEREL1NURA0KICAgICAgQVJDOiBlbnRy
eTogRVZfVHJhcCBleHBlY3RzIHIxMCAodnMuIHI5KSB0byBoYXZlIGV4Y2VwdGlvbiBjYXVzZQ0K
ICAgICAgQVJDdjI6IGVudHJ5OiBzaW1wbGlmeSByZXR1cm4gdG8gRGVsYXkgU2xvdCB2aWEgaW50
ZXJydXB0DQoNCiBhcmNoL2FyYy9ib290L2R0cy9oYXBzX2hzLmR0cyAgICAgICAgfCAgMzAgKysr
DQogYXJjaC9hcmMvYm9vdC9kdHMvaHNkay5kdHMgICAgICAgICAgIHwgIDE0ICsrDQogYXJjaC9h
cmMvY29uZmlncy9oYXBzX2hzX2RlZmNvbmZpZyAgIHwgICA1ICstDQogYXJjaC9hcmMvY29uZmln
cy9oc2RrX2RlZmNvbmZpZyAgICAgIHwgICA1ICsNCiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9lbnRy
eS1hcmN2Mi5oICAgfCAzNjEgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCiBh
cmNoL2FyYy9pbmNsdWRlL2FzbS9lbnRyeS1jb21wYWN0LmggfCAgIDQgKy0NCiBhcmNoL2FyYy9p
bmNsdWRlL2FzbS9saW5rYWdlLmggICAgICAgfCAgMTggKysNCiBhcmNoL2FyYy9rZXJuZWwvYXNt
LW9mZnNldHMuYyAgICAgICAgfCAgIDcgKw0KIGFyY2gvYXJjL2tlcm5lbC9lbnRyeS1hcmN2Mi5T
ICAgICAgICB8ICA2MiArKy0tLS0NCiBhcmNoL2FyYy9rZXJuZWwvZW50cnktY29tcGFjdC5TICAg
ICAgfCAgIDIgKy0NCiBhcmNoL2FyYy9rZXJuZWwvZW50cnkuUyAgICAgICAgICAgICAgfCAgIDQg
Ky0NCiBhcmNoL2FyYy9rZXJuZWwvdW53aW5kLmMgICAgICAgICAgICAgfCAgIDkgKy0NCiBhcmNo
L2FyYy9tbS9mYXVsdC5jICAgICAgICAgICAgICAgICAgfCAxODUgKysrKysrKystLS0tLS0tLS0t
DQogYXJjaC9hcmMvbW0vdGxiZXguUyAgICAgICAgICAgICAgICAgIHwgIDExICsrDQogMTQgZmls
ZXMgY2hhbmdlZCwgMzc3IGluc2VydGlvbnMoKyksIDM0MCBkZWxldGlvbnMoLSkNCg==
