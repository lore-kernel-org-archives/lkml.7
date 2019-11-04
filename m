Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403DCCA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048DF21655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uoCNWgNW";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uoCNWgNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfKDJp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:45:57 -0500
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:33326
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfKDJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXDpE+nRkRv5PGGEvuAaRD2ag46feHLKiaCiX0dQTA4=;
 b=uoCNWgNWsmk81OHIwatqtI8841v25wkT0H+IggAdT5EYZEg1dyAcnV7f8FiPXdyYWo7hMeDjj2hyorDSOTvF+1/DTiq4+4KIZV/2YvHI9fNHg5C268M0NmRgy7wBXbsEmFszVvyzUSsBVmlrv9jUT8zA0zPCqONfUWWCkk5HITw=
Received: from VI1PR0802CA0040.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::26) by HE1PR0802MB2490.eurprd08.prod.outlook.com
 (2603:10a6:3:d9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 09:45:50 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0802CA0040.outlook.office365.com
 (2603:10a6:800:a9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 09:45:50 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 09:45:49 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Mon, 04 Nov 2019 09:45:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0a3e5f307d717108
X-CR-MTA-TID: 64aa7808
Received: from 74d743bea6a7.1 (cr-mta-lb-1.cr-mta-net [104.47.8.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DDFDAB03-446A-4DE4-9AF7-5A8A83FD76BF.1;
        Mon, 04 Nov 2019 09:45:43 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 74d743bea6a7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 04 Nov 2019 09:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQcUk/st4ue8shQAQ3C6pNWuaOoUvR113rVCqsGJM9e9hizYG/DtbacTEv4mKKyXyjdKiGG3fnJLakuH94/DQdEkKBbMLiaHlWgNRqkckSMKGMyMAs5Q59murg954ZWSFXEZtb0vtVhQg8VIb3DZnZbiLxxElD0nEpJg6Q0OsLy7d3UabTdmeMSQM5WzuyE/KkrzR1tatV7frRC9fRD2w24VTh5MgYefTnoWNl8mGQQ9IsO0fUKYN3pNd4IjmVTdSBeG6pwUPGLO/nuwifAitdwyDi/LDS3YCRU5OnN4lRWWvkoB9TR89pCTGpHinihy6j0XwtOSC9v0vAl1u57HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXDpE+nRkRv5PGGEvuAaRD2ag46feHLKiaCiX0dQTA4=;
 b=SuXBXCRlUyvjHXSoIxyOS3BQFrVcmRYLdr+On1vMINVohbP6aqFJCo4eb5tCWtSdDgOPlM8gQS6h7KJdQJKSZ6f9zExTyOX4puRD7FHK9MBpDShrCO3hDF/lhK5FzH6xczthw0fmXiP7q9NGqYu1laKh359TsXf5tkcNiZHjSeaqZhyV1reOoMSUvnNGj10aDYN/UeLWF2VYePw65Rici2+qdCJsxVNwpW8RqZj0+ADVx6f1tBhlPS8AatrncI1t0UkTMsl7JNJ8Y4A/8jb/Igs94aEwIy8N4kXHnQIGDxdnQ5jgxgd0mYRJqwUEdFaeSlJi5DgqmknjBXMWu7/nOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXDpE+nRkRv5PGGEvuAaRD2ag46feHLKiaCiX0dQTA4=;
 b=uoCNWgNWsmk81OHIwatqtI8841v25wkT0H+IggAdT5EYZEg1dyAcnV7f8FiPXdyYWo7hMeDjj2hyorDSOTvF+1/DTiq4+4KIZV/2YvHI9fNHg5C268M0NmRgy7wBXbsEmFszVvyzUSsBVmlrv9jUT8zA0zPCqONfUWWCkk5HITw=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB2949.eurprd08.prod.outlook.com (52.135.167.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 09:45:42 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::6804:f05f:47c0:d9e]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::6804:f05f:47c0:d9e%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 09:45:42 +0000
From:   Brian Starkey <Brian.Starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [RFC][PATCH 2/2] dma-buf: heaps: Allow system & cma heaps to be
 configured as a modules
Thread-Topic: [RFC][PATCH 2/2] dma-buf: heaps: Allow system & cma heaps to be
 configured as a modules
Thread-Index: AQHVi4693yBg1FyyFkSgMcWi1Q79X6d60haA
Date:   Mon, 4 Nov 2019 09:45:42 +0000
Message-ID: <20191104094533.zal4sjexrmtgaacn@DESKTOP-E1NTVVP.localdomain>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-3-john.stultz@linaro.org>
In-Reply-To: <20191025234834.28214-3-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.51]
x-clientproxiedby: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a3c028d-03b0-421b-c737-08d7610bc67e
X-MS-TrafficTypeDiagnostic: AM6PR08MB2949:|HE1PR0802MB2490:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0802MB24909E9C5A57446B6921AEA9F07F0@HE1PR0802MB2490.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0211965D06
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(6916009)(66946007)(9686003)(6512007)(66556008)(76176011)(99286004)(66446008)(64756008)(66476007)(256004)(186003)(54906003)(26005)(6506007)(6436002)(229853002)(386003)(52116002)(58126008)(316002)(486006)(476003)(44832011)(66066001)(7416002)(6246003)(102836004)(305945005)(5024004)(14444005)(6486002)(7736002)(3846002)(6116002)(478600001)(4326008)(14454004)(71190400001)(71200400001)(86362001)(5660300002)(1076003)(8676002)(2906002)(25786009)(8936002)(81156014)(81166006)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB2949;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 146ZkeT18gUHe5TgT5cE50PahMAJA27oaLqeYoJ6BhXRTffcOcCItsWTlHmxnsehmXOFBLHCHmN90lnZWo+I8Bb9CJCKsWgckViC4w8TEDOUFAUkPYZW7jepTThGOd+GerILH9W2n0Y3q0gky6Wd9dGGePem5TDid3OCGy3SMc5SlsfEjxrRj6BMkzVn436QIok1jmfBILlkZAY20l4TZvnNDZg6VLrCdYd14EpxmkImy7UJz9Xh8YBMkEQH81kDYm8STPmTq8pyCSzvIlu+Zt1/fPLmqRiexnkKcRh7vaTl3+9w3lqYNs17cO1GYdosw5TbpExm881GzL802ujbggFtzDsUxvr7QM5OhdPtMHOgHpfO8yfUprj06db8Gj6Fc4Zn2wGCaK8QUbwmswUHN+qeeKB3tOFowkys7Nd5kVdgkahTFRO4Kiihl7En6GCE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <53BABD4A2570FD43AE1D2D5C1FF1CEA9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2949
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(1110001)(339900001)(199004)(189003)(7736002)(99286004)(70586007)(46406003)(102836004)(1076003)(8746002)(26005)(66066001)(25786009)(105606002)(356004)(8936002)(186003)(5024004)(14444005)(86362001)(8676002)(81156014)(81166006)(76130400001)(50466002)(22756006)(478600001)(70206006)(26826003)(97756001)(14454004)(5660300002)(305945005)(23726003)(229853002)(6862004)(336012)(2906002)(126002)(476003)(446003)(36906005)(11346002)(6116002)(3846002)(486006)(6512007)(9686003)(47776003)(6246003)(4326008)(6486002)(54906003)(58126008)(76176011)(6506007)(386003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2490;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 60135d11-fddf-4ae6-f91e-08d7610bc1dc
NoDisclaimer: True
X-Forefront-PRVS: 0211965D06
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEJnZf+XyItiBXwBcluoZCnwtbhwg2tLUSTHluvvIdsRzxnEbZ3Im8F2OHC76TwhIOSoAth1wTmpKUgxIXHUb+J5beiJ8q2cO2rIaMgAeYAxZk4V/nIiF8oqk2SItv9X5o6Eaf4qgJBVqX+drYfyHpomUOWUYkq6PLGK0a4ycY8RmlkUN07WmJt7jKvf4yq6AQd0eTOgi4GeS5+Jh/aUDINhPCJWcuEe1hZQVWtMvc9z412L0CjPOXYPLgl5rEJH7xjuSgQh3lpopRc1CIiaWSyH3HMpUXZfaBYKY6NxnWM8UoH2mDId0Tccpob6oXrWwPCtVeY/rFTAuvPY8+rnMNGaURB3kucskLd6nwkqmkslR9XP6Ce6p9cIQTiHS8+4r3YS5i+CMmABDRedxhVtahXpv6yFVsBwiAdV14ELMH8MhP5/i7O4CSo8psaW6nPR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 09:45:49.8365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3c028d-03b0-421b-c737-08d7610bc67e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Oct 25, 2019 at 11:48:34PM +0000, John Stultz wrote:
> Allow loading system and cma heap as a module instead of just as
> a statically built in heap.
>=20
> Since there isn't a good mechanism for dmabuf lifetime tracking
> it isn't safe to allow the heap drivers to be unloaded, so these
> drivers do not implement any module unloading functionality and
> will show up in lsmod as "[permanent]".

Cool, that alleviates my concerns :-)

>=20
> This patch also exports key functions from dmabuf heaps core and
> the heap helper functions so they can be accessed by the module.
>=20
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yue Hu <huyue2@yulong.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/dma-buf/dma-heap.c           | 2 ++
>  drivers/dma-buf/heaps/Kconfig        | 4 ++--
>  drivers/dma-buf/heaps/heap-helpers.c | 2 ++
>  3 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 9a41b73e54b4..2c4ac71a715b 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -161,6 +161,7 @@ void *dma_heap_get_drvdata(struct dma_heap *heap)
>  {
>  	return heap->priv;
>  }
> +EXPORT_SYMBOL_GPL(dma_heap_get_drvdata);
> =20
>  struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_inf=
o)
>  {
> @@ -243,6 +244,7 @@ struct dma_heap *dma_heap_add(const struct dma_heap_e=
xport_info *exp_info)
>  	kfree(heap);
>  	return err_ret;
>  }
> +EXPORT_SYMBOL_GPL(dma_heap_add);

Maybe overly picky - but adding the note about "no safe way to remove,
so there's no dma_heap_remove" to a comment on this function may be
easier to notice than in the git log alone.

Cheers,
-Brian

> =20
>  static char *dma_heap_devnode(struct device *dev, umode_t *mode)
>  {
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfi=
g
> index a5eef06c4226..e273fb18feca 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -1,12 +1,12 @@
>  config DMABUF_HEAPS_SYSTEM
> -	bool "DMA-BUF System Heap"
> +	tristate "DMA-BUF System Heap"
>  	depends on DMABUF_HEAPS
>  	help
>  	  Choose this option to enable the system dmabuf heap. The system heap
>  	  is backed by pages from the buddy allocator. If in doubt, say Y.
> =20
>  config DMABUF_HEAPS_CMA
> -	bool "DMA-BUF CMA Heap"
> +	tristate "DMA-BUF CMA Heap"
>  	depends on DMABUF_HEAPS && DMA_CMA
>  	help
>  	  Choose this option to enable dma-buf CMA heap. This heap is backed
> diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps=
/heap-helpers.c
> index 750bef4e902d..fb9835126893 100644
> --- a/drivers/dma-buf/heaps/heap-helpers.c
> +++ b/drivers/dma-buf/heaps/heap-helpers.c
> @@ -24,6 +24,7 @@ void init_heap_helper_buffer(struct heap_helper_buffer =
*buffer,
>  	INIT_LIST_HEAD(&buffer->attachments);
>  	buffer->free =3D free;
>  }
> +EXPORT_SYMBOL_GPL(init_heap_helper_buffer);
> =20
>  struct dma_buf *heap_helper_export_dmabuf(struct heap_helper_buffer *buf=
fer,
>  					  int fd_flags)
> @@ -37,6 +38,7 @@ struct dma_buf *heap_helper_export_dmabuf(struct heap_h=
elper_buffer *buffer,
> =20
>  	return dma_buf_export(&exp_info);
>  }
> +EXPORT_SYMBOL_GPL(heap_helper_export_dmabuf);
> =20
>  static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
>  {
> --=20
> 2.17.1
>=20
