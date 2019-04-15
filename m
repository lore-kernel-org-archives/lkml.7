Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4520C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C0A20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3DLm0Uga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfDOGkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:40:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33862 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOGkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:40:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F6Y7vu146260;
        Mon, 15 Apr 2019 06:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=XS+g3Z0HRLfU8/sWnJD7AQpQm56bAk9JHlxE4S9qN4M=;
 b=3DLm0UgaQF2zzfumrPrMGjRkHkdUI8vcWyFMEPRo8sShlgl4/nicB7oh6OBAPcrsjAnH
 TjTr8Je4wUKf/VQ+sdhlfeV2peyWwernWJ+uauoq1gxEWQCrgr5FM3whwFwZzM9vT3Md
 TbI6Fy0ND2v7oITGzl4Ik5r9mx6IkNqbq9urXUwArzTEVgmsztRrBSg1/JPGe5lT6U6K
 JGEIvR5jDRk7Sc02+IHmWeXnFB//69b3ZXHuVCPyTU65ljaL1w3OS9iVTJVJozCrqv45
 VN+E9i575LFEXks3Z49ujJyjNCe+D0vpc65F+iBEypsoCa9jjJkUFSBatqDyQArX7fxt Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2ru59cvu55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 06:39:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F6cLYB096181;
        Mon, 15 Apr 2019 06:39:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rv2tu0m90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 06:39:52 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3F6dpcT022487;
        Mon, 15 Apr 2019 06:39:52 GMT
Received: from kadam (/197.157.0.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 23:39:50 -0700
Date:   Mon, 15 Apr 2019 09:39:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: android: vsoc: fix copy_from_user overrun
Message-ID: <20190415063904.GH31633@kadam>
References: <20190414153726.25362-1-vincent.stehle@laposte.net>
 <20190415063244.GM6095@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415063244.GM6095@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150044
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:32:44AM +0300, Dan Carpenter wrote:
> On Sun, Apr 14, 2019 at 05:37:26PM +0200, Vincent Stehlé wrote:
> > The `np->permission' structure is smaller than the `np' structure but
> > sizeof(*np) worth of data is copied in there. Fix the size passed to
> > copy_from_user() to avoid overrun.
> > 
> > Fixes: 3d2ec9dcd5539d42 ("staging: Android: Add 'vsoc' driver for cuttlefish.")
> > Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/staging/android/vsoc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
> > index 8a75bd27c4133..00a1ec7b91549 100644
> > --- a/drivers/staging/android/vsoc.c
> > +++ b/drivers/staging/android/vsoc.c
> > @@ -259,7 +259,8 @@ do_create_fd_scoped_permission(struct vsoc_device_region *region_p,
> >  	atomic_t *owner_ptr = NULL;
> >  	struct vsoc_device_region *managed_region_p;
> >  
> > -	if (copy_from_user(&np->permission, &arg->perm, sizeof(*np)) ||
> > +	if (copy_from_user(&np->permission,
> > +			   &arg->perm, sizeof(np->permission)) ||
> 
> The original code was probably correct...  This is a common thing where
> people use "&p->first_struct_member" to represent the whole struct.
> It seems like kind of a horrible thing to do and I can't explain why
> people do it, but they do...

I have reviewed the code in a less totally lazy way and your patch is
correct.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

The bug is harmless, though.  We copy over the list pointers with user
data and then immediately write the correct data to it.

It should probably be a static checker warning when we copy to non
__user tagged pointers.  I think someone was adding this to Sparse but I
should probably add it to Smatch as well.

regards,
dan carpenter

