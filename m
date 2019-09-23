Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9003C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778AE207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VqxtY4qX";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VqxtY4qX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503227AbfIWWJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:09:59 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:47841
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388713AbfIWWJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc8Tfh34zAPh9+3AfK/FXg9bVZJdBA3AvUnXSOf12GU=;
 b=VqxtY4qXwsDOaAnf00MunlnYis06IjUtlgk+pT9jTSHxm1FE3K7reDi0GaeyawFGdozs1Jlxer0iNSp+3f4FO5TYfS1Uwid5WjpKNS0PYsP+k0ZPxe8mx3sILnaNOOh8kp4nvYieHJs2WQm+KYGBshVreoKRhRgjU83C551u2h0=
Received: from VI1PR0802CA0020.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::30) by VI1PR08MB4160.eurprd08.prod.outlook.com
 (2603:10a6:803:ea::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 23 Sep
 2019 22:09:51 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0802CA0020.outlook.office365.com
 (2603:10a6:800:aa::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23 via Frontend
 Transport; Mon, 23 Sep 2019 22:09:51 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 22:09:49 +0000
Received: ("Tessian outbound 55d20e99e8e2:v31"); Mon, 23 Sep 2019 22:09:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 986c322c4087359b
X-CR-MTA-TID: 64aa7808
Received: from 0f8e15793f5c.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2131CFEF-9C7A-4E04-ACAD-27B878361B4E.1;
        Mon, 23 Sep 2019 22:09:42 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0f8e15793f5c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 23 Sep 2019 22:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moFzZi6DEGuWhiDk8GgugjrnFYLlxqjyFiXJBP/DJRtJ1eu9mBn9yF6ooV64LT4Xj/dPiJqZEMrtFSBGlkJ5ef1gaF0TygR0zKRFRtQPCPvJDlSCiU2jXpkZgux1kw/ooXlzo7q2Wxc69Dgg2KcT6FTFjcfGduggvN/AnsrUxePu7BUJ59Uile9jD0U+j+flkc24PjrWV8/pxYfcjoJE1KeRnCk/JUdF/6u3Re35nfaw6r8mcGZ8RC2HK6h/dZn5QPq5L6CKtEZJSBFKy6tFjtdPQrx9f5ZAze/CF7VZdpDbb2Ly+HkNhsXe8BkiX7SPheMtJTY/ILsOFmg9f8PuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc8Tfh34zAPh9+3AfK/FXg9bVZJdBA3AvUnXSOf12GU=;
 b=Ycgh0T+P4e8GFRezkiZIKbGAnvKAaWyELii+cZSnw3hvcLGSNMh187WzZKCHGagihEvk4zEEKhcCNG1x7PrGtODBtFtfCe2qe0SxA0z+/k+5awVlN9G2DzSJewBapoMDlwvBHBH35kQnXszVEQWBrvVximZmD9romhuEffOGxwkWhxTL5kO4UV081k6F96leYGjlgTZTaE4YMiRm5Pyll5xXqYqpb1/COQY0Uga3ATGOjtCgbv93JCe5QXf+cw5uejct//wof9JCtRdpRJZFSt07tatO8C3YjhMMXNKqwOm7G1jBQf/aMND9WpZIBggHraHRI6i7Xc391puJXEYUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc8Tfh34zAPh9+3AfK/FXg9bVZJdBA3AvUnXSOf12GU=;
 b=VqxtY4qXwsDOaAnf00MunlnYis06IjUtlgk+pT9jTSHxm1FE3K7reDi0GaeyawFGdozs1Jlxer0iNSp+3f4FO5TYfS1Uwid5WjpKNS0PYsP+k0ZPxe8mx3sILnaNOOh8kp4nvYieHJs2WQm+KYGBshVreoKRhRgjU83C551u2h0=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Mon, 23 Sep 2019 22:09:39 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 22:09:39 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RESEND][PATCH v8 3/5] dma-buf: heaps: Add system heap to dmabuf
 heaps
Thread-Topic: [RESEND][PATCH v8 3/5] dma-buf: heaps: Add system heap to dmabuf
 heaps
Thread-Index: AQHVZOOHJe6ZtAME/0aSh1asthmU3Kc57WGA
Date:   Mon, 23 Sep 2019 22:09:39 +0000
Message-ID: <20190923220933.htme33l5naj7r2dy@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-4-john.stultz@linaro.org>
In-Reply-To: <20190906184712.91980-4-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [195.233.151.100]
x-clientproxiedby: DB7PR03CA0054.eurprd03.prod.outlook.com
 (2603:10a6:5:2a::31) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 6ffdfc1f-81db-41f5-7965-08d74072c0bf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB3829;
X-MS-TrafficTypeDiagnostic: AM6PR08MB3829:|AM6PR08MB3829:|VI1PR08MB4160:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4160928CCA68DE254FD79C14F0850@VI1PR08MB4160.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:6108;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(6506007)(26005)(7736002)(81166006)(186003)(52116002)(316002)(99286004)(64756008)(66476007)(66446008)(229853002)(66946007)(4326008)(25786009)(66556008)(446003)(9686003)(386003)(76176011)(6512007)(6246003)(102836004)(7416002)(58126008)(305945005)(476003)(6436002)(11346002)(5660300002)(2906002)(14454004)(71200400001)(71190400001)(54906003)(6486002)(486006)(81156014)(256004)(44832011)(1076003)(6916009)(4744005)(8676002)(6116002)(478600001)(8936002)(66066001)(86362001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3829;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: M7i3YGRSQ365TBmuk/8wzjLkfXTpcMAV4Ap2q6b95T8OAPQMvQEfq+y02eA6gHY26YbrFMLT9b9Y4e3AX4ldUUN7RdZNimiPIazd1nUpItanN5Y5toID/kPIQXrlSG4LXuf2EXFQshjZvnUUW0e5pFO5jtS36CuNsLrkk0GVwzppqgZShlDLjKBTvUdZ5KUOpzQphMzmpoU3gLRC9wgDTqhSgueWG/CDNy5nTKZQxNxT5UczELlPAkhtWfZ5aXdxTnmqPTCPPfgchSI/OQ2q7Bn24cTcna/NYM/RJZjCsVCdWsqFYIR6LMHXXGRoJKkNvu1xcqt/7rhI/6YwJ9ldzHruH0h8n5Ce50TDDDXpDjUoEuK8okUNzDw4+4r6h4U511t6P4hXlYeKWHa8pgzPvGVpP0Ds10QMXfIaBnii0nc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D174ADD896DF4142AD1D0767135D08A7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3829
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39850400004)(396003)(199004)(189003)(229853002)(476003)(47776003)(11346002)(486006)(126002)(446003)(50466002)(66066001)(336012)(86362001)(6506007)(186003)(99286004)(76176011)(23726003)(6116002)(3846002)(386003)(2906002)(14454004)(356004)(6862004)(76130400001)(305945005)(70206006)(70586007)(22756006)(4326008)(26005)(63350400001)(26826003)(36906005)(25786009)(5660300002)(58126008)(8676002)(478600001)(316002)(81166006)(81156014)(6486002)(54906003)(1076003)(97756001)(7736002)(9686003)(46406003)(8746002)(8936002)(6512007)(6246003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4160;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6d0895c4-4de8-4214-0bcf-08d74072ba47
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB4160;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: 5v0N4Q9hMY8DchqpLpVXaFuOsBD8AHUeBUatRFf1gYRdrmhE7MYPvZOtDIexX1VpvLZBhoET52g49qQCE5oUJYwreKBcG8ZeqHvz3uEmltvzq5hUriB4J0h3EQpXAk28l4Vdri8qyCj0OmDw2wk6/N3Ij2R4nZfRHn7AWe0ufbLWJNXVQA/Xv/L6exAQCWM6k5eDoAwJ7LKvEG7H0/nOfMFVEstQxz7un28huOLd584y03tKOrDI9fnSjYVKhwlHzfLwNHwo7OPBAiQEuSgYSEZuZNw32+PxaXmBo5jeMxJ1r10rkzoZkM4sFcUJhTFN4UyjwmW+fcQTWCspJ6vIwcKW+gMAVL/yqDY6UbJpRNMjnUgqFFDCVFAz1oT80brXHQvDd2sFnoR8/FnOCrErhwAWTHJvA6HdtM9pIUomPQk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 22:09:49.9737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffdfc1f-81db-41f5-7965-08d74072c0bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 06:47:10PM +0000, John Stultz wrote:
> This patch adds system heap to the dma-buf heaps framework.
>=20
> This allows applications to get a page-allocator backed dma-buf
> for non-contiguous memory.
>=20
> This code is an evolution of the Android ION implementation, so
> thanks to its original authors and maintainters:
>   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
>=20
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

LGTM:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>
