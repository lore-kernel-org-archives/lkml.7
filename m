Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CED206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qflofk8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfC2OPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:15:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfC2OPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:15:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEDoHF195938;
        Fri, 29 Mar 2019 14:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ArgrVe2n/QrNNR7jLLQQSMbhYPCvTCIbzXI5b7Uywbw=;
 b=qflofk8slfJh0cYZiJEx18VTuOtos7N0G4vSM79Y1XxEPyTrP+5R1hAt0jBhPTWd7wwV
 u5hhPnSAPQ+v9P1/ZDrmI/FB9pUFpR88g48P3KToz6UwILLQVEo7K1K6Xj/PzHUFEUhs
 N2MVa9pWiLFmMiDbYhDb5orvw7f3yPyj9rT3Wts8+GjcHVt+BZ83krYjo4e9peZDaLLO
 47nf7QmbqOWoc4ClnRbLVwE1kzcNeEITssCkjINRazFSS0qUMyHJKN1LimYKTfmYfa7f
 tu1exireBjZYMgtN+GLo1l6mrgze4cnKnS8hrdgM5a3Xp1eIk8AvOiLvT8yCBojvS7Zt UA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2re6g1mmwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:14:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEEpXo011826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:14:51 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEEhOI009961;
        Fri, 29 Mar 2019 14:14:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:14:43 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: pm8001: clean up structurally dead code when PM8001_USE_MSIX is defined
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190328234328.15860-1-colin.king@canonical.com>
Date:   Fri, 29 Mar 2019 10:14:41 -0400
In-Reply-To: <20190328234328.15860-1-colin.king@canonical.com> (Colin King's
        message of "Thu, 28 Mar 2019 23:43:28 +0000")
Message-ID: <yq1zhpdrcmm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=822 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> When macro PM8001_USE_MSIX is defined there are redundant dead code
> calls to pm8001_chip_intx_interrupt_{enable|disable}. Clean this up by
> compiling in the appropriate enable/disable handlers for the defined
> PM8001_USE_MSIX and undefined PM8001_USE_MSIX cases.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
