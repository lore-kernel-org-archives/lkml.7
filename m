Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757D0C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A52218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mY0ZsRuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfJCLNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:13:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47832 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCLNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:13:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93B9DLO113654;
        Thu, 3 Oct 2019 11:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2QI2whAR0eSmVo1/waKAX5FLkh2SyO0ymtbtvm3t65g=;
 b=mY0ZsRuSWWsWBscNfWJCsoMDV2+OsiCTI06RsLqeRgTAWsHtaGvfjr99SyaVCnfli+Hl
 qy9HND3gjHwg/h9sUov7b9MMqsPTcRxenzpMDlVFzYgTd6WjByzN21HxiMPRFAj66ZbZ
 cOa8H8f9e4xb5s5JF8K18/jFNHu86P/wnBQD2um0QcOhToXZTrZ8P2AxB7sNXDov3y4s
 eH1RkHQFNcCXBzSE9r4oudJyD5oZL6HmEObuDrjjuARbv1im7AfvCnGqS2qa4bXW77FS
 FwWWfaJ6hI/uTPM578UYQIYTa/D6KmEv9Yi7avahP5kR6UWzd5vI6kTVbMCBw2q+PBWe qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxv37a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 11:13:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93B8K0K095938;
        Thu, 3 Oct 2019 11:13:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vc9dnm5e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 11:13:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x93BD8v0027718;
        Thu, 3 Oct 2019 11:13:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 04:13:08 -0700
Date:   Thu, 3 Oct 2019 14:13:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: use bdev_sync function directly where
 needed
Message-ID: <20191003111302.GQ22609@kadam>
References: <20191002151703.GA6594@SD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002151703.GA6594@SD>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=939
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 08:47:03PM +0530, Saiyam Doshi wrote:
> fs_sync() is wrapper to bdev_sync(). When fs_sync is called with
> non-zero argument, bdev_sync gets called.
> 
> Most instances of fs_sync is called with false and very few with
> true. Refactor this and makes direct call to bdev_sync() where
> needed and removes fs_sync definition.
> 
> Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

