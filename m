Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86837C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C3120830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qugWByDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfJCLep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:34:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42648 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbfJCLep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:34:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93BXvVO133419;
        Thu, 3 Oct 2019 11:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=ER+a2BxvyuPvFP+5B1+t/eEBvhU2exoZo5NNX+TZSPo=;
 b=qugWByDP7h2kyZmosEsA//CzOArVNvhkCVGLxNlY1WOzTGzEUn7pSrcWWiIpvNZjCx9o
 OcjuayS1A/KLU9vIvKtBGF7nXiE2qqyCRyxGpEkBF1h0gSIDI2zyokb4TDfbhxakbPMq
 thhCTFx5LgGmQKGa+57K99TbnS+fLlOlaFpYkKr1l3TscksQiLmtAj3RnWrkzP2DyoW4
 Isy6Ksevpvc8IlPN1HprJM0B5Ain9o53TNtczfzlHHg7PH4mh5DGe7t+xZOIf6firg+U
 snA6g3ezW8XbNS+G2kseHOCWQ0/lMhJ+KubLFhJfX692NrThnXslDcjKj6joCovu4gQZ eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2v9xxv3bm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 11:34:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93BYMqu059837;
        Thu, 3 Oct 2019 11:34:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vckyqmerm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 11:34:40 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x93BYcG0006862;
        Thu, 3 Oct 2019 11:34:39 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 04:34:38 -0700
Date:   Thu, 3 Oct 2019 14:34:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: Re: [PATCH] drivers/staging/exfat - explain the fs_sync() issue in
 TODO
Message-ID: <20191003113429.GS22609@kadam>
References: <9837.1570042895@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9837.1570042895@turing-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:01:35PM -0400, Valdis Klētnieks wrote:
> We've seen several incorrect patches for fs_sync() calls in the exfat driver.
> Add code to the TODO that explains this isn't just a delete code and refactor,
> but that actual analysis of when the filesystem should be flushed to disk
> needs to be done.
> 

This doesn't help at all because no one can be expected to read it.
Put a comment in the code which says something like:

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 229ecabe7a93..c1710d99875e 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -287,6 +287,13 @@ static DEFINE_SEMAPHORE(z_sem);
 
 static inline void fs_sync(struct super_block *sb, bool do_sync)
 {
+	/*
+	 * Oct 2019:  Please, do not delete this code or the callers.  This
+	 * code is obviously bogus and many of the callers are dead code, yes,
+	 * but it may hold clues as to when syncing is required.  Someone needs
+	 * to go through and audit it really carefully.
+	 *
+	 */
 	if (do_sync)
 		bdev_sync(sb);
 }
