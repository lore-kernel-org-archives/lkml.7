Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DEDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B9A2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pzp7/UYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfGXCTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:19:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXCTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:19:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2IaK2042371;
        Wed, 24 Jul 2019 02:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=+M7LK/ZtYxBmXZfLIfjuOrGvvva8ZmsJzQvLKXtlqfY=;
 b=Pzp7/UYtgsYSGYF/it5yMDCJwnB4GnfhmgBABiZ/kNKbj/cRnVy2UUX1OKsRNwR0AVmU
 Ionj01aaOMfz7YQP0qiRX6rrPO+d191jZdBRrqP7w6tIEmD4zHQEM3EQ/VhgDXT8ln9H
 9T15DgQ7V1q00WaKmS+jOiUpbWwS6nu7TPExzvsXEpGcUOazLPxf7PMoXXWeyazIZlkg
 gELAQpNU0/tQDpPcxJaAdrZvvU26xKlNwzoNoYxXrxq/OAJjoMzGQW9XwAoHupYB3vyv
 WK9X5XSpMSG4c/fpjz8Y3gTFntmWl2kwD7qqSZCdd0ByMjzUV7zyV2TWYAX03UY0+9NR KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tx61bt7u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:19:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2I6bx072234;
        Wed, 24 Jul 2019 02:19:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tx60wy810-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:19:01 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6O2IqrZ019991;
        Wed, 24 Jul 2019 02:18:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 19:18:52 -0700
To:     Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc:     james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.vnet.ibm.com,
        abdhalee@linux.vnet.ibm.com
Subject: Re: [PATCH] ibmvfc: fix WARN_ON during event pool release
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190717194827.12514-1-tyreld@linux.vnet.ibm.com>
Date:   Tue, 23 Jul 2019 22:18:49 -0400
In-Reply-To: <20190717194827.12514-1-tyreld@linux.vnet.ibm.com> (Tyrel
        Datwyler's message of "Wed, 17 Jul 2019 14:48:27 -0500")
Message-ID: <yq1ftmwqinq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=780 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tyrel,

> While removing an ibmvfc client adapter a WARN_ON like the following
> WARN_ON is seen in the kernel log:

Applied to 5.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
