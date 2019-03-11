Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ED320643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WkWVjyEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfCKSvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:51:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44634 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:51:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BInWmn049311;
        Mon, 11 Mar 2019 18:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8esqf1a+k18dDMk1Ii6Fe2s/Ygpm0bd7FK0nWwvqGvs=;
 b=WkWVjyEbWAcRZs/Xv6C8VcAgVozySKJgnN4XagFRulPiQi7yDa6rPvSgcDEJHEn2ORCb
 fubTuzjayUACMKCQKQWSwib6iERjiNUFcEJ5VLqWBXT7/DkAR6QvZfdqdIJ0ITf4juew
 cYL98ATohgfj1KRmSan+r9Kcbu7Ah2431Y6Q/ZGKpJIqePo2YOG4mcJPGLrYOwgj53Ut
 lGV4+I/57qd8IXwVywtvUBmF0pQHoFFLdOx5ioRFFJp7tddE8qcCqC5oXXxWALrI0l/y
 zsTrXaOuxE4/KnvYkllvhgxplLpFeUrzQGuWz3budVR5gWqKWyscOUJeals0Hblp+Yy9 Sw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2r430egthq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 18:51:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2BIpN4r002181
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 18:51:23 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BIpMHj024904;
        Mon, 11 Mar 2019 18:51:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 11:51:22 -0700
To:     Tony Luck <tony.luck@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.0+ merge window
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1551940186.8289.60.camel@HansenPartnership.com>
        <CA+8MBb+MJhS9ejWQ0+vjDyhdnK5bsuaLPwpM5f-h1-6tHr4rVg@mail.gmail.com>
Date:   Mon, 11 Mar 2019 14:51:20 -0400
In-Reply-To: <CA+8MBb+MJhS9ejWQ0+vjDyhdnK5bsuaLPwpM5f-h1-6tHr4rVg@mail.gmail.com>
        (Tony Luck's message of "Mon, 11 Mar 2019 11:47:41 -0700")
Message-ID: <yq1ef7dqm6v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=761 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tony,

> arch/ia64/hp/sim/simscsi.c: In function 'simscsi_interrupt':
> arch/ia64/hp/sim/simscsi.c:108:51: error: 'struct scsi_cmnd' has no
> member named 'serial_number'

I asked Hannes to fix this but he's been quiet for a few days. I guess
I'll clean it up...

-- 
Martin K. Petersen	Oracle Linux Engineering
