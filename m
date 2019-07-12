Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03021C742A1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4A3208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C8bCwhVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfGLAiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:38:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGLAiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:38:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0XsBO179766;
        Fri, 12 Jul 2019 00:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3YQo0ogAq7ZhlFyUYP1eMcCPQV10NpbRaXAOsP9YmaA=;
 b=C8bCwhVH8dhIuv4jB1nHG1qE69l+u88NRWGuVFgVjbbGFEGu4x6356wBO3V2xhlVZRki
 JVNqyNXi5cn9K/T1xfQo4PDGHy/olQLriozJD+EO99fYmjF9FO//ENiRoJQp6UYvfOuY
 nbWc8ETbjVg7NdvBi4oPxrZOWQjSIXyU1KyfcPonmgw25q4HkAZiZrkAlY94gu9CtcfF
 dRDywx4vZpAE4fal5LDuOgCL5FywZI8ue26XqM7NwyTLgR2iZkKFka6tlCCyXd2fEaqJ
 swIFgPgEZJPY75XCNNEp+QIu1s94y/4tBBulPIuxdHK0WiK0PqCwy6VhpDMXzGT5pXK4 gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tjkkq2uve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:38:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0cBZL089169;
        Fri, 12 Jul 2019 00:38:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tnc8tuctf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:38:48 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0clYB004447;
        Fri, 12 Jul 2019 00:38:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:38:47 -0700
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Keyur Patel <iamkeyur96@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: aha1740: Use !x in place of NULL comparisons
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190711234833.27475-1-iamkeyur96@gmail.com>
        <1562889124.2915.5.camel@linux.ibm.com>
Date:   Thu, 11 Jul 2019 20:38:45 -0400
In-Reply-To: <1562889124.2915.5.camel@linux.ibm.com> (James Bottomley's
        message of "Thu, 11 Jul 2019 16:52:04 -0700")
Message-ID: <yq17e8o84tm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=815
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=882 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James,

> I also don't really think the replacement adds anything to readability,
> so it should probably be removed from the checkpatch warnings.

I agree.

-- 
Martin K. Petersen	Oracle Linux Engineering
