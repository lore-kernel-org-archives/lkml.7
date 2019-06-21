Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62704C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375012084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 00:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUdvtFPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFUAhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 20:37:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50422 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfFUAhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 20:37:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L0ZhaB017940;
        Fri, 21 Jun 2019 00:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=/7QDdP9/WJOg0gSuyjMLRQTxk0IMpbuTco7zCSYWUl0=;
 b=mUdvtFPGZYyJz9ZH6pK+IPtHf5kTpZaljmEa62c/hoM+P5HypXjJtAlIiqQqApfKN3sy
 6+SMbR7deZR87cqa0ZOs/tf0FimOY1z9riOS4rwFHkuj0ZD0j0VRL8JN6TjslcUscLAR
 87oWd88sUw77PCMDEO8AqL861igMQQ73Tzgevp1dFQ8wgifsM2/GidQwMclqH5TWJnlK
 u1cZ9dYQlHC9xSaNlKSFxP9ukAI6NRScFtwcRoldSp5iORqw9RYwE0MACpBQLIoDSpTB
 jVgBURGpwMuNpvYRqNCKkPJbk0uRZ3RTQ6V7OGkKfOO6tJMEoCSVcsJOW2yENyTG25hf +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t7809ksc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 00:36:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L0Xf9S007583;
        Fri, 21 Jun 2019 00:34:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t77ynx82k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 00:34:49 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5L0Ye0c024603;
        Fri, 21 Jun 2019 00:34:42 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 17:34:40 -0700
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: linux-next: manual merge of the scsi tree with Linus' tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190522100808.66994f6b@canb.auug.org.au>
        <20190528114320.30637398@canb.auug.org.au>
        <20190621095907.4a6a50fa@canb.auug.org.au>
        <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
Date:   Thu, 20 Jun 2019 20:34:37 -0400
In-Reply-To: <CAHk-=whVBjssws88tSeoVLG5o5ZWXQu=S7rv-0Hd3qt9=VYsTQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 20 Jun 2019 17:07:20 -0700")
Message-ID: <yq1wohfpyhu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

> That said, I would tend to trust the due diligence that Thomas, Greg &
> co have done, and am wondering why the scsi tree ends up having
> different SPDX results in the first place..

I left Christoph's patches in my 5.3 queue after Stephen let me know
about the treewide series because, well, it came from people with SCSI
affiliation and it got reviewed.

In any case I assumed the delta was formatting or purely cosmetic. I
don't recall there being any ambiguity about choice of license or SPDX
tag when I reviewed the patches.

I have been meaning to take a closer look but have had a critical fire
eating up a bunch of my time the last couple of weeks. I'll get to it...

-- 
Martin K. Petersen	Oracle Linux Engineering
