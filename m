Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68171C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4BE2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qwKDLy4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfFSDNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 23:13:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:13:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J38uh2087827;
        Wed, 19 Jun 2019 03:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=jBqr8EGGUKl6jT179TS0wuWnGNESxVANKSQ31JH6dVA=;
 b=qwKDLy4x4x/1skVteYhCMsshTZuKYOFSWRcukwP32dd4zc2RNdBsjZw+7YCNSLY1izRn
 vBop+OLFJquuetFZEeG6JHtCrk8BAr3xgip2PSWN1z1jC86pEuGvVVObhYAjKmHHHxhW
 7327RlKDaXFRp10YDZqYV1V2nnm1096FYvXi0U5VRAQCB5CbXtRDDiDOJBrbftRd3Mny
 pA9YGlIZpB6+El2p+mt4eHm4PDZC19SJFXBF9HA5VKSXn3Jo+g0tQNTs8t/r7cQrj9ob
 Ag6WYARtB05v+D2hFCCir1qeAMkK7UI9fVIlm6M3CUMtFQPR5duBM8/ZvPf26DHD0Dqq PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t78098sd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:13:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J3Ba26139328;
        Wed, 19 Jun 2019 03:13:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t77ymu22c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:13:08 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J3D4gv007749;
        Wed, 19 Jun 2019 03:13:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 20:13:04 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ondrej Zary <linux@zary.sk>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fdomain: fix building pcmcia front-end
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190617111937.2355936-1-arnd@arndb.de>
Date:   Tue, 18 Jun 2019 23:13:01 -0400
In-Reply-To: <20190617111937.2355936-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 17 Jun 2019 13:19:17 +0200")
Message-ID: <yq1v9x2uv2a.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Move the common support outside of the SCSI_LOWLEVEL section.
> Alternatively, we could move all of SCSI_LOWLEVEL_PCMCIA into
> SCSI_LOWLEVEL. This would be more sensible, but might cause surprises
> for users that have SCSI_LOWLEVEL disabled.

It seems messy to me that PCMCIA lives outside of the LOWLEVEL section.

Given that the number of users that rely on PCMCIA for their system disk
is probably pretty low, I think I'm leaning towards cleaning things up
instead of introducing a nonsensical top level option.

Or even better: Get rid of SCSI_FDOMAIN as a user-visible option and
select it if either of the PCI/ISA/PCMCIA drivers are enabled.

-- 
Martin K. Petersen	Oracle Linux Engineering
