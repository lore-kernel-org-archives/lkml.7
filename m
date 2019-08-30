Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3727FC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130892186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 03:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfH3DU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 23:20:58 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3959 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfH3DU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 23:20:57 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id C63AB9F8AE0403F8D5D2;
        Fri, 30 Aug 2019 11:20:54 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 30 Aug 2019 11:20:54 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 30 Aug 2019 11:20:53 +0800
Date:   Fri, 30 Aug 2019 11:20:06 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Joe Perches <joe@perches.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        "Fang Wei" <fangwei1@huawei.com>
Subject: Re: [PATCH v2 2/7] erofs: some marcos are much more readable as a
 function
Message-ID: <20190830032006.GA20217@architecture4>
References: <20190830030040.10599-1-gaoxiang25@huawei.com>
 <20190830030040.10599-2-gaoxiang25@huawei.com>
 <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b2ecf5cec1a6aa3834e9af41886a7fcb18ae86a.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Thu, Aug 29, 2019 at 08:16:27PM -0700, Joe Perches wrote:
> On Fri, 2019-08-30 at 11:00 +0800, Gao Xiang wrote:
> > As Christoph suggested [1], these marcos are much
> > more readable as a function
> 
> s/marcos/macros/
> .
> []
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> []
> > @@ -168,16 +168,24 @@ struct erofs_xattr_entry {
> >  	char   e_name[0];       /* attribute name */
> >  } __packed;
> >  
> > -#define ondisk_xattr_ibody_size(count)	({\
> > -	u32 __count = le16_to_cpu(count); \
> > -	((__count) == 0) ? 0 : \
> > -	sizeof(struct erofs_xattr_ibody_header) + \
> > -		sizeof(__u32) * ((__count) - 1); })
> > +static inline unsigned int erofs_xattr_ibody_size(__le16 d_icount)
> > +{
> > +	unsigned int icount = le16_to_cpu(d_icount);
> > +
> > +	if (!icount)
> > +		return 0;
> > +
> > +	return sizeof(struct erofs_xattr_ibody_header) +
> > +		sizeof(__u32) * (icount - 1);
> 
> Maybe use struct_size()?
> 
> {
> 	struct erofs_xattr_ibody_header *ibh;
> 	unsigned int icount = le16_to_cpu(d_icount);
> 
> 	if (!icount)
> 		return 0;
> 
> 	return struct_size(ibh, h_shared_xattrs, icount - 1);
> }

Okay, That is fine, will resend this patch.

Thanks,
Gao Xiang

> 
