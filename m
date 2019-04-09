Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F04C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143E120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="worTJd4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDIBeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:34:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDIBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:34:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391SjHg073490;
        Tue, 9 Apr 2019 01:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=yIxhe6Bl7ENcq2sbZzOlPvKyrWDWIEYZ2kgCOyaKPtE=;
 b=worTJd4SL33Wot6n44ngGfsTVmuYdozo+fW4e9v4IBDbWzzXCHPi3RWbrvvbCEvnCziz
 rlbXlFW0sn3mbMSki+F9aXdH+OFsAKhH7nXjKBMdZW/fKFRWmagzSJtKucmDMynirSsP
 wfbTXiakHqQI+iUA50izXJZUoVWXOHtfdq2160k4p2N99WmKVzkma4wnb7Jk1m2RLhxZ
 EaRrz1TCsqU5bxNNwvU7t3CahW71DK1M/jjEBXE59r2um7OH0PRDAJ9nfHIHc9Tkxm0Z
 nvSl/Bxh4kDOoq8FJ58BOk8zBEDqc6TksMuzpGjN+mBXZEeCMx+6wXZOGNs6u2q7DvdB 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrq1uhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:34:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391WQJn121681;
        Tue, 9 Apr 2019 01:34:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rph7sabtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:34:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x391Y7O1026755;
        Tue, 9 Apr 2019 01:34:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 18:34:07 -0700
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mvumi: fix warning Using plain integer as NULL pointer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190406175331.GA22504@hari-Inspiron-1545>
Date:   Mon, 08 Apr 2019 21:34:05 -0400
In-Reply-To: <20190406175331.GA22504@hari-Inspiron-1545> (Hariprasad Kelam's
        message of "Sat, 6 Apr 2019 23:23:31 +0530")
Message-ID: <yq1mul0otbm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=721
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090008
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=750 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hariprasad,

> Changed "0 to NULL" to avoid below sparse warnings
>
> drivers/scsi/mvumi.c:755:58: warning: Using plain integer as NULL
> pointer
> drivers/scsi/mvumi.c:1797:48: warning: Using plain integer as NULL
> pointer
> drivers/scsi/mvumi.c:2142:50: warning: Using plain integer as NULL
> pointer

This has already been fixed up in 7512ddef6307. In the future, please
make sure to submit patches against my for-next branch.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
