Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262A0C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F0218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gUIbidyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCUHVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:21:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34024 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCUHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:20:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L7FR8A056292;
        Thu, 21 Mar 2019 07:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=c7i1Zr1Oeu2KbKqDknFFU5AYuWj4p3NzsbodfbSJpe4=;
 b=gUIbidyMSkQhuhdAXX+QRoCiZNupyMe8qwqWYdEVOHDAinAaUy5Rirsr2z3gX2Mm+PEk
 G2LGWiEXlB32ENKqy0e1xizHVcPcCtqtaV+nOnKgAXpsQHgH8d/s/KVqkVYfqVFWIM9v
 J08bG6Fb/Qp2PL6hAjvF3aiBAxqV990AQzH1GYnpkqrMqTYYaoY3gvCe1GLbpt/POGNQ
 X22k7+UYun46dMN8OqrXNw2yI2Jnn6LI7K2mkr0nNPhxgpfhnozELYLwexU7Ho3+xJVP
 UU9yZzd1ZvmI8UUkAw91gTzavSyOOIi+RGMts1fRNhfQ/VZ5fCRBz/9udGyKkhVAfuYv kg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2r8pney0uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 07:20:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2L7Kpdl005196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 07:20:53 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2L7KpKL016296;
        Thu, 21 Mar 2019 07:20:51 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Mar 2019 00:20:50 -0700
Date:   Thu, 21 Mar 2019 10:20:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtlwifi: Fix potential NULL pointer
 dereference of kzalloc
Message-ID: <20190321072039.GI2202@kadam>
References: <20190319201509.16252-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319201509.16252-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:15:08PM -0500, Aditya Pakki wrote:
> phydm.internal is allocated using kzalloc which is used multiple
> times without a check for NULL pointer. This patch avoids such a
> scenario.
> 
> --
> v1: Patch collision with different things, fix as per Greg
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---

Gar...  Sorry, no, that's not quite right.  It should be:

blah blah blah...

Signed-off-by: you
---
V1: Patch collision with different things, fix as per Greg

Try applying your patch with `cat raw_email.txt | git am` and you'll see
the problem with the commit message.

regards,
dan carpenter

