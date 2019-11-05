Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F7C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2FC217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W19ll0Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfKEPAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:00:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbfKEPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:00:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5Ex3jX187535;
        Tue, 5 Nov 2019 14:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=/Bsxp4S3+a3fFJuRw3QU2lGizYk8ZzHduC29p7dcUSY=;
 b=W19ll0Wyv9tHFNUcaMw0HK8Z35DB74VXx89suj7fb0b7BHFGGnBw2WhWJMfh3VbGaQdY
 +fdEWMD7EWJwNda8Wfuim+5lF0cLCtA3sE7sv44c6UA7c8tb5UwCMtxedKavuTtDCxR7
 Hk2WySFnf7iiHGf7ZociO61+WbdrYLmjbvvmFdeCvvsQ2lP2pMQmpZ+UTh5aIxmeNv0j
 jH0/wKqQQxcoXJANu/MLgpqWK3ueMS6t2p8Q5R5tzHcgpgikm7R9jAyosBBty2JC3d5R
 AyWnA9RrzLJ0ufPC2G+o78uHugYgRS19+ZVLSI+fA5MthJqVxi8BBpxM6uOMJtF9Fmu5 7w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w12er6u46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 14:59:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5ExInw023976;
        Tue, 5 Nov 2019 14:59:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2w333vbdhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 14:59:33 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA5Ex1IZ006440;
        Tue, 5 Nov 2019 14:59:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 06:59:00 -0800
Date:   Tue, 5 Nov 2019 17:58:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himadri Pandya <himadri18.07@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix potential use after free
Message-ID: <20191105145851.GI10409@kadam>
References: <1572965351-6745-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572965351-6745-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=706
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=792 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 10:49:11PM +0800, Pan Bian wrote:
> The variable skb is released via kfree_skb() when the return value of
> _rtl92e_tx is not zero. However, after that, skb is accessed again to
> read its length, which may result in a use after free bug. This patch
> fixes the bug by moving the release operation to where skb is never
> used later.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

