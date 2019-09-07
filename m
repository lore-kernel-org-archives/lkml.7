Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAA0C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1565721871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iSuHLhQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406003AbfIGOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 10:39:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfIGOjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 10:39:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87EdQQl082101;
        Sat, 7 Sep 2019 14:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=s9aXxI7sA4me/ycb0JLeHZ2uDjHcFtgU9B3Kh9Cf838=;
 b=iSuHLhQJwF9e7CB3TviGpt1E4HkfhqMvBAPwkCPFb4jMd40mMwZ+PeAAQk3bJSKJ7nFS
 yznndfF+cG5gcqz/2EK9GJ5Pq4xM/dv5GCpqMsZ1DN57/h6hHTDDFXC0KbXFYPPUjojH
 sZ4XHpgXho2gnAga45cd3ykizzgHz1aXuoQKrYSZxfnQuw4Qqv65uNaZSH9mBYzQ7uYC
 PlBZVAl+zN8W4ljOiq5X5bbynr/fXjHeBfuVACUw9IOlMHImcmGA04+Avw4krAnpRY24
 OrgyuPmTpDMpU0x7WW2ScygnPyGHbii+QI9Bkv3JzGow4zpqH5VNSs5Ck8tR/wW99H/l jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uve1c01rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 14:39:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87EdN8K127952;
        Sat, 7 Sep 2019 14:39:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2uve9b0a34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 14:39:24 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x87Ecudq009512;
        Sat, 7 Sep 2019 14:38:56 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Sep 2019 07:38:55 -0700
Date:   Sat, 7 Sep 2019 17:38:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     volery <sandro@volery.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
Message-ID: <20190907143849.GA30834@kadam>
References: <20190906183801.GA2456@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906183801.GA2456@volery>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909070157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909070157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You need a subject prefix.  It should be something like:

[PATCH] Staging: gasket: Fix parentheses malpractice in apex_driver.c

Generally "Fix" is considered better style than "Fixed".  We aren't
going to care about that in staging, but the patch prefix is mandatory
so you will need to redo it anyway and might as well fix that as well.

On Fri, Sep 06, 2019 at 08:38:01PM +0200, volery wrote:
> There were some parentheses at the end of lines, which I took care of.
> This is my first patch.
  ^^^^^^^^^^^^^^^^^^^^^^

Put this sort of comments after the --- cut off line

> 
> Signed-off-by: Sandro Volery <sandro@volery.com>
> ---
  ^^^
Put it here.  It will be removed when we apply the patch so it won't
be recorded in the git log.

>  drivers/staging/gasket/apex_driver.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Joe's comments are, of course, correct as well.

regards,
dan carpenter

