Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570902087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AkkaOKgR";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="EFvMpZdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfCLAQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:16:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33106 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfCLAQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:16:24 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C02p0U031837;
        Mon, 11 Mar 2019 17:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yEsQic9A0/OZ7vFfSurRTqbvcYZcuYEV+T9ohUAOMwc=;
 b=AkkaOKgRjZDMxGwCUNn1PNDPvyNj34mO+vmqHEuy3JJKr8EaFH72bM/BxZOS2u/xguDy
 Gv++ftOv/FJjTm/v/dM+Toy9oCCi9dfatuzinTggNkG6s5/Rm9eIjf3e3OUK/QQX3N1S
 hrSdTNIGP4bysqYAFVjbev0NK+AaXofGmnQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5yahgmg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 17:16:10 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 17:16:09 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 17:16:09 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 17:16:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEsQic9A0/OZ7vFfSurRTqbvcYZcuYEV+T9ohUAOMwc=;
 b=EFvMpZdn5wTFgZHNPfFmkTWFvlEP3lw35xRK6ip1q9M/nz9/8Ov9LN2QTG7h/SBOd/DcSFeWUg7WCT1BFdp9JdYFJXiPP/vq7BstGRPO2CoFQ0m6985xMrPV9hr7IG4o8gqMB2wLIIlUcZF1SbdDfwc7mjHIlpToG2TlCupzlVY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2951.namprd15.prod.outlook.com (20.178.237.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Tue, 12 Mar 2019 00:16:07 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 00:16:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 12/15] xarray: Implement migration function for objects
Thread-Topic: [RFC 12/15] xarray: Implement migration function for objects
Thread-Index: AQHU1WWo/dXt33FMnkORmiARkMoWrqYHJsEA
Date:   Tue, 12 Mar 2019 00:16:07 +0000
Message-ID: <20190312001602.GB25059@tower.DHCP.thefacebook.com>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-13-tobin@kernel.org>
In-Reply-To: <20190308041426.16654-13-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:300:ed::18) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b487]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6924867f-88bc-4545-b12e-08d6a67fec01
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2951;
x-ms-traffictypediagnostic: BYAPR15MB2951:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2951;20:YidRqfCZ9gfSPGeHMDzBjxi3dTUj1yciuvfhLE2i2SZ+Yzk15elcOfrd+VJHqKf/Ms5TIo0MkfnAZFlBQ1ws8eeH8dzfjZf1GVfnN1B9FYqpOKTmQZPyKImVE8c4OLVAm5OnZJ3TBFGVHNgiAYwugBYQlI3gq1icTB2ULWhp1jY=
x-microsoft-antispam-prvs: <BYAPR15MB2951739B6DC78D4080D8B0A5BE490@BYAPR15MB2951.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(46003)(256004)(6916009)(102836004)(6246003)(6116002)(81166006)(81156014)(8936002)(186003)(97736004)(6512007)(478600001)(8676002)(6436002)(9686003)(6486002)(7736002)(14454004)(53936002)(305945005)(229853002)(4326008)(6506007)(76176011)(106356001)(316002)(54906003)(386003)(105586002)(2906002)(99286004)(476003)(86362001)(486006)(11346002)(68736007)(5660300002)(52116002)(446003)(33656002)(71190400001)(1076003)(71200400001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2951;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cOW+58xwgkGYA8bzWzgQhsMtO8NZg6Jkt+k3GdLOZOZmO+mINWYg3liUiaMwgbG0fX6AAZGNEnwzngvd1FJO0sOLRnjN5x/xrT/JkzgCDAGhpMdm84sqp98vf1QJuvJuSmMdh7sYm2aooktBYSQrzAt4Nw+pbUtnNglpGvnmkXKjT7HHvkB1WTwO1Cz2Mt+AvU7tGvOcSKYcrCZgKdXSuN17tBP9uIaG72btsLralDe21n5NW0G24Jbk1BOuawbfb0umpih2BlEqtRbkOQ4jOf7ewGRSE9PWAL3izaC+53x4oRiYHnzp4aRlDyEEX4ZximtqGQ6eMHWk7pGH1fWNbpZcbsESkoqIUHmj1iO0jFIHeWVprf5T+P18uu/xrGDXzMnIr5w978nmomyWzvo5hzcoVb+/6RwvqNSFuY+pAbE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69B394CDEC3A1442927A6A5F0A9F8DC3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6924867f-88bc-4545-b12e-08d6a67fec01
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 00:16:07.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2951
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:14:23PM +1100, Tobin C. Harding wrote:
> Implement functions to migrate objects. This is based on
> initial code by Matthew Wilcox and was modified to work with
> slab object migration.
>=20
> Co-developed-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  lib/radix-tree.c | 13 +++++++++++++
>  lib/xarray.c     | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>=20
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index 14d51548bea6..9412c2853726 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -1613,6 +1613,17 @@ static int radix_tree_cpu_dead(unsigned int cpu)
>  	return 0;
>  }
> =20
> +extern void xa_object_migrate(void *tree_node, int numa_node);
> +
> +static void radix_tree_migrate(struct kmem_cache *s, void **objects, int=
 nr,
> +			       int node, void *private)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < nr; i++)
> +		xa_object_migrate(objects[i], node);
> +}
> +
>  void __init radix_tree_init(void)
>  {
>  	int ret;
> @@ -1627,4 +1638,6 @@ void __init radix_tree_init(void)
>  	ret =3D cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
>  					NULL, radix_tree_cpu_dead);
>  	WARN_ON(ret < 0);
> +	kmem_cache_setup_mobility(radix_tree_node_cachep, NULL,
> +				  radix_tree_migrate);
>  }
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 81c3171ddde9..4f6f17c87769 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -1950,6 +1950,50 @@ void xa_destroy(struct xarray *xa)
>  }
>  EXPORT_SYMBOL(xa_destroy);
> =20
> +void xa_object_migrate(struct xa_node *node, int numa_node)
> +{
> +	struct xarray *xa =3D READ_ONCE(node->array);
> +	void __rcu **slot;
> +	struct xa_node *new_node;
> +	int i;
> +
> +	/* Freed or not yet in tree then skip */
> +	if (!xa || xa =3D=3D XA_FREE_MARK)
> +		return;

XA_FREE_MARK is equal to 0, so the second check is redundant.

#define XA_MARK_0		((__force xa_mark_t)0U)
#define XA_MARK_1		((__force xa_mark_t)1U)
#define XA_MARK_2		((__force xa_mark_t)2U)
#define XA_PRESENT		((__force xa_mark_t)8U)
#define XA_MARK_MAX		XA_MARK_2
#define XA_FREE_MARK		XA_MARK_0

xa_node_free() sets node->array to XA_RCU_FREE, so maybe it's
what you need. I'm not sure however, Matthew should know better.

> +
> +	new_node =3D kmem_cache_alloc_node(radix_tree_node_cachep,
> +					 GFP_KERNEL, numa_node);

We need to check here if the allocation was successful.

Thanks!
