Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D49BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB0F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J3SpXvam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDDDYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:24:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45352 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:24:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343ONv3039740;
        Thu, 4 Apr 2019 03:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=eEf8G6QPqXwHU+Qn2u00XPjfTemL1SALrL30eyZgD90=;
 b=J3SpXvamhV2UPPhoDeZPA03cLRMEJ8UzPK5f7W2/Xs6Nw8GsDruzbBgOpM3ktHXBCGtK
 K06QLsH+tal/cZYQkbsKLGmeVkDGNa+1aePkZqjRxeRVV9zcJ0m2XU3vQ9QPSuG2ACZQ
 wLq42bA6L/Cl6o/HF6LooGzrLiA71+3RwotO9cK1dacBYO3iqOrXqwXXeeWfACqs50Jd
 9b/0lt9v9TgrDkTFw2zv9cE0KljSx4XDKwnrrhGeBDZ0/myNE4kEzwBSItmTqUtsPLg3
 sXa6qG22bFmUW9qgVnNngSDJPXwa3u9PzV/xY5L3GIdp+bxwdY7Q1UZP9jp9eXnRPwo7 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rhwydcpsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:24:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343NJcr101516;
        Thu, 4 Apr 2019 03:24:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2rm8f5pgwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:24:23 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x343OLxN012090;
        Thu, 4 Apr 2019 03:24:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 20:24:20 -0700
To:     Jan Kotas <jank@cadence.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2/2] scsi: ufs-cdns: Add support for UFSHCI with M31 PHY
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190327144405.5716-1-jank@cadence.com>
        <20190327144405.5716-3-jank@cadence.com>
Date:   Wed, 03 Apr 2019 23:24:17 -0400
In-Reply-To: <20190327144405.5716-3-jank@cadence.com> (Jan Kotas's message of
        "Wed, 27 Mar 2019 14:44:05 +0000")
Message-ID: <yq1mul6tpum.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040022
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=796 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jan,

> +	if (hba->vops && hba->vops->phy_initialization) {
> +		status = hba->vops->phy_initialization(hba);
> +		if (status)
> +			return status;
> +	}
> +
> +	return status;

I zapped the superfluous return conditional. Applied patches 1 and 2 to
5.2/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
