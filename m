Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2D9C76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A35217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 12:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u54k7FbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfGTMtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 08:49:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51884 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfGTMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 08:49:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6KCmjZ3087998;
        Sat, 20 Jul 2019 12:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HI68ck3X7iby1bN4RjNrOyRxX4aQnakb6mwXYHvzpfw=;
 b=u54k7FbMdMB+BtexyAha7euXfhYABoR1qlA4PO9wZJRWQ7nBkB6MrWTx75KbLBWjs2Ej
 z03DSIaL6sS0rwhXypcFSUIpavjMqEQ/Ko45227dJy4fzQoB2iyhA/LG9ACgpDbt65Qd
 jqpQMyq+j2jpd71r4ePsI4p7vqyu8J0GTr9lY9/MHks8SsgWImhqmtqZ93JQZlYxVmLT
 DSbRrnwLxNA0kgCLqDrSHfejRVDhRZGbQ3W+PC+4K4AAvUf5SGtFALlC2QR1i5/ptG0V
 FjYvhdh//xz2IfiPLICOtSSKcKqOvIgVx23t1yT3ZcnrjRljM1XBW+tgfv8CciGx04NB +Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tutct0wsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jul 2019 12:48:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6KCh2OO084752;
        Sat, 20 Jul 2019 12:46:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2tus0aw6ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Jul 2019 12:46:49 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6KCkeCC001829;
        Sat, 20 Jul 2019 12:46:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 20 Jul 2019 12:46:40 +0000
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.2+ merge window
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1563579201.1602.7.camel@HansenPartnership.com>
        <CACVXFVNOPhiUhrgw07sna0dt5Jy2zckbNXDWPPRAGadXQAS_mQ@mail.gmail.com>
Date:   Sat, 20 Jul 2019 08:46:38 -0400
In-Reply-To: <CACVXFVNOPhiUhrgw07sna0dt5Jy2zckbNXDWPPRAGadXQAS_mQ@mail.gmail.com>
        (Ming Lei's message of "Sat, 20 Jul 2019 10:29:40 +0800")
Message-ID: <yq14l3gx49d.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9323 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=996
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907200165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9323 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907200166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ming!

>> Christoph Hellwig (8):
>>       scsi: megaraid_sas: set an unlimited max_segment_size
>>       scsi: mpt3sas: set an unlimited max_segment_size for SAS 3.0 HBAs
>>       scsi: IB/srp: set virt_boundary_mask in the scsi host
>>       scsi: IB/iser: set virt_boundary_mask in the scsi host
>>       scsi: storvsc: set virt_boundary_mask in the scsi host template
>>       scsi: ufshcd: set max_segment_size in the scsi host template
>>       scsi: core: take the DMA max mapping size into account
>
> It has been observed on NVMe the above approach("take the DMA max
> mapping size into account") causes performance regression, so I'd
> suggest to fix dma_max_mapping_size() first.

Christoph specifically asked me to queue these up. I presume the swiotlb
tweak is going through his DMA tree and it is therefore orthogonal to
the SCSI changes.

I do think it's important that we get these fixed up in 5.3. And given
that we're on the eve of the merge window, the time to get these changes
merged is now. I'd hate to see them miss another release...

-- 
Martin K. Petersen	Oracle Linux Engineering
