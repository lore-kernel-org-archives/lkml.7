Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605522133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iqrW8vgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfDAUfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:35:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41070 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDAUfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:35:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x31KYbHi112171;
        Mon, 1 Apr 2019 20:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Oz2lBXpFOO7Uhfmu91wpRbUCZwJBC1fFr2TeZERUG6E=;
 b=iqrW8vgHRwoW85biQdhRJl+cEn03OGd8nzgyym/QkFNtfTZw9qHDzJQj8dL3QhwhLy6H
 uAY5xGz2YxXWYfG7085EHCFsBUyYYFEe2yWW22YFNGmmB7DYTLULRBH6m5DsfkIyN9yw
 qc4uUDhqj+pqHYgvFhHzA+5sjreDMwmgWARBKLuZaQZe+5S+Uqf8lssLkx/GfZRLPm/R
 72IakgpBIJ4DwmY6AolpOdwQrjsvqA9g8vmpWocW6EgRH89pZJqiAZLPzkNm6nZnESIz
 8ldZpVZXa8bhouOWfUoS618HstzYeNxPEloqyKmbhKs/8upj3fYNe6jlDRbA6OAAJM3B qA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2rhyvt1d96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Apr 2019 20:35:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x31KZHNa010081
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 20:35:18 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x31KZHkw009985;
        Mon, 1 Apr 2019 20:35:17 GMT
Received: from localhost (/67.161.8.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 13:35:15 -0700
Date:   Mon, 1 Apr 2019 13:35:14 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs/open: Fix most outstanding security bugs
Message-ID: <20190401203514.GC1177@magnolia>
References: <20190401090113.22946-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401090113.22946-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904010133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:01:13AM +0200, Johannes Thumshirn wrote:
> Over the last 20 years, the Linux kernel has accumulated hundreds if not
> thousands of security vulnerabilities.
> 
> One common pattern in most of these security related reports is processes
> called "syzkaller", "trinity" or "syz-executor" opening files and then
> abuse kernel interfaces causing kernel crashes or even worse threats using
> memory overwrites or by exploiting race conditions.
> 
> Hunting down these bugs has become time consuming and very expensive, so
> I've decided to put an end to it.
> 
> If one of the above mentioned processes tries opening a file, return -EPERM
> indicating this process does not have the permission to open files on Linux
> anymore.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/open.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index f1c2f855fd43..3a3b460beccd 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1056,6 +1056,20 @@ long do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)
>  	struct open_flags op;
>  	int fd = build_open_flags(flags, mode, &op);
>  	struct filename *tmp;
> +	char comm[TASK_COMM_LEN];
> +	int i;
> +	static const char * const list[] = {
> +		"syzkaller",
> +		"syz-executor,"
> +		"trinity",
> +		NULL
> +	};

This makes no sense, why would you gate on "syz-executor,trinity"?

> +
> +	get_task_comm(comm, current);
> +
> +	for (i = 0; i < ARRAY_SIZE(list); i++)
> +		if (!strncmp(comm, list[i], strlen(list[i])))
> +			return -EPERM;

This is insufficient, because this isn't the only way to open a file.

Wouldn't it be far more effective to use copy_to_user to inject
shellcode into the syzkaller image and change the return address, to
find all the places where syzbot doesn't validate itself sufficiently?
In Soviet Russia, the kernel syzkallz you.

NAK.

--D

>  
>  	if (fd)
>  		return fd;
> -- 
> 2.16.4
> 
