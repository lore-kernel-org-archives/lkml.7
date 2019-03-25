Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24128C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8C321019
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 00:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4fdvpi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfCYAEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 20:04:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54150 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfCYAEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 20:04:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P00HQu172121;
        Mon, 25 Mar 2019 00:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=GUQvlqCGpF5sXUlzuiYiGp5toTKCdFx1X6C+8+hPJFI=;
 b=W4fdvpi17Fdq7jIAIOaI9sZl94qBswGRb6chylypgIFE8MSitTFjJiDFoY7BHrkYapdo
 wb0jq2dZ3B86V89lwudfDHTZ3LcluauYaVZQ02nCB/i/gZzBk/vb7IsmcYyVE0P6WljY
 UOrRxQLLP5tXQ3yoq6KXSeL9UcfyPKL5rY4ofG0FjJsGknt81Pj7PTOjQsNG+s5FNuzB
 BDw3/Ic/0Ci6TBOcIP+qqHK4ottQaPxaOkglxaNMSSe2IZOW/eMk0U51DTmF2dmuqmKM
 L0F2Sj/bYH7vjl2VMByBMzA8zYG4/O/YjVlqjZYxTQsjk3AbA1Qjqb633Uh19BPJJdcK lw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2re6g0h3yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 00:04:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P04AZn014836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 00:04:10 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P04ACQ001000;
        Mon, 25 Mar 2019 00:04:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 17:04:09 -0700
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Hussam Al-Tayeb <ht990332@gmx.com>, linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Debug scsi message in linux 4.19.31
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <624bbdbb24ad7db69be29956cbf14689fd003cdb.camel@gmx.com>
        <25d0ddcb-b603-6e0d-d512-b188813837bf@infradead.org>
Date:   Sun, 24 Mar 2019 20:04:07 -0400
In-Reply-To: <25d0ddcb-b603-6e0d-d512-b188813837bf@infradead.org> (Randy
        Dunlap's message of "Sun, 24 Mar 2019 09:18:58 -0700")
Message-ID: <yq15zs73jm0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=878 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903240184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

>> Mar 23 17:40:10 hades kernel: sd 0:0:0:0: [sda] Optimal transfer size 0
>> bytes < PAGE_SIZE (4096 bytes)

We're just trying to weed out the devices that report garbage in this
field. But of course none of the devices I tested with put 0 in there.

>> Does it really belong in an LTS kernel?

The patch does fix problems for devices that report a nonsensical
value. But it is a regression that it now prints a warning for devices
that don't report an optimal I/O size at all.

Sorry about that. Will fix tomorrow!

-- 
Martin K. Petersen	Oracle Linux Engineering
