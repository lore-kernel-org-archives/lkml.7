Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48632C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2D1206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lYHeCI8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfCFRkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:40:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46740 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfCFRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:40:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x26HXgnD196522;
        Wed, 6 Mar 2019 17:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=fr7D4Rs1y0bsowizgCo34pLfBPffKHe7r20bIqHzoZQ=;
 b=lYHeCI8PMTwf+4GdtBRKB/bJgSwXWFr3R6DK07wdsGQnfhfIzr1YKoJc7XQCJcnGfv/k
 klXIpAoXS5xvZMxJcB4HMgDNYzhKDoedzhW6WLfYxVbvxaTqKrDBjFq9ggZc5lgN9Lkz
 FloXiRLQVD+4LUsCjDOLUxp+mAHQd7DtpGlLoobLp5x8a4VuaE37/Q+Z5utKiXdNnKNH
 tgDmRRqXZYbRoABRID9Wg8mMsOdygdWoDDzRLdnFmpwJr9+X2QwtjYauEwFbxtnSmXTR
 irZSoH1qCIdfxXUTLu67IuqJmRVvvEZ9Og67sVc+StngzLBd3vQhuI5ITl3petD0hACQ AA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qyjfrn52p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 17:39:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x26HdjNO024254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 17:39:45 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x26HdhEe004381;
        Wed, 6 Mar 2019 17:39:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 09:39:43 -0800
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] scsi: NCR5380: Mark expected switch fall-through
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190228202759.GA5883@embeddedor>
        <alpine.LNX.2.21.1903011143550.8@nippy.intranet>
Date:   Wed, 06 Mar 2019 12:39:40 -0500
In-Reply-To: <alpine.LNX.2.21.1903011143550.8@nippy.intranet> (Finn Thain's
        message of "Fri, 1 Mar 2019 12:16:57 +1100 (AEDT)")
Message-ID: <yq1imwvzyub.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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


Hi Finn,

Please submit this as a formal patch. Thanks!

> Here's an alternative patch, which has the virtue that a simple heuristic 
> will work. This patch does not require that other static analysis tools 
> will follow gcc's weird rules about hyphens. (I assume they don't but I 
> didn't check.)
>
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index 7fed9bb72784..fe0535affc14 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -1932,13 +1932,13 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>  					if (!hostdata->connected)
>  						return;
>  
> -					/* Fall through to reject message */
> -
> +					/* Reject message */
> +					/* Fall through */
> +				default:
>  					/*
>  					 * If we get something weird that we aren't expecting,
> -					 * reject it.
> +					 * log it.
>  					 */
> -				default:
>  					if (tmp == EXTENDED_MESSAGE)
>  						scmd_printk(KERN_INFO, cmd,
>  						            "rejecting unknown extended message code %02x, length %d\n",

-- 
Martin K. Petersen	Oracle Linux Engineering
