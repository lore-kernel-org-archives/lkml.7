Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CEEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6958721721
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 16:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2HS/eCCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392528AbfETQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 12:06:04 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44318 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbfETQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 12:06:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KG3ocl004844;
        Mon, 20 May 2019 16:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=WDlTfhKqJMZ2zyqiSTpLnbD7JXsJmqETioOP6yU6rfE=;
 b=2HS/eCCLMyxPInXGNYoD/VCOiXGqrZv0qxAcTXwAUMveelOAv3MndRVb61EwOefBqxdF
 Xrqzut2R4ufoUbuKCC8m3P079QIEYh3AqpejF8y20DzarQZYFVkvlxA1bBrOoiuarNcl
 F96d8GSBtdQV6p+Q55SHDzVNW3/E+JnmdNKUKbnoiRJQBZhC8moFUpLRURTft/dw761J
 X47t2e+c34ZAmJpGOWUb3ZdIlZvF9KJX/YRFcFNwrklc8U89bDYkYycW7CVePd7oUHeW
 UML/I5Wng+0kSZf0/LFJRaQy3LNqsIUfxAjNxvuyrRRdKwJkpXg2b983Lh7hSJqxFwRL 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2sj7jdg6sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 16:05:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4KG5SFT107894;
        Mon, 20 May 2019 16:05:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2sks1xpasf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 16:05:42 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4KG5eDj022282;
        Mon, 20 May 2019 16:05:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 16:05:40 +0000
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Waiman Long <longman@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in ses_enclosure_data_process()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190501180535.26718-1-longman@redhat.com>
        <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
        <1558363938.3742.1.camel@linux.ibm.com>
        <3385cf54-7b6c-3f28-e037-f0d4037368eb@redhat.com>
        <1558367212.3742.10.camel@linux.ibm.com>
Date:   Mon, 20 May 2019 12:05:38 -0400
In-Reply-To: <1558367212.3742.10.camel@linux.ibm.com> (James Bottomley's
        message of "Mon, 20 May 2019 08:46:52 -0700")
Message-ID: <yq1zhnh8625.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James,

> Please.  What I'm interested in is whether this is simply a bug in the
> array firmware, in which case the fix is sufficient, or whether
> there's some problem with the parser, like mismatched expectations
> over added trailing nulls or something.

Our support folks have been looking at this for a while. We have seen
problems with devices from several vendors. To the extent that I gave up
the idea of blacklisting all of them.

I am collecting "bad" SES pages from these devices. I have added support
for RECEIVE DIAGNOSTICS to scsi_debug and added a bunch of deliberately
broken SES pages so we could debug this.

It appears to be very common for devices to return inconsistent or
invalid data. So pretty much all of the ses.c parsing needs to have
sanity checking heuristics added to prevent KASAN hiccups.

-- 
Martin K. Petersen	Oracle Linux Engineering
