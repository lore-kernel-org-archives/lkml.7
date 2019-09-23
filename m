Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351FC432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3A20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5f3IB297";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5f3IB297"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503237AbfIWWKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:10:15 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:18885
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388455AbfIWWKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AzploTuVwFsMI06k76KZYFgDdpT9L7tfPDQCifWLUo=;
 b=5f3IB297/v9a06qvH4USM1PIruWZ2G4XyDxvgRkOJiTn6dKnh4ajOgWgNO1NR5HK94JCYv/EyAR/fe7SfYLtWIgnh2jrd1COarl2jFD/W6jbb+cIcon1n4txYLc7KRz5/Q21JBiJZOcHQB0EJfe3JYHCi0rbijXglhEPntpjHVc=
Received: from VI1PR08CA0188.eurprd08.prod.outlook.com (2603:10a6:800:d2::18)
 by AM4PR08MB2642.eurprd08.prod.outlook.com (2603:10a6:205:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 23 Sep
 2019 22:08:24 +0000
Received: from VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by VI1PR08CA0188.outlook.office365.com
 (2603:10a6:800:d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Mon, 23 Sep 2019 22:08:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT010.mail.protection.outlook.com (10.152.18.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 22:08:22 +0000
Received: ("Tessian outbound 5061e1b5386c:v31"); Mon, 23 Sep 2019 22:08:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6733263cbfd8902e
X-CR-MTA-TID: 64aa7808
Received: from a350a2b54642.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E3E7A4FC-3CBD-4EE3-BBEF-73A80B84B68B.1;
        Mon, 23 Sep 2019 22:08:15 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a350a2b54642.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 22:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2EfnDbYmH7wtnD6Wr940xLmnyi0geXBp4MZqHXYWNXOXvo5AxbeUzfWQwyyWJ7EyP+/VQhq/vvxNSDSum+JnzaBjDolJz8OQ0kp9DEjiFD0HUsngWRGHMEmvDOea46sxOjyJc2LUN5GLXN9+OIe0/tvJvEtqP/kFA0T/VTcj8CaxZaTrTEo4hhbXYLjaD0fr1nAXFqoKhbGtKWJ69D6/DbRNUmZiutkyGDFH3Rr0ws31JIbZUcvzUuP+HW7fuPakbg2vDQLIsv/gP2Qg1kRzQ4fns0K+Pcaw1WPsJI3az7gTMO/IyBHB1fb2ZJeKJs5kVnU4E4X3UtBpeg7TsrddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AzploTuVwFsMI06k76KZYFgDdpT9L7tfPDQCifWLUo=;
 b=n9ATfWoXXh/7Z9pYLE08xFbjrJu+pGeILxgsIqH9cl0NNiNyOSgfePIZzt4JPkpMpC7s1JKA0Wk3LsZIfXa5tBmD0MZ6AwPsb/m5I2C2HPnyRVDCkWmJgO3s9eCQ5zcHKPMM7Z2D7pirBmbYk0jCZ/Gv8KljieVExakcY80ue7XSQ3H7s/e0n1a7mvUMu3miSjuCGTvs5BRjiaA6VbnlcJo0a55ny2C9WJKFCHCR/fN8EPaIz1lV6AdVxE891pffT7xq2JN2GT6bLBBvOrg/QGsNPEdamAbpQ7IGx579Dw/uemRor/K0u2qvi+HGab+qLfhoqazuABT6iG0mchMD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AzploTuVwFsMI06k76KZYFgDdpT9L7tfPDQCifWLUo=;
 b=5f3IB297/v9a06qvH4USM1PIruWZ2G4XyDxvgRkOJiTn6dKnh4ajOgWgNO1NR5HK94JCYv/EyAR/fe7SfYLtWIgnh2jrd1COarl2jFD/W6jbb+cIcon1n4txYLc7KRz5/Q21JBiJZOcHQB0EJfe3JYHCi0rbijXglhEPntpjHVc=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Mon, 23 Sep 2019 22:08:14 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 22:08:14 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RESEND][PATCH v8 1/5] dma-buf: Add dma-buf heaps framework
Thread-Topic: [RESEND][PATCH v8 1/5] dma-buf: Add dma-buf heaps framework
Thread-Index: AQHVZOOEQkMSgLmukEqMxYT6yyq9FKc57PqA
Date:   Mon, 23 Sep 2019 22:08:13 +0000
Message-ID: <20190923220807.zuqxthydxybjgoog@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-2-john.stultz@linaro.org>
In-Reply-To: <20190906184712.91980-2-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [195.233.151.100]
x-clientproxiedby: AM3PR07CA0090.eurprd07.prod.outlook.com
 (2603:10a6:207:6::24) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4c88b69a-d6ed-42aa-1c6a-08d740728cdc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB3829;
X-MS-TrafficTypeDiagnostic: AM6PR08MB3829:|AM6PR08MB3829:|AM4PR08MB2642:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB2642DBEB5F454159A9EDAB5CF0850@AM4PR08MB2642.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(6506007)(26005)(7736002)(81166006)(186003)(52116002)(316002)(99286004)(64756008)(66476007)(66446008)(229853002)(66946007)(4326008)(25786009)(66556008)(446003)(9686003)(386003)(76176011)(6512007)(6246003)(102836004)(7416002)(58126008)(305945005)(476003)(6436002)(11346002)(5660300002)(2906002)(14454004)(71200400001)(3716004)(71190400001)(54906003)(6486002)(486006)(81156014)(256004)(44832011)(1076003)(6916009)(8676002)(6116002)(478600001)(8936002)(66066001)(86362001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3829;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: nEwgbpN0NOJiiVlt9QBL1//niqJdFMYbxGi5V04Y6rfEZjxKU1Uz5hE9Mb5z/VzkZoFvIXHyK2R9RFDJ3WASQTymDcbzY2mnfD6ELWu2woRifxAwHaTxgT5bSd2ZnPI15lfPxb6tFbMZz+4VMMXYCBbpdczHmpmto9VTYQhCDYjV9O90+x4EtY/SW8oOML3r3UKxHItTSsrWhe5hy0X/xXl6CTdumKbmJKF+sbO5iaQPpnzkr0RFqACSg5gQpgVl8Wd9lpfdRJ9F+lQMJ4Lr0ts3slfG4xG2FWUI/uwQMpxaI04frihZ/oZbPY6rj1IG0RxwX5CWTi/F4UQWEUpot/u6C7H81ADXSdb/b6DTTa0Fbl2R7MEJJV45ptxT1vX3VHk4TeaNTse6bLMhGCo9nk1Kj8pHv7UUNhdaq2aMzlg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A34E9C70F7D03F4E84E34DE9823550B8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3829
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(81156014)(478600001)(58126008)(316002)(8676002)(54906003)(6486002)(81166006)(36906005)(26826003)(25786009)(5660300002)(8936002)(9686003)(6512007)(46406003)(8746002)(7736002)(1076003)(97756001)(6246003)(102836004)(229853002)(186003)(86362001)(3716004)(386003)(99286004)(6116002)(3846002)(6506007)(23726003)(76176011)(486006)(47776003)(446003)(11346002)(126002)(50466002)(66066001)(336012)(476003)(4326008)(22756006)(305945005)(63350400001)(2906002)(26005)(70586007)(76130400001)(6862004)(14454004)(356004)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR08MB2642;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 65efa81c-4923-4505-b938-08d7407286e9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR08MB2642;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: 9OPCUw2I+q9rmD/+XbD7tGbm91VJEIRzY3nhldTU6b7VgV/SSiExY0N1xgfxOu2FOdyYzgpA/zXyjSixSHChmLMGm/CRhnvL+QZ/Ect5TUoSH1wLDvccKS4CJdl/jQG82RHcmGCHPaqmEDYL5rErnmrLwqxzaCnv2Yxs5V3+pJ8g3xmuuOYkm4tbE8Wi/nfQPJDHxUqExBWvCg0IpIBK4IgZS2wtYGE4F9z9QBswb78ihge5Ozs5h91btZAnAAPTWRrYuFlXCdq/U7g2JiyG0MCG6HHok6GRkSxaqVr6Avoq2mJZ29kZjizfF9Ztly/r0IoH6yMG4Bzeof/Rba0VS951QrLWgBsmrxJZxSptX+SiPR9vJE97dZsstGRw1KYOIdYC0e0b2VkMqUT6M4gabVS6SqQ42eXO21X9b0O5M/Y=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 22:08:22.8888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c88b69a-d6ed-42aa-1c6a-08d740728cdc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Sep 06, 2019 at 06:47:08PM +0000, John Stultz wrote:
> From: "Andrew F. Davis" <afd@ti.com>
>=20
> This framework allows a unified userspace interface for dma-buf
> exporters, allowing userland to allocate specific types of memory
> for use in dma-buf sharing.
>=20
> Each heap is given its own device node, which a user can allocate
> a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
>=20
> This code is an evoluiton of the Android ION implementation,
> and a big thanks is due to its authors/maintainers over time
> for their effort:
>   Rebecca Schultz Zavin, Colin Cross, Benjamin Gaignard,
>   Laura Abbott, and many other contributors!
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
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

One miniscule nit from me below, but whether you change it or not, you
can add my r-b:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

Thanks for pushing this through!

-Brian

> ---

...

> +
> +	dev_ret =3D device_create(dma_heap_class,
> +				NULL,
> +				heap->heap_devt,
> +				NULL,
> +				heap->name);
> +	if (IS_ERR(dev_ret)) {
> +		pr_err("dma_heap: Unable to create device\n");
> +		err_ret =3D (struct dma_heap *)dev_ret;

Tiny nit: ERR_CAST() would be more obvious for me here.

