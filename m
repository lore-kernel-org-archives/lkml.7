Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921EC217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qSBiSBE8";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JVW1ym7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfCNSw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:52:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727087AbfCNSwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:52:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x2EIfZmD019718;
        Thu, 14 Mar 2019 11:52:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=d2sSbapTwcTumnN3OeKt94fU0GIneXeAloWPROv4/aY=;
 b=qSBiSBE83byOIbuhfzU8izXuDXszokIVO/BelPytXXa9QGrZB5Y5k4NSaqc8+Kpsx+Nr
 AM5Xai+A/S2fDtivFRJylyQMaRIdDMscYset3J3pb2QKY5T9/egJq78EOt53Mfz5Iv0C
 ivq2/LOBBsqVHfo0GFyqhYMg7cuKJeJh8BY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2r7u1c0cxp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Mar 2019 11:52:40 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 14 Mar 2019 11:52:27 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 14 Mar 2019 11:52:27 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Mar 2019 11:52:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2sSbapTwcTumnN3OeKt94fU0GIneXeAloWPROv4/aY=;
 b=JVW1ym7uVrnjrSYn0tokbfMZeZRg79IhKCcurThph2ab89zxOCU5NZk0b3je4wIcW6nUqseAwLdG9P5qlhZRWpsGefSzohHHkFQiRRbNDS5xUallENJFm+GeObWOgLbJYzabjyg2QUDWnIigqWr9FbPC+ECU8NVipXu3HqqZf4c=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2696.namprd15.prod.outlook.com (20.179.156.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 18:52:25 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 18:52:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] slob: Use slab_list instead of lru
Thread-Topic: [PATCH v3 3/7] slob: Use slab_list instead of lru
Thread-Index: AQHU2idNmO7zKpJyvkWsK1RfI7m50qYLec2A
Date:   Thu, 14 Mar 2019 18:52:25 +0000
Message-ID: <20190314185219.GA6441@tower.DHCP.thefacebook.com>
References: <20190314053135.1541-1-tobin@kernel.org>
 <20190314053135.1541-4-tobin@kernel.org>
In-Reply-To: <20190314053135.1541-4-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0057.namprd10.prod.outlook.com
 (2603:10b6:300:2c::19) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:75e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ed1969a-39c9-4cdf-57d8-08d6a8ae32a3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2696;
x-ms-traffictypediagnostic: BYAPR15MB2696:
x-microsoft-antispam-prvs: <BYAPR15MB2696C3686D4CF900C41F6BAEBE4B0@BYAPR15MB2696.namprd15.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(136003)(376002)(396003)(199004)(189003)(105586002)(476003)(14444005)(81166006)(6512007)(9686003)(76176011)(53936002)(6436002)(52116002)(1076003)(81156014)(478600001)(2906002)(68736007)(256004)(486006)(99286004)(186003)(71190400001)(446003)(11346002)(102836004)(14454004)(8676002)(97736004)(33656002)(4326008)(71200400001)(8936002)(86362001)(386003)(6506007)(6916009)(6116002)(305945005)(316002)(5660300002)(6246003)(229853002)(54906003)(25786009)(46003)(106356001)(6486002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2696;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4SqkHJjiZgFSRKvQTUiE8KWQCcNMZH0UK1Dn08ktcBinAcbkvX0ToXoOGSm5sjMyi9AHvSqHvT7ZCSN971oC2CmD2nWDf36KeJYT1BVNFfkk8YlQieYDLHpiZayQZ0pBwVSxIK4cvEfP1bYOpy3DJMB16CJD1+cohSbW5j9+mrI3SmWCMfOsFunO7AxxojWt6wn0lfsGaJhOniIt8umcB2WIyW8ykeqmlbSHfc03W7XFVX2mOSNE/h1FYFbyro9dbo0ZpiN7/y8M2nRK56VcEi/KQ8DRZWV38EsfcAtr4v6OAIvdDvcrLjk3U18vr0+gvkjSgujbYuXQ7sxmuWCUh1MJcH8iuIjnd2Qn2kdGa6pnPjpWxjMDIaA+YBaPaOhbEklL+gaa7eNZhafF1GBOD/mMc0xh3ECFM43Rrn4FXiE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76F232CD9CBEB9408671DA8ADAC23A3E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed1969a-39c9-4cdf-57d8-08d6a8ae32a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 18:52:25.0327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2696
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 04:31:31PM +1100, Tobin C. Harding wrote:
> Currently we use the page->lru list for maintaining lists of slabs.  We
> have a list_head in the page structure (slab_list) that can be used for
> this purpose.  Doing so makes the code cleaner since we are not
> overloading the lru list.
>=20
> The slab_list is part of a union within the page struct (included here
> stripped down):
>=20
> 	union {
> 		struct {	/* Page cache and anonymous pages */
> 			struct list_head lru;
> 			...
> 		};
> 		struct {
> 			dma_addr_t dma_addr;
> 		};
> 		struct {	/* slab, slob and slub */
> 			union {
> 				struct list_head slab_list;
> 				struct {	/* Partial pages */
> 					struct page *next;
> 					int pages;	/* Nr of pages left */
> 					int pobjects;	/* Approximate count */
> 				};
> 			};
> 		...
>=20
> Here we see that slab_list and lru are the same bits.  We can verify
> that this change is safe to do by examining the object file produced from
> slob.c before and after this patch is applied.
>=20
> Steps taken to verify:
>=20
>  1. checkout current tip of Linus' tree
>=20
>     commit a667cb7a94d4 ("Merge branch 'akpm' (patches from Andrew)")
>=20
>  2. configure and build (select SLOB allocator)
>=20
>     CONFIG_SLOB=3Dy
>     CONFIG_SLAB_MERGE_DEFAULT=3Dy
>=20
>  3. dissasemble object file `objdump -dr mm/slub.o > before.s
>  4. apply patch
>  5. build
>  6. dissasemble object file `objdump -dr mm/slub.o > after.s
>  7. diff before.s after.s
>=20
> Use slab_list list_head instead of the lru list_head for maintaining
> lists of slabs.
>=20
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  mm/slob.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/slob.c b/mm/slob.c
> index 39ad9217ffea..94486c32e0ff 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -112,13 +112,13 @@ static inline int slob_page_free(struct page *sp)
> =20
>  static void set_slob_page_free(struct page *sp, struct list_head *list)
>  {
> -	list_add(&sp->lru, list);
> +	list_add(&sp->slab_list, list);
>  	__SetPageSlobFree(sp);
>  }
> =20
>  static inline void clear_slob_page_free(struct page *sp)
>  {
> -	list_del(&sp->lru);
> +	list_del(&sp->slab_list);
>  	__ClearPageSlobFree(sp);
>  }
> =20
> @@ -282,7 +282,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int a=
lign, int node)
> =20
>  	spin_lock_irqsave(&slob_lock, flags);
>  	/* Iterate through each partially free page, try to find room */
> -	list_for_each_entry(sp, slob_list, lru) {
> +	list_for_each_entry(sp, slob_list, slab_list) {
>  #ifdef CONFIG_NUMA
>  		/*
>  		 * If there's a node specification, search for a partial


Hi Tobin!

How about list_rotate_to_front(&next->lru, slob_list) from the previous pat=
ch?
Shouldn't it use slab_list instead of lru too?

Thanks!
