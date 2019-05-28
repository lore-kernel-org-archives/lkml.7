Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB2EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40732075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lR4HFSrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfE1G7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:59:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43350 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfE1G7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:59:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4S6wsWV045880;
        Tue, 28 May 2019 06:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tZAX3OSSOn0wbgFIM+YoGaSl2A5m+BXr7W4j+it+KCA=;
 b=lR4HFSrRAJpJgeClHkslNPlFVXCp8cMEetM4b6S6kl2urid3xZfKtkw14p3f4KKAQqDy
 1V/TEtj31Pkr+tP9KYYJXbsvd5Ore+HnjsPrp3B7B7ne+ZZ1kUuNaxDugIHF2irw+ugl
 VQKz5x6f5VWpWmLbQaSPwZ2S8iG1/Vw0pQcO/LYXYi//tPdzp0fAee/UUyZBMg6e652V
 A4PHm6wuOndjNnDO8W8UthvgG7iFu+chOQTkDkshGjVSPh6AXLn6SKxPoB0KXrz4Enaf
 sNGGaeOo20MIeS8flmyn4a7RbG2rq2DB8c8LssEpoZJWVWlAOOR5FPVIsYdc5JvDg/JJ og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7d940m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 06:59:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4S6uMMc119906;
        Tue, 28 May 2019 06:57:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh72xjfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 06:57:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4S6vHWp018798;
        Tue, 28 May 2019 06:57:17 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 23:57:17 -0700
Date:   Tue, 28 May 2019 09:57:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v2 2/2] staging: erofs: fix i_blocks calculation
Message-ID: <20190528065709.GY31203@kadam>
References: <20190528023147.94117-2-gaoxiang25@huawei.com>
 <20190528023602.178923-1-gaoxiang25@huawei.com>
 <fe0ff7bb-b576-f949-d57a-2892d116b22f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0ff7bb-b576-f949-d57a-2892d116b22f@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 11:02:12AM +0800, Chao Yu wrote:
> On 2019/5/28 10:36, Gao Xiang wrote:
> > For compressed files, i_blocks should not be calculated
> > by using i_size. i_u.compressed_blocks is used instead.
> > 
> > In addition, i_blocks was miscalculated for non-compressed
> > files previously, fix it as well.
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> > change log v2:
> >  - fix description in commit message
> >  - fix to 'inode->i_blocks = nblks << LOG_SECTORS_PER_BLOCK'
> > 
> > Thanks,
> > Gao Xiang
> > 
> >  drivers/staging/erofs/inode.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> > index 8da144943ed6..6e67e018784e 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -20,6 +20,7 @@ static int read_inode(struct inode *inode, void *data)
> >  	struct erofs_vnode *vi = EROFS_V(inode);
> >  	struct erofs_inode_v1 *v1 = data;
> >  	const unsigned int advise = le16_to_cpu(v1->i_advise);
> > +	erofs_blk_t nblks = 0;
> >  
> >  	vi->data_mapping_mode = __inode_data_mapping(advise);
> >  
> > @@ -60,6 +61,10 @@ static int read_inode(struct inode *inode, void *data)
> >  			le32_to_cpu(v2->i_ctime_nsec);
> >  
> >  		inode->i_size = le64_to_cpu(v2->i_size);
> > +
> > +		/* total blocks for compressed files */
> > +		if (vi->data_mapping_mode == EROFS_INODE_LAYOUT_COMPRESSION)
> > +			nblks = v2->i_u.compressed_blocks;
> 
> Xiang,
> 
> It needs to use le32_to_cpu(). ;)
> 

I wonder it the kbuild bot is going to send an email about that...
Hopefully these sorts of bugs get detected with Sparse CF=-D__CHECK_ENDIAN__

regards,
dan carpenter

