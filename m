Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A91C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E1F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MX2lw0nV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfGRS06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:26:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57994 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:26:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IIIa1J047109;
        Thu, 18 Jul 2019 18:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=OnYLhiqXiu1Y8FarVePAOqTyggRJtJ1wRkHK85SbSQc=;
 b=MX2lw0nVN0So3oklGUpaSfpZJkVmGkoadUUdK+D9edKcfqA1+PMU4BL9PdiwB57x6oby
 WbBL9dGHHErR1TR4xR9l/VeDIpH7o1TzKIBd2Z1+MifcUg01goUsZDro/5UazptvuDgA
 tZHZE2iu3jmho+EStl6MbF4rh2D0qYghRYbksVcIDOVDjMmbjxVP2q3SluAyq2/rwitF
 p9oLb1vDeC0PYqVhKKRl6FABlU4JOB+LIV2TXhvopzj4EFLTAQZGCkciVoQg2FWrRv8i
 tIf7J+qAT4g91eD8fVn5gUhztdAPA9PTSiL9IIny5VyZjhKzLo66bmdsgV70VLPtD8/3 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tq6qu2ndk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 18:26:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6IIHVij033612;
        Thu, 18 Jul 2019 18:26:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tsctyc9bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 18:26:40 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6IIQb2J028563;
        Thu, 18 Jul 2019 18:26:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Jul 2019 18:26:37 +0000
To:     Waiman Long <longman@redhat.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in ses_enclosure_data_process()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190501180535.26718-1-longman@redhat.com>
        <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
        <1558363938.3742.1.camel@linux.ibm.com>
        <729b0751-01a6-7c0b-ce0d-f19807b59dee@redhat.com>
Date:   Thu, 18 Jul 2019 14:26:33 -0400
In-Reply-To: <729b0751-01a6-7c0b-ce0d-f19807b59dee@redhat.com> (Waiman Long's
        message of "Thu, 18 Jul 2019 14:18:25 -0400")
Message-ID: <yq1blxrxkpy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907180188
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9322 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907180188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Waiman,

> Is someone going to merge this patch in the current cycle?

I was hoping somebody would step up and patch all the bad accesses and
not just page 10.

-- 
Martin K. Petersen	Oracle Linux Engineering
