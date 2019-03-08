Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7592DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4539320675
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="thbNOARm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCHAsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:48:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49324 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCHAsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:48:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x280j7UZ191051;
        Fri, 8 Mar 2019 00:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/RR5ecfrt9U2QBqkft0dpd+Ol4Yogdf9rXa72q/KpNQ=;
 b=thbNOARmZh2PMi6DP8MOjvknX0eTA5fkAN0kuW81WJByIXejh/ooRRPtD2gGGvtRQ5pA
 0G8cJVw5TocoSvGEFDXnSmR+KRVHm/JTq4BeaI+joNaRachJUtMrANSgYyUJpRPNPwcb
 GwhlxxSLQTiONt07V7zcangLB1bxDTkMIdtkA0/CiglfCSSgMezohlHvxMpRvh8cG9oh
 PFX4+lJ06DsOa35zfMHOfAYoKRL33x3jMY00PmDaOJluasdqebUbo5M4lXBe9qmS/kMb
 gTqplLIv2Om+GDEt/O5+9ca/YYUcWmpchpUwR1bXwgF34VWC5Eziwe3W/n4OeELB5LBy 2g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qyfbenw51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 00:48:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x280m4Wj030605
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 00:48:04 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x280m3VW026179;
        Fri, 8 Mar 2019 00:48:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Mar 2019 16:48:03 -0800
Date:   Thu, 7 Mar 2019 16:47:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] xfs: Zero initialize highstale and lowstale in
 xfs_dir2_leafn_add
Message-ID: <20190308004759.GB4676@magnolia>
References: <20190308003413.25068-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308003413.25068-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9188 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:34:13PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> fs/xfs/libxfs/xfs_dir2_node.c:481:6: warning: variable 'lowstale' is
> used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
> fs/xfs/libxfs/xfs_dir2_node.c:481:6: warning: variable 'highstale' is
> used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
> 
> While it isn't technically wrong, it isn't a problem in practice because
> highstale and lowstale are only initialized in xfs_dir2_leafn_add when
> compact is not zero then they are passed to xfs_dir3_leaf_find_entry,
> where they are initialized before use when compact is zero. Regardless,
> it's better not to be passing around uninitialized stack memory so zero
> initialize these variables, which silences this warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/393
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/xfs/libxfs/xfs_dir2_node.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_dir2_node.c b/fs/xfs/libxfs/xfs_dir2_node.c
> index 3b03703c5c3d..de46f26c5292 100644
> --- a/fs/xfs/libxfs/xfs_dir2_node.c
> +++ b/fs/xfs/libxfs/xfs_dir2_node.c
> @@ -444,6 +444,8 @@ xfs_dir2_leafn_add(
>  
>  	dp = args->dp;
>  	leaf = bp->b_addr;
> +	highstale = 0;
> +	lowstale = 0;

I think it would be a good idea to clean all the typedef junk out of the
function definition as well... but on its own this will at least shut up
the smatch/clang warnings, so:

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(I'll have this and the cleanup tested and ready tomorrow, probably...)

Thanks for the contribution!

--D

>  	dp->d_ops->leaf_hdr_from_disk(&leafhdr, leaf);
>  	ents = dp->d_ops->leaf_ents_p(leaf);
>  
> -- 
> 2.21.0
> 
