Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D3C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EBA20863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oo6lKzKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfFSBpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:45:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34784 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSBpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:45:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J1ivKP034351;
        Wed, 19 Jun 2019 01:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Gxr1fEAA3yxSROFNVcdoxrsWna+LC6kS+5yOQwYybAg=;
 b=oo6lKzKHZMZr9qfuNeKOks+ED+tpywHah9e7LgkuMe5gXVt2vuQyfQCSpiFYGDuEf2qS
 KPEY7MMXSszKG+I9a/hK+vlnv+jFVjpMPvWdKS1U2aUPKUxG+jKAeuys/o0cK9NLtpQv
 b2zYPZ7ofZfmMilP5PjbE0BEFuFKnI8JquwaqZFye36pSX+i4wYuOPk3vU49GB/4jMK6
 Jh+gTfoCaQiJA55JOWJTAhvTjwVbRaJVWBoOugCcGpV5/WfzWfvBraNQkYnBtZaX+MIB
 joCDFR6ob76hLoO9dtXBH4DjPkGFVyQYf8UGsXOqKCpvc1AaY54UzCQs0XuK4vA6yfQR Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t78098k3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:45:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J1jaXj185735;
        Wed, 19 Jun 2019 01:45:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2t77ymt9wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 01:45:46 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J1jiEK024237;
        Wed, 19 Jun 2019 01:45:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 18:45:44 -0700
To:     Ondrej Zary <linux@zary.sk>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [resend] wd719x: Fix resets and aborts
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190617175012.25323-1-linux@zary.sk>
Date:   Tue, 18 Jun 2019 21:45:42 -0400
In-Reply-To: <20190617175012.25323-1-linux@zary.sk> (Ondrej Zary's message of
        "Mon, 17 Jun 2019 19:50:12 +0200")
Message-ID: <yq1v9x2wdo9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=940
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ondrej,

> Host reset oopses because it calls wd719x_chip_init, which calls
> request_firmware, under a spinlock. Stop the RISC first, then flush
> active SCBs under a spinlock. Finally call wd719x_chip_init unlocked.

Applied to 5.3/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
