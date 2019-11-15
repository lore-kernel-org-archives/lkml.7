Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1FBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309A520740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 07:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZH1elWzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKOHnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 02:43:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52516 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfKOHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 02:43:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF7d6ib109361;
        Fri, 15 Nov 2019 07:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=g8uThl8dkg+cj+2qFvpX4UHz2ZpNIXnP5NoBMB9GLqg=;
 b=ZH1elWzwIglBNSmcB5X+wP0yf/LmUt1gwQ+BKmeAdqrKDHpR/B3VCP4gZCn+KMqZMs9o
 VGHfMyBeXTtqPWxiohoxTx5o7AfdSifH5au/Bm2F7yVdLrt3SFvNiIu3Bmkqjm2Sh1FQ
 PezEvg+YOhnSG5jhEdCiE5XV3iqHQhA9DYdcDAsrS43yoJzICjQ8HGET00MD1DelpZ0X
 M+etngT3aPLHcBKyusqkOVVWdOf2MdHXjY7n+YHRfOY5MAx7YFmUmeiVh70iLUsFIgRv
 KCSZWILoTsg5EdUjbLSi1zTrjbonXuFcKjTLQm2+RS4ZrBxPO9YIBIsDHfdo4Swj/sjF Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w9gxphk9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 07:42:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAF7brgj141487;
        Fri, 15 Nov 2019 07:40:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w9h149024-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 07:40:14 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAF7eBZl031896;
        Fri, 15 Nov 2019 07:40:12 GMT
Received: from kadam.lan (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 23:40:11 -0800
Date:   Fri, 15 Nov 2019 10:40:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: rtl*: Remove tasklet callback casts
Message-ID: <20191115074003.GB19101@kadam.lan>
References: <201911142135.5656E23@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911142135.5656E23@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 09:39:00PM -0800, Kees Cook wrote:
> In order to make the entire kernel usable under Clang's Control Flow
> Integrity protections, function prototype casts need to be avoided
> because this will trip CFI checks at runtime (i.e. a mismatch between
> the caller's expected function prototype and the destination function's
> prototype). Many of these cases can be found with -Wcast-function-type,
> which found that the rtl wifi drivers had a bunch of needless function
> casts. Remove function casts for tasklet callbacks in the various drivers.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Clang should treat void pointers as a special case.  If void pointers
are bad, surely replacing them with unsigned long is even more ambigous
and worse.

regards,
dan carpenter

