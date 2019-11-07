Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9DC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D63C21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 06:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LtEIYDbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfKGGuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 01:50:11 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfKGGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:50:11 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA76n1Jp196208;
        Thu, 7 Nov 2019 06:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=l7mmS/BfVHFftT6TRlrOwVf4WCbYvzr8ANLVN4YzayM=;
 b=LtEIYDbw0nvLzWoy6/9YEKUxKh0mr1rXrNBYYWCS4+C4yY63WgF4KPpuv1MoXCp4OVyP
 1HZxia0/4rlIT8jVGF6F4FlWds26jxoxXOHYjR6LSC6dw8E1Tp2YRTVy0ucBnNHHXV7Y
 QTwW2u7eZMKG7EKWVXD7jPSILZW69e3oL5tH1qS6N/uo88EK0LiXmU3Djf+br6EQqJLc
 CJ2XZENJ49IiSv8Pf8nH0ms8UCBs02Vuza1ZJJBqh5gZABLcaTsDU80zyCjZxdJTDpZx
 fASChHQiNjOZOhlBLfRSeLg/T7D1sZTEl3UWaQ8+/96+VCPaLZ79CxGdiFrNp8sbQNPE cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w41w0uw0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 06:49:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA76mimV124568;
        Thu, 7 Nov 2019 06:49:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w41wgn6tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 06:49:06 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA76n3St028935;
        Thu, 7 Nov 2019 06:49:03 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 22:49:02 -0800
Date:   Thu, 7 Nov 2019 09:48:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>, linux-s390@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
Message-ID: <20191107064854.GM10409@kadam>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <4fa0e106-2565-8610-1356-4adfba08c0a0@web.de>
 <a4eaf80e-a5dd-4da3-75ca-8231f01af193@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4eaf80e-a5dd-4da3-75ca-8231f01af193@de.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=710
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=789 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 07:30:19PM +0100, Christian Borntraeger wrote:
> 
> 
> On 06.11.19 14:00, Markus Elfring wrote:
> >>> Reuse existing functionality from memdup_user() instead of keeping
> >>> duplicate source code.
> >>>
> >>> Generated by: scripts/coccinelle/api/memdup_user.cocci
> > …
> >>> Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA AES cipher key support")
> >>
> >> This doesn't fix anything
> > 
> > How would you categorise the proposed source code reduction and software reuse?
> 
> Cleanup.
> 
> Can you please stop arguing about review feedback that is clearly right? This is not fixing 
> anything. The Fixes tag is used to decide if something needs a backport.

Fixes tags are independent from backports.  If you want a backport you
should CC stable.

Fixes tags are useful for a bunch of things like when you're reviewing a
patch you can look at the original commit to see what was intended.
Also we can do automated analysis to see what sort of commits introduce
bugs (did they spend time in linux-next etc).

regards,
dan carpenter

