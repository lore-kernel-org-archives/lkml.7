Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1419C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D6624425
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wl6p/gtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfE3CMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:12:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfE3CMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:12:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2A3ZL183552;
        Thu, 30 May 2019 02:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TK4HxiyT84v3DfXzv3Ghgl6nVzJVOQ1vSjKsSf7Y7OE=;
 b=Wl6p/gtZSzx1hdyVhn9C9JTVr20EFddGGd1t47OCeKJl6XjQgquYXgQVV3Tr1w6uYhMR
 ZG8OcbJz208Kymyamche4saBYSfGX5sMYJdd7mKh/zJe8sUQo/Qq30DtzE3VX+Q4BAhs
 PU0mCVQqaMQ/V8vobM/jBlEJmrkkwkZHnc/UxhiyKjuQklony61Pc64PQQiGY8N2mRK7
 hlxhJJj3GbiAyO4RuGhyaKpr8uDSkNNEAzaTE6YESMImZubNRngCbAoLfKrPiqYAhRae
 QTTMzJlcUHnqJWTGuleeNfK2v0bFYgilNLBm2fS8TE6sb40+AkLN0Jow0TO4MAyCNX6V tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tnbk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:11:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2BMa6139401;
        Thu, 30 May 2019 02:11:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ss1fnt2dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:11:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U2BgQn022351;
        Thu, 30 May 2019 02:11:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:11:41 -0700
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>
Subject: Re: [PATCH v2] scsi: libsas: no need to join wide port again in sas_ex_discover_dev()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190520140600.22861-1-yanaijie@huawei.com>
Date:   Wed, 29 May 2019 22:11:38 -0400
In-Reply-To: <20190520140600.22861-1-yanaijie@huawei.com> (Jason Yan's message
        of "Mon, 20 May 2019 22:06:00 +0800")
Message-ID: <yq1muj4y9lx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=841
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=883 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason,

> Since we are processing events synchronously now, the second call of
> sas_ex_join_wide_port() in sas_ex_discover_dev() is not needed. There
> will be no races with other works in disco workqueue. So remove the
> second sas_ex_join_wide_port().

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
