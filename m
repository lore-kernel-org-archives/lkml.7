Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A90CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7878720856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3AwHM8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfJ3VEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:04:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44102 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfJ3VEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:04:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UL4NL4128665;
        Wed, 30 Oct 2019 21:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=m8BQpoKL4gVtfFSx2IrDIKqn/JTZlYXtuUr58S1gZ0c=;
 b=I3AwHM8NFCoaWStcPR5VaVGVIUPSBRnCM7BT08dsWJxFHCaiN0sPx30k6Frn6xk4ePSh
 ye9qZ1KP80FnHuA3AnUQOTxXLAeW+F8BcKWvQ/yE7kMalGp+Ck0yPY66Fbm3kvqZ0UD3
 FOhEB97BcYwp6rZ0H//q0bAl2+H6RSGius9m6L0EO6dCTBmbiSUP95fyGLi5krBsf7eS
 uR6ZQ0lLUgcTGmKJMere0GXgkBqvGy0gtWfkiUQVJJL3orkArm5QmepQ+3zKaByfd7FD
 1UoYP2SKisUuCPDV2d+M133BuqoPr1M/ZUKyfnyGmhUKaX7Cc5tnpXze1XrjSdXB1QLu pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vxwhff2cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 21:04:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9UL4OsX130182;
        Wed, 30 Oct 2019 21:04:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vxwhwtage-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 21:04:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9UL3Iov013454;
        Wed, 30 Oct 2019 21:03:19 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 14:03:18 -0700
Date:   Wed, 30 Oct 2019 17:03:14 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
Message-ID: <20191030210314.2el7wysojucqypoq@ca-dmjordan1.us.oracle.com>
References: <20191025232710.4081957-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025232710.4081957-1-guro@fb.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=729
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300183
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=816 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Fri, Oct 25, 2019 at 04:27:10PM -0700, Roman Gushchin wrote:
> page_cgroup_ino() doesn't return a valid memcg pointer for non-compund
> slab pages, because it depends on PgHead AND PgSlab flags to be set
> to determine the memory cgroup from the kmem_cache.
> It's correct for compound pages, but not for generic small pages. Those
> don't have PgHead set, so it ends up returning zero.
> 
> Fix this by replacing the condition to PageSlab() && !PageTail().

You may also want to update the comment above memcg_from_slab_page():

 * So this function assumes that the page can pass PageHead() and PageSlab()
 * checks.
