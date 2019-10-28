Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7077CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2DE20862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QZ3mFo4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfJ1HVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:21:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44484 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbfJ1HVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:21:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S7JGF8158431;
        Mon, 28 Oct 2019 07:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=6UrEt8Yob0WvnmAEmegBqErzZ/vNf8vt6/tp3mnw1QE=;
 b=QZ3mFo4dfKxKWOxUf6tINRvNo006Y5lDeMmbZsbVUFo7aYrvSdpBSJY2p8gki1dfWCvF
 k7QB2fwdMVRYpGzKuGUDYuxfsuS1kav/Mln3nN6gymXwknafBlsx7b37p6AvDvHHBO7f
 T2t9cuDpnbUYBQLN8CmI2OLiTf5EW0rLDDBAhNCg0O4ImO0MzJopRn1qaSssxkt2zv0U
 6A0gwzsPllysVcXgprVZdlfrJEpLvodyZQdcxx9YTrA+heH6bSwppYquJDdtLss1NXNj
 6Kv1sS7i7T9HtsDg7xfZuoQWgWMTPc+a4HE4dB6R8/94IUSqxrQLMzB2czwEml7yRnBh qQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vve3pyyjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 07:21:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S7JSsE168600;
        Mon, 28 Oct 2019 07:19:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vwakxgjfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 07:19:30 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9S7J2ZJ004438;
        Mon, 28 Oct 2019 07:19:04 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 00:19:02 -0700
Date:   Mon, 28 Oct 2019 10:18:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel: sys.c: Avoid copying possible padding bytes in
 copy_to_user
Message-ID: <20191028071856.GA1944@kadam>
References: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa331c00881d61c8ee51577a082d8bebd61805c.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=884
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=964 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 12:46:08PM -0700, Joe Perches wrote:
> Initialization is not guaranteed to zero padding bytes so
> use an explicit memset instead to avoid leaking any kernel
> content in any possible padding bytes.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  kernel/sys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a611d1..3459a5 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1279,11 +1279,13 @@ SYSCALL_DEFINE1(uname, struct old_utsname __user *, name)
>  
>  SYSCALL_DEFINE1(olduname, struct oldold_utsname __user *, name)
>  {
> -	struct oldold_utsname tmp = {};
> +	struct oldold_utsname tmp;

oldold_utsname doesn't have an struct holes.  It looks like this:

struct oldold_utsname {
        char sysname[9];
        char nodename[9];
        char release[9];
        char version[9];
        char machine[9];
};

regards,
dan carpenter

