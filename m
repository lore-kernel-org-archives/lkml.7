Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9A3C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49B22086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxczLG/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfHPL2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:28:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49768 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfHPL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:28:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GBNw7F109538;
        Fri, 16 Aug 2019 11:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=SqXeneh5bcubBR+QyitTTb1yLD5Uh3NKY8dvKiiRDp4=;
 b=dxczLG/XYCt7XkjLc8FaO8r8HZR+RKxUxjj544ZKc2fSI5vu/ItVvpvD5TBDlNxAIlpu
 WF0tGkD9sAf+dTYi4gxExKwPx/kDA8j9ASZgBrM1lI+E3BZuNRSD6bNbb496qdeDkdBN
 12xYkwU6FeviXs1ie4GvxUPEajafJ235BAhO3KbW7wnjX1QT4XPwpQLZbWnTTlW/6OED
 VZSbqP8LKE5XjScbPDPTyhWkHiKhDuQzuuWq2Vw9m6L9l75+RiAakgs9YD//gGjgZkf4
 LZ3Nb95OJrzmruUNrr+DjKcGgKZ7CyWyCOgmHy2b/aIbXbJMOlXWdX88cyAujYei/NRD lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u9pjqyveh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 11:28:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GBS9Pm154035;
        Fri, 16 Aug 2019 11:28:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2udscpb8gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 11:28:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7GBSVFw009073;
        Fri, 16 Aug 2019 11:28:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 04:28:30 -0700
Date:   Fri, 16 Aug 2019 14:28:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Mingqiang Chi <mingqiang.chi@intel.com>,
        Jack Ren <jack.ren@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
Subject: Re: [RFC PATCH 04/15] drivers/acrn: add the basic framework of acrn
 char device driver
Message-ID: <20190816112820.GV1974@kadam>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-5-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565922356-4488-5-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:45AM +0800, Zhao Yakui wrote:
> +static
> +int acrn_dev_open(struct inode *inodep, struct file *filep)
> +{
> +	pr_info("%s: opening device node\n", __func__);
> +
> +	return 0;
> +}
> +
> +static
> +long acrn_dev_ioctl(struct file *filep,
> +		    unsigned int ioctl_num, unsigned long ioctl_param)
> +{
> +	long ret = 0;
> +
> +	return ret;


This module is mostly stubs and debugging printks...  :(

I looked ahead in the patch series to see if we do something with the
stubs later on and it turns out we do.  Fold the two patches together so
that we don't have to review patches like this one.  Each patch should
do "one thing" which makes sense and can be reviewed independently.

regards,
dan carpenter

