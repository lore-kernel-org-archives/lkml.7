Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F99C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFEC2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PZ7A+XLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfFGRAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:00:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36310 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbfFGRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:00:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57GwwjZ153112;
        Fri, 7 Jun 2019 17:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=qJWNPqVnOuZdNUVs/8DblqBQeJjxerPcG8WYUK6blAg=;
 b=PZ7A+XLIaQ0oHDMUwYf9cYEejGBEg5xhO87mHVCWlC0HNRwi0vBgOFBUUYirNalwlLBh
 LlKYvgBxuRCxABAtZk+QqyJYrUPhSweiWaEB+sa5l/bE9A9PFGLeAB4Me7TJ7zDcvIGw
 8l9xXAAsDRSr7q7aJNx0cguMh4O5dxhYFfCy8f1qB1UQd4T2RyCrYbrIBnnXsr1SK0Ya
 sLcTSl+UTojUPEm8zsk2mlloWASyYoBFcjoE+Hlk5XLF37rNHZkLNfz+lp0l9TWgatRC
 2YjMBqJEsidL+FfGOgIiTyRqYQ/k+t2LjYgh3yZtNZlxGlNmaXroXQM31dJptzJt6x57 kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sugstyfn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 17:00:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57GvckQ021941;
        Fri, 7 Jun 2019 16:58:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2swngn6abk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 16:58:34 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57GwXiM032176;
        Fri, 7 Jun 2019 16:58:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 09:58:32 -0700
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <155989287898.1506.14253954112551051148.stgit@buzz>
Date:   Fri, 07 Jun 2019 12:58:30 -0400
In-Reply-To: <155989287898.1506.14253954112551051148.stgit@buzz> (Konstantin
        Khlebnikov's message of "Fri, 07 Jun 2019 10:34:39 +0300")
Message-ID: <yq1wohxib7t.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9281 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=727 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Konstantin,

> +			if (dev->horkage & ATA_HORKAGE_NOTRIM)
> +				trim_status = "backlisted";

blacklisted

> +			else
> +				trim_status = "supported";
> +
> +			if (!ata_fpdma_dsm_supported(dev))
> +				trim_queued = "no";
> +			else if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
> +				trim_queued = "backlisted";

ditto

> +			else
> +				trim_queued = "yes";

Why is trim_status "supported" and trim_queued/trim_zero "yes"?

> +
> +			if (!ata_id_has_zero_after_trim(id))
> +				trim_zero = "no";
> +			else if (dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
> +				trim_zero = "yes";
> +			else
> +				trim_zero = "maybe";
> +
> +			ata_dev_info(dev, "trim: %s, queued: %s, zero_after_trim: %s\n",
> +				     trim_status, trim_queued, trim_zero);
> +		}
> +

Otherwise no particular objections. We were trying to limit noise during
boot which is why this information originally went to sysfs instead of
being printed during probe.

-- 
Martin K. Petersen	Oracle Linux Engineering
