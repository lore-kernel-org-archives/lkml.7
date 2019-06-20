Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73290C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B22E2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AcD7rKoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfFTUvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:51:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37602 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:51:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKmsDQ064926;
        Thu, 20 Jun 2019 20:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6JP7lm2OZ/s8N3n4vrVmlS3zuDBNhdh0HIxRfpm1X88=;
 b=AcD7rKoagx/YGPKephWJA4xky+veL8fIllJ2JTX/6X1kDfjeMC36iA3x83BZ6IBa225C
 mhxBPDa7BX7z82TNikunwfJuwMaZ4ijYb1M+x2NZfwPWJVeXyTnQTu9SlKqykc5VxaPx
 RlYWnluddsi5GG8btjlorBotYluSSUZl3qJ9egPGSdpXOOiiyQgD36wTfvZYZKu8Bu0Y
 DvRo9W9TkF2hcdmQLdmkIG+oc1yON4JDLh81pxiRnkLXeExojFJ0Au4G8TMag8+4VEP0
 fB0CgtAdxfoNjuZu1AQ0kisWnd+avPYdltLhgGAvbQqIjey9ViAoHV/ENwQYO2ctp+3Y fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t7809k7s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:50:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKnOlJ107759;
        Thu, 20 Jun 2019 20:50:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t77ynu3ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:50:57 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5KKouUx007906;
        Thu, 20 Jun 2019 20:50:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 13:50:55 -0700
To:     Young Xiao <92siuyang@gmail.com>
Cc:     QLogic-Storage-Upstream@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: Check if sense buffer has been allocated during completion
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1560501397-831-1-git-send-email-92siuyang@gmail.com>
Date:   Thu, 20 Jun 2019 16:50:53 -0400
In-Reply-To: <1560501397-831-1-git-send-email-92siuyang@gmail.com> (Young
        Xiao's message of "Fri, 14 Jun 2019 16:36:37 +0800")
Message-ID: <yq1v9x0q8uq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=975 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Young,

> sc_cmd->sense_buffer is not guaranteed to be allocated so we need to
> sc_cmd->check if the pointer is NULL before trying to copy anything
> into it.

bnx2fc does not appear to use a driver-specific sense buffer.

-- 
Martin K. Petersen	Oracle Linux Engineering
