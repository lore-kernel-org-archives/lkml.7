Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F7EC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091E422CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j9LKolnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfIDO5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:57:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbfIDO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:57:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84EsLv7021639;
        Wed, 4 Sep 2019 14:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bMkLNokI8FrqjbwiojaO/ClC+naevlTB3j4jok3nW9w=;
 b=j9LKolnDe405L/SnefO66pxHYcZ+puiqVF086GdjYze1AJWjqAiEInb2SC/dMiBrf/iN
 zkRzErR8bMQjsBJkZZDZkYTlHti8Tv5F4V1uFxiWciStEjwcYxCPU4WfFMl355qr02I1
 4thmAcgTf8Rf4gD+ezRD7HYFGfgRiSRGrG+NEqdup7Yn0LIawJ2R2gdsmarwUBxu5XYk
 8bfvZuCYvU9guvA2EAXuP6d3tkIJNjTtx26JBBOj5YlobUFSAh2JASqHnlCA1qir1khh
 O9JEdCt1Rlrg9tqz6HlLJIhww27a5IF/F9xKlHpjN5xfcUvEVDIBSLYugBThdLe9CWv3 iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2utfejg0ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 14:57:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84EqgYt065225;
        Wed, 4 Sep 2019 14:57:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2usu51xw9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 14:57:13 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84Ev9FT025123;
        Wed, 4 Sep 2019 14:57:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 07:57:09 -0700
Date:   Wed, 4 Sep 2019 17:57:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Anders Larsen <al@alarsen.net>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/qnx: Delete unnecessary checks before brelse()
Message-ID: <20190904145700.GB3115@kadam>
References: <056c8b8e-abaa-8856-4953-118d14048ddc@web.de>
 <21774224.cEpxz9ejUk@alarsen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21774224.cEpxz9ejUk@alarsen.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:27:22PM +0200, Anders Larsen wrote:
> On Tuesday, 2019-09-03 19:20 Markus Elfring wrote:
> > diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> > index 345db56c98fd..083170541add 100644
> > --- a/fs/qnx6/inode.c
> > +++ b/fs/qnx6/inode.c
> > @@ -472,10 +472,8 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
> >  out1:
> >  	iput(sbi->inodes);
> >  out:
> > -	if (bh1)
> > -		brelse(bh1);
> > -	if (bh2)
> > -		brelse(bh2);
> > +	brelse(bh1);
> > +	brelse(bh2);
> >  outnobh:
> >  	kfree(qs);
> >  	s->s_fs_info = NULL;

It looks like the original code is buggy:

fs/qnx6/inode.c
   409                  pr_info("superblock #1 active\n");
   410          } else {
   411                  /* superblock #2 active */
   412                  sbi->sb_buf = bh2;
   413                  sbi->sb = (struct qnx6_super_block *)bh2->b_data;
   414                  brelse(bh1);
                        ^^^^^^^^^^
brelse()

   415                  pr_info("superblock #2 active\n");
   416          }
   417  mmi_success:
   418          /* sanity check - limit maximum indirect pointer levels */
   419          if (sb1->Inode.levels > QNX6_PTR_MAX_LEVELS) {
   420                  pr_err("too many inode levels (max %i, sb %i)\n",
   421                         QNX6_PTR_MAX_LEVELS, sb1->Inode.levels);
   422                  goto out;
                        ^^^^^^^^
goto

   423          }

[ snip ]

   466  
   467  out3:
   468          dput(s->s_root);
   469          s->s_root = NULL;
   470  out2:
   471          iput(sbi->longfile);
   472  out1:
   473          iput(sbi->inodes);
   474  out:
   475          if (bh1)
   476                  brelse(bh1);
                        ^^^^^^^^^^^
Double brelse().

   477          if (bh2)
   478                  brelse(bh2);
   479  outnobh:
   480          kfree(qs);
   481          s->s_fs_info = NULL;
   482          return ret;
   483  }

regards,
dan carpenter

