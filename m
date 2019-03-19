Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B522173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eK7U2MBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCSSht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:37:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45766 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSSht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:37:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JISlkG063128;
        Tue, 19 Mar 2019 18:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cvcsuesv40EeW/nlGhgFXZq/Ge7gh0asgjnrOwR/CAc=;
 b=eK7U2MBysAY9l7S2YUNEig3SkGAUxzmRn7iyJTBO7EPjXLD0NMAFn25jGupHchV/vBYX
 ZAke5kRcZ/b9VqEwiKr8UycuFgzehbE2goag1cqu2/oMzsExA5oUE9+VBP60TjdC/Wkn
 AomthRbLTdnVxbnGJemMoA887i4d8KdGOAe62hy+7ZJwMzDs15hdTNjZ2C39YB+fddPa
 u7eHyVFZ8WO6R/8jI6aPdj09cefEtv4i7guRU/kpLMV0NhxZY80i+/rHw+tk05rXl1c+
 gYjb4mA1rp/wtqQIibBiDZtR3O90YyBdzXxZ+PYdMymJCJxiOtyd4fU+V/qidivX330E cQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r8rjupmb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:37:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2JIbcjt011450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:37:39 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2JIbc5a016302;
        Tue, 19 Mar 2019 18:37:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 11:37:37 -0700
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: fix a missing check of devm_reset_control_get
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <SN6PR04MB4925DB2652FAED5F3AED27CCFC4B0@SN6PR04MB4925.namprd04.prod.outlook.com>
        <20190315071156.21588-1-kjlu@umn.edu>
Date:   Tue, 19 Mar 2019 14:37:35 -0400
In-Reply-To: <20190315071156.21588-1-kjlu@umn.edu> (Kangjie Lu's message of
        "Fri, 15 Mar 2019 02:11:56 -0500")
Message-ID: <yq1y35ad828.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=937 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kangjie,

> devm_reset_control_get could fail, so the fix checks its return value
> and passes the error code upstream in case it fails.

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
