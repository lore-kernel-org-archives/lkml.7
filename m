Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B9F206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r4Rng49K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfFTVrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:47:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58474 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfFTVrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:47:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLhxKU004623;
        Thu, 20 Jun 2019 21:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=IE9TD5eL6LGXQo7rYRggqfOlzYr+mtZp6vIZPxJmskQ=;
 b=r4Rng49KNSI5jwEHefRWVXBmfVm0jfIeKEEyjyQVPWzEnonAis1AW0utcWPY7cIoHBF/
 bjcUfaUWrfysip/Gq7fgFdahhk6byhd0Pp69iXmzLF/sY6oF++yZ8O+7pNJvc3fMSdsw
 cKVTGp+PJ8EZFEKT/f66KD7Vp1RAcOC6wuysLCYWtRBTD8LjIZi15WU5jbAYLvR+ricq
 LO6LO1D+ezphhcKML99Bp8IBBGTMyILRmSxbW8Z+J1AG6BroF+1jH1qOo14g9sHSiJGi
 cgXOblKKRjO1FIuWn+X+f/lExzATHCUwA/DaDz3+hARLWv/KJMgKb2OegZ+Xwj757Pe5 Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2t7809kcc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:47:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLjnj3178049;
        Thu, 20 Jun 2019 21:47:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t77ynuub3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:47:09 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5KLl50A011658;
        Thu, 20 Jun 2019 21:47:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 14:47:05 -0700
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr>
        <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org>
        <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
        <alpine.LNX.2.21.1906181107240.287@nippy.intranet>
        <017cf3cf-ecd8-19c2-3bbd-7e7c28042c3c@free.fr>
        <f8339103-5b45-b72d-9f87-fd4dd7b3081e@interlog.com>
        <f1f98ab0-399a-6c12-073d-ee8ad47d5588@free.fr>
        <48912bc0-8c79-408d-7ed2-c127b99b8bcc@interlog.com>
        <e04e14b7-e1ee-c0c1-9e6d-2628d2c873a9@free.fr>
Date:   Thu, 20 Jun 2019 17:47:01 -0400
In-Reply-To: <e04e14b7-e1ee-c0c1-9e6d-2628d2c873a9@free.fr> (Marc Gonzalez's
        message of "Thu, 20 Jun 2019 11:01:39 +0200")
Message-ID: <yq1muicq696.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=638
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=691 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc,

> (I work on smaller systems where we do use /proc occasionally, but we
> don't enable CHR_DEV_SG or SCSI_PROC_FS.)

Many sg apps depend on SCSI_PROC_FS. That doesn't imply that only sg
apps depend on it.

As an example, with SCSI_PROC_FS enabled we don't need your SanDisk
Cruzer Blade patch at all since you can tweak the blacklist flags from
user space.

Also, the "legacy" moniker was wishful thinking. Applied to the Kconfig
option at a time where sysfs was new and shiny and considered the
solution to all the kernel's problems. But that wholesale transition of
all interfaces from /proc simply never took place. What happened was
that *new* functionality largely went to sysfs.

Note that I don't have a problem adding missing knobs to sysfs where it
makes sense. But it will obviously take a while for userland apps to
adopt it.

-- 
Martin K. Petersen	Oracle Linux Engineering
