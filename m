Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01935C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A8D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4GmL0YL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDLAV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:21:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59380 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDLAV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:21:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C09vn3149950;
        Fri, 12 Apr 2019 00:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=wN/MwZ3CVa4Cm3tgRbC0EkkYzPMnWNJvAXa/v3LMrCA=;
 b=4GmL0YL8HgIh0lfuNAIhLi5fgFMUu2v65Y9ITCJUrco5tdXqHMiI7sjqKva+q/IdoPV4
 4lnjPnOyQad/Y7YUD+WdxA5cDCUZAqRk75RQM4abkGeWhopuAn73QSGenjkFJ02EtiSH
 wnSRoO6j7DHMxy8Rs6jeCqZzb60FxsOY7rg26pMdb7dYGHmrTkR81Zk+XCDFPHv9yXRz
 Xsl5FFNM8biFeY5wTnAM5sf88xahOADUgETRVmB5Co6smflVpFi/JBOQ0CJHtS5AkNar
 QgaVNOsAzOHe39vEP3kuXZ3e9rUEyA06EbK56c4NrHnatnNmFZ19y5MTdObYf5LbczZV xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2rphmeuyxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 00:21:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3C0Jhqf176560;
        Fri, 12 Apr 2019 00:19:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2rpytd2hnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 00:19:44 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3C0JgWA022936;
        Fri, 12 Apr 2019 00:19:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Apr 2019 17:19:42 -0700
Date:   Thu, 11 Apr 2019 17:19:41 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: use struct_size() helper
Message-ID: <20190412001941.GV15524@magnolia>
References: <20190411233758.GA19031@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411233758.GA19031@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120000
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[fixing linux-xfs cc]

On Thu, Apr 11, 2019 at 06:37:58PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded  version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace code of the following form:
> 
> sizeof(*alist) + context->count * sizeof(alist->al_offset[0]
> 
> with:
> 
> struct_size(alist, al_offset, context->count)
> 
> and remove unnecessary variable arraytop.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Has this been run through xfstests?

--D

>  fs/xfs/xfs_attr_list.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
> index 3d213a7394c5..05e03348553e 100644
> --- a/fs/xfs/xfs_attr_list.c
> +++ b/fs/xfs/xfs_attr_list.c
> @@ -553,7 +553,6 @@ xfs_attr_put_listent(
>  {
>  	struct attrlist *alist = (struct attrlist *)context->alist;
>  	attrlist_ent_t *aep;
> -	int arraytop;
>  
>  	ASSERT(!context->seen_enough);
>  	ASSERT(!(context->flags & ATTR_KERNOVAL));
> @@ -572,10 +571,8 @@ xfs_attr_put_listent(
>  	    ((flags & XFS_ATTR_ROOT) == 0))
>  		return;
>  
> -	arraytop = sizeof(*alist) +
> -			context->count * sizeof(alist->al_offset[0]);
>  	context->firstu -= ATTR_ENTSIZE(namelen);
> -	if (context->firstu < arraytop) {
> +	if (context->firstu < struct_size(alist, al_offset, context->count)) {
>  		trace_xfs_attr_list_full(context);
>  		alist->al_more = 1;
>  		context->seen_enough = 1;
> -- 
> 2.21.0
> 
