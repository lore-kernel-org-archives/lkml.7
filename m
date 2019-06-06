Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AFBC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7877A2064A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TiuKhcgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfFFWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:02:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55612 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFFWCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:02:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56LsQKi098174;
        Thu, 6 Jun 2019 22:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8VdDFbqHussZfRli7/Ekq+VSSWAZRQe4ch9vBJOAbCg=;
 b=TiuKhcgQGIeZ6Q8j04RBHFzib+klmcOpCPiw7y0TVbH6qww1avRuXAl16W4Ds4DxOrko
 MJz/AtGd79kSsHvl6MyefahqRb5tXi0snhJCdhJKMv2Xh9fVsEs+BWUPDuHFwsRdzT+y
 u9CYgaG3WheNyiARdFthJq4pijv4ia5oUVWqeUfVcy5Hr3nbBkwx1yFx+kjL8IFD8zyD
 XUDlP5O6UR3bWJr0g99EnrOCx0tNpqM/Exuxmx0YXk23cH4MLEuDRDwnnDEnBDtdoSi0
 BUaNSdL4kyPMzxVeYZlAQbobdPgcXI2tAqdTEEW6xm2p3HDkWeBr5hFU0NywOSrIFvyw eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2suevdudp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 22:02:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56M2L6t166587;
        Thu, 6 Jun 2019 22:02:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2swngmrr15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 22:02:25 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56M2H2A012404;
        Thu, 6 Jun 2019 22:02:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 15:02:17 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <intel-linux-scu@intel.com>, <artur.paszkiewicz@intel.com>,
        <jinpu.wang@profitbricks.com>, <lindar_liu@usish.com>,
        <yanaijie@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>
Subject: Re: [PATCH] scsi: libsas, lldds: Use dev_is_expander()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1559751143-168560-1-git-send-email-john.garry@huawei.com>
Date:   Thu, 06 Jun 2019 18:02:14 -0400
In-Reply-To: <1559751143-168560-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Thu, 6 Jun 2019 00:12:23 +0800")
Message-ID: <yq1k1dymkyh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=685 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> Many times in libsas, and in LLDDs which use libsas, the check for an
> expander device is re-implemented or open coded.

Applied to 5.3/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
