Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F026C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29E3217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TeJrtWHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDJCL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:11:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60320 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJCL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:11:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A29SIv098615;
        Wed, 10 Apr 2019 02:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=D6VFEX4tjvQDgusFjl96erUOBVkuqeHzQ+BBXr4q1qA=;
 b=TeJrtWHpVto5LAeLFWcKCSfya+EmjjmtsANBrFG+N6+3Bgvw9UMx3MJbz2ZpUndDaFqk
 kyHaCBJppQn7P60t6lj1X1vOLJSDWVEkMQ0D8jO5FFMwGb0HDO44oD56o2AoZuiVUZy8
 zvmL0yGL7FV6GJpx/wRk4Zuy7f1KDBinh/J33v86LfhbY58jJCE098JBLZt0u+LLq0To
 p40xFj4ymr2B5k1BFcVqnLHaaLKfx2ermpvGHvc+negWWVAytX4Z51iN4PKl4S+oe+/e
 z3ovtEePefskBSAdnaEGlM2f3TgDbwEE/4rBSiPcmdNjJ+XOXaRziVINbOpOIsp0a2To DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2rphmegh5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 02:11:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A29dOo097026;
        Wed, 10 Apr 2019 02:11:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rpytbxknq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 02:11:13 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3A2B9wA028552;
        Wed, 10 Apr 2019 02:11:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 19:11:09 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kento.A.Kobayashi@sony.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Oliver Neukum <oneukum@suse.com>, gregkh@linuxfoundation.org,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        Jacky.Cao@sony.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub port
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <Pine.LNX.4.44L0.1904091014570.1599-100000@iolanthe.rowland.org>
        <1554823007.161891.6.camel@acm.org>
Date:   Tue, 09 Apr 2019 22:11:06 -0400
In-Reply-To: <1554823007.161891.6.camel@acm.org> (Bart Van Assche's message of
        "Tue, 09 Apr 2019 08:16:47 -0700")
Message-ID: <yq1lg0imwxx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=563
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100015
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=583 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

> From which context does that unbind happen? From inside a SCSI EH
> callback or from the context of a workqueue? I think the former is not
> allowed but that the latter is allowed. The SRP initiator driver
> (ib_srp.c) follows the latter approach.

Yeah. It's better to punt the actual tear down.

-- 
Martin K. Petersen	Oracle Linux Engineering
