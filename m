Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660FB20835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1Jn9i6E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCUAdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:33:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34554 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfCUAdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:33:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L0TG90138702;
        Thu, 21 Mar 2019 00:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HKgrBqbUgKzxTA4A92UBs5xKqD9cHL0+kseWjwVcktI=;
 b=1Jn9i6E0azQme1uziY2hqyZ1HQVPZUtDP30WAUCooH6JVPqTuCc2zP/hR7VtiHcfFcxN
 d8Ew6bN3rWCyfBBU4cgntYhH1G24gWn/1IdjVQgPjt1zj5GzB/ktxY6CYIR9Z7NRV1jK
 tZtesBVJQsk9895JcdVk/c5N3J+H3HwfURlmW+YOb+SDG9We0u64r8v/ObOpoQqNxYdm
 3WZCUY7f4eeN9t+wioci74rns0i4COOnBDm17mTcWx3ulf763cTCzcjQKtBsLvplILlo
 vnfFO4AVnaDUUq/56o8hTVWrz05nkywALw8OGJ8WdY9daP+Bx9jwb2HY5eeKTFDb9gLc Ng== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjuwv0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 00:33:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2L0XkW8023726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 00:33:46 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2L0Xj2D023264;
        Thu, 21 Mar 2019 00:33:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 17:33:45 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: target: fix unsigned comparision with less than zero
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190320163709.28767-1-colin.king@canonical.com>
Date:   Wed, 20 Mar 2019 20:33:42 -0400
In-Reply-To: <20190320163709.28767-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 20 Mar 2019 16:37:09 +0000")
Message-ID: <yq1sgvh5amx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=858 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Currently an error return is being assigned to an unsigned size_t
> varianle and then checked if the result is less than zero which will
> always be false.  Fix this by making ret ssize_t rather than a size_t.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
