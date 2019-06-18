Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD41C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBB920823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aa+6dcAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfFRI4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:56:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfFRI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:56:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5I8rYYH121174;
        Tue, 18 Jun 2019 08:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=N4RH0cwrpdeDoVRKfcDnUfAwZ5Y7e3pZpXdIwgGwtyU=;
 b=Aa+6dcAvpXYCHQ2ip/cIcsjE1eSzhw68hyzP7HfX0GAt8MTw8OULBP9Db7LXMIC3o6a6
 edkbZfV42yhIICie3nEWGFUVUdagWZvQPSPgYdw57gZ+poPDx2AJdntcYAmC9Ln0Kngm
 n8O8lAL/F7pYKuM6Cf+ui53H33JQXlBNrHmmnbKimfiDSUm3TMqsenphR1bg5E8oPvPx
 wCqglANR1zLar5iqQNaFsyWXmZb8yK+ikN9zRw/uDsYxu9Etl/c3eMmZcyRJe3KQmhf8
 rs4feYkfX4lo/15AC6AgkobUcIraMlA4j0h7kDCSZEfANNQdxGwA72oihUM8IGTog1kq ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t4rmp32w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 08:56:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5I8tYPb146055;
        Tue, 18 Jun 2019 08:56:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t59gdq7ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 08:56:03 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5I8u0ba002118;
        Tue, 18 Jun 2019 08:56:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 01:56:00 -0700
Date:   Tue, 18 Jun 2019 11:55:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: rtl8723bs: os_dep: ioctl_linux: make use of
 kzalloc
Message-ID: <20190618085524.GJ28859@kadam>
References: <20190618014410.GA8505@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618014410.GA8505@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=605
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906180075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=654 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906180075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:14:10AM +0530, Hariprasad Kelam wrote:
> kmalloc with memset can be replaced with kzalloc.
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> -----
> changes in v2: Replace rtw_zmalloc with kzalloc
> ---
> ---


The changelog should say something like:

    This patch is a cleanup which replaces rtw_malloc(wep_total_len)
    with kzalloc() and removes the memset().

    The rtw_malloc() does GFP_ATOMIC allocations when in_atomic() is true.
    But as the comments for in_atomic() describe, the in_atomic() check
    should not be used in driver code.  The in_atomic() check is not
    accurate when preempt is disabled.

    In this code we are not in IRQ context and we are not holding any
    spin_locks so GFP_KERNEL is safe.

regards,
dan carpenter

