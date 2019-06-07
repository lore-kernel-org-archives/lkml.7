Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B77C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BF8207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="166+1VM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfFGR1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:27:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35332 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfFGR1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:27:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57HIhbF170100;
        Fri, 7 Jun 2019 17:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=sJ8louzcxQ+/SPIhPvWd1tKDp21eQEHrE1jVzge2LQE=;
 b=166+1VM+mm6mrDqJiJxkRNV+jFY0kgNKrlXigCn0Z8P+u7eSFbncZzJqod4QrudvvsXL
 9j6QtE7aKpH6hEiC4CUsd/SQZP19AzOR3DV4ju1jqtxUuCNSoRY7J/wLQyo1uF3aDIbH
 t7ocbrgBVh5zvhspPvEjnB+XmHtw5hKAWtWo12WtHbr8ROY9oiyy8kSaydBZhK96OnHl
 wVG7PTO7cMWNB1CAjwFkJJ1P04LyDOpDQSLvVvGvNHchZoN4LKkK3m+SIausTO8KfnvL
 QLCA0NH/NqlR46tdOSTPjum/NtAJakET+crL5dHttVFrPFIUd23xuhfD8L5E3PP94NIE Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugstymb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 17:27:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57HQifN055246;
        Fri, 7 Jun 2019 17:27:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2swnhdcn1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 17:27:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x57HR29p020389;
        Fri, 7 Jun 2019 17:27:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 10:27:02 -0700
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] drivers/ata: remove flood "Enabling discard_zeroes_data"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <155989286981.1471.16344793966539115439.stgit@buzz>
Date:   Fri, 07 Jun 2019 13:26:54 -0400
In-Reply-To: <155989286981.1471.16344793966539115439.stgit@buzz> (Konstantin
        Khlebnikov's message of "Fri, 07 Jun 2019 10:34:29 +0300")
Message-ID: <yq1sgsli9wh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=756
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=806 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Konstantin,

> Printing this at each SCSI READ_CAPACITY command is too verbose.
>
> Flag "discard_zeroes_data" is deprecated since commit 48920ff2a5a9
> ("block: remove the discard_zeroes_data flag").

> -			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
> -				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
> +			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
>  				rbuf[14] |= 0x40; /* LBPRZ */

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
