Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED308CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9523E21E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lZwRLCBb";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lZwRLCBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfKDKYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:24:34 -0500
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:30363
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbfKDKYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AED2QI4qnXu4aR/wc6nzNo53uTPSX3riuBOewkPH3Vc=;
 b=lZwRLCBbjlDhL3bCPtLF6g6o62XHkfOpPonTjj4/jcSTBdvbCb3uDjUIcVtJI/fK1jOswEzF8B7HdLhBWkNYIFK+4/XUvs34HiJqcGLSqtQm8i19MLGJFPhWdQTHxuVdjNmYSuNauKQWwPh0H5lLZ66b/oDgRCWGJubYvXsMTU8=
Received: from DB6PR0802CA0044.eurprd08.prod.outlook.com (2603:10a6:4:a3::30)
 by DB7PR08MB3882.eurprd08.prod.outlook.com (2603:10a6:10:7d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 10:24:18 +0000
Received: from VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by DB6PR0802CA0044.outlook.office365.com
 (2603:10a6:4:a3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 10:24:18 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT004.mail.protection.outlook.com (10.152.18.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 10:24:18 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Mon, 04 Nov 2019 10:24:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f5af1d64c6b0c5bc
X-CR-MTA-TID: 64aa7808
Received: from 56c76ac4d65d.2 (cr-mta-lb-1.cr-mta-net [104.47.14.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E9936728-7DBD-4066-89B4-58D59DFB5C24.1;
        Mon, 04 Nov 2019 10:24:12 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 56c76ac4d65d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 04 Nov 2019 10:24:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NurXPDaUv4myeDr7oiXvPQR7cpNOkwqLUjF3O5ENP+VM5XuaMY0m9y6AkUd41yjAH4qEyn46nvpLmZH+9Zoffj03ydOS/pSnJWgC3+w3DfyW2x384iTypz5gmIr3sZc/HbyKgwkZYcdVphakJFOxhz49ZyUqtZ/F9/xKYVG9P4d8wfJ7cl9rp7G36Tyt3Pe3oaWwJVEQWHHqYG+4QZPnFdbdXyJ9HYVfocUV7DK5670qkvrkDqwG6Z+7AlVQLKqhoVuYtgQuaf5qHqMYNZobLlw+1N6XRRVjgWVfg68dgCvW2PDN9/sH5An78dLUej6WjB4opQv+gCd8Cx2Q6bCiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AED2QI4qnXu4aR/wc6nzNo53uTPSX3riuBOewkPH3Vc=;
 b=kzQvbEPbVs10d+jwSx403hJ4lG+LHMbu4wNQKE1iTmXB+0DotaYA8+A3WezbfCljHZHRvXPdHCzoW0bmmITum7yj5crS5lXKBRU1ZyXotwN8z0NyZxS84vBPnNlxbaL/ADYrqb947+KKyizhGJMgomS9shRivpULfw/XUFDX2pE9I5QePA55yj884IOxfQGBSO3M1Xr1UtZBi+tF48lkGiFq+x9NOolxMggWI/qBBQmW2ngW947snlDJh6P8J3mt4tSuZc03AFPAJl39mTxwmHShteDATVdBkE1sLQdWAyHBDSMcUI4+aJgM72JvBViiR/rLQi+Ckqk+sONTTiJp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AED2QI4qnXu4aR/wc6nzNo53uTPSX3riuBOewkPH3Vc=;
 b=lZwRLCBbjlDhL3bCPtLF6g6o62XHkfOpPonTjj4/jcSTBdvbCb3uDjUIcVtJI/fK1jOswEzF8B7HdLhBWkNYIFK+4/XUvs34HiJqcGLSqtQm8i19MLGJFPhWdQTHxuVdjNmYSuNauKQWwPh0H5lLZ66b/oDgRCWGJubYvXsMTU8=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB4134.eurprd08.prod.outlook.com (20.179.1.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 10:24:10 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::6804:f05f:47c0:d9e]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::6804:f05f:47c0:d9e%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 10:24:10 +0000
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
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
Thread-Topic: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
Thread-Index: AQHVkP1N8JZOPDbdaESLvvbvV23eEqd60gMA
Date:   Mon, 4 Nov 2019 10:24:09 +0000
Message-ID: <20191104102410.66wlyoln5ahlgkem@DESKTOP-E1NTVVP.localdomain>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-2-john.stultz@linaro.org>
In-Reply-To: <20191101214238.78015-2-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [217.140.106.51]
x-clientproxiedby: CWLP265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5c::24) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6970015-3113-4bbc-df76-08d7611126a5
X-MS-TrafficTypeDiagnostic: AM6PR08MB4134:|AM6PR08MB4134:|DB7PR08MB3882:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB38826B45F58995B842806B2FF07F0@DB7PR08MB3882.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:296;OLM:296;
x-forefront-prvs: 0211965D06
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(8676002)(3846002)(8936002)(486006)(81166006)(316002)(476003)(6116002)(44832011)(81156014)(6916009)(66946007)(64756008)(66446008)(66556008)(66476007)(11346002)(6436002)(102836004)(446003)(4326008)(14444005)(256004)(1076003)(2906002)(25786009)(54906003)(99286004)(66066001)(478600001)(58126008)(30864003)(26005)(14454004)(186003)(52116002)(386003)(6506007)(6486002)(5660300002)(6246003)(71200400001)(71190400001)(86362001)(229853002)(76176011)(305945005)(7736002)(7416002)(9686003)(6512007)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4134;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cmP/q7TRNhFQDanetT26q5T1XHdmIB3KNmuoMOVTqFAAMx0frFPKEC1KgXC+68jrbrO0BySPaB7RGT7RRq7KWt6Zf8yfoTkz1Imk5F8Mfd+S9hwce5PFfCH2OyvK7K3CRGNSY98s9VeLLJ8kD3QfxfjK0Y7PjiyieArtSnye7te0XydT+TBhN+pUX9Nb0rYNjJgEBVlpZ8WZjgcaEN1J5Yzjb0aeUSc36kmKY7bk1hK/ooElfB7IORDTbsxjF8rZGuaINZrQug5UuTA7qWTH11r6ae5zjJU9CrLcz+Tr8Cg6msojVbKLcTFzdwZiTAWLdx+WpD949+laVFY7IiMA6v0BMEnOA7Z3YeHiEhhK1OV2Jwq4WrVU4NSEcb6b6o7Kfzxqc3MCFoVK2rfOmUjcc2KR1NH+71/hR9fgq5GQAbxVVi8sfyaZlJTcijy0rsbn
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E8C65DBBAD85046A5845EC352E27BA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4134
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(1110001)(339900001)(199004)(189003)(6486002)(76130400001)(478600001)(6512007)(66066001)(36906005)(386003)(6506007)(102836004)(22756006)(81166006)(81156014)(8676002)(105606002)(50466002)(486006)(99286004)(76176011)(25786009)(305945005)(7736002)(186003)(446003)(11346002)(476003)(336012)(23726003)(126002)(97756001)(9686003)(54906003)(47776003)(316002)(58126008)(356004)(1076003)(70206006)(30864003)(26826003)(8936002)(26005)(14454004)(46406003)(8746002)(70586007)(4326008)(6246003)(6862004)(5660300002)(14444005)(2906002)(6116002)(3846002)(86362001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3882;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 72258a4d-c425-4bde-ae2e-08d761112145
NoDisclaimer: True
X-Forefront-PRVS: 0211965D06
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfoJAvY2h3gUqVyZFVt71tEj3RMuNGlTIB/ZhfxCndUhEpYUkAforFIopYTI9c8fAIEKYPNwYRrf2Oy35fbM6UeTf1hqzUNaI8+ePC0q5cYjp+q0vX3VNq4ZdLNWO7GZApML8vQnIbNUzWAn2X2Fc4cT6ALwOnBTDKNr69aQNh0TBbVnQOktHn+Yl7Hb6zQCnmpR2o04cXzWy0PewUw6LlBMYegBizpjbAPWqrvcgfP93GVr1A4tPrvNuOnBhN3wFLsEKy54Auu+68uzat+tro7y+IkzJfb6R3w7GJuPLxYdL9+omgRSZwSet5rTaRK5PoV+MdZwJtyWxHvyLaFQ2oxrnu61pI2rKEwgxWe359z3GDe/1PmvJPe/E4ZvFNcmMdr/aSq+w71pNPtwjqdppi8SDc3bgz5GMfWcqUpYUruryVmvzZoztRttIHcSEz4X
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 10:24:18.5536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6970015-3113-4bbc-df76-08d7611126a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Nov 01, 2019 at 09:42:34PM +0000, John Stultz wrote:
> From: "Andrew F. Davis" <afd@ti.com>
>=20
> This framework allows a unified userspace interface for dma-buf
> exporters, allowing userland to allocate specific types of memory
> for use in dma-buf sharing.
>=20
> Each heap is given its own device node, which a user can allocate
> a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
>=20
> Additionally should the interface grow in the future, we have a
> DMA_HEAP_IOC_GET_FEATURES ioctl which can return future feature
> flags.

The userspace patch doesn't use this - and there's no indication of
what it's intended to allow in the future. I missed the discussion
about it, do you have a link?

I thought the preferred approach was to add the new ioctl only when we
need it, and new userspace on old kernels will get "ENOSYS" to know
that the kernel doesn't support it.

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
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Folded down fixes I had previously shared in implementing
>   heaps
> * Make flags a u64 (Suggested by Laura)
> * Add PAGE_ALIGN() fix to the core alloc funciton
> * IOCTL fixups suggested by Brian
> * Added fixes suggested by Benjamin
> * Removed core stats mgmt, as that should be implemented by
>   per-heap code
> * Changed alloc to return a dma-buf fd, rather than a buffer
>   (as it simplifies error handling)
> v3:
> * Removed scare-quotes in MAINTAINERS email address
> * Get rid of .release function as it didn't do anything (from
>   Christoph)
> * Renamed filp to file (suggested by Christoph)
> * Split out ioctl handling to separate function (suggested by
>   Christoph)
> * Add comment documenting PAGE_ALIGN usage (suggested by Brian)
> * Switch from idr to Xarray (suggested by Brian)
> * Fixup cdev creation (suggested by Brian)
> * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
>   Brian)
> * Make struct dma_heap internal only (folded in from Andrew)
> * Small cleanups suggested by GregKH
> * Provide class->devnode callback to get consistent /dev/
>   subdirectory naming (Suggested by Bjorn)
> v4:
> * Folded down dma-heap.h change that was in a following patch
> * Added fd_flags entry to allocation structure and pass it
>   through to heap code for use on dma-buf fd creation (suggested
>   by Benjamin)
> v5:
> * Minor cleanups
> v6:
> * Improved error path handling, minor whitespace fixes, both
>   suggested by Brian
> v7:
> * Longer Kconfig description to quiet checkpatch warnings
> * Re-add compat_ioctl bits (Hridya noticed 32bit userland wasn't
>   working)
> v8:
> * Make struct dma_heap_ops consts (Suggested by Christoph)
> * Checkpatch whitespace fixups
> v9:
> * Minor cleanups suggested by Brian Starkey
> * Rename dma_heap_get_data->dma_heap_get_drvdata suggested
>   by Hilf Danton
> v11:
> * Kconfig text improvements suggested by Randy Dunlap
> v12:
> * Add logic to prevent duplicately named heaps being added
> * Add symbol exports for heaps as modules
> v13:
> * Re-remove symbol exports per discussion w/ Brian. Will
>   resubmit in a separte patch for review
> v14:
> * Reworked ioctl handler to zero fill any difference in
>   structure size, similar to what the DRM core does, as
>   suggested by Dave Airlie
> * Removed now unnecessary reserved bits in allocate_data
> * Added get_features ioctl as suggested by Dave Airlie
> * Removed pr_warn_once messages as requested by Dave
>   Airlie
> ---
>  MAINTAINERS                   |  18 ++
>  drivers/dma-buf/Kconfig       |   9 +
>  drivers/dma-buf/Makefile      |   1 +
>  drivers/dma-buf/dma-heap.c    | 313 ++++++++++++++++++++++++++++++++++
>  include/linux/dma-heap.h      |  59 +++++++
>  include/uapi/linux/dma-heap.h |  77 +++++++++
>  6 files changed, 477 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-heap.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6c34d04ce95..77c3e993fb2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4940,6 +4940,24 @@ F:	include/linux/*fence.h
>  F:	Documentation/driver-api/dma-buf.rst
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> =20
> +DMA-BUF HEAPS FRAMEWORK
> +M:	Sumit Semwal <sumit.semwal@linaro.org>
> +R:	Andrew F. Davis <afd@ti.com>
> +R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
> +R:	Liam Mark <lmark@codeaurora.org>
> +R:	Laura Abbott <labbott@redhat.com>
> +R:	Brian Starkey <Brian.Starkey@arm.com>
> +R:	John Stultz <john.stultz@linaro.org>
> +S:	Maintained
> +L:	linux-media@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> +F:	include/uapi/linux/dma-heap.h
> +F:	include/linux/dma-heap.h
> +F:	drivers/dma-buf/dma-heap.c
> +F:	drivers/dma-buf/heaps/*
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +
>  DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
>  M:	Vinod Koul <vkoul@kernel.org>
>  L:	dmaengine@vger.kernel.org
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index a23b6752d11a..bffa58fc3e6e 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -44,4 +44,13 @@ config DMABUF_SELFTESTS
>  	default n
>  	depends on DMA_SHARED_BUFFER
> =20
> +menuconfig DMABUF_HEAPS
> +	bool "DMA-BUF Userland Memory Heaps"
> +	select DMA_SHARED_BUFFER
> +	help
> +	  Choose this option to enable the DMA-BUF userland memory heaps.
> +	  This options creates per heap chardevs in /dev/dma_heap/ which
> +	  allows userspace to allocate dma-bufs that can be shared
> +	  between drivers.
> +
>  endmenu
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index 03479da06422..caee5eb3d351 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y :=3D dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
>  	 dma-resv.o seqno-fence.o
> +obj-$(CONFIG_DMABUF_HEAPS)	+=3D dma-heap.o
>  obj-$(CONFIG_SYNC_FILE)		+=3D sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+=3D sw_sync.o sync_debug.o
>  obj-$(CONFIG_UDMABUF)		+=3D udmabuf.o
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> new file mode 100644
> index 000000000000..7cdd7179e5fa
> --- /dev/null
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -0,0 +1,313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Framework for userspace DMA-BUF allocations
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/err.h>
> +#include <linux/xarray.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/syscalls.h>
> +#include <linux/dma-heap.h>
> +#include <uapi/linux/dma-heap.h>
> +
> +#define DEVNAME "dma_heap"
> +
> +#define NUM_HEAP_MINORS 128
> +
> +/**
> + * struct dma_heap - represents a dmabuf heap in the system
> + * @name:		used for debugging/device-node name
> + * @ops:		ops struct for this heap
> + * @minor		minor number of this heap device
> + * @heap_devt		heap device node
> + * @heap_cdev		heap char device
> + *
> + * Represents a heap of memory from which buffers can be made.
> + */
> +struct dma_heap {
> +	const char *name;
> +	const struct dma_heap_ops *ops;
> +	void *priv;
> +	unsigned int minor;
> +	dev_t heap_devt;
> +	struct list_head list;
> +	struct cdev heap_cdev;
> +};
> +
> +static LIST_HEAD(heap_list);
> +static DEFINE_MUTEX(heap_list_lock);
> +static dev_t dma_heap_devt;
> +static struct class *dma_heap_class;
> +static DEFINE_XARRAY_ALLOC(dma_heap_minors);
> +
> +static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> +				 unsigned int fd_flags,
> +				 unsigned int heap_flags)
> +{
> +	/*
> +	 * Allocations from all heaps have to begin
> +	 * and end on page boundaries.
> +	 */
> +	len =3D PAGE_ALIGN(len);
> +	if (!len)
> +		return -EINVAL;
> +
> +	return heap->ops->allocate(heap, len, fd_flags, heap_flags);
> +}
> +
> +static int dma_heap_open(struct inode *inode, struct file *file)
> +{
> +	struct dma_heap *heap;
> +
> +	heap =3D xa_load(&dma_heap_minors, iminor(inode));
> +	if (!heap) {
> +		pr_err("dma_heap: minor %d unknown.\n", iminor(inode));
> +		return -ENODEV;
> +	}
> +
> +	/* instance data as context */
> +	file->private_data =3D heap;
> +	nonseekable_open(inode, file);
> +
> +	return 0;
> +}
> +
> +static long dma_heap_ioctl_get_features(struct file *file, void *data)
> +{
> +	struct dma_heap_get_features_data *heap_features =3D data;
> +
> +	/* nothing should be passed in */
> +	if (heap_features->features)
> +		return -EINVAL;
> +
> +	heap_features->features =3D DMA_HEAP_SUPPORTED_FEATURES;
> +	return 0;
> +}
> +
> +static long dma_heap_ioctl_allocate(struct file *file, void *data)
> +{
> +	struct dma_heap_allocation_data *heap_allocation =3D data;
> +	struct dma_heap *heap =3D file->private_data;
> +	int fd;
> +
> +	if (heap_allocation->fd)
> +		return -EINVAL;
> +
> +	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
> +		return -EINVAL;
> +
> +	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> +		return -EINVAL;
> +
> +	fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> +				   heap_allocation->fd_flags,
> +				   heap_allocation->heap_flags);
> +	if (fd < 0)
> +		return fd;
> +
> +	heap_allocation->fd =3D fd;
> +
> +	return 0;
> +}
> +
> +unsigned int dma_heap_ioctl_cmds[] =3D {
> +	DMA_HEAP_IOC_GET_FEATURES,
> +	DMA_HEAP_IOC_ALLOC,
> +};
> +
> +static long dma_heap_ioctl(struct file *file, unsigned int ucmd,
> +			   unsigned long arg)
> +{
> +	char stack_kdata[128];
> +	char *kdata =3D stack_kdata;
> +	unsigned int kcmd;
> +	unsigned int in_size, out_size, drv_size, ksize;
> +	int nr =3D _IOC_NR(ucmd);
> +	int ret =3D 0;
> +
> +	if (nr >=3D ARRAY_SIZE(dma_heap_ioctl_cmds))
> +		return -EINVAL;
> +
> +	/* Get the kernel ioctl cmd that matches */
> +	kcmd =3D dma_heap_ioctl_cmds[nr];
> +
> +	/* Figure out the delta between user cmd size and kernel cmd size */
> +	drv_size =3D _IOC_SIZE(kcmd);
> +	out_size =3D _IOC_SIZE(ucmd);
> +	in_size =3D out_size;
> +	if ((ucmd & kcmd & IOC_IN) =3D=3D 0)
> +		in_size =3D 0;
> +	if ((ucmd & kcmd & IOC_OUT) =3D=3D 0)
> +		out_size =3D 0;
> +	ksize =3D max(max(in_size, out_size), drv_size);
> +
> +	/* If necessary, allocate buffer for ioctl argument */
> +	if (ksize > sizeof(stack_kdata)) {
> +		kdata =3D kmalloc(ksize, GFP_KERNEL);
> +		if (!kdata)
> +			return -ENOMEM;
> +	}
> +
> +	if (copy_from_user(kdata, (void __user *)arg, in_size) !=3D 0) {
> +		ret =3D -EFAULT;
> +		goto err;
> +	}
> +
> +	/* zero out any difference between the kernel/user structure size */
> +	if (ksize > in_size)
> +		memset(kdata + in_size, 0, ksize - in_size);
> +
> +	switch (kcmd) {
> +	case DMA_HEAP_IOC_GET_FEATURES:
> +		ret =3D dma_heap_ioctl_get_features(file, kdata);
> +		break;
> +	case DMA_HEAP_IOC_ALLOC:
> +		ret =3D dma_heap_ioctl_allocate(file, kdata);
> +		break;
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0)
> +		ret =3D -EFAULT;
> +err:
> +	if (kdata !=3D stack_kdata)
> +		kfree(kdata);
> +	return ret;
> +}

The new zeroing stuff all looks good to me - so wrt. that you can add
back my r-b; would still like to get some clarification on the
get_features, though.

Couple of typos below.

> +
> +static const struct file_operations dma_heap_fops =3D {
> +	.owner          =3D THIS_MODULE,
> +	.open		=3D dma_heap_open,
> +	.unlocked_ioctl =3D dma_heap_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl	=3D dma_heap_ioctl,
> +#endif
> +};
> +
> +/**
> + * dma_heap_get_drvdata() - get per-subdriver data for the heap
> + * @heap: DMA-Heap to retrieve private data for
> + *
> + * Returns:
> + * The per-subdriver data for the heap.
> + */
> +void *dma_heap_get_drvdata(struct dma_heap *heap)
> +{
> +	return heap->priv;
> +}
> +
> +struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_inf=
o)
> +{
> +	struct dma_heap *heap, *h, *err_ret;
> +	struct device *dev_ret;
> +	int ret;
> +
> +	if (!exp_info->name || !strcmp(exp_info->name, "")) {
> +		pr_err("dma_heap: Cannot add heap without a name\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!exp_info->ops || !exp_info->ops->allocate) {
> +		pr_err("dma_heap: Cannot add heap with invalid ops struct\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	/* check the name is unique */
> +	mutex_lock(&heap_list_lock);
> +	list_for_each_entry(h, &heap_list, list) {
> +		if (!strcmp(h->name, exp_info->name)) {
> +			mutex_unlock(&heap_list_lock);
> +			pr_err("dma_heap: Already registered heap named %s\n",
> +			       exp_info->name);
> +			return ERR_PTR(-EINVAL);
> +		}
> +	}
> +	mutex_unlock(&heap_list_lock);
> +
> +	heap =3D kzalloc(sizeof(*heap), GFP_KERNEL);
> +	if (!heap)
> +		return ERR_PTR(-ENOMEM);
> +
> +	heap->name =3D exp_info->name;
> +	heap->ops =3D exp_info->ops;
> +	heap->priv =3D exp_info->priv;
> +
> +	/* Find unused minor number */
> +	ret =3D xa_alloc(&dma_heap_minors, &heap->minor, heap,
> +		       XA_LIMIT(0, NUM_HEAP_MINORS - 1), GFP_KERNEL);
> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to get minor number for heap\n");
> +		err_ret =3D ERR_PTR(ret);
> +		goto err0;
> +	}
> +
> +	/* Create device */
> +	heap->heap_devt =3D MKDEV(MAJOR(dma_heap_devt), heap->minor);
> +
> +	cdev_init(&heap->heap_cdev, &dma_heap_fops);
> +	ret =3D cdev_add(&heap->heap_cdev, heap->heap_devt, 1);
> +	if (ret < 0) {
> +		pr_err("dma_heap: Unable to add char device\n");
> +		err_ret =3D ERR_PTR(ret);
> +		goto err1;
> +	}
> +
> +	dev_ret =3D device_create(dma_heap_class,
> +				NULL,
> +				heap->heap_devt,
> +				NULL,
> +				heap->name);
> +	if (IS_ERR(dev_ret)) {
> +		pr_err("dma_heap: Unable to create device\n");
> +		err_ret =3D ERR_CAST(dev_ret);
> +		goto err2;
> +	}
> +	/* Add heap to the list */
> +	mutex_lock(&heap_list_lock);
> +	list_add(&heap->list, &heap_list);
> +	mutex_unlock(&heap_list_lock);
> +
> +	return heap;
> +
> +err2:
> +	cdev_del(&heap->heap_cdev);
> +err1:
> +	xa_erase(&dma_heap_minors, heap->minor);
> +err0:
> +	kfree(heap);
> +	return err_ret;
> +}
> +
> +static char *dma_heap_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "dma_heap/%s", dev_name(dev));
> +}
> +
> +static int dma_heap_init(void)
> +{
> +	int ret;
> +
> +	ret =3D alloc_chrdev_region(&dma_heap_devt, 0, NUM_HEAP_MINORS, DEVNAME=
);
> +	if (ret)
> +		return ret;
> +
> +	dma_heap_class =3D class_create(THIS_MODULE, DEVNAME);
> +	if (IS_ERR(dma_heap_class)) {
> +		unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
> +		return PTR_ERR(dma_heap_class);
> +	}
> +	dma_heap_class->devnode =3D dma_heap_devnode;
> +
> +	return 0;
> +}
> +subsys_initcall(dma_heap_init);
> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> new file mode 100644
> index 000000000000..454e354d1ffb
> --- /dev/null
> +++ b/include/linux/dma-heap.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMABUF Heaps Allocation Infrastructure
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#ifndef _DMA_HEAPS_H
> +#define _DMA_HEAPS_H
> +
> +#include <linux/cdev.h>
> +#include <linux/types.h>
> +
> +struct dma_heap;
> +
> +/**
> + * struct dma_heap_ops - ops to operate on a given heap
> + * @allocate:		allocate dmabuf and return fd
> + *
> + * allocate returns dmabuf fd  on success, -errno on error.
> + */
> +struct dma_heap_ops {
> +	int (*allocate)(struct dma_heap *heap,
> +			unsigned long len,
> +			unsigned long fd_flags,
> +			unsigned long heap_flags);
> +};
> +
> +/**
> + * struct dma_heap_export_info - information needed to export a new dmab=
uf heap
> + * @name:	used for debugging/device-node name
> + * @ops:	ops struct for this heap
> + * @priv:	heap exporter private data
> + *
> + * Information needed to export a new dmabuf heap.
> + */
> +struct dma_heap_export_info {
> +	const char *name;
> +	const struct dma_heap_ops *ops;
> +	void *priv;
> +};
> +
> +/**
> + * dma_heap_get_drvdata() - get per-heap driver data
> + * @heap: DMA-Heap to retrieve private data for
> + *
> + * Returns:
> + * The per-heap data for the heap.
> + */
> +void *dma_heap_get_drvdata(struct dma_heap *heap);
> +
> +/**
> + * dma_heap_add - adds a heap to dmabuf heaps
> + * @exp_info:		information needed to register this heap
> + */
> +struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_inf=
o);
> +
> +#endif /* _DMA_HEAPS_H */
> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.=
h
> new file mode 100644
> index 000000000000..22f620991758
> --- /dev/null
> +++ b/include/uapi/linux/dma-heap.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * DMABUF Heaps Userspace API
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +#ifndef _UAPI_LINUX_DMABUF_POOL_H
> +#define _UAPI_LINUX_DMABUF_POOL_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/**
> + * DOC: DMABUF Heaps Userspace API
> + */
> +
> +#define DMA_HEAP_FEATURE_NONE (0x0)
> +
> +/* Currrently no supported features */
> +#define DMA_HEAP_SUPPORTED_FEATURES (DMA_HEAP_FEATURE_NONE)
> +
> +/**
> + * struct dma_heap_get_features_data - metadata passed from userspace fo=
r
> + *                                    getting interface features
> + * @features:		features flag returned from kernel
> + *
> + * Provided by userspace as an argument to the ioctl
> + */
> +struct dma_heap_get_features_data {
> +	__u64 features;
> +};
> +
> +/* Valid FD_FLAGS are O_CLOEXEC, O_RDONLY, O_WRONLY, O_RDWR */
> +#define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
> +
> +/* Currently no heap flags */
> +#define DMA_HEAP_VALID_HEAP_FLAGS (0)
> +
> +/**
> + * struct dma_heap_allocation_data - metadata passed from userspace for
> + *                                      allocations
> + * @len:		size of the allocation
> + * @fd:			will be populated with a fd which provdes the
> + *			handle to the allocated dma-buf
> + * @fd_flags:		file descriptor flags used when allocating
> + * @heap_flags:		flags passed to heap
> + *
> + * Provided by userspace as an argument to the ioctl
> + */
> +struct dma_heap_allocation_data {
> +	__u64 len;
> +	__u32 fd;
> +	__u32 fd_flags;
> +	__u64 heap_flags;
> +};
> +
> +#define DMA_HEAP_IOC_MAGIC		'H'
> +
> +/**
> + * DOC: DMA_HEAP_IOC_GET_FEATURES - Get interface features
> + *
> + * Takes an dma_heap_features_data struct and returns it with the featur=
es
> + * flages set with the interfaces supported features.
> + */

s/Takes an/Takes a/
s/features flages/feature flags/
s/interfaces/interface's/

> +#define DMA_HEAP_IOC_GET_FEATURES _IOR(DMA_HEAP_IOC_MAGIC, 0x0,\
> +				       struct dma_heap_get_features_data)
> +/**
> + * DOC: DMA_HEAP_IOC_ALLOC - allocate memory from pool
> + *
> + * Takes an dma_heap_allocation_data struct and returns it with the fd f=
ield
> + * populated with the dmabuf handle of the allocation.
> + */
> +#define DMA_HEAP_IOC_ALLOC	_IOWR(DMA_HEAP_IOC_MAGIC, 0x1,\

s/Takes an/Takes a/

Thanks!
-Brian

> +				      struct dma_heap_allocation_data)
> +
> +#endif /* _UAPI_LINUX_DMABUF_POOL_H */
> --=20
> 2.17.1
>=20
