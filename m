Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFADFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711742075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p6dZ8GyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfD2Vfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:35:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfD2Vfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:35:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TLSWTe103152;
        Mon, 29 Apr 2019 21:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=CdXMKscwEm9icP54reJCtnpZ0in48lITPMzsR5TBUG4=;
 b=p6dZ8GyTmoANREJ5ShorWN73+ENofoykFswmAKVeMZFl71kxF/sRbLeJCmeozc+JnTER
 Ab3nLlqoz/YBL1O0Ol3qUYDGubiySKx2wQM+OnU4QrmOKRtO7psseYN6I2bqMggkhhNE
 UwxOTbCUE0FpoE7VFlY9EOo6g90B6vIvlenOPr3RF5IjocX+ZvyrkmdNN5DvJ47tkjQk
 vNGc4+/5QKyVuqsyERC7ZLDoTnGDKYKby2OcY7HwfwWrEReLrRmJA2R6vwjnDe30UKdb
 v3HJscrV6+Nuf3VipEyXNdKMDluZNv5whvGJzhs/pHkXhIx51fisiv4FTMKBPD83UnB3 kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2s4fqq102e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 21:35:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TLZ4NZ085482;
        Mon, 29 Apr 2019 21:35:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s5u50mpk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 21:35:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3TLZUWW023877;
        Mon, 29 Apr 2019 21:35:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 14:35:30 -0700
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>,
        "David A . Hinds" <dahinds@users.sourceforge.net>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] fdomain: Resurrect driver (modular version)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190428200626.28092-1-linux@zary.sk>
Date:   Mon, 29 Apr 2019 17:35:28 -0400
In-Reply-To: <20190428200626.28092-1-linux@zary.sk> (Ondrej Zary's message of
        "Sun, 28 Apr 2019 22:06:22 +0200")
Message-ID: <yq1imuwxzof.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=666
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290139
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=697 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ondrej,

> Resurrect previously removed fdomain driver, in modern style.
> Initialization is rewritten completely, with support for multiple
> cards, no more global state variables.  Most of the code from
> interrupt handler is moved to a workqueue.
>
> This is a modularized version with core separated from bus-specific
> drivers (PCI, ISA and PCMCIA). Only PCI driver is tested for now.

I applied patches #1(v2) and #2 to 5.2/scsi-queue with a few tweaks.

Thanks for your work on this!

-- 
Martin K. Petersen	Oracle Linux Engineering
