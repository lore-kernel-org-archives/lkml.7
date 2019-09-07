Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4491CC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A21E21871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYEPcycU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406047AbfIGOw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 10:52:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54130 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391160AbfIGOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 10:52:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87EmhLw088769;
        Sat, 7 Sep 2019 14:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tsKmCXb/CruJncApOshfpn/JACneo/DGDdmtT3egoso=;
 b=CYEPcycU8FDYEHOoqIMJp+jApC2SO55fi3P0ZsZNIz4PTdUBeL+yLDQ3yCZR2CdQHW8g
 LAyKkVR6AOBnQcQImuvX5Av3fHQS520PugRBVt7evJY1yz6+HX97eMq1/meEKTKgiUxR
 MpR7BsJh+/0vUdxOWTLchkhLTdnZKSq9n1rtvUhDuEwkR0ZLzcDeO/r+661QRd2aqb8B
 0qMrAg4AD9K3XK1B9+AXyvsa+m8fDD8X5sJ/t9jD74agQfpRRUa5ZueSGfVaM4I8lMNq
 7eIPH+7d+hbWNL7MVHNPRNoVGdc1k0fiDVL0BEmAFtvUEAnfSxI7yhGhELv2gNUFuzPz Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uvem080dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 14:52:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87Elw3c093136;
        Sat, 7 Sep 2019 14:52:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uv2kxckwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 14:52:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x87EqJeR022719;
        Sat, 7 Sep 2019 14:52:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Sep 2019 07:52:19 -0700
Date:   Sat, 7 Sep 2019 17:52:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed parentheses malpractice in apex_driver.c
Message-ID: <20190907145210.GB20699@kadam>
References: <20190907143849.GA30834@kadam>
 <C3F8799B-2CFE-4F3B-A01A-DFDF248BA01F@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C3F8799B-2CFE-4F3B-A01A-DFDF248BA01F@volery.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909070159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909070159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 04:48:21PM +0200, Sandro Volery wrote:
> > Joe's comments are, of course, correct as well.
> > 
> > regards,
> > dan carpenter
> > 
> 
> I'll take a look at Joe's suggestions too sometime tonight. I'd feel kinda bad tho if I just apply his work and send it in?

Don't feel bad.  Just do it.  Give him credit in the commit message if
you want.  "Thanks to Joe Perches for his help."

I sometimes give people word for word patches and they don't copy it
exactly and I wonder if this is why...  My exact patch was the best one.

regards,
dan carpenter


