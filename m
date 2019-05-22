Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDD2C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410D32173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yWWvOAKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfEVHEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:04:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfEVHEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:04:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M6wl1Q044442;
        Wed, 22 May 2019 07:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dSL2k3WA3sCWVQjdlAEtqyhk4rfZ8LtxiTQMWRcgG70=;
 b=yWWvOAKA8vTjSJJb7aoNWfSv64ycNUjxrnrxPx55KEd69mUDrxXtjqhfUNIkX2/J/+uT
 hVe4k6D7Y9ze2UNu4qMAogwBYVIwown5aefDz4ynPrLH+/JiMpBuXszHYqVt9nKSQbm5
 oVm1hqrlfowkhhliUUleSG8hrIqV5I3pxr9uF4Atf/5yJWG4NPhju2XmUB0hrnYpU75O
 ZgbDfgpp4Y9yMKMXw1jxKtEP9gNOBeDYp7zpqvQ263m1kTFryvS7Lg5DkHcypK93lJMa
 oUwPy8bD9+0NkZKXH/GjceAy+qqj92umAVBjvb24W5KSJow6tYzu+Il3bDQ4S964+3eG Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2smsk51mbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 07:04:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M73V3H026224;
        Wed, 22 May 2019 07:04:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2smsgsean1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 07:04:29 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4M74RFx022760;
        Wed, 22 May 2019 07:04:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 May 2019 07:04:26 +0000
Date:   Wed, 22 May 2019 10:04:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] staging: rtl8192u: Remove an unnecessary NULL check
Message-ID: <20190522070418.GP31203@kadam>
References: <20190521174221.124459-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521174221.124459-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905220052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905220052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:42:21AM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c:2663:47: warning:
> address of array 'param->u.wpa_ie.data' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>             (param->u.wpa_ie.len && !param->u.wpa_ie.data))
>                                     ~~~~~~~~~~~~~~~~~^~~~
> 
> This was exposed by commit deabe03523a7 ("Staging: rtl8192u: ieee80211:
> Use !x in place of NULL comparisons") because we disable the warning
> that would have pointed out the comparison against NULL is also false:
> 

Heh.  Weird.  Why would people disable one and not the other?

regards,
dan carpenter

