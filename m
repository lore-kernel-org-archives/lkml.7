Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D8FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5985220652
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXzhus8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCIRci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:32:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58750 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfCIRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:32:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x29HU7GC160241;
        Sat, 9 Mar 2019 17:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=K72n3LRR1IiXXxWI77xSvyZrgLnPxW0wTS/a3sK+pB0=;
 b=MXzhus8lLmyyHOzjbCZg3XoQ/DfutWMV+dZoyTXZ01GMmFez/xOgS4Ctf1CaRpMYbRcB
 WGO26zZUy2fogPO5ueyAI2blku2Y8EoxrZLhCy09LEO4nV48y90fXp9wsB199RejgDS/
 2zBZTDImly7jnGk9w5i+94AV+EG/kvPYhqZy/ewtsfoG+iVMfgjfIn7mIel4BbMKNIkv
 WMd9Qmw3vZ/ydLrx/zhnrXv/riZo/lqzp8RlHRJH7xO6u3FpGlvPr0PFYBh/wZMd177v
 i/N4QtgmP+qOvAl0Im/ScdEzUWd6oAp6qQ7DILMLpgO/CcBcgaRdw7PqiGbL6jUNgW2+ Cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r44wtscne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Mar 2019 17:32:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x29HWZNV002833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Mar 2019 17:32:35 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x29HWZfQ023147;
        Sat, 9 Mar 2019 17:32:35 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 09 Mar 2019 09:32:35 -0800
Date:   Sat, 9 Mar 2019 09:32:30 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Sean Fu <fxinrong@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Use kmem_zalloc for bp->b_pages.
Message-ID: <20190309173230.GA4359@magnolia>
References: <20190309153636.14154-1-fxinrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309153636.14154-1-fxinrong@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9190 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903090133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 11:36:36PM +0800, Sean Fu wrote:
> Change the allocation of bp->b_pages to use kmem_zalloc instead of
> kmem_alloc.
> Remove unnecessary memset for bp->b_pages.
> 
> This reduces text size by 42 bytes.
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   23335	    588	      8	  23931	   5d7b	./fs/xfs/xfs_buf.o
> After:
>    text	   data	    bss	    dec	    hex	filename
>   23293	    588	      8	  23889	   5d51	./fs/xfs/xfs_buf.o
> 
> Signed-off-by: Sean Fu <fxinrong@gmail.com>
> ---
>  fs/xfs/xfs_buf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 4f5f2ff3f70f..be4f740b97c1 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -289,12 +289,11 @@ _xfs_buf_get_pages(
>  		if (page_count <= XB_PAGES) {
>  			bp->b_pages = bp->b_page_array;
>  		} else {
> -			bp->b_pages = kmem_alloc(sizeof(struct page *) *
> +			bp->b_pages = kmem_zalloc(sizeof(struct page *) *
>  						 page_count, KM_NOFS);
>  			if (bp->b_pages == NULL)
>  				return -ENOMEM;
>  		}
> -		memset(bp->b_pages, 0, sizeof(struct page *) * page_count);

Does this leave b_pages uninitialized in the page_count <= XB_PAGES
case?

--D

>  	}
>  	return 0;
>  }
> -- 
> 2.16.4
> 
