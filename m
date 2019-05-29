Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D656BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0FC233FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMlg+I8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfE2OBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:01:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39114 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfE2OBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:01:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TDrJA7001159;
        Wed, 29 May 2019 14:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=096L/LOXEdmc+XaWi2V/0dCL3u92z1sdlldyNO1mdgI=;
 b=nMlg+I8J1a0BUCwqzV37xbUI5/URaP1WCX6i4ybMyd2pIT5QV/ccJEJGoB8N2X4Vg5Tz
 Wc2y5oa4ocs5lGXdDZE6hHEmfm4jpAUNYiZ/dlkl4spLqRe1QwiSQC4w3lMbwKO18Wuy
 U7e3yBLQmyf/5Yd540pZEL5T6gQ0olmU2OTLtr3OJkLXKvYShLe1ja3Ewd3oLNb36NOK
 RyBvaQ7gfrXKRDWcPkTF5QmQ25+dbFT9bsj/uNvod2xON8nY31ZUsKQ5j/84uoPjv9yD
 8AmYvTV7IMhZX3S2LhCWRmGayuH8lUKTVBB8sEmR/QeElO+WwjzMVDjRsk1vlxv+dCjz wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dj5tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 14:01:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TE03Ll058476;
        Wed, 29 May 2019 14:01:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sr31v9chy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 14:01:07 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4TE11MY017847;
        Wed, 29 May 2019 14:01:01 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 07:01:01 -0700
Date:   Wed, 29 May 2019 10:01:02 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix recent_rotated history
Message-ID: <20190529140102.xfxeiv3fvcw555tv@ca-dmjordan1.us.oracle.com>
References: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
 <0354e97d-ecc5-f150-7b36-410984c666db@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0354e97d-ecc5-f150-7b36-410984c666db@virtuozzo.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:30:09AM +0300, Kirill Tkhai wrote:
> Missed Johannes :(
> 
> CC
> 
> On 28.05.2019 19:09, Kirill Tkhai wrote:
> > Johannes pointed that after commit 886cf1901db9
> > we lost all zone_reclaim_stat::recent_rotated
> > history. This commit fixes that.

Ugh, good catch.

I took another pass through this series but didn't notice anything else.

> > 
> > Fixes: 886cf1901db9 "mm: move recent_rotated pages calculation to shrink_inactive_list()"
> > Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > ---
> >  mm/vmscan.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d9c3e873eca6..1d49329a4d7d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1953,8 +1953,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
> >  	if (global_reclaim(sc))
> >  		__count_vm_events(item, nr_reclaimed);
> >  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> > -	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
> > -	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];
> > +	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
> > +	reclaim_stat->recent_rotated[1] += stat.nr_activate[1];
> >  
> >  	move_pages_to_lru(lruvec, &page_list);
> >  
> > 
> 
