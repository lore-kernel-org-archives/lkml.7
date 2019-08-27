Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5E4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A8C206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5UooV1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfH0Oht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:37:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38066 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0Oht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:37:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7REJ2Ms056832;
        Tue, 27 Aug 2019 14:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=gGnFZ51yq9RAEaysy8uvp9bvDV7zC+1crJWVSuzKqOE=;
 b=l5UooV1qCywqyCSH6s1M+JzNpijLmUrNMCS6Dl/PLapjsfeUHtSy7++v1PKVbLHVYISC
 3GbI7+0Cyt7nmbCH4EokcGxnS5Z9K2X7ngh+zgBW8Brqwgl2oHcjZMm/Mlg+U6se2bak
 8lQ/qB3TTglNPPUXwgN+TAb7CR2ru64M743Pgt21FyXWmy+xKq5a4vTBAGDe0fyEYbR6
 VwNhuORZf+rKRjtNKbAAFwoRzpB3as3DYUYGqGny6pXTmW6sGSY0JtIdV74PQ37/RKRT
 mBZWUP1zn3DVGpGM39WuEOOtOC617kttzYBYw22LpI7byRW/hFVbg7tyLzwixuMIZV19 pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2un5vs0djy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 14:37:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7REIfhD065315;
        Tue, 27 Aug 2019 14:37:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2umhu8u0aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 14:37:42 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7REbfsM026482;
        Tue, 27 Aug 2019 14:37:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 07:37:41 -0700
Date:   Tue, 27 Aug 2019 17:37:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] staging: move greybus core out of staging
Message-ID: <20190827143733.GF23584@kadam>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190827133611.GE23584@kadam>
 <20190827134557.GA25038@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827134557.GA25038@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=961
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:45:57PM +0200, Greg Kroah-Hartman wrote:
> Why can't you compile the code?
> 

Now that I try to investigate the compile errors, it starts to compile
perfectly...

> > drivers/staging/greybus/operation.c:379 gb_operation_message_alloc() warn: check 'message_size' for integer overflows 'kzalloc()'
> 
> That should be checked on line 368, right?

This is a false positive.  I assumed it was related to the compile
problem...

> 
> > drivers/staging/greybus/light.c:1256 gb_lights_request_handler() warn: 'light->channels' double freed
> > drivers/staging/greybus/light.c:1256 gb_lights_request_handler() warn: 'light->name' double freed
> 
> I don't understand this warning, how are these potentially double freed?

I will fix these.

regards,
dan carpenter

