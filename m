Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F888C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16E220820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1tOYVW57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDJTwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:52:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51548 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDJTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:52:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AJnFur184681;
        Wed, 10 Apr 2019 19:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=i0h0mKYIzGcSkp5GyeepgfefbxGRwGYGQncX7cOrT6w=;
 b=1tOYVW57t2rluwais3CojTvoD/wFtYokHlbA86Meti1k38JNCkz+ytqD0e4y2ohUXj00
 hWJ7uU1/IRPeJlzJBs0COFVF8TbggPc/vlB8OiSYxnUaYLc7wY08hq4SCouX6VBNB4Xs
 erH4iQYVwNCwyIKb9686kSmdRsL0Ro0chDsevnacix2W8sXTB6acrwCvT0isuXlP4iyS
 YRGBXR0SO/bVBgn64tX+5rrNBNYVfVFpI6AeFe4VF6UGDZv7HcKNqlRU5HIFq4t2Cpp6
 NRcHusZ9+yTcXcwkGv2PIKtxmYRtJKUktkjCZ3w4UQHcWAW2lv7WGGz7Vx985PB4VGUQ ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rpkht57h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 19:52:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3AJperI142730;
        Wed, 10 Apr 2019 19:52:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rpytce9x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 19:52:28 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3AJqP9c021695;
        Wed, 10 Apr 2019 19:52:25 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Apr 2019 12:52:25 -0700
Date:   Wed, 10 Apr 2019 22:52:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Karen Xie <kxie@chelsio.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] scsi: cxgbi: remove redundant __kfree_skb call on
 skb and free cst->atid
Message-ID: <20190410195215.GH6095@kadam>
References: <20190410155431.10045-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410155431.10045-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100129
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:54:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error return path via label rel_resource checks for a non-null
> skb before free'ing it.  However, skb is always null at this exit
> path, so the null check and the free are redundant and can be removed.
> Removing this allows the original goto's to rel_resource to be cleaned
> up; the first can be replaced by a return of -EINVAL, the second can
> be replaced by a more appropriate -ENOMEM return and fix a memory
> leak by freeing csk->atid
> 
> Addresses-Coverity: ("Logically Dead Code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: Ensure cst->atid is free'd to fix memory leak, thanks to
>     Walter Harms for spotting this mistake in V1.
> ---
>  drivers/scsi/cxgbi/cxgb3i/cxgb3i.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> index 75e1273a44b3..15a48c2ac536 100644
> --- a/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> +++ b/drivers/scsi/cxgbi/cxgb3i/cxgb3i.c
> @@ -979,14 +979,16 @@ static int init_act_open(struct cxgbi_sock *csk)
>  	csk->atid = cxgb3_alloc_atid(t3dev, &t3_client, csk);
>  	if (csk->atid < 0) {
>  		pr_err("NO atid available.\n");
> -		goto rel_resource;
> +		return -EINVAL;
>  	}
>  	cxgbi_sock_set_flag(csk, CTPF_HAS_ATID);
>  	cxgbi_sock_get(csk);
        ^^^^^^^^^^^^^^^^^^^
Don't we need to a put for this as well?

>  
>  	skb = alloc_wr(sizeof(struct cpl_act_open_req), 0, GFP_KERNEL);
> -	if (!skb)
> -		goto rel_resource;
> +	if (!skb) {
> +		cxgb3_free_atid(t3dev, csk->atid);
> +		return -ENOMEM;
> +	}


regards,
dan carpenter

