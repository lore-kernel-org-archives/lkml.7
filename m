Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2C120867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="CuGfyJBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfJFGnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 02:43:01 -0400
Received: from mail-eopbgr10121.outbound.protection.outlook.com ([40.107.1.121]:8580
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfJFGnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 02:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTGBYlNtQzweuGfy1pyZ6QK/41n54LSh+bfL9NJjYnCTv1V68NBkR+jMh1Dpkg66FVYntB5t4mnUfc84V1hIqQV3aDXDGmcCW8VKO9qhchtSbDqeNqGPXftWC3lbhNXWz9RqX+hL7srUTrf3bDTGz1fK4GoMOv4Ox0uDmewUYoRPvXqF78AJldZn1Ooq3jLtJd5jFvzBu1sHKXGEQ1YQ1V8WZEEM4ebYTlW1ZkQr5hHo2Pkx1Qgw8P9aTtCHl/dO44UxE/p4DWEVSb9vc+a6TLdGgLlZPzkOPSjKux4b2VjSCwnDz1UmFI0Bg4wYaFmyZOj32pb6NpBCjXeMqGtl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvhbjw45ipjyS34vGCJUlqLxRLStHqweP5yW593SBU8=;
 b=Jptg+f197jN1CHtxM4iIl2lJ10Dk3d5HHhJbuIEz70IL3z02xVIbXgGvvSpu8XA9GmFkOY14P9899ZjBe8D6Y5q0WmlEqxQVAir6OD9JOU3r5ZVu/dJ6Vq+DcGtDaqE4HBQs2ceZyP8j3iyMbK7cZRYRLXz7M6U6oSNg/A95kGtyQXp4dtYXgfYlETCU6hezWWpkK27gM33j10pdU19oIuKmiW5hbYYi7GDb44cw5LH2aOEyWRg73o48BbTYQxJZjBPhol3WrFXeoUZUDeJfGNCvDiZpfUXIGCxeUy8Z+KGVQbgriF58Grz6ii6A70PQcav/agc1Mydu2mMKQGfp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvhbjw45ipjyS34vGCJUlqLxRLStHqweP5yW593SBU8=;
 b=CuGfyJBhJw1FR3pugS0vgsAc4Z06kxSksjqY6Jdk8M9zAaZJ/wMc3+TB5NvawEp1BQN9wclqiW4r/26TXgDZSZf2oSY5Z/pXMqwVlTRv3yusY+hZo9cEvmWvJf6FCVUJRV6nGo+vHMR5fo1PqpnGONFyr+9OmwxOu/R6dsJiCLw=
Received: from DB6PR02MB3047.eurprd02.prod.outlook.com (10.170.220.21) by
 DB6PR02MB3239.eurprd02.prod.outlook.com (10.175.232.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Sun, 6 Oct 2019 06:42:56 +0000
Received: from DB6PR02MB3047.eurprd02.prod.outlook.com
 ([fe80::79a4:760:a6da:bd12]) by DB6PR02MB3047.eurprd02.prod.outlook.com
 ([fe80::79a4:760:a6da:bd12%3]) with mapi id 15.20.2305.023; Sun, 6 Oct 2019
 06:42:56 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: set TPC Icache to 16 cache lines
Thread-Topic: [PATCH] habanalabs: set TPC Icache to 16 cache lines
Thread-Index: AQHVe0pLCnRCOCVcwkyMEGutMvUcNKdNK6eg
Date:   Sun, 6 Oct 2019 06:42:56 +0000
Message-ID: <DB6PR02MB304787F8E1B8F60099C9EE63D2980@DB6PR02MB3047.eurprd02.prod.outlook.com>
References: <20191005065826.3878-1-oded.gabbay@gmail.com>
In-Reply-To: <20191005065826.3878-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ee77927-44c7-4f3c-8747-08d74a286bb0
x-ms-traffictypediagnostic: DB6PR02MB3239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR02MB3239C8F474B1C57536BCA4B8D2980@DB6PR02MB3239.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0182DBBB05
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39840400004)(136003)(396003)(199004)(189003)(66446008)(305945005)(14454004)(25786009)(81156014)(9686003)(476003)(229853002)(110136005)(55016002)(6636002)(8676002)(81166006)(33656002)(446003)(316002)(11346002)(6436002)(64756008)(76116006)(8936002)(478600001)(66476007)(66556008)(7736002)(66946007)(486006)(74316002)(7696005)(76176011)(256004)(558084003)(6506007)(2501003)(66066001)(52536014)(6246003)(102836004)(5660300002)(2906002)(186003)(71190400001)(71200400001)(4326008)(86362001)(6116002)(99286004)(3846002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR02MB3239;H:DB6PR02MB3047.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhCHup4N2Kz8wXC6sxNUDjFSlylKYGMx+Hof7+eIQVsShPuU6KSXWZWM/AvcYuse3iQpu9AvH1vrgC00tthT1kPBX9iUJ7v5rLW7lRIugwYNumha2eHk22ZsuKd2O6amtQV9U2mMKIlAY7w24Y32sktlf10OGyhwhMpeKZuUmaWolgsvIqwzdSaOZbfKdIDt6B/t3BhmYgCZAQMeHwrbE1hD45tOHPhwsYo76gzZAUYNIc2NG0o3pPSjSRfZWgqcmzRuO5JNGGhJeLV3IZyeOGvNwg4tvcD1naNDmsnx/xRSJaf9/zcQSt33qoqFWwmL1PIrQmDZtFOIpEkJCXhfoRAyiX9YNgalXUOKQW8hKMvULGWsNljhQpckrJeMkqof8YCz/j6JBier4NF9MkcK74bYUNmVOOYqWaKNhYHkdho=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee77927-44c7-4f3c-8747-08d74a286bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2019 06:42:56.0963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLGt5iHSKUZqkDZ+e2GhLQWLruImmQDyBudVPRl79QDnOE7mIggDBrTOWttXDfkrEnII3xvkN5cDRmpe6fU6Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <oded.gabbay@gmail.com>
Sent: Saturday, 5 October 2019 9:58
> Reduce latency to memory during TPC kernel execution.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
