Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B14FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03E02133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tiAKq/iy";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tiAKq/iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfJCIjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:39:45 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:60230
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728842AbfJCIjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oK1Edr1Gq/FQtLRfSlO65CEqu9rJoosIIX2im8TFIY=;
 b=tiAKq/iyI3N8krCRwGrOJrP2wqG79tlAmzJli9LgHpCukojyc/R78+C8tshLeImk1wgMQ5IMeLYApcUnCE4Hoy5GnSk1xorsbNYRA2KcfeT7UWyY/fkXiaw6ADiZd9EjBb/4DOhJBNMTgPaOAt0VIV2S4L2W5cgA4bKqHrcNNPM=
Received: from VI1PR0802CA0047.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::33) by VI1PR08MB4190.eurprd08.prod.outlook.com
 (2603:10a6:803:eb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Thu, 3 Oct
 2019 08:39:33 +0000
Received: from AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by VI1PR0802CA0047.outlook.office365.com
 (2603:10a6:800:a9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 3 Oct 2019 08:39:33 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT037.mail.protection.outlook.com (10.152.17.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 3 Oct 2019 08:39:32 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Thu, 03 Oct 2019 08:39:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 23d9141348d62267
X-CR-MTA-TID: 64aa7808
Received: from 3594177c2351.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0E4398E1-065A-4D33-A7E2-EBD4CF1C95A0.1;
        Thu, 03 Oct 2019 08:39:25 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3594177c2351.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 03 Oct 2019 08:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQqd9L/560LWhgUNRd2Trh50NIwafQMFf5/epXbeJQWbPycLpoq0nMrJEZSoN3R7NpiQnmyxhObAHvM8Gvl02k+jBI7PBHFUOb3d1NQ0TjNZSEPJUicx7ne6B5CgLg/aYiM9ETyaG5IVbygjEdeFgRYF2cpkbNpuXbu2SZAwTzmE/FoSaVoXOBiY1dhOHy0BnOVnWfr3ZWYRzBcQ/ZSei5rozW+4G6Ee0sct/sHiFecpGgaVF5V7zG8DPcknHf316amR8tgaRyp95BrJPHdKS6A2GknNUQOnHAPwkv4O0kajARBs9U+N0OSLz5zQEn6WKd0E/LhK0LRZyVFajCd50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oK1Edr1Gq/FQtLRfSlO65CEqu9rJoosIIX2im8TFIY=;
 b=MQDmMyu6pvdNecZuNNiiqmQybBnBs5E6opS1vqP9NiJ81zYW9dfGNgw5zPDJyxuvVqYyrHO0lhi/2SU1gy77fmLnB4ZhKRMx1Py6c0Wpc9X4D8iIJfli06UUNcn/D5+HkrkQIa4DlXErZfkT08hHZVeA+urZRBuunLXbkJfURc4uP8/KQ6FnMHfnS81TTVB7gdJ0d05sjW9E0vr3I1dbFNNRDzeq9zSFz7ECIaxQpQyTSOtKEzEG2A28r/iQpB3+zobMQnszs4W3ssB5nL5Q2bTYhqD65irI53V+TVo3FCPuTdX7f8i4ZZf92C4WxGrnIHtEapYC8U213Bq3a92PAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oK1Edr1Gq/FQtLRfSlO65CEqu9rJoosIIX2im8TFIY=;
 b=tiAKq/iyI3N8krCRwGrOJrP2wqG79tlAmzJli9LgHpCukojyc/R78+C8tshLeImk1wgMQ5IMeLYApcUnCE4Hoy5GnSk1xorsbNYRA2KcfeT7UWyY/fkXiaw6ADiZd9EjBb/4DOhJBNMTgPaOAt0VIV2S4L2W5cgA4bKqHrcNNPM=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3013.eurprd08.prod.outlook.com (52.135.168.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 08:39:23 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::ce0:f47b:919d:561a%5]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 08:39:22 +0000
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
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v9 0/5] DMA-BUF Heaps (destaging ION)
Thread-Topic: [PATCH v9 0/5] DMA-BUF Heaps (destaging ION)
Thread-Index: AQHVeU5uJZ+g71n3wUCMjQwSMwttGKdImX4A
Date:   Thu, 3 Oct 2019 08:39:22 +0000
Message-ID: <20191003083922.coty5zobkrku27bc@DESKTOP-E1NTVVP.localdomain>
References: <20191002182255.21808-1-john.stultz@linaro.org>
In-Reply-To: <20191002182255.21808-1-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 76367f26-a31f-4a65-3674-08d747dd3661
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: AM6PR08MB3013:|AM6PR08MB3013:|VI1PR08MB4190:
X-MS-Exchange-PUrlCount: 2
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB41909297A58ED6C3F211B44CF09F0@VI1PR08MB4190.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 01792087B6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39840400004)(396003)(136003)(346002)(199004)(189003)(316002)(54906003)(6512007)(305945005)(58126008)(6916009)(3846002)(6116002)(1076003)(386003)(99286004)(6506007)(66946007)(102836004)(26005)(71190400001)(71200400001)(2906002)(6246003)(66476007)(76176011)(6436002)(186003)(6486002)(52116002)(256004)(229853002)(6306002)(66446008)(64756008)(66556008)(8676002)(9686003)(81156014)(81166006)(44832011)(476003)(66066001)(8936002)(4326008)(5660300002)(966005)(486006)(86362001)(11346002)(14454004)(446003)(7416002)(25786009)(7736002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3013;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1W0TwyONWtAR6Z3vYDfswbxqy3ZEyfpKC7+KgrRSCxqkaEApbzH9S0blY87OkQ0QHNJHRmL4pEdx1tmKuVhqkV4UIgjTFtemTVD12RpnF/+/OwEJrxZhliCV88dr+j4a1DxqBzDYYEqGsfLtokH9DoN1l2c7oOXJJBnH9emtar+wHcmXnEz18bbE2WcU5EOAUUioNrxvBKUTex+vSXmK1zVMRH8B3PmCYDwHAGVJ85kKOHpYeplrIYjVmteOVkMt0a+UNy49MGWKSaDj4UeuxElDDKjnW4FTWarwZAWx8lA5haLq4zGA5auGvIxJZQ9l+xVrnso7j51I9Abvz7tDyJXZp8A6612QGF0M8mRveM1RItffVBlf9mnuvSiYZC+hcHD/ED6nwQlwTJvkhs9Veq/USmzlZvVJGxVMEijfub+f/USGJ8nENDEQfrWfbinlRCbImKuarW/OCLpA8nUPSA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6F494B1BEFFCA499F1EABD7FAD3D198@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3013
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39840400004)(136003)(396003)(376002)(189003)(199004)(25786009)(336012)(2906002)(356004)(8936002)(186003)(76176011)(46406003)(8746002)(11346002)(63350400001)(3846002)(446003)(126002)(386003)(476003)(1076003)(6506007)(22756006)(26005)(50466002)(66066001)(47776003)(102836004)(486006)(81166006)(81156014)(8676002)(5660300002)(6116002)(23726003)(54906003)(4326008)(36906005)(99286004)(76130400001)(58126008)(316002)(6246003)(6862004)(9686003)(6512007)(6306002)(86362001)(966005)(229853002)(478600001)(26826003)(14454004)(97756001)(70586007)(70206006)(7736002)(305945005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4190;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 73a1b691-34f1-438d-af8b-08d747dd309f
NoDisclaimer: True
X-Forefront-PRVS: 01792087B6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F6rlJOFo2yaVRyRcDu5blpzyciRGHYBJutY6eujJsCC9vrQQHjK3NN06k1QdqQIQcQ2d1CdRYHgThTNTHJNSAsvL2DJmUtW1lmagCgOX5XPeuKrbe/LTwm6rgTzSuxHNS87/PpzEmPrb+MvOae7sUyheVOx3jDWTSnS8YIZRsxX//v+B918rhfpAIe/BQAdDKnOrCBLX8CPMjq/jKCznbkXAFI8zESejD/a7hw9F9z3bKPuvtozOxjfce0ORVq4302eUN4LguBbNTwI9/DRYB8lAsl/wzn7hwPoZadz6i3++5i/tl1x9xIoBjOuZ43DIhejsAPL3Zjkr7oWbmEKcHEMW+h7VZ92f/jR0liHPbcpmT6Mxd5+Wdw72JQrOeDQGUVi7kQCm2DvWh8kJag4xTIWGyeUF4VQf4kWRhVCB8XTat9uu5q546qqLOfkHOGnAbcaF1EZ35zDfaKAVU8+4A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2019 08:39:32.0678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76367f26-a31f-4a65-3674-08d747dd3661
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Oct 02, 2019 at 06:22:50PM +0000, John Stultz wrote:
> Here is yet another pass at the dma-buf heaps patchset Andrew
> and I have been working on which tries to destage a fair chunk
> of ION functionality.
>=20
> The patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
>=20
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl.
>=20
> Also, I've provided relatively simple system and cma heaps.
>=20
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=3Ddev/=
dma-buf-heap
>=20
> And the userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>=20
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
>=20
> I've also removed the stats accounting, since any such accounting
> should be implemented by dma-buf core or the heaps themselves.
>=20
> New in v9:
> * Removing needless check in cma heap (noted by Brian Starkey)
> * Rename dma_heap_get_data->dma_heap_get_drvdata (suggested by
>   Hilf Danton)
> * Check signals after clearing memory pages to avoid doing
>   needless work if the task is killed (suggested by Hilf)
> * Better test error reporting (suggested d by Brian)
> * Other minor cleanups (suggested by Brian)
>=20
> Thoughts and feedback would be greatly appreciated!

Looks good to me! Please feel free to add my r-b to the remaining
patches.

Thanks again for moving this forwards.

-Brian

>=20
> thanks
> -john
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
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: dri-devel@lists.freedesktop.org
>=20
> Andrew F. Davis (1):
>   dma-buf: Add dma-buf heaps framework
>=20
> John Stultz (4):
>   dma-buf: heaps: Add heap helpers
>   dma-buf: heaps: Add system heap to dmabuf heaps
>   dma-buf: heaps: Add CMA heap to dmabuf heaps
>   kselftests: Add dma-heap test
>=20
>  MAINTAINERS                                   |  18 ++
>  drivers/dma-buf/Kconfig                       |  11 +
>  drivers/dma-buf/Makefile                      |   2 +
>  drivers/dma-buf/dma-heap.c                    | 250 ++++++++++++++++
>  drivers/dma-buf/heaps/Kconfig                 |  14 +
>  drivers/dma-buf/heaps/Makefile                |   4 +
>  drivers/dma-buf/heaps/cma_heap.c              | 169 +++++++++++
>  drivers/dma-buf/heaps/heap-helpers.c          | 266 ++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
>  drivers/dma-buf/heaps/system_heap.c           | 122 ++++++++
>  include/linux/dma-heap.h                      |  59 ++++
>  include/uapi/linux/dma-heap.h                 |  55 ++++
>  tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 ++++++++++++++++
>  14 files changed, 1272 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-heap.h
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>=20
> --=20
> 2.17.1
>=20
