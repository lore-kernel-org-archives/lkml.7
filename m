Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6124DC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1BF20838
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 19:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCeCB8cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfIKTWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 15:22:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfIKTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 15:22:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BJJB0g088474;
        Wed, 11 Sep 2019 19:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zXz8SobsB2HBCVMsfL4mmnkbie6nNEZHVFvO9t7bQT4=;
 b=NCeCB8ccCjw8QWh8IPZgUHP+jGLM+zX7o5DkXcN7LRQ0PG6y5HhVuKeQGQGMNYnqmcdC
 TDZGSkqfRavytp3GGY3a5dRGTzoreLQ05of6JmVbmsyUiWIhAqQHleqidKZjKYyleWel
 QYnwZGVwC+m2cOB2y7ZQyWI+tOjDUcy7LLPMo9k60cuBmIZZEpKFr1Isqc0NQaCuoVRE
 SBCDz9lv48ZL4ShRi1/yQ5YlPmu5+EIq8psaviZcAyrl2RcI9WU2Lf276vhZ58B6FPWO
 daqJR6/q1NbHmBTtuULLDFtkAEvix0cIhUXoEmVkHurki7zjTe9hb/on60Ez3T4GBpOx Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2uw1m94a1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 19:22:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BJIXkL099927;
        Wed, 11 Sep 2019 19:22:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2uxk0tjksj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 19:22:47 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8BJMkdV024891;
        Wed, 11 Sep 2019 19:22:46 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 12:22:45 -0700
Date:   Wed, 11 Sep 2019 22:22:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v4] Staging: exfat: avoid use of strcpy
Message-ID: <20190911192239.GM20699@kadam>
References: <20190911190355.GA18977@kadam>
 <27939F0F-4406-4CAE-9D88-CFDA58A76BA1@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27939F0F-4406-4CAE-9D88-CFDA58A76BA1@volery.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=740 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No worries...  We all have days like that occasionally.  :P

regards,
dan carpenter

