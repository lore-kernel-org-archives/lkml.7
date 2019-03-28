Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F30C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA8E206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="38S160oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfC1B3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:29:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34364 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC1B3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:29:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2S1SqJE031068;
        Thu, 28 Mar 2019 01:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=nml7gG+2M8xRZZi30iz7HgQa6HvXmHZccEomLXubZzk=;
 b=38S160oye7SNXkoVlpSWF1T/UjXAJ/8RQdrc3Xjz1E18XFDVC/N9ST+NvWkyAOYMHtAE
 CQZKSSh8guz+b/EtPirgG9dP/zBUwQPDiiETgTdi+5XfAOHdNg7w2M07mhtXU6hV/3MA
 9qBVbAKb6VvSa8pV44tI51om9WTS1MvB3PWy2ay9LPXVB/IgSXdtsu7e84Game/YBHXp
 7TG6pTgcugbRzBbYoHEad8EFtKhTzcP8LaGpns20fK99ZC+r7PSBj8UZoktR8wWJ42da
 qcCrqAW4ebihxLSoZh8VXvAn2Sr40kGSpzS/JlmB+Rm8IVkbRJ6Nj/VMgl+V2jQ5PZiE vg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6djkv1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 01:28:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2S1Spnt029570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 01:28:51 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2S1So66019967;
        Thu, 28 Mar 2019 01:28:51 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 18:28:50 -0700
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Joe Carnuccio <joe.carnuccio@cavium.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] scsi: qla2xxx: Simplify conditional check again
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190320163315.12740-1-natechancellor@gmail.com>
        <20190326220444.10040-1-natechancellor@gmail.com>
Date:   Wed, 27 Mar 2019 21:28:47 -0400
In-Reply-To: <20190326220444.10040-1-natechancellor@gmail.com> (Nathan
        Chancellor's message of "Tue, 26 Mar 2019 15:04:46 -0700")
Message-ID: <yq1ftr7vlbk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=751 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nathan,

> Clang warns when it sees a logical not on the left side of a
> conditional statement because it thinks the logical not should be
> applied to the whole statement, not just the left side:

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
