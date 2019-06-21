Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F5DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A212084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dfS4HZzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfFUBOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:14:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45764 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:14:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L1DeA8042178;
        Fri, 21 Jun 2019 01:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6IlbzkV3Z0HNy70iucmx+Oaex/RmrCR3lowOfenjYsI=;
 b=dfS4HZzZZq8KHEakbGTQFoXeMoo7bl8KAPqFDOSRdzf3WCRz8Tzm7DGjj61Ou3BD+4jW
 kePMfetzto8EL5mLnJYv8vuJFWhKQpsZuJOhG+mKcp4SOot+PW8vJMLx544EYAdFZ9ZD
 K77EL0rig5qVzEJ7KYUVNxsfUvteYfN1IuFxwdxG+Fy0yYsOOuo6eI2v5sMyp1jfZiHc
 HjJdnj28u7QVyLGLeqhDL20LYaQI5pdJGJzTbg50FjkiaryTikwdrBZbwTMGUJ5rAvxm
 JcPo0Hxw2E/K0Jy9xTAVwPlG0l7jCvLmqCpWBa8QgM+FsNnbLM7BWhclwkWZGZPCrhZh WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t7809kubk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 01:14:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5L1DTSE167400;
        Fri, 21 Jun 2019 01:14:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77ynxt6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 01:14:21 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5L1EACp015929;
        Fri, 21 Jun 2019 01:14:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 01:14:09 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
        <1561077341.7970.47.camel@HansenPartnership.com>
Date:   Thu, 20 Jun 2019 21:14:07 -0400
In-Reply-To: <1561077341.7970.47.camel@HansenPartnership.com> (James
        Bottomley's message of "Thu, 20 Jun 2019 17:35:41 -0700")
Message-ID: <yq1fto3pwo0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James,

> There's two problems.  One is simple terminology: the
> Documentation/process/licence-rules.rst say:
>
> GPL-2.0 means GPL 2 only
> GPL-2.0+ means GPL 2 or later
>
> I believe RMS made a fuss about this and he finally agreed to 
>
> GPL-2.0-only
> GPL-2.0-or-later

Looks like there are tons of the old style SPDX tags in the kernel. Is
there going to be a treewide conversion to the new tag format?

Just wondering how much to clean up given that the files Christoph
touched only constitute a subset of the old style tags found under
drivers/scsi.

-- 
Martin K. Petersen	Oracle Linux Engineering
