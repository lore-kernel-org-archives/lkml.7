Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70659213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t4lUA46e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCSSo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:44:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfCSSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:44:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JISmcc070755;
        Tue, 19 Mar 2019 18:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=x2ncoMDTKBqNd/nE2KUHRm71WZMJUlHQG4ALc6y+L7g=;
 b=t4lUA46e7+PCTIAJ+y8dIejw0/H9TtTV0ocFNE+h7dxBHKB9x9GpmiNFgFBz/xjL4Ulr
 73wOeYAlSJptVaz1aOIvmMlooUPOAMP8CRdvzAVYJHYkDnGJRrPlvD3VgtKrdoNDnw8i
 JvXrAy/hWpFOe9VS2lG5xZQgKdI/GLJQlGlNJSrUwvoOARMtig2G84acy/O/nSaNJ71l
 x8Upoeka4weO/IEZjnw/dwo0lxYXFfyObOd1pENmoTzyXMwKSTcCN/X+Q1DtD9X4GQS0
 Ca00G29yBNUWLta2kBDFmsMjOSEKHtLhtkX+WH7+GOwMIBRrPOsLbP7S9sz4dwcpzsRs VA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r8ssregyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:44:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2JIiEtH005287
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:44:14 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2JIiDfr008214;
        Tue, 19 Mar 2019 18:44:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 11:44:12 -0700
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-scsi@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        linux-kernel@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, don.brace@microsemi.com,
        esc.storagedev@microsemi.com
Subject: Re: [PATCH 0/4] scsi: cleanup hardcoding by replacing 0 by HCTX_TYPE_DEFAULT
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
Date:   Tue, 19 Mar 2019 14:44:10 -0400
In-Reply-To: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
        (Dongli Zhang's message of "Tue, 12 Mar 2019 09:00:27 +0800")
Message-ID: <yq1tvfyd7r9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=759 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dongli,

> As in commit 7d76f8562f4c ("blk-mq: use HCTX_TYPE_DEFAULT but not 0 to
> index blk_mq_tag_set->map"), this patch set cleanup driver/scsi/* to
> index blk_mq_tag_set->map[] with HCTX_TYPE_DEFAULT, but not 0.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
