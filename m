Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21207C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE43820673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3jXIUaGH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3jXIUaGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502949AbfIWWJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:09:13 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:11398
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388713AbfIWWJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs0uLQ+7ayo72lsps0s5J4WoZOy8kgBAOwtwOVbbh28=;
 b=3jXIUaGHcyCo4itqvseaAp0FH2tFsfy3Iv6X8UUCzxgmeMAA9P1IiC6i84t5rBA6pNjagCXDIESwwJG19HPDu1fRNZSEOzHCTxpHLCrJ7PcMqfQ7JHig69SR4rbMpCFoUNW+ZDfqrJqSOGsRj4TNwpAYO8jmmpRNRWQd4Hto1B8=
Received: from VI1PR0802CA0019.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::29) by VI1PR0802MB2416.eurprd08.prod.outlook.com
 (2603:10a6:800:bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Mon, 23 Sep
 2019 22:09:06 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VI1PR0802CA0019.outlook.office365.com
 (2603:10a6:800:aa::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.22 via Frontend
 Transport; Mon, 23 Sep 2019 22:09:06 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Mon, 23 Sep 2019 22:09:05 +0000
Received: ("Tessian outbound 55d20e99e8e2:v31"); Mon, 23 Sep 2019 22:09:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f8cd07ef4be39880
X-CR-MTA-TID: 64aa7808
Received: from c5da9443c0cf.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E92ADA13-9602-42E0-92AB-084ADA34C547.1;
        Mon, 23 Sep 2019 22:08:58 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c5da9443c0cf.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 23 Sep 2019 22:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdAUw8m/5H+Lw6dsyoeI/eai/qaQmzATkd5+8Ebfb47X2hGtOmRlTFsVWGmzr9PxMZc+2S3jaNY2zZmLAbaX/0lyc8B9ggWgOEMbbtaD09gII/WacB3rSbhhOxGANRtpFYe5hSt6Qldwleq/3FaNNRByde12Ar/KaLsx/CrzRk954bLksxCoxKkw/Zkv1SOu4cjBr28D5kP6liceaZhGYcGkMDtCXnw0ogz7yNJ520yL9V8Q+19mClazt9W/DU7J1cF+WLFdvwnWUc/9PwL6ZMCx83c+Ua1YgGqqgJa79iaDZwikoTN2rwRA/BM7DqKV/gdVHMORgfgPxsCP6VQL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs0uLQ+7ayo72lsps0s5J4WoZOy8kgBAOwtwOVbbh28=;
 b=bsv4qFuDFTGRK9xJhgyvqfgqNXgVN9pZ/8zFlm+z+LdOK+e7fI/SBRuS1BfijJYeF7NRxOlz24yWicKzpRT1Y3Rlp+AzE1Bahls6sYKeqrsVnW1oiSHK2pQb5Puf77+hOWqQe5K7W2e2YTZhqeIofja60WsVZOOrOOmd6KfdSrjgQrwti87r2MIpH7Gk9p+japBleuIqMXSJuF95rfZtz3gC9sGvqANcgtK+t6oeqd+KRHHcAi6ZF6JzQJkTEDURVI9gXBK5qnFqEdHrrwm9fTfLu49KihyLBMg73uw4V4SA1EVrOEzamaEjPAlYJrzbOszMuRt2lmi4n9+1m9gYxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs0uLQ+7ayo72lsps0s5J4WoZOy8kgBAOwtwOVbbh28=;
 b=3jXIUaGHcyCo4itqvseaAp0FH2tFsfy3Iv6X8UUCzxgmeMAA9P1IiC6i84t5rBA6pNjagCXDIESwwJG19HPDu1fRNZSEOzHCTxpHLCrJ7PcMqfQ7JHig69SR4rbMpCFoUNW+ZDfqrJqSOGsRj4TNwpAYO8jmmpRNRWQd4Hto1B8=
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Mon, 23 Sep 2019 22:08:56 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::3d72:3e6c:cb97:8976%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 22:08:56 +0000
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
Subject: Re: [RESEND][PATCH v8 2/5] dma-buf: heaps: Add heap helpers
Thread-Topic: [RESEND][PATCH v8 2/5] dma-buf: heaps: Add heap helpers
Thread-Index: AQHVZOOG1jZpePfnXUe2Ard5pOa+Bqc57SyA
Date:   Mon, 23 Sep 2019 22:08:55 +0000
Message-ID: <20190923220849.ttwmt2xohptzznme@DESKTOP-E1NTVVP.localdomain>
References: <20190906184712.91980-1-john.stultz@linaro.org>
 <20190906184712.91980-3-john.stultz@linaro.org>
In-Reply-To: <20190906184712.91980-3-john.stultz@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716-849-147d51-dirty
x-originating-ip: [195.233.151.104]
x-clientproxiedby: DB8PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:10:be::31) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: eeda84d1-eacd-4710-2e42-08d74072a62e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR08MB3829;
X-MS-TrafficTypeDiagnostic: AM6PR08MB3829:|AM6PR08MB3829:|VI1PR0802MB2416:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB24162BE013923931AB109C08F0850@VI1PR0802MB2416.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0169092318
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(6506007)(26005)(7736002)(81166006)(186003)(52116002)(316002)(99286004)(64756008)(66476007)(66446008)(229853002)(66946007)(4326008)(25786009)(66556008)(446003)(9686003)(386003)(76176011)(6512007)(6246003)(102836004)(7416002)(58126008)(305945005)(476003)(6436002)(11346002)(5660300002)(2906002)(14454004)(71200400001)(71190400001)(54906003)(5024004)(14444005)(6486002)(486006)(81156014)(256004)(44832011)(1076003)(6916009)(8676002)(6116002)(478600001)(8936002)(66066001)(86362001)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3829;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: Y4jR+8DFizkCVsPS6PW8R370yk4F4GGZqDg9RKY4+wd4HoprXA3Fy9CdmmiLRylXJikSFzrccHTyh/MKGQ+OtBlOWHuPhoxB+am5cHhoSsZyCzqaQfEfzwfXWuCXsqKplt650Gkyz7AAAG+C652rAPL2vFrNKFDMJNAYnrVpke5+GNZrnq4nSwKUbfePdMfBzZUK2Lg0ZX+2vJxHsEnLKOFRBOlEnGcshX8txEQXScxkumz++wBKthsMw9hVpSc6oI/JruP05Kdu9oXuyZLLT2Qbb6TR3NRKkeBPIvSouRmoBvWnjxsSY9f40tn1MGF4+VEZzoL63n2xmlZcOP0D8JqdGqRZ/8wYtwnRPtkkBKq3HQxCXe7+i/PVvE6qS5MvGuGfS9r9n+INp0rAmoETqadLMjvwnUQMt6pqAAQMgcI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A12B407184C0A438128F946138711EE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3829
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(7736002)(305945005)(70586007)(6506007)(54906003)(81166006)(386003)(5024004)(70206006)(14444005)(316002)(26826003)(6116002)(86362001)(23726003)(81156014)(99286004)(6486002)(2906002)(478600001)(5660300002)(63350400001)(14454004)(25786009)(6246003)(229853002)(8936002)(8746002)(8676002)(102836004)(76176011)(356004)(50466002)(486006)(336012)(76130400001)(126002)(476003)(3846002)(446003)(58126008)(66066001)(22756006)(9686003)(6512007)(6862004)(1076003)(46406003)(186003)(11346002)(36906005)(4326008)(97756001)(26005)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2416;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: af97c941-664c-458d-8146-08d74072a019
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0802MB2416;
NoDisclaimer: True
X-Forefront-PRVS: 0169092318
X-Microsoft-Antispam-Message-Info: 7+GyUCSpiG2qeaK9Kfak9qQ1t1lK/ve8ywyFKSdKgu07wWlvYgJ70CWqJYXxq0YdbfNv/oCAK39FyrgBvGqYiZV/Fe+hq2TEvQjdJytV+OciTGVsJaczYXpLjrG6B/iFJSQ3WS7FXXLni9dzqocXKoPbA9Ck9NA+22sR7L39N06oALWnc+9jS2ZNoqCzpNYEjnAMTWcSu+JRkvsoXI7guE7GUZBy4r1xUtfkKLK2Y45grN5NgSHO+E2gc1/TFtoc1C0HPcmmMxeFIN2DQ4EZETo9jba6xHw2suq8k/kEW2RSqpLmpB69tAqgCXslsj65luFOjSbQp5zV4M63t6Y8vAuX2ZOF5i5Db/hJn/cmPoDOoIWzR0U7F5BosQs5eJPGY1LFQpXQurR7Q4a2wathN5eOtw0Xxi3IInVhxZ3usgc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2019 22:09:05.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeda84d1-eacd-4710-2e42-08d74072a62e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Sep 06, 2019 at 06:47:09PM +0000, John Stultz wrote:
> Add generic helper dmabuf ops for dma heaps, so we can reduce
> the amount of duplicative code for the exported dmabufs.
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

Two minor things below.

> ---
> v2:
> * Removed cache management performance hack that I had
>   accidentally folded in.
> * Removed stats code that was in helpers
> * Lots of checkpatch cleanups
> v3:
> * Uninline INIT_HEAP_HELPER_BUFFER (suggested by Christoph)
> * Switch to WARN on buffer destroy failure (suggested by Brian)
> * buffer->kmap_cnt decrementing cleanup (suggested by Christoph)
> * Extra buffer->vaddr checking in dma_heap_dma_buf_kmap
>   (suggested by Brian)
> * Switch to_helper_buffer from macro to inline function
>   (suggested by Benjamin)
> * Rename kmap->vmap (folded in from Andrew)
> * Use vmap for vmapping - not begin_cpu_access (folded in from
>   Andrew)
> * Drop kmap for now, as its optional (folded in from Andrew)
> * Fold dma_heap_map_user into the single caller (foled in from
>   Andrew)
> * Folded in patch from Andrew to track page list per heap not
>   sglist, which simplifies the tracking logic
> v4:
> * Moved dma-heap.h change out to previous patch
> v6:
> * Minor cleanups and typo fixes suggested by Brian
> v7:
> * Removed stray ;
> * Make init_heap_helper_buffer lowercase, as suggested by Christoph
> * Add dmabuf export helper to reduce boilerplate code
> v8:
> * Remove unused private_flags value
> * Condense dma_heap_buffer and heap_helper_buffer (suggested by
>   Christoph)
> * Fix indentation by using shorter argument names (suggested by
>   Christoph)
> * Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
>   (suggested by Christoph)
> * Checkpatch whitespace fixups
> ---

...

> +
> +static void *dma_heap_buffer_vmap_get(struct heap_helper_buffer *buffer)
> +{
> +	void *vaddr;
> +
> +	if (buffer->vmap_cnt) {
> +		buffer->vmap_cnt++;
> +		return buffer->vaddr;
> +	}
> +	vaddr =3D dma_heap_map_kernel(buffer);
> +	if (WARN_ONCE(!vaddr,
> +		      "heap->ops->map_kernel should return ERR_PTR on error"))

Looks like the message is out-of-date here.

...

> +
> +/**
> + * struct heap_helper_buffer - helper buffer metadata
> + * @heap:		back pointer to the heap the buffer came from
> + * @dmabuf:		backing dma-buf for this buffer
> + * @size:		size of the buffer
> + * @flags:		buffer specific flags
> + * @priv_virt		pointer to heap specific private value
> + * @lock		mutext to protect the data in this structure
> + * @vmap_cnt		count of vmap references on the buffer
> + * @vaddr		vmap'ed virtual address
> + * @pagecount		number of pages in the buffer
> + * @pages		list of page pointers
> + * @attachment		list of device attachments

s/attachment/attachments/

With those fixed, feel free to add:

Reviewed-by: Brian Starkey <brian.starkey@arm.com>

Thanks,
-Brian

