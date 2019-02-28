Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC59C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE22205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MzWmVYRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbfB1Mxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:53:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44420 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfB1Mxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:53:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1SCrOID024718;
        Thu, 28 Feb 2019 12:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=po1j0KR6Nm5uwMVtLQBfkhGgL9CUys0U0tbhsXrVkfA=;
 b=MzWmVYRiBNZL6OcOVaXsbG5quyRc59s7Y6Tvf/uedlIRVDM18oCZDX3SNrxepYg0vrEg
 fYsITvmGnd8z+tlkxGpmY4Xk0KhJkDszLmRIvSQnso+gjUsnCp41ip8+vjYvhrIllD78
 9Z3ZXPeRRdwsl49Ha5+dYHC1qEA/hZYumcKBAGlP+StR8/fOurovOl8oRPiguss9rKYB
 vsFicvcATiTBr2DrtE4yybve2E8S5MjmFZ98GBfnVZrYRLrkUPeWSQvI1tfCGl7XgNg3
 4s2xN57ZxGRgkJ/v0Fq1ZwnLdBIG6W0njK/J4MIogGT9272XsEKfA2hPwrljOd2Ng0pt 5Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qtwkuguak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 12:53:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1SCrfsI029788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 12:53:41 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1SCrd6r030348;
        Thu, 28 Feb 2019 12:53:40 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 04:53:39 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH v2 2/4] mm: remove zone_lru_lock() function access
 ->lru_lock directly
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190228083329.31892-2-aryabinin@virtuozzo.com>
Date:   Thu, 28 Feb 2019 05:53:37 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AF5AEF9-FF0A-41C1-834A-4C33EBD0CA09@oracle.com>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
 <20190228083329.31892-2-aryabinin@virtuozzo.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9180 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902280090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 28, 2019, at 1:33 AM, Andrey Ryabinin <aryabinin@virtuozzo.com> =
wrote:

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a9852ed7b97f..2d081a32c6a8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1614,8 +1614,8 @@ static __always_inline void =
update_lru_sizes(struct lruvec *lruvec,
>=20
> }
>=20
> -/*
> - * zone_lru_lock is heavily contended.  Some of the functions that
> +/**

Nit: Remove the extra asterisk here; the line should then revert to =
being unchanged from
the original.

