Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF42CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6E620873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="CKC9r7Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfJOIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:01:23 -0400
Received: from mail-eopbgr130107.outbound.protection.outlook.com ([40.107.13.107]:39399
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbfJOIBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXZ9c/PbrA7zNDSWZV70C1Iz+xxqeVSagpve4BtKtFMJskk/g6DeZu2bqbBAHEF+vFrMj8Mc9yU87rYEOp3MJNIk8eWEL5iNSHOa65y/V3V0SeBmZoUn6QKPPKnTVk9a5rmd0qrbDHt/zgYKvT/Wi0rq4SRuXjS5KTOgdZeQPQuZcSjlSZezXo4RkIvpvGQRKWvaUb+mRGGGVlzqt7z1nBGD/CiQSX7Zbc5A/ZXVla+X/GQwX2orm32AAs9zi63BFKYWAd89oA9dsK4OuPlQ3rcBO7ssAl8ebOOxvUZyYHUEiaf6ed0U6y3m06oNWuaCZsNq5UxB9GhbR75pHoTjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CanRzWxUV3skfWcURtjRsZ0tjir3svbeykUfH5I/cb4=;
 b=D6PPXig6rGeHTiD9vNjc0PZb0swy1bUq94ZYYMuld8fZDmi59tKpP4VB0a2A2xGg2pyd8zPHpxcDTe75OJ0tr3lmyZlBZdWDlbKw7m5LJv/7QVDQS6ClVf6MYDg42UsmC9llV6CS+Kp8zzE1xBFNB4Av6rbqOtnjfasq1FsH9x1JoA+sOSzs9WcTfEkr0M/HoBPqnglpqBFLZb2rvZDwlJXE9PWtSS5SvHD3iSisKSyOBBFXE3WVS2olGQTCU+DWURpq49Rva7jem2q+S0xOFIncyCUfsEReYXc/IjnLGKXBgt6619+ursEAJ0Pm64mZ5GRPt42UuyLBdsEFrqWPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CanRzWxUV3skfWcURtjRsZ0tjir3svbeykUfH5I/cb4=;
 b=CKC9r7BfS2PFeWaQ3YihctCWsUJiGYumZfOTyuvG8jOOiqmL52dfL4OxhRxGNSvIsnp5mDquVW8WcwukUqyWZvks5iGvxBRcMEgq759yCAQnx2ySGLaYALcBxajWLPIULbvvASSktRzAZgboHH6FgQkOUViOfnc9/h3xj4PbxLc=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.175.244.155) by
 VI1PR02MB3888.eurprd02.prod.outlook.com (52.134.25.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 15 Oct 2019 08:01:17 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::5189:b8e8:918d:c74c]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::5189:b8e8:918d:c74c%6]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 08:01:17 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: add opcode to INFO IOCTL to return clock rate
Thread-Topic: [PATCH] habanalabs: add opcode to INFO IOCTL to return clock
 rate
Thread-Index: AQHVgAR5rouOoVlvqUikfk+CUgp/V6dbXKXA
Date:   Tue, 15 Oct 2019 08:01:17 +0000
Message-ID: <VI1PR02MB3054975B6C8A3732C0E647C0D2930@VI1PR02MB3054.eurprd02.prod.outlook.com>
References: <20191011072113.4992-1-oded.gabbay@gmail.com>
In-Reply-To: <20191011072113.4992-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-originating-ip: [2.55.130.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bfbe4c4-a2d0-4a28-3cbb-08d75145dba7
x-ms-traffictypediagnostic: VI1PR02MB3888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR02MB3888335917BA67FF0B3580CED2930@VI1PR02MB3888.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39840400004)(396003)(366004)(199004)(189003)(66556008)(6436002)(8676002)(25786009)(305945005)(7736002)(110136005)(9686003)(316002)(71200400001)(64756008)(256004)(66476007)(66446008)(66946007)(71190400001)(2501003)(558084003)(55016002)(81156014)(81166006)(74316002)(33656002)(7696005)(76176011)(486006)(229853002)(99286004)(6506007)(53546011)(102836004)(26005)(5660300002)(11346002)(52536014)(446003)(66066001)(476003)(186003)(76116006)(6636002)(4326008)(2906002)(6116002)(3846002)(478600001)(6246003)(14454004)(86362001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3888;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vf+9Efh5xE2NZrecLw/d1naKuBQrYI0ls/f2nKEscnVXNbFtF1kHvyVTh+4Fgpk7oz9tMILS46cs29k/fqLZF81Z/c14Lh2d9GRbBfYMFVsvs4Xxuay6AQqbMc6ZMLeyLz/NQwXWNm9W1M2fXz7T2ypkA018iZpGZcoNju9tQzQzBzJqQbQnyjk9/hWysPwoBqBRgIXL+BKopYQNgIRngPdH8RE66q7ej7X/jV+W0w+H96jE1saomb2obyQbS5b/CLSToVsf8N3LTKY8af0GtdxVcfyXf/kmVLG5H8l6PmOCvAuXpJRjKxe7NOTR3AAl7SMpHqE7oZpf7ExPs3HMlW7FZVkIvru8m90OyyXBWw6vtEZH8ZYbYZkX3cRdnqQH/c3oFZ0BUVINFGYoJe7i5PyUECPKmYxCnTMYkeTC+DM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfbe4c4-a2d0-4a28-3cbb-08d75145dba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 08:01:17.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyRcDOhkdb9dJ7AsMBJz1tZwL2MD65kbAUj4kQ2Q4rSwPkk/SRymyOTTcneSnmpsP383cG7O8bUhoO+l15083Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3888
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:21 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> Add a new opcode to the INFO IOCTL to allow the user application to
> retrieve the ASIC's current and maximum clock rate. The rate is
> returned in MHz.
>=20
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
