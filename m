Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E1CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31321734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RJX4gUl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfKAJfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:35:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54054 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfKAJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:35:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA19Xok3095393;
        Fri, 1 Nov 2019 09:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=C7/ct8+ievqCQqX4iE018JBhq+KFOagNcvYT9LbMAZA=;
 b=RJX4gUl7uF91JVv1XVxxBIkBOFFU5L50+6Zm9Ost91IM3s31lgYaqkCBekP6T0njVZkn
 X+xcWlR5Kc2ZxL2+GXWMgj8hICXDZzuW/jNhe2DM/FXUKxkwbwGTvxN2tw79Rj04Bp2I
 gk1Aj+sI5UsK4NgWQx64GlqEw1ZqVs4JZRgAw0aFLZNuO0B9Nzrkz2b4YU2UpEYqwU7v
 Q199bKPPHJXKXl4ngMAcaKfzlN9bFA5A9BN5WtP5CdMaqFjTl+B+XBEfE0X9Qr1Ug37B
 Ul6KCTCGrFjd+1WhSDo4D16W0WlmN/o/T05RiiDRjcWFvMQCxG8wA1psVJM8kddIQiqu Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vxwhg0u6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 09:34:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA19XCnS118290;
        Fri, 1 Nov 2019 09:34:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vykw323aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 09:34:57 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA19Yuuc010647;
        Fri, 1 Nov 2019 09:34:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 02:34:56 -0700
Date:   Fri, 1 Nov 2019 12:34:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Roi Martin <jroi.martin@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: exfat: replace kmalloc with kmalloc_array
Message-ID: <20191101093447.GG18421@kadam>
References: <20191031123139.32361-1-jroi.martin@gmail.com>
 <20191031132503.GD1705@kadam>
 <20191031160356.GB6924@miniwopr.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031160356.GB6924@miniwopr.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 05:03:56PM +0100, Roi Martin wrote:
> > > diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> > > index f71235c6a338..f4f82aecc05d 100644
> > > --- a/drivers/staging/exfat/exfat_core.c
> > > +++ b/drivers/staging/exfat/exfat_core.c
> > > @@ -713,8 +713,8 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
> > >  
> > >  	u32 checksum = 0;
> > >  
> > > -	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
> > > -						GFP_KERNEL);
> > > +	upcase_table = kmalloc_array(UTBL_COL_COUNT, sizeof(u16 *), GFP_KERNEL);
> > > +	p_fs->vol_utbl = upcase_table;
> > 
> > This patch is fine, but one idea for future patches is that you could
> > remove the "upcase_table" variable and use "p_fs->vol_utbl" everywhere
> > instead.
> 
> Thanks for the suggestion.
> 
> This is my first contribution and I tried to introduce the minimum
> number of changes necessary to fix the issues reported by checkpatch.pl.
> Also, I'm still immersed in getting familiar with the contribution
> process and the code.
> 
> Do you think it makes sense to include this change in a future patch
> series along with other refactoring? Or, should I modify this patch?

No don't modify the patch.  The patch is fine.

> 
> By the way, upcase_table is sometimes accessed in quite complex ways.
> For instance:
> 
> 	upcase_table[col_index][get_row_index(index)] = uni;
> 
> Where having an intermediate variable instead of using the struct field
> directly seems to improve readability a bit. Otherwise:
> 
> 	p_fs->vol_utbl[col_index][get_row_index(index)] = uni;

This line isn't very complex.  It's fine.


> 
> I assume, in cases like this, from a coding style perspective, the
> following approach is preferred:
> 
> 	row_index = get_row_index(index);
> 	p_fs->vol_utbl[col_index][row_index] = uni;

But this is better, yes.

regards,
dan carpenter

