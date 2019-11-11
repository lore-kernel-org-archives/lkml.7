Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFB6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D8D206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="EMDNQgId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKF7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:59:30 -0500
Received: from mail-eopbgr50093.outbound.protection.outlook.com ([40.107.5.93]:13784
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbfKKF73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:59:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEXVD8rD4eveoXGd8jquWVqoGoMVmLYLwpPwpoHhWUecQ2S+BcYcxCoOn8b3zhmb5e8bPOSj3f1920Z4RwY9ZVpa7hE3svAAumaS05C+WhvCZzkByMcuc7EQU0++3//ofsiWud871LT31z/x11MInrzInUFERHKFyKxFpQLjhBZd9hzhMB3fk+HEg1AFUCjOEij8JHSypBsoI9AcvE5qksW5qh6y6z63EsITn9cGKsqD4tR91KYhqeduMYM860LwOXshJB0xpNTd6fOEnNig53Ff3XMlLDp+O3L4baNK1HTSHonMmxlD/Nvg8BWF8evxSoNcSJ+t0cfmIuoWSslHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkntDSEQeiXl187G6hhza/NaqAMtWSWG0svmGMcm08c=;
 b=YCQX0Ardy7szY2iyP/yt6aQNWrUFICpx9FtKwBskw340CaPXoXIEvfwsfbV9pC/M51ui+wi6xA1LUkqvIETUBINvsvQykWjXDmmxt86sDc32CYZQgyNML248AYul0aMB2tSvZEczuPrIIZcXk5MpTo42+j7fcEkLKdsrxM+YbKYqWuBamBbQbivvdLdQ/NSQQSfFZO7TrVw5BKEhYmR6UWvEGcUm6QT28NYvYkLTlT+INhsppRh/YCKO7VW+Gt0OEQU5gEQe4U8tDXaSOvkZdMgcNQfv6aXmtEWWXMWis6riS3qaFD2ZBOqXKEpG2CiLXeO60nw+tF2eBi5tFSw4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkntDSEQeiXl187G6hhza/NaqAMtWSWG0svmGMcm08c=;
 b=EMDNQgIdAFkNzQHR3PsXLo3CGaIJZBf591cD6n9V+2JA18qRyjF2R8PKJ1oo7gKjwLofbxpZFH8mg0YI3jK+Vc4ZGzVunriymz8UAig72sXI7m1DadOcEf5PFjQZW/mslOC+3/tA3Unzr3PYLV8RCpaYXNl876frSdeIpmjs0DE=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3270.eurprd02.prod.outlook.com (52.133.9.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 05:59:26 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 05:59:26 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/6] habanalabs: use registers name defines for ETR block
Thread-Topic: [PATCH 2/6] habanalabs: use registers name defines for ETR block
Thread-Index: AQHVmBGXzP5oj/bLykOK4tAyAU2z8aeFegPA
Date:   Mon, 11 Nov 2019 05:59:26 +0000
Message-ID: <AM6PR0202MB3382B0CF785032440FE9FBE0B8740@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
 <20191110215533.754-2-oded.gabbay@gmail.com>
In-Reply-To: <20191110215533.754-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.8.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6867a231-d2e9-4bcc-f12d-08d7666c4ef9
x-ms-traffictypediagnostic: AM6PR0202MB3270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB3270553F2A9F86CCF96C1080B8740@AM6PR0202MB3270.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39840400004)(136003)(376002)(199004)(189003)(4326008)(476003)(26005)(229853002)(11346002)(7696005)(66066001)(186003)(256004)(102836004)(6436002)(446003)(5660300002)(86362001)(52536014)(9686003)(6636002)(6246003)(486006)(55016002)(71200400001)(71190400001)(53546011)(6506007)(76176011)(74316002)(305945005)(7736002)(66946007)(2906002)(66476007)(33656002)(3846002)(6116002)(66556008)(66446008)(81156014)(8936002)(81166006)(8676002)(2501003)(316002)(478600001)(558084003)(99286004)(25786009)(14454004)(76116006)(110136005)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3270;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9MmVpEHrBJDYvynQSP8cOMvYZWmFt5EHSEoQfByWQNObk4npF9+LsGBnzOuUDwohYCi8lVanoR4eQeMQwsNjMyNBJRsgwGZLFbRh9/rHOrX5C0g89XxKed8NYK349rgzcDRNgr3iWinglodnzuo0BxieZC5aHoGzfHDKcoE0aFxcV9cKNFZXygRx5rBKxy/DgMv3VXlMj+6xGaltvafOMWfESXGsiLlj1PFoCsO2vZ9Vuvf2duLyY074TpMPGE5Br19fsRCizDzYFqew7omeGz3bBkXxOZgDR6+8NTrb8GQC5uRNWg6ZF0sGTRFOD/YL3WIpFc4VtWC/Xkpg/96naIW+NwSKRZAnzf8JooLwASEhbL77r0u1tSXXmmxua+m/XB4OeKtp9JNADmJCOLVaXYFGOHt77wsga1VJkWbHJYqRI6Hvml+pGyFYU2JJHBB2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 6867a231-d2e9-4bcc-f12d-08d7666c4ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 05:59:26.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqgZgMpaKKYLUvDvOiHsNpFOTNy6BTjgX8/0Z3I+Z7y9BKoUeKRZyBNDK0Y+vnJsuij73htj05e1Rwv+1nis5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBOb3YgMTAsIDIwMTkgYXQgMTE6NTUgUE0gT2RlZCBHYWJiYXkgd3JvdGU6DQo+IFdl
IGhhdmUgYSBzaW5nbGUgRVRSIGJsb2NrIGluIHRoZSBTT0MsIHNvIHVzZSBleHBsaWNpdCByZWdp
c3RlciBuYW1lIGRlZmluZXMNCj4gZm9yIGluaXRpYWxpemluZyB0aGlzIGJsb2NrLiBUaGlzIG1h
a2VzIGl0IG1vcmUgcmVhZGFibGUgYW5kIG1haW50YWluYWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBP
bWVyIFNocGlnZWxtYW4gPG9zaHBpZ2VsbWFuQGhhYmFuYS5haT4NCg==
