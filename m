Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4509AC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1778E21734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kPalE5uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgACIvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:51:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:51:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0038ht9v138539;
        Fri, 3 Jan 2020 08:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tzuXPE/Pks4hujfIYPzNgVGPbsKo4j/Ts3ZzA5B7ZZs=;
 b=kPalE5ucdFXLKZ/tpsrqgDQDYHOLQNdrC6ttTw+laxN2MOpmdp4wtGW3AnGnk4uQLHnS
 Z4t4Jzo/SvFmpkxNqE7gf1c8FRLwxYshO8Gw8uHdTg3kLX+7t/aRUoIWx2al3k33H2K9
 heO5i/qeEz+fyZzF2WMmxCx1yfHZGBLpMQ4t7sHWVjk+8BjJjaCwx3JRYSLl68unTgDv
 59BCqr+Lb6ddVOzjF4KwmU6LZAbYjGn9l5FnIwbvRvxbbJQVF9Bxo5MwNt/bvMBkBoUJ
 7NCDgRZ4sZfkP9PvagVyCutXdZj1+vSn61f/8NmtQo0YpEBdPxRTCDSLrUomkSouLKAH cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2x5xftucc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 08:50:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0038nF2L105835;
        Fri, 3 Jan 2020 08:50:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2x8guw81xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 08:50:12 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0038o94j018279;
        Fri, 3 Jan 2020 08:50:09 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jan 2020 00:50:08 -0800
Date:   Fri, 3 Jan 2020 11:49:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Harsh Jain <harshjain32@gmail.com>,
        Vandana BN <bnvandana@gmail.com>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Subject: Re: [PATCH] staging: kpc2000: replace assertion with recovery code
Message-ID: <20200103084959.GA3911@kadam>
References: <20191215181243.31519-1-pakki001@umn.edu>
 <20191215182814.GA859066@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215182814.GA859066@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001030083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 07:28:14PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 15, 2019 at 12:12:37PM -0600, Aditya Pakki wrote:
> > In kpc_dma_transfer, if either priv or ldev is NULL, crashing the
> > process is excessive and is not needed. Instead of asserting, by
> > passing the error upstream, the error can be handled.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > ---
> >  drivers/staging/kpc2000/kpc_dma/fileops.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > index cb52bd9a6d2f..1c4633267cc1 100644
> > --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> > +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> > @@ -49,9 +49,11 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
> >  	u64 dma_addr;
> >  	u64 user_ctl;
> >  
> > -	BUG_ON(priv == NULL);
> > +	if (!priv)
> > +		return -EINVAL;
> 
> How can prive ever be NULL here?  Can you track back to all callers to
> verify this?  If so, just remove the check.
> 

Smatch says that "priv" can't be NULL.

Also if you have a NULL dereference the kernel prints a nice stack
trace.  Normally just doing the NULL dereference and Oopsing is better
than doing a BUG_ON().  The one exception would be when the Oops leads
to filesystem corruption.

regards,
dan carpenter
