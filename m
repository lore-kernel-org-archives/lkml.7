Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4ACC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7036E2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYfQodRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfJCLrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:47:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56074 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCLrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:47:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93BiNmT141829;
        Thu, 3 Oct 2019 11:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=VkrIv0UgUYabJ9VoBKBsjxs38jDxDS91sqJRxmziBN0=;
 b=bYfQodREFQ2hKwNSHsOKxqCPlSGvrESt4bnu6kAFrquq6uMPA2FVtsTbIhC/KHtK6W2T
 Y/3EMLP8xsXBVP+u9tdbXIMKz2m4zduUhSODUqerWgaC4OatL4iNSFgxro0vRceDXxx6
 T/jye2y5I/EKaqr1UUH1hD0jLot8NpM31uAacOnPrXGRhiC3xyrHXKrT0PuIUsEUO5Ic
 ooeKum2JddPgFuxECytL0toqz33thsLAc+zII+ajzT/xackFNYP3M1CHepzlzYv1EUxp
 MnaFQayfyrItvu22nzfWnWX5k6vgsVNj5PTT7y+ZqpK3KEYiUIysFPtbdsBTX8R2yDfG MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v9xxv3e23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 11:47:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93BhvWL033585;
        Thu, 3 Oct 2019 11:47:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vcg63fc06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 11:47:13 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x93BlAFs008475;
        Thu, 3 Oct 2019 11:47:10 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 04:47:09 -0700
Date:   Thu, 3 Oct 2019 14:46:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: use bdev_sync function directly where
 needed
Message-ID: <20191003114654.GT22609@kadam>
References: <20191002151703.GA6594@SD>
 <9938.1570043055@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9938.1570043055@turing-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=927 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I replied to your other thread and I added Saiyam Doshi to the CC list
there.  Just to be clear this patch is a good cleanup and doesn't affect
runtime at all.

In the other thread, I suggested that we leave fs_sync() as a marker
even though it's dead code.  But looking at it now, I think that it's
not really useful.  Future auditors should look for places which call
fs_set_vol_flags(sb, VOL_CLEAN); instead.  That's exactly the places
which call fs_sync().

regards,
dan carpenter
