Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF41DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECB120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YyVPVkry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfCZCZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:25:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfCZCZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:25:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q2P5SX077370;
        Tue, 26 Mar 2019 02:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=YlN08lgWqUjAGIaUpT9fV5glukI3seX0g5Ww3GQPoic=;
 b=YyVPVkryj2pD/q8vyuw3DdS847Vjky17X8RuUS0gQi9LnN6zlMnnnY4IPgSwZ+1SWQza
 i9NMvFqQAIEjWOENlSNcpaSYYC0f8irdr04ZHNq7A0/+wj8Nrcc3DNZeFNDTXV/b/pAl
 1l+W40futhu8fRiOiATS+7ztV5DKppBcdvecRdT6hyR4rU+mbiLqOhvRDVCCMUeFdXZF
 llcaU+KTOZQ3Z3lVh4NeK3YhzhHi0Qei2oxUKZKof43ZUs1lNk8adj/tO0A205y11vax
 TaZmGTLEVRDm64KnrPaNAISbV0kmjx0/nesv3ADC8fdOn8iaaoGUHhIILM6J0TbBXoXU sA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2re6dj7ngt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:25:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2PVT7001141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:25:31 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2PT10028429;
        Tue, 26 Mar 2019 02:25:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 19:25:29 -0700
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla4xxx: fix a potential NULL pointer dereference
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190314063100.12805-1-kjlu@umn.edu>
Date:   Mon, 25 Mar 2019 22:25:26 -0400
In-Reply-To: <20190314063100.12805-1-kjlu@umn.edu> (Kangjie Lu's message of
        "Thu, 14 Mar 2019 01:30:59 -0500")
Message-ID: <yq1d0mez815.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=583 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kangjie,

> In case iscsi_lookup_endpoint fails, the fix returns -EINVAL to avoid
> NULL pointer dereference.

Applied to 5.1/scsi-fixes, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
