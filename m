Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D50C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288B1206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="p5taEsjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfIPLIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:08:20 -0400
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:1154
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfIPLIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN/NwvFvlPORIdD9hLvhvW/aXLZkenI0I+05dFT4Dw71QSi2YbI306RhMrr8EPaHneWl5ot7m9dMPyiqPLUGK6tiC/l48LjfGxRWroh8R/inO12tXb5EKL2I6Me8SLAZsyV3iYJanQ/W40eNcVE7vgduacVcGSwZl74a1KpBKmlX1vdmJKgsQtlZgyLYqGmGh7wCWWgqi4CyarsojJmy3i2xFgJLm8u7JNxgehuKWUzF1/kq7LjSM78qladBYmBXZpRfryLDPRtWbQSfRyGKU850mwv9FtzrBpCICnFyK6mexZCUCJhZL5nUyyECrhRwWPAjp9DHdF9myGiUvtrXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okybqE2nhxKZl1HSKfDWzQRyhZXYWFg4In5kOUOK6Zo=;
 b=ZvFNLpLFQ6SwWeH2qnWUrSMyi7pZYM11iR7Gt2NqSBnluwlc/Bep0avuNQnCKLtuHCzrBlyVOTkKNKOuXOD19jrRzEQzbdfe5IPL8IrxfDr5DasypzgxRmTTh16NtGnP9YpUchI9N5EeYuy7bnriJVtCRQtlumAP/P2kIGpia61tleV2LFcp2uhuMKyaqiplTcf0V7Toik7cXms+zpwK1gQVAUK/Z9MpWUIiTvM6M1jVGcC1zI5X8HaJ80+0JYFEpahJeWUgn86Ip8GkogQFwcQb8/7V3XE40kbf/HymQDYlLp4I4YlKSICca4C+tHtfhcDig/R4T15fx2QkRjwDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okybqE2nhxKZl1HSKfDWzQRyhZXYWFg4In5kOUOK6Zo=;
 b=p5taEsjfMJpeDJViySPR4WxdDVM4XJOF54TZ3svSN3yqMrJjG7BSLIJHuwb1iaVeotadx7Kxbo9s0BuBsrlk7DqDFqVdNWBLd+bTCCu0TeLlhrGoBTtZkTsDYxyQtFba7FMX3aQS43unQ41sN5eG/jpERtjJ1BsK1Nt1WaHMSbo=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3822.eurprd02.prod.outlook.com (52.134.24.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Mon, 16 Sep 2019 11:08:14 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::11e9:160b:3f2e:3bb]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::11e9:160b:3f2e:3bb%2]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 11:08:14 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: handle F/W failure for sensor initialization
Thread-Topic: [PATCH] habanalabs: handle F/W failure for sensor initialization
Thread-Index: AQHVbGyl9IooWTKLKEWhHRLGPZ4efacuJAZQ
Date:   Mon, 16 Sep 2019 11:08:13 +0000
Message-ID: <VI1PR02MB3054FC1874E1E840502D298DD28C0@VI1PR02MB3054.eurprd02.prod.outlook.com>
References: <20190916085626.1085-1-oded.gabbay@gmail.com>
In-Reply-To: <20190916085626.1085-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64353603-25b8-4b3c-c841-08d73a962b5e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR02MB3822;
x-ms-traffictypediagnostic: VI1PR02MB3822:
x-microsoft-antispam-prvs: <VI1PR02MB38225D75F8B1275834A2FB0FD28C0@VI1PR02MB3822.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(376002)(346002)(39840400004)(189003)(199004)(8676002)(81156014)(6246003)(81166006)(478600001)(4326008)(8936002)(25786009)(14454004)(7736002)(55016002)(305945005)(6436002)(53936002)(33656002)(2906002)(9686003)(74316002)(229853002)(99286004)(86362001)(6116002)(3846002)(76116006)(64756008)(66946007)(71200400001)(71190400001)(66556008)(66476007)(66446008)(102836004)(558084003)(5660300002)(52536014)(11346002)(476003)(446003)(7696005)(6506007)(76176011)(316002)(66066001)(256004)(186003)(26005)(2501003)(486006)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3822;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iDuood+80JnL8BbArVkCcxXMQHlO0jwHsC34m9h5p2n9Pt923GZNrRZL2mb79fOSUS6k+uBMw37YHE4bNt3Gt5J2U7LX/h87aIXa9kypdslC80GngxrAIDNobJ73+FXd7D8AhB34M57FTS6U2kho1YwpxAf6cvpXwY9afRkRmMK0jjXR7/N1i6dL0S/nHTBUfk2AI1ehvnmSwKHYRX29hWvg3XD3XBgL2Gt01vOOGSzVQeJZ3+3CK/kuUSilzZ0YU+1K5jkEo9j8VPEBwzns2YRmNkuuO6ocl1QoUTK+FW/GBhx7D19sXAceaVwa2xmvYbAwW52Cb/Kw2Pz4JTmUSYTkzUkbqy4mEqLsn6wh/hsmdwxc5Q2ie5NNy2rziO4y9eZ51oCsEiI0fojVLtEgsAzcLd6UsQas5cZpTKg+8+0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 64353603-25b8-4b3c-c841-08d73a962b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 11:08:14.0723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHfC7qHUBYM4klm0YrFfOu5h0KLUN2TtsB07p1Neqc2WAsHRrMzH6e8jBL2o/w6Y7Tv6arc5thBtq7G7LOQdCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <oded.gabbay@gmail.com>
Sent: Monday, 16 September 2019 11:56
> In case the F/W fails to initialize the thermal sensors, print an
> appropriate error message to kernel log and fail the device
> initialization.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>

