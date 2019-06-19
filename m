Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3932C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983802084B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SJLZ2/h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfFSDVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 23:21:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57452 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:21:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J3Jloc192264;
        Wed, 19 Jun 2019 03:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=dNGfXrVODZeLUeOs+59qJ6aLAWrKQNwrxAmhW8FAz68=;
 b=SJLZ2/h/Z6M0QPFbuJOwfaCNIKpp0RflobvfjPe9EMUHRlr0+bqwWLtEcYfGDry91ZNh
 7jrBY1hHvduUZQrHpB6FQeDW4RKyVFCvFxHUm0RyhefFlm51naWXReJYNj6qVPMOl9sN
 8OTR7ZVAaEa0dY9i5MLLDyITH4buQSQtOiMwr5cVQA0rhpHofHTfQ7NlfKOLJrO6VhcR
 cWA8sfkrFpjapqRnMxMScm4r/T3v7c+Hi2HiPGG77c1qdkmD7myueBY1otSOHpmSiv8f
 VlDhEwg6V/zM8HvBWQ6aSS6Myd4PHQg/bGMeuqlQedzJJI3G9QGk8qSH8GTWp+ZrMioq Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t78098shu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:21:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J3LLAW089444;
        Wed, 19 Jun 2019 03:21:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2t77yn34qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:21:26 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J3LPcm009737;
        Wed, 19 Jun 2019 03:21:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 20:21:25 -0700
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/2] scsi: devinfo: BLIST_TRY_VPD_PAGES for SanDisk Cruzer Blade
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
        <20190618013146.21961-2-marcos.souza.org@gmail.com>
Date:   Tue, 18 Jun 2019 23:21:22 -0400
In-Reply-To: <20190618013146.21961-2-marcos.souza.org@gmail.com> (Marcos Paulo
        de Souza's message of "Mon, 17 Jun 2019 22:31:45 -0300")
Message-ID: <yq1r27quuod.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marcos,

> Currently, all USB devices skip VPD pages, even when the device
> supports them (SPC-3 and later), but some of them support VPD, like
> Cruzer Blade.

What's your confidence level wrt. all Cruzer Blades handling this
correctly? How many devices have you tested this change with?

-- 
Martin K. Petersen	Oracle Linux Engineering
