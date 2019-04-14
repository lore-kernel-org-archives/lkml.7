Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33561C10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5172084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 01:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mTa+071Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDNBDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 21:03:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33164 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDNBDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 21:03:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3E0wUCF015722;
        Sun, 14 Apr 2019 01:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Jjtt1C4q5jJWXIAVbQkI9RXn6+bD9T+MgROnOkgii0s=;
 b=mTa+071ZJ/chh/hRCIC//XjFMdvfIw4Pfig3LFU8He+Snmuv3rmda4o4fknDCWGPaRX6
 BCYOkJEXvmX4jGJNetAfOHMHKvWYzwwcOiNOGEk0N7dk5xXmsDIO0/vxjcl35ygDQYiT
 DBrb7AqxwvzWWcOelvQuR6AJ7z8mXR0EsgIVdfas7np+ATlLyz8z/2hp47vs5CS33IYw
 N7/MjVtjvUQ1TkgxERPSWkVZKbi15P7gHiJKc+s8EQDvAFTignKulOFrp+bOWXdsDiVG
 HhyDiF58Hssu7MDvTxy20iFr5fStJkOBYnM3E26QK+ssYXA/J3P/vPsTTe9tIdjwk1Qs cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ru59ct5u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 01:02:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3E12GKc039346;
        Sun, 14 Apr 2019 01:02:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2rubq55y7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 01:02:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3E12tNh017588;
        Sun, 14 Apr 2019 01:02:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Apr 2019 18:02:54 -0700
Date:   Sat, 13 Apr 2019 18:02:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Shawn Landden <shawn@git.icu>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new flag COPY_FILE_RANGE_FILESIZE for copy_file_range()
Message-ID: <20190414010254.GA7408@magnolia>
References: <20190413205439.9623-1-shawn@git.icu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413205439.9623-1-shawn@git.icu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9226 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=100 mlxscore=100 mlxlogscore=-1000
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904140005
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9226 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=100 clxscore=1011
 lowpriorityscore=0 mlxscore=100 impostorscore=0 mlxlogscore=-1000
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904140005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 03:54:39PM -0500, Shawn Landden wrote:

/me pulls out his close-reading glasses and the copy_file_range manpage...

> If flags includes COPY_FILE_RANGE_FILESIZE then the length
> copied is the length of the file. off_in and off_out are
> ignored.  len must be 0 or the file size.

They're ignored?  As in the copy operation reads the number of bytes in
the file referenced by fd_in from fd_in at its current position and is
writes that out to fd_out at its current position?  I don't see why I
would want such an operation...

...but I can see how people could make use of a CFR_ENTIRE_FILE that
would check that both file descriptors are actually regular files, and
if so copy the entire contents of the fd_in file into the same position
in the fd_out file, and then set the fd_out file's length to match.  If
@off_in or @off_out are non-NULL then they'll be updated to the new EOFs
if the copy completes succesfully and @len can be anything.

Also: please update the manual page and the xfstests regression test for
this syscall.

> This implementation saves a call to stat() in the common case
> of copying files. It does not fix any race conditions, but that
> is possible in the future with this interface.
> 
> EAGAIN: If COPY_FILE_RANGE_FILESIZE was passed and len is not 0
> or the file size.

The values are invalid, so why would we tell userspace to try again
instead of the EINVAL that we usually use?

> Signed-off-by: Shawn Landden <shawn@git.icu>
> CC: <linux-api@vger.kernel.org>
> ---
>  fs/read_write.c           | 14 +++++++++++++-
>  include/uapi/linux/stat.h |  4 ++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 61b43ad7608e..6d06361f0856 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1557,7 +1557,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_out = file_inode(file_out);
>  	ssize_t ret;
>  
> -	if (flags != 0)
> +	if ((flags & ~COPY_FILE_RANGE_FILESIZE) != 0)

FWIW you might as well shorten the prefix to "CFR_" since nobody else is
using it.

--D

>  		return -EINVAL;
>  
>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
> @@ -1565,6 +1565,18 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>  	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
>  		return -EINVAL;
>  
> +	if (flags & COPY_FILE_RANGE_FILESIZE) {
> +		struct kstat stat;
> +		int error;
> +		error = vfs_getattr(&file_in->f_path, &stat,
> +				    STATX_SIZE, 0);
> +		if (error < 0)
> +			return error;
> +		if (!(len == 0 || len == stat.size))
> +			return -EAGAIN;
> +		len = stat.size;
> +	}
> +
>  	ret = rw_verify_area(READ, file_in, &pos_in, len);
>  	if (unlikely(ret))
>  		return ret;
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7b35e98d3c58..1075aa4666ef 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -170,5 +170,9 @@ struct statx {
>  
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
>  
> +/*
> + * Flags for copy_file_range()
> + */
> +#define COPY_FILE_RANGE_FILESIZE	0x00000001 /* Copy the full length of the input file */
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> -- 
> 2.20.1
> 
