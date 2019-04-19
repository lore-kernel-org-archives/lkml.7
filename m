Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE500C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C37E2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 00:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j77Im32A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfDSAdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:33:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45224 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDSAdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 20:33:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3J0SsUk187711;
        Fri, 19 Apr 2019 00:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6hr9wOAg/2Gq9iOyAv8Cy8Ccua3tVlGNSGr4rrWv3K4=;
 b=j77Im32AKoSQaa25bDt7szeMKo5maZmF3i0q7fCfXCMsavw0Atwy02G52uleAINhnAib
 zusKOzXL6j2PmQlV3uRt0+rAULzUlpoeRLw1mb/qoLIANNYxcXmCXECOqiy40o7g3pVs
 qtBaglOX7UZ92hLHIFfjk4G+c4dJbkrzKBUK8fuGFrsOYfLHKLu09JgDvq26OXJRwNYM
 ieIzsf/7Y3oAX49KjcK7aojib/BznrksEBssRVWOYQ93mwe76VJqAhRsTv1sh7rzX8PD
 mgnksLf/yNXP+G10j7bWhUp9CuNhn8I/TUAOKKJB2vBfEK2qQRZvpxYlv81tMFCd//VQ ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2rusnf9hs4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 00:33:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3J0WUrM077256;
        Fri, 19 Apr 2019 00:33:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2rubq7tp3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Apr 2019 00:33:25 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3J0XO1V009181;
        Fri, 19 Apr 2019 00:33:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Apr 2019 17:33:23 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] scsi: qedf: remove memset/memcpy to nfunc and use func instead
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190412094829.15868-1-colin.king@canonical.com>
Date:   Thu, 18 Apr 2019 20:33:21 -0400
In-Reply-To: <20190412094829.15868-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 12 Apr 2019 10:48:29 +0100")
Message-ID: <yq11s1ydeb2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9231 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904190001
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9231 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904190001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Currently the qedf_dbg_* family of functions can overrun the end of
> the source string if it is less than the destination buffer length
> because of the use of a fixed sized memcpy. Remove the memset/memcpy
> calls to nfunc and just use func instead as it is always a null
> terminated string.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
