Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905CC432C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5140207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PQqzsGL8";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PQqzsGL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503248AbfIWWKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:10:41 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:39398
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388455AbfIWWKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGvhMgnXJXwpLJTptEp3F31xtqfPRaEgNOZQBm+Qdos=;
 b=PQqzsGL818Atp/dIqTX/fOCgkdaEOdWj1xb/dJXnXdrhf/WILnVRSPI7ajYfjPMS3QNnBBdwTZLRK/xbdleeVkqOtLqeaXh4ib7FYP0e3hufX84Qu/fZ91aMpoVud90jnAAt57OOA3yte7vl2MATjf/zMli3A17nAtxt5IJTi1U=
Received: from DB6PR0802CA0032.eurprd08.prod.outlook.com (2603:10a6:4:a3::18)
 by AM0PR08MB3761.eurprd08.prod.outlook.com (2603:10a6:208:103::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 23 Sep
 2019 22:10:30 +0000
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::202) by DB6PR0802CA0032.outlook.office365.com
 (2603:10a6:4:a3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Mon, 23 Sep 2019 22:10:29 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT023.mail.protection.outlook.com (10.152.20.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 22:10:28 +0000
Received: ("Tessian outbound 4a9865a8921c:v31"); Mon, 23 Sep 2019 22:10:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 38c6030cebe789a5
X-CR-MTA-TID: 64aa7808
Received: from 658229868cd6.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 84FEBFFC-DE1D-48A2-A2EA-8FECB3E1418A.1;
        Mon, 23 Sep 2019 22:10:21 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 658229868cd6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 23 Sep 2019 22:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZAQ84+bVMbLhanH7sQdAyaDUvxTlESiR/TCUxG/43/3RMIyyn8nMXneUHyYv3k2vzldP+sq5l5sNbXgeBsWjk3N4vPZ5+pd8syL3P+Et9xtThL6eu8dnK0TXhXNK5RxqphtW3h25oEWr/ShQPL9gZq73IWtUZPOhUU2p2x7tHxSOeXkV8vWdZgfbFc7Sz+KU0jQlCBSj/ognoCDPPFdn3fnxLKwmwbf2i0gpKZWooydo9GKHyw7ZUBHsFEDCvJdFD4lko4+f6rDrjyxTg1soFMRoia269CSMDoHTtONBCdeuqbVzHZU5ZewxObC4ArIKg6IHl7UknZAktJ8g+FUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGvhMgnXJXwpLJTptEp3F31xtqfPRaEgNOZQBm+Qdos=;
 b=AQwf5C3s1yz7WGwNlmDXRPkwsfWQPGUNxbo7BEzLR45joaHAXay6sg2aCJotc2+J8nDCaBHmcOIKWaKE6ptoLVoIaKev+47lbhfw7KDQtYt0jo5hdjqXwat5n6xbbwhRbdduP45oZLGG7Ta2iyB8sswUr4YhSh8iiq0cuOKRQDyIETHI/JbKloakwbHOlQpALZBzwhE9vghKLNr+jAYbKxGQa/Eo7XYiiqVlo3b3ncqP2eoq6tSSRGvYRMSD62S+57K0m4rlTPtHmerRNipUtpZvqNAbL4//vEXXiLVanELvt4lOPbdCdFhlEhaR/1GBYO3jl4TN3fyhGCxztNprZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGvhMgnXJXwpLJTptEp3F31xtqfPRaEgNOZQBm+Qdos=;
 b=PQqzsGL818Atp/dIqTX/fOCgkdaEOdWj1xb/dJXnXdrhf/WILnVRSPI7ajYfjPMS3QNnBBdwTZLRK/xbdleeVkqOtLqeaXh4ib7FYP0e3hufX84Qu/fZ91aMpoVud90jnAAt57OOA3yte7vl2MATjf/zMli3A17nAtxt5IJTi1U=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Mon, 23 Sep 2019 22:10:19 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 22:10:19 +0000
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
Subject: Re: [RESEND][PATCH v8 4/5] dma-buf: heaps: Add CMA heap to dmabuf
 heaps
Thread-Topic: [RESEND][PATCH v8 4/5] dma-buf: heaps: Add CMA heap to dmabuf
 heaps
Thread-Index: AQHVZOOH7YpCGzy7L0qigIXTV5Du46c57ZCA
Date:   Mon, 23 Sep 2019 22:10:19 +0000
Message-ID: <20190923221013.ovwqdr34777cluj2@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-5-john.stultz@linaro.org>
In-Reply-To: <20190906184712.91980-5-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [195.233.151.106]
x-clientproxiedby: DB6PR07CA0107.eurprd07.prod.outlook.com
 (2603:10a6:6:2c::21) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1dbd4e47-0fd3-4c83-48e7-08d74072d7a2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB3829;
X-MS-TrafficTypeDiagnostic: AM6PR08MB3829:|AM6PR08MB3829:|AM0PR08MB3761:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB376161D5C8A3D7BEE60B897CF0850@AM0PR08MB3761.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(6506007)(26005)(7736002)(81166006)(186003)(52116002)(316002)(99286004)(64756008)(66476007)(66446008)(229853002)(66946007)(4326008)(25786009)(66556008)(446003)(9686003)(386003)(76176011)(6512007)(6246003)(102836004)(7416002)(58126008)(305945005)(476003)(6436002)(11346002)(5660300002)(2906002)(14454004)(71200400001)(71190400001)(54906003)(14444005)(6486002)(486006)(81156014)(256004)(44832011)(1076003)(6916009)(8676002)(6116002)(478600001)(8936002)(66066001)(86362001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3829;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 0blQdPxk0ik0KEUsOjtxHziQ8W/GKiu7lwEK0cJpgtrVbwoeArZFd5dM4uLaSz64xd0vGm1BrwqcOiWJRF4Z/NhI60uwYkjxLIQjUkxYNQqrfKK2sDjOnF+pME45e65WLnZFvvU4Nrh72FzZSxhRtMFsjalMk9ezdYImXNYnh2mJ4buTCKkDfMoQ7+8EGM/Eady4uoXAaLWOjexEC7geTdRKm5vCI3msWgqvhg9ETKlcJA02wA5y0K9w+t6sargs1YSLjIH4iREX2Mr+y1AgMDSnFw5kKCMpDWVdM4Bj29pEA2Fylit3E3fnstDoARTkyBEuHKhpLU6stie6rmgPmHLNuMzuRRAGhW4xuEUnZDTDlb8Z6zybOzQvYHaNtubNP7Htn1bLkqa9bfarQJ9+hCaoJxjETRT0PhSbgOLq5uQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9484091C05350E49B0D3FF94BD7EBD2F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3829
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(478600001)(356004)(76176011)(86362001)(26826003)(66066001)(23726003)(6116002)(3846002)(46406003)(22756006)(14444005)(5660300002)(70586007)(70206006)(1076003)(47776003)(76130400001)(186003)(336012)(486006)(126002)(54906003)(6486002)(102836004)(8676002)(63350400001)(11346002)(81156014)(14454004)(81166006)(2906002)(25786009)(6862004)(6246003)(9686003)(99286004)(8746002)(446003)(50466002)(4326008)(97756001)(8936002)(6512007)(316002)(58126008)(305945005)(6506007)(26005)(386003)(229853002)(476003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3761;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53780cd3-2012-4cb5-8eac-08d74072d21d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB3761;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: Y8nVz8qLPoqSff8uxbHNnxb/Wbe5URFfL2sMpde0EX9aIluhj0i8UQKuRwbsOnalA5TvxTYMwq7MqD5pK+Xl9NUAdgTB8pqsRrNup33B+BvUvydvZLlXRlhuYyFSsRVcozkENID8ymFNJUCAXst/ihJy+0/OZvlTAlW9rYfsmdRGmTFeQnk/S4+hl/Mu+G8Lnl11MklCwHNRrSMwV/Op8mTl0V4ANl2tXz4dXVcq3FRQlTqt4EcuiXMAci9qdm32xS3PmLJwunYY9F6GiWRI0kTicSNSvutH3e/QBYGhoA5+8wkeineXyk8Me/Zwyyx6TguovgaZ8h/71iablxcL4cr++/2Fy+zWl7lPKSGEKeC9+yW1TLz1rT7guxBpnMmc+9FZyvaliqB6NLqaMZboAgGTI93MBNXJ1KgoT8DvhfM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 22:10:28.3872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbd4e47-0fd3-4c83-48e7-08d74072d7a2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I spotted one thing below which might be harmless, but best to check.

On Fri, Sep 06, 2019 at 06:47:11PM +0000, John Stultz wrote:
> This adds a CMA heap, which allows userspace to allocate
> a dma-buf of contiguous memory out of a CMA region.
>=20
> This code is an evolution of the Android ION implementation, so
> thanks to its original author and maintainters:
>   Benjamin Gaignard, Laura Abbott, and others!
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
> ---
> v2:
> * Switch allocate to return dmabuf fd
> * Simplify init code
> * Checkpatch fixups
> v3:
> * Switch to inline function for to_cma_heap()
> * Minor cleanups suggested by Brian
> * Fold in new registration style from Andrew
> * Folded in changes from Andrew to use simplified page list
>   from the heap helpers
> v4:
> * Use the fd_flags when creating dmabuf fd (Suggested by
>   Benjamin)
> * Use precalculated pagecount (Suggested by Andrew)
> v6:
> * Changed variable names to improve clarity, as suggested
>   by Brian
> v7:
> * Use newly lower-cased init_heap_helper_buffer helper
> * Use new dmabuf export helper
> v8:
> * Make struct dma_heap_ops const (Suggested by Christoph)
> * Condense dma_heap_buffer and heap_helper_buffer (suggested by
>   Christoph)
> * Checkpatch whitespace fixups
> ---

...

> +
> +/* dmabuf heap CMA operations functions */
> +static int cma_heap_allocate(struct dma_heap *heap,
> +			     unsigned long len,
> +			     unsigned long fd_flags,
> +			     unsigned long heap_flags)
> +{
> +	struct cma_heap *cma_heap =3D dma_heap_get_data(heap);
> +	struct heap_helper_buffer *helper_buffer;
> +	struct page *cma_pages;
> +	size_t size =3D PAGE_ALIGN(len);
> +	unsigned long nr_pages =3D size >> PAGE_SHIFT;
> +	unsigned long align =3D get_order(size);
> +	struct dma_buf *dmabuf;
> +	int ret =3D -ENOMEM;
> +	pgoff_t pg;
> +
> +	if (align > CONFIG_CMA_ALIGNMENT)
> +		align =3D CONFIG_CMA_ALIGNMENT;
> +
> +	helper_buffer =3D kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> +	if (!helper_buffer)
> +		return -ENOMEM;
> +
> +	init_heap_helper_buffer(helper_buffer, cma_heap_free);
> +	helper_buffer->flags =3D heap_flags;
> +	helper_buffer->heap =3D heap;
> +	helper_buffer->size =3D len;
> +
> +	cma_pages =3D cma_alloc(cma_heap->cma, nr_pages, align, false);
> +	if (!cma_pages)
> +		goto free_buf;
> +
> +	if (PageHighMem(cma_pages)) {
> +		unsigned long nr_clear_pages =3D nr_pages;
> +		struct page *page =3D cma_pages;
> +
> +		while (nr_clear_pages > 0) {
> +			void *vaddr =3D kmap_atomic(page);
> +
> +			memset(vaddr, 0, PAGE_SIZE);
> +			kunmap_atomic(vaddr);
> +			page++;
> +			nr_clear_pages--;
> +		}
> +	} else {
> +		memset(page_address(cma_pages), 0, size);
> +	}
> +
> +	helper_buffer->pagecount =3D nr_pages;
> +	helper_buffer->pages =3D kmalloc_array(helper_buffer->pagecount,
> +					     sizeof(*helper_buffer->pages),
> +					     GFP_KERNEL);
> +	if (!helper_buffer->pages) {
> +		ret =3D -ENOMEM;
> +		goto free_cma;
> +	}
> +
> +	for (pg =3D 0; pg < helper_buffer->pagecount; pg++) {
> +		helper_buffer->pages[pg] =3D &cma_pages[pg];
> +		if (!helper_buffer->pages[pg])

Is this ever really possible? If cma_pages is non-NULL (which you
check earlier), then only if the pointer arithmetic overflows right?

If it's just redundant, then you could remove it (and in that case add
my r-b). But maybe you meant to check something else?

Cheers,
-Brian
