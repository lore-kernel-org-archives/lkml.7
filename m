Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA6FC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C291220665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l9Sht2Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbfIXPZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:25:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54468 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfIXPZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:25:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OF6Aus154431;
        Tue, 24 Sep 2019 15:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=4zi/+s7I/onEAaUL73Ae/9HlAMiuZOtfhgCHOYa+uWg=;
 b=l9Sht2BczUSR3//LsOrLp2Ajz6BBQCS34ui0VyPatKqISKnfr3y1PzHv03Kz2ERGWf1u
 8wc131OAzpFChz13aSk+4/rYxoL9P8AsqL4NWG5SHlKGc4ySnzjNuRFABqAZ6Jm78MwI
 GB/rRwpTMSSXQZmNcLeqZoxsvo8faF31aZl+yF8YUzViFcrgI6UMh3dvARQQoekWEusC
 2wJ3zSw/XPgU7SQHVLZavQ8/RISV8GHe8Fw7oE0qYqLJkbpRn1yIgoAZvzsY+zTg3Mxe
 inUZnTpq+AG+LzBVTBR/o/cMXXUbNWgwb5OZHiDCUHfjMGz6jhiQtaewoZwWbaLzZwmR iA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v5b9tpwpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 15:25:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8OF6nBL082340;
        Tue, 24 Sep 2019 15:25:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v6yvkqgam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 15:25:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8OFPSTa029998;
        Tue, 24 Sep 2019 15:25:29 GMT
Received: from kadam (/102.167.217.97)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Sep 2019 08:25:27 -0700
Date:   Tue, 24 Sep 2019 18:25:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Connor Kuehl <connor.kuehl@canonical.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NACK: [PATCH] staging: rtl8188eu: remove dead code in do-while
 conditional step
Message-ID: <20190924152515.GD29696@kadam>
References: <20190923194806.25347-1-connor.kuehl@canonical.com>
 <52e473f0-6b92-9504-b86e-a73a0d82617f@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e473f0-6b92-9504-b86e-a73a0d82617f@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=582
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=684 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This email is fine, but I just want to make sure that you don't think
it's required.  We all assumed that you would send a v2.  I sort of hate
the word NACK as well because it sounds like shouting or ducks and those
are my two pet peeves.

Sometimes  people send a v2 patch without any replies to the original
email and we apply the v1 patch that's the only thing to avoid.

regards,
dan carpenter

