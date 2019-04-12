Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DACC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A7D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2OfrfLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLGaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:30:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52452 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDLGai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:30:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C6TMZu012974;
        Fri, 12 Apr 2019 06:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WMO0fWyAZSW3DgS7if0+YJUXKA5pbNK0NyskqzxzTnM=;
 b=U2OfrfLMiDCNG/MQrwKcExaC0KlzDWPRrq2UxXr8NPmEGHIR5AMD3toaAid1htm9fm7h
 E73zt1FW7DrI+EvXTVhmZk7rEcGgKIBPRgOAEi7XBQjQyyCZQHDbxQHtU5cl2R/nrmOH
 AZpYYQTMmvjsye13OsqaLwMgM5eJMH44wnJNBXA56YWBp1Ji8H87PU9/VaxbmqGppKei
 n+W6fFAvdIxJ33+2WHNlj5TPe5XZJ6UZzEmAFbDjKyTrts9C/0g+TJ1BVnpLv91UuEZ5
 5rWuzNJ8Egj5cg0+SQ1/49rDqEPLlK6QHQd3FtfmzBDH7o6jerdxIdl/Lckl649txdvS DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2rphmevteh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 06:30:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C6TueX185118;
        Fri, 12 Apr 2019 06:30:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rpytd5fkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 06:30:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3C6UPo7004477;
        Fri, 12 Apr 2019 06:30:25 GMT
Received: from localhost (/10.159.157.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 23:30:24 -0700
Date:   Thu, 11 Apr 2019 23:30:23 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: use struct_size() helper
Message-ID: <20190412063023.GI1019523@magnolia>
References: <20190411233758.GA19031@embeddedor>
 <20190412001941.GV15524@magnolia>
 <51407603-d144-ece9-6cd5-edea72374527@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51407603-d144-ece9-6cd5-edea72374527@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120044
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:57:14PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 4/11/19 7:19 PM, Darrick J. Wong wrote:
> > [fixing linux-xfs cc]
> > 
> 
> Thanks for this.
> 
> > On Thu, Apr 11, 2019 at 06:37:58PM -0500, Gustavo A. R. Silva wrote:
> >> Make use of the struct_size() helper instead of an open-coded  version
> >> in order to avoid any potential type mistakes, in particular in the
> >> context in which this code is being used.
> >>
> >> So, replace code of the following form:
> >>
> >> sizeof(*alist) + context->count * sizeof(alist->al_offset[0]
> >>
> >> with:
> >>
> >> struct_size(alist, al_offset, context->count)
> >>
> >> and remove unnecessary variable arraytop.
> >>
> >> This code was detected with the help of Coccinelle.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > Has this been run through xfstests?
> > 
> 
> No.  Is this a requirement?

Yes, since this is a change to core functionality (and my eyes aren't so
good at digging through preprocessor macros...)

--D

> Thanks
> --
> Gustavo
> 
> > --D
> > 
> >>  fs/xfs/xfs_attr_list.c | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
> >> index 3d213a7394c5..05e03348553e 100644
> >> --- a/fs/xfs/xfs_attr_list.c
> >> +++ b/fs/xfs/xfs_attr_list.c
> >> @@ -553,7 +553,6 @@ xfs_attr_put_listent(
> >>  {
> >>  	struct attrlist *alist = (struct attrlist *)context->alist;
> >>  	attrlist_ent_t *aep;
> >> -	int arraytop;
> >>  
> >>  	ASSERT(!context->seen_enough);
> >>  	ASSERT(!(context->flags & ATTR_KERNOVAL));
> >> @@ -572,10 +571,8 @@ xfs_attr_put_listent(
> >>  	    ((flags & XFS_ATTR_ROOT) == 0))
> >>  		return;
> >>  
> >> -	arraytop = sizeof(*alist) +
> >> -			context->count * sizeof(alist->al_offset[0]);
> >>  	context->firstu -= ATTR_ENTSIZE(namelen);
> >> -	if (context->firstu < arraytop) {
> >> +	if (context->firstu < struct_size(alist, al_offset, context->count)) {
> >>  		trace_xfs_attr_list_full(context);
> >>  		alist->al_more = 1;
> >>  		context->seen_enough = 1;
> >> -- 
> >> 2.21.0
> >>
