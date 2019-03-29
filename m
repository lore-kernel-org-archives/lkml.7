Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76616C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47165206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e08Y5pL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfC2OFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:05:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfC2OFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:05:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TE3pXC186536;
        Fri, 29 Mar 2019 14:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=C6xZHf8lFi2uBI1WxZNU478lOA3CGjHP0MydF18ySoY=;
 b=e08Y5pL5oz8BykRoc2edTI2Rw/KxC95/YC8/mJQ+LxCZairLeiDw1fj6KdzuMUvRE88H
 OOW3u8oIKW14UD3RjNjv6UH1YyadYgl4U+0Z11AWCA1QoKW60/VsBVjsZnFwO9EhFGZ7
 KlqpWG0Uvc1G7IVf/WfOBoq5TQP1yO3V/qY/1Jt2fGiv/h2MQkfbx6DgLfwqF15hAqCz
 y457vKKqB7LVA6k+TdpBbdhqSu5kA101GPfKQ/GeKm+Li30zNJDFV+3ae0TGb+XJpOyt
 FFGfg/NwW0VpYs5YQuX8DE0vi5zyw3PvqC/T+8JxxTc/mbFe67npHCwL5BWuKuKYEoAK mQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2re6g1mjx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:04:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TE4xuS030354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:04:59 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TE4wbm003756;
        Fri, 29 Mar 2019 14:04:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:04:57 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedi: remove declaration of nvm_image from stack
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190327181103.15677-1-colin.king@canonical.com>
Date:   Fri, 29 Mar 2019 10:04:53 -0400
In-Reply-To: <20190327181103.15677-1-colin.king@canonical.com> (Colin King's
        message of "Wed, 27 Mar 2019 18:11:03 +0000")
Message-ID: <yq1d0m9srne.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=813 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The nvm_image is a large struct qedi_nvm_iscsi_image object of over
> 24K so don't declare it on the stack just for a sizeof requirement;
> use sizeof on struct qedi_nvm_iscsi_image instead.

Applied to 5.1/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
