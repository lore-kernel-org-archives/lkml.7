Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20C3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5A820830
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1q7sRZNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfDOXdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:33:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41358 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfDOXdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:33:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FNOaVs004724;
        Mon, 15 Apr 2019 23:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=S6iUoWbdaEA+PSkUhDZ8iSrYCCtvlfOWfd9NXhcPRSU=;
 b=1q7sRZNa8+FtGtlHwgu4KdsuT0WutoxSWF/n810CLiw+q6EHEW2ummfT3CffHueHt+Wp
 jd/J4IUyRXWE0V+AeRa6+D1lB4z/RGr532/W9wXdvIG12Wz8U7Veo9oqSjSLh9V7F6mG
 jlZLDc7lzqszhrpm+LqQ0qmc056xejdlM1WowdKkzWty5y4LZbi33BD87EQyYH+ZULfe
 CpJEJALnn3FXIATbOCoTQARJLpTVxPK9b9GujqN64EhuOm1SqfhEI7j0ThEBMxVpPH1a
 536G34mGC0nXA6cKotrwWXaTySaZM3GplA8HYREdz6LN0Bphrof70EVCu7l6fUcF3b4H qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rvwk3hn9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 23:33:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FNX1CP143458;
        Mon, 15 Apr 2019 23:33:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ru4vsvqaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 23:33:29 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3FNXSDw031940;
        Mon, 15 Apr 2019 23:33:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 16:33:27 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>
Subject: Re: [PATCH 0/6] libsas: Some minor improvements and tidy-up
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1555059478-36224-1-git-send-email-john.garry@huawei.com>
Date:   Mon, 15 Apr 2019 19:33:24 -0400
In-Reply-To: <1555059478-36224-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Fri, 12 Apr 2019 16:57:51 +0800")
Message-ID: <yq1v9zehmij.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=710
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150157
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=731 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> This patchset introduces some minor improvements and tidy-up, including:
> - fix PHY info in sysfs for PHY events
> - min pathway rate programming improvement
> - some other tidy-up and neatening

Applied to 5.2/scsi-queue, thanks!

One thing that always bugged me is the ambiguous "ex" prefix for many
libsas log messages. And in a way, your patch #3 makes things worse by
replacing the more descriptive "Expander" with "ex". It does make things
more consistent, though.

I'd really like to see all the libsas messages be cleaned up with a
sensible prefix and a consistent format where possible.

-- 
Martin K. Petersen	Oracle Linux Engineering
