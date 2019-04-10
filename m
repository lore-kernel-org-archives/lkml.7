Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCB5C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147AF20874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I8isczBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfDJBd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:33:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60982 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDJBd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:33:27 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A1TBlj071627;
        Wed, 10 Apr 2019 01:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=efDcI+eIByyCHzz2i/O4AhEn2Ewz8neL0793qaoZnG8=;
 b=I8isczBEz2kgTpSfQ6ClDhodXLRkMjqBP5s3eVwxA1hwP0tW1W73vpsXm8tSqlPeg//O
 RdkU8HjGR6YNcUmpbioqMEp9oT1sAi6v12WjYaOtg8gTgrbxd7H48bXRyg3oNZIOV2EQ
 3GSxGylFXjX1jzxkVAh+7KbxV3OsR5zA7p02v7d16xAuST4WuHUfn+ebf4YhK+MYGiS8
 3gJR9yG48p8EKad1eAL3f94jKKTuJN6yf4/XenY4W1UZkbOAukGNFW/KH+F+FtMX04lK
 krkyhCqIiwFvlZT9WV5NxZ3aW8kGUbiTb9I/bG4PzVsDjzTTH3Z3OrKsfIDhRAHxyle/ lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphmegea4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 01:33:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A1XAoe148229;
        Wed, 10 Apr 2019 01:33:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rpkejkfbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 01:33:15 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A1XBCm015407;
        Wed, 10 Apr 2019 01:33:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 18:33:11 -0700
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190409162749.7eb6656f@canb.auug.org.au>
        <20190410112138.178aa7bd@canb.auug.org.au>
Date:   Tue, 09 Apr 2019 21:33:09 -0400
In-Reply-To: <20190410112138.178aa7bd@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 10 Apr 2019 11:21:38 +1000")
Message-ID: <yq1tvf6myp6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100010
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=813 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

>> I have reverted that commit for today.
>
> This has now migrated to the scsi tree.

I have a fix in my tree but I haven't pushed it yet.

-- 
Martin K. Petersen	Oracle Linux Engineering
