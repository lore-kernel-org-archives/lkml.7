Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C499C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E817A2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3rqpEBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfC1BAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:00:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfC1BAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:00:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2S100oK002497;
        Thu, 28 Mar 2019 01:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=gsrSWdgbGH4dOSb8bSfpOTpht5K52Hh9WDmoa4gkt8Q=;
 b=I3rqpEBZ9rIEHFJ6wwFhHkau4I0aO4aY7pq6lurxXXhV0nm2jEuq27gQepwYAG4xqKva
 5pU4swigcLGuJtvNBJPL6LwS/TBvrSZMSaDKZImjBctz/eHJ5xFfhuvgCpggTc4SsnuX
 DWXgd6/aI/OhUHPYjkapdkwkY1BsLThJELYkEX+Z1ZnukD7Nb9kTH6kor/zWGyD6qqy9
 b44NL2PX3nxGVsai0gSKQR8jke1FsrvPfksa4aV4M7vbAbCVE+afMA8tMTBQvkR0OoJI
 +Qz++NPQnz9u8JIXf0zuFqbSyaD/BJVS3yiPblw/EbFAHy4xnymsXyPgnZrNeeoDzcbP vQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1bqh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 01:00:00 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2S0xx2E029113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 00:59:59 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2S0xw0E006648;
        Thu, 28 Mar 2019 00:59:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 17:59:58 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        David Ahern <dsahern@gmail.com>, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libcxgbi: remove uninitialized variable len
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190316225709.8630-1-colin.king@canonical.com>
Date:   Wed, 27 Mar 2019 20:59:55 -0400
In-Reply-To: <20190316225709.8630-1-colin.king@canonical.com> (Colin King's
        message of "Sat, 16 Mar 2019 22:57:09 +0000")
Message-ID: <yq15zs3x184.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=857 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The variable len is not being inintialized and the uninitialized value
> is being returned. However, this return path is never reached because
> the default case in the switch statement returns -ENOSYS.  Clean up
> the code by replacing the return -ENOSYS with a break for the default
> case and returning -ENOSYS at the end of the function.  This allows
> len to be removed.

Not a fan of this ENOSYS business but I guess it's been that way
forever. Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
