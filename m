Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8184CC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9B92084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ii2RKoyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfFTUcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:32:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFTUcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:32:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKO7b8045039;
        Thu, 20 Jun 2019 20:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=4OeBcn9e/hhlLrtRhAZE+XYp/xCDVF5HETiYD7GCSAs=;
 b=Ii2RKoyRtMzRinltQK6lHLX/GC8xNTWfy4WqWZ/VoP77kAOCASzKnOqdIR0bx4vE96In
 Gg8V47smVYAZxV+QTE30ijVB9U8H4lRTUVdx7KGixfgkS6bX5tdni6svXzPsF5IPOav9
 /TFNcY24kClP8W8Q+KIc/ZxU+E8kKACkTf+5pVVibR0o8xQu/xYuuPGKjZeoR2tlhPgr
 DCvlvMPuOrqf2rovSjW07D/ZYbnYIaKvBJqtwAkHj4lDoo9Br/d4RdjfGiFt5kUA2C+6
 o5mfzZSvd9pquagjzzefelJQ26+jZcOWCK/5C7zxTiCzCFTs0zKUBIbdGdn2+atYekOU 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t7809k57p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:32:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KKVHpt127956;
        Thu, 20 Jun 2019 20:32:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t7rdxc79m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 20:32:41 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5KKWe6U028624;
        Thu, 20 Jun 2019 20:32:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 13:32:40 -0700
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk Cruzer Blade
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
        <20190618013146.21961-2-marcos.souza.org@gmail.com>
        <yq1r27quuod.fsf@oracle.com> <20190619094540.GA26980@continental>
        <20190619120346.GC26980@continental>
Date:   Thu, 20 Jun 2019 16:32:38 -0400
In-Reply-To: <20190619120346.GC26980@continental> (Marcos Paulo de Souza's
        message of "Wed, 19 Jun 2019 09:03:52 -0300")
Message-ID: <yq14l4kro9l.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marcos,

> My first idea was to add a vendor:product mapping at SCSI layer, but
> so far I haven't found one, so I added the model/vendor found by
> INQUIRY. Would it be better to check for prod:vendor (as values,
> instead of the description)?

Your patch is functionally fine. I'm just trying to establish how risky
it is for me to pick it up.

-- 
Martin K. Petersen	Oracle Linux Engineering
