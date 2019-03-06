Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D068C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB28206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3slpz7pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfCFRej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:34:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53668 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfCFRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:34:39 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x26HXnTj193543;
        Wed, 6 Mar 2019 17:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=n6y1aQUDElZ7paoxxJnrQibQCGHiuR4BaJNc5tEgvPk=;
 b=3slpz7pquMO3RV1NICGz1whyJInNLp2So8170vEgVCfv8IrP2cfTCL6jnNbcYbFgJ73k
 11DVmtqMeq7/VFlX7xOFuTnv+2X3MfgwfToyUqHjcXN5Td0SRGJTUkSZn9kTCQZ2dIVH
 CJj8gjL4KR0qb/WLevcW8DvrBbVSTcKnfTqnXqEZy42nvhZU76svm4SUmJzEZeu7Nt4c
 IJo9KVF3ow2JWpgKSzVVjpsXsFC5wHz1oTbxRsSTLsWjlFWggk0leo7HpatFq4W/Zccs
 uVOSsDUZh58r9he6d7pc0Hx+eWEKPKeEJmBrOFCIjL0J3I4Rkubo7inpdPvQAZ5SLG4U Yg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qyfbedfn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 17:34:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x26HYUXB023141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 17:34:30 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x26HYTOK006313;
        Wed, 6 Mar 2019 17:34:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 09:34:29 -0800
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20190301160806.16099-1-e.velu@criteo.com> (Erwan Velu's message
        of "Fri, 1 Mar 2019 17:08:06 +0100")
Organization: Oracle Corporation
References: <1551455797.3334.6.camel@linux.ibm.com>
        <20190301160806.16099-1-e.velu@criteo.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 06 Mar 2019 12:34:26 -0500
Message-ID: <yq1y35rzz31.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9187 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Erwan,

> When the HARDWARE_ERROR/0x3e/0x1 case is triggered, the logical volume
> is offlined.  When reading the kernel log, the reason why the device
> got offlined isn't reported to the user.  This situation makes
> difficult for admins to estimate the root cause of the issue they
> analize.

Applied to 5.1/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
