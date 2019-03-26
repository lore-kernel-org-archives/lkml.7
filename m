Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2C620823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xYnu1uSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfCZCZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:25:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfCZCZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:25:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q2Ea0Q070654;
        Tue, 26 Mar 2019 02:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=qtJc4bBB/NvNu/ixyGKJVHvgBt+AIiWPQfvS/jXStcw=;
 b=xYnu1uSpv39AErf7rZYY7xTS1WqW+l8AV25FqQYDMxxWGD0gpLbtQZ0A7CSVonJdgRKC
 CawPholmMzhnSMSMU8TDMc728XXc/ewRDVLQ2Trm6QKBMc6RTM/nHvhif4IEPcmChSZX
 4CYb/Z4rSyI10OXSGUCUp2UOMYXAVpChP40QtLLCFU93POUtZrJ/JGyDY8YiBcyuV75R
 6FaW3GcpDtayf+tUVCtiNkoaPU8xIPlt4Qi5W45C+XxnQmd7s9cQwCynM/Os5z/QxQ2K
 qOTpxRrfgtr4rD1zu1KsZujjyx47CKy5cZBLInaTatIlgiIDx31kZdNanceqvKJFtj51 OQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6dj7ndk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:23:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2NKDx025409
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:23:20 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q2NJoG031885;
        Tue, 26 Mar 2019 02:23:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 19:23:19 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] scsi: gdth: Only call dma_free_coherent when buf is not NULL in ioc_general
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190307231839.3330-1-natechancellor@gmail.com>
Date:   Mon, 25 Mar 2019 22:23:16 -0400
In-Reply-To: <20190307231839.3330-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Thu, 7 Mar 2019 16:18:39 -0700")
Message-ID: <yq1h8bqz84r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=836 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/scsi/gdth.c:3662:6: warning: variable 'paddr' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> Don't attempt to call dma_free_coherent when buf is NULL (meaning that
> we never called dma_alloc_coherent and initialized paddr), which avoids
> this warning.

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
