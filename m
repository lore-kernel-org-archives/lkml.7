Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22637C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D991020818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yj7sZ2la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbfCAQxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:53:34 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39608 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388993AbfCAQxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:53:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x21GnpOL015521;
        Fri, 1 Mar 2019 16:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=j4k6jLrVnlcAbIMB0yIUdCVdkW0RQdj2PTG7DoWiLGE=;
 b=Yj7sZ2la/PZpxGK/vwPTjSRo6O5i8nladTA0zCsMDSu7TBx6C361CWufB7AkoMnwFh0n
 mNOVFJI7Bb9EL1U+PUG5LeVOHsm7oryKk4zx5DnHzF6Fnnc/ig5eUAfWjumWOYXZDJBr
 mzFKi5QHt83Crb3Nz/bKniCB+sjSIkfUgLvRYTwY4GslQ2z/PEjCUWprBAt5wCMejIq5
 plRyFgIoyFMo/bbVnLSWl8r5qq3QhGT2t7wjlcxHSdT9rsplwuOIDYk+haAAu2uT+Soq
 4Il2yqAGhQFWuKTDLsQJpIsJokfGSZLxF3JW1e890ImusZYhkbj/YpgHh6lrUsAQonLA MA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qtwkurfky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Mar 2019 16:53:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x21GrT6R005516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 16:53:29 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x21GrTud010079;
        Fri, 1 Mar 2019 16:53:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Mar 2019 08:53:28 -0800
Date:   Fri, 1 Mar 2019 08:53:27 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     dhowells@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] xfs: fix reporting supported extra file attributes for
 statx()
Message-ID: <20190301165327.GQ21626@magnolia>
References: <20171031221305.12908-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171031221305.12908-1-mcgrof@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9182 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903010118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2017 at 03:13:05PM -0700, Luis R. Rodriguez wrote:
> statx(2) notes that any attribute that is not indicated as supported by
> stx_attributes_mask has no usable value. Commit 5f955f26f3d42d ("xfs: report
> crtime and attribute flags to statx") added support for informing userspace
> of extra file attributes but forgot to list these flags as supported
> making reporting them rather useless for the pedantic userspace author.
> 
> $ git describe --contains 5f955f26f3d42d04aba65590a32eb70eedb7f37d
> v4.11-rc6~5^2^2~2
> 
> Fixes: 5f955f26f3d42d ("xfs: report crtime and attribute flags to statx")
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
> 
> Its unclear why David left these out or if it was just a mistake, I checked
> the original patch thread [0] but it was not clear in the end. David?
> 
> Also, I posted a patch to add support to clearing these flags through
> xfs_repair on symlinks [1] due to the pain this can cause as you have no option
> but to use xfs_db to fix these otherwise. Since we *didn't* list these extra
> file attributes as supported, it begs the question if instead we should only
> set them *and* this mask if !S_ISLNK(inode->i_mode)).
> 
> If so, that also begs the question if we should add further sanity check
> on the xfs setattr to ensure these are never set on symbolic links, despite the
> fact that FS_IOC_FSSETXATTR ioctl won't be able to set them...
> 
> A long shot question in terms of semantics is if all the above is rather
> generic for Linux, is if the VFS should even be checking for immutable or
> append flags on unlink for symbolic links.
> 
> [0] https://patchwork.kernel.org/patch/9607879/
> [1] https://lkml.kernel.org/r/20171031215156.12544-1-mcgrof@kernel.org
> 
>  fs/xfs/xfs_iops.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 17081c77ef86..6b7d293a4aab 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -531,6 +531,10 @@ xfs_vn_getattr(
>  	if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
>  		stat->attributes |= STATX_ATTR_NODUMP;
>  
> +	stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
> +				  STATX_ATTR_APPEND |
> +				  STATX_ATTR_NODUMP);
> +

Heh, I just posted the same diff as a patch, having forgotten that this
existed.  I'll ... just take this one instead.

Sorry for whiffing on this for a year and a half(!!)

--D

>  	switch (inode->i_mode & S_IFMT) {
>  	case S_IFBLK:
>  	case S_IFCHR:
> -- 
> 2.14.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
