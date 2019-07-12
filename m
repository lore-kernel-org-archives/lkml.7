Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E986C742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEBB216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 00:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y7XUMYLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfGLAld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:41:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55748 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGLAlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 20:41:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0dS3h084881;
        Fri, 12 Jul 2019 00:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=LfV3Hvs8VARF1vppClK6Jd7h/IG9t72oJK4StV6hROc=;
 b=y7XUMYLTEisPNSd2ckHdEz0uEEp9SMnJyOjqYis6Z9JWZeaVMCcaQS2v23FOUpvuf6xz
 lX779bJPW9GilS0w/RpRwxT5O+y27cESBd0IZauucXlX5/SqheaKbtmgj/dyyWEpcar6
 wrom1XT56+e0ova71qSQbOl8YndhJNYvB5I37j7Xe2DJoaCApfeen9T5c9DIAWluMsAS
 uzFzRLQtbU5aBkSsXrVMUMWLaK71NP8QXTVupvFyka9RTsPPsxOiFAmt4Pdj/yOjlPeI
 uv0J/dTt5zdRi0QYNsTsCKYLeGwScpyKgQrO3weKbPm+SyywgIzF0SCoAZZNRjp6nWzL fQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tjk2u2xc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:41:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0cAvp089146;
        Fri, 12 Jul 2019 00:41:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tnc8tuefk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:41:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0fSGO005654;
        Fri, 12 Jul 2019 00:41:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:41:27 -0700
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk Cruzer Blade
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
        <20190618013146.21961-2-marcos.souza.org@gmail.com>
Date:   Thu, 11 Jul 2019 20:41:25 -0400
In-Reply-To: <20190618013146.21961-2-marcos.souza.org@gmail.com> (Marcos Paulo
        de Souza's message of "Mon, 17 Jun 2019 22:31:45 -0300")
Message-ID: <yq136jc84p6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=994
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marcos,

> Currently, all USB devices skip VPD pages, even when the device
> supports them (SPC-3 and later), but some of them support VPD, like
> Cruzer Blade.

We'll try it and see what happens. As I mentioned, SanDisk have
traditionally been pretty good wrt. spec compliance.

-- 
Martin K. Petersen	Oracle Linux Engineering
