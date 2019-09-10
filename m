Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EF4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECDA20872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jc9c2q27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfIJL1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:27:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50524 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfIJL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:27:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ABNeNa016028;
        Tue, 10 Sep 2019 11:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=i9SWZWg8DmcXWp3fnhkTPVRtLG9I2F4flnfmYaltpPA=;
 b=jc9c2q27oN/Sy2WrefdD3FvV7b1uZAEtNW4b87XapfvzN0ODXjkHfvrlShpWqYyg5Ut+
 OPKLBx/GU6hkUIf9Xj4IhphhK2bmRgJLaLc23ADEEpELwa7EZQ7n6Vecp25RxK3uJv5f
 vfA8T5H8i5GsCmz0lSjvdoU0YqZhPImX5e5j+HtdgM+jiATrqHi5Lb3z7HicLfYYqQnQ
 5qB6234VCwJph85e7jhj5lUdGd6RomAqkPb+N2ZiHp0yMP5tt8LPJFi2u0updxs6TIvA
 Hd86zgNtv9osU7E+Dki1vUWIC53nwGqfn8/hv6g/049QNsgMgFWuwTjgbfACeUZhFtnh 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uw1m8tpgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 11:27:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ABNvGm003340;
        Tue, 10 Sep 2019 11:27:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uwpjvpp8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 11:27:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8ABR93O023364;
        Tue, 10 Sep 2019 11:27:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 04:27:08 -0700
Date:   Tue, 10 Sep 2019 14:27:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery LKML <lkml.sandro@volery.com>
Cc:     Sandro Volery <sandro@volery.com>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rspringer@google.com, joe@perches.com, toddpoynor@google.com
Subject: Re: [PATCH v2] Staging: gasket: Use temporaries to reduce line
 length.
Message-ID: <20190910112700.GB30834@kadam>
References: <20190910050557.GA8338@volery>
 <73C0743C-6864-4868-829B-D567F12A9463@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73C0743C-6864-4868-829B-D567F12A9463@volery.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 07:11:26AM +0200, Sandro Volery LKML wrote:
> Wow... I checked, compiled and still sent the wrong thing again. I'm
> gonna have to give this up soon if i can't get it right.
> 

The mistake was using gasket_page_table_num_simple_entries() instead
of gasket_page_table_num_entries()?

When I write a patch, I always queue it up and the let it sit in my
outbox overnight so I can review it again in the morning.  Otherwise my
mind is clouded with other emotions and I can't review objectively.
There is never a rush.

> Sandro V
> 
> > On 10 Sep 2019, at 07:06, Sandro Volery <sandro@volery.com> wrote:
> > 
> > ﻿Using temporaries for gasket_page_table entries to remove scnprintf()
> > statements and reduce line length, as suggested by Joe Perches. Thanks!
                                                                    ^^^^^^^

Don't put this in the commit log.  :P

regards,
dan carpenter

