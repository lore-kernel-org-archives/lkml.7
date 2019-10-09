Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A806BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793EC206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YrlRJpdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfJIN60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:58:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43584 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJIN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:58:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99Ds1P4030202;
        Wed, 9 Oct 2019 13:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=KuFxysVjGvj9HNkv/L58Cim31ODyPhyJGS4wNznP1v0=;
 b=YrlRJpdq5+RuPMCTXFueXKSo1WJ7EbeZc6ILfpqp/V3RnH82yVBuOjuOB4sGyueRSvx2
 8Tp0OAIeEap/S0ypRCu3TxosqeqRqypTgJC94SjBYkRY+2m2CDNHBfRPVdprIqUw4yen
 oMS5q6NQgpsXB2Fadibh2DerijspBWuGhdabJx0fUpipZbbm1zM3yPV16BCcr+ewNV6J
 0hvbFqh8yHJrH8KU2e/DAj+D+KN/3xvlDk0lVcqFjAzQ3A1ogblVGOXi+atCy4N65np0
 wj78tfZuwza1TF12f6hGoOMgbDBkcfAReWANH/58etQVotiJOb+879PzwNGSzpPThHIY FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4qmq5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 13:56:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99DraOI032368;
        Wed, 9 Oct 2019 13:56:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vgefcr16q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 13:56:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x99DuiVK029752;
        Wed, 9 Oct 2019 13:56:46 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 06:56:44 -0700
Date:   Wed, 9 Oct 2019 16:56:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
Message-ID: <20191009135522.GA20194@kadam>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=881 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I haven't reviewed the original patch ]

On Wed, Oct 09, 2019 at 03:26:18PM +0200, Rasmus Villemoes wrote:
> On 09/10/2019 14.14, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 9 Oct 2019 13:53:59 +0200
> > 
> > Several functions return values with which useful data processing
> > should be performed. These values must not be ignored then.
> > Thus use the annotation “__must_check” in the shown function declarations.
> 
> This _might_ make sense for those that are basically kmalloc() wrappers
> in one way or another [1]. But what's the point of annotating pure
> functions such as strchr, strstr, memchr etc? Nobody is calling those
> for their side effects (they don't have any...), so obviously the return
> value is used. If somebody does a strcmp() without using the result, so
> what? OK, it's odd code that might be worth flagging, but I don't think
> that's the kind of thing one accidentally adds.


	if (ret) {
		-EINVAL;
	}

People do occasionally make mistakes like this.  It can't hurt to
warn them as early as possible about nonsense code.


> You're also not consistent - strlen() is not annotated. And, for the
> standard C functions, -Wall already seems to warn about an unused
> call:
> 
>  #include <string.h>
> int f(const char *s)
> {
> 	strlen(s);
> 	return 3;
> }
> $ gcc -Wall -o a.o -c a.c
> a.c: In function ‘f’:
> a.c:5:2: warning: statement with no effect [-Wunused-value]
>   strlen(s);
>   ^~~~~~~~~

That's because glibc strlen is annotated with __attribute_pure__ which
means it has no side effects.

regards,
dan carpenter

