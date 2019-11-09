Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABE2C17440
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BA221019
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 02:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HUt92Hqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfKICMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 21:12:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39016 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfKICMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:12:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA929KOP176049;
        Sat, 9 Nov 2019 02:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=L1LC8EBp/F6brXaxrx2kW3YWQ/z7Tgejaop6gaGSYe4=;
 b=HUt92HqgFd7aS3/HbK96fAFqc+6jQChTTMK1PqSyUiQIxqqpyzQ2xxr66zQi2KYEESvl
 OviKteOeaKosTa7/0B0wRTqG6HbGNSK/TJvbnByZcbQUZJ++XM2952m6pgtp+dNnR/xB
 QcV0P0kTm/bgP7Kfhxbl5YJWn46zLZjsI8UmjcyoX3bDvvbCrpfr6fE99XvE6TlZwZHM
 jBEWleZjWN9ACP+mvHkcEfSnytHRged6ub1DsgWKWXIdJLxtypqGoo1mPLuzM++Jhvi6
 gAhuXbHtMqOH3f2TkR4V7AQQ9IuB47POIgWDvFlubcmSwOL3C9XctnfLyoXLKs6P/0u3 PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w5hgwrbbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Nov 2019 02:12:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA927c6O003160;
        Sat, 9 Nov 2019 02:12:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w5hgxbgsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Nov 2019 02:12:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA92CTVA008645;
        Sat, 9 Nov 2019 02:12:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 18:12:29 -0800
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        kernel test robot <lkp@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@lists.01.org
Subject: Re: [scsi] 9393c8de62: Initramfs_unpacking_failed
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191108072255.GX29418@shao2-debian>
        <alpine.LNX.2.21.1.1911091123280.9@nippy.intranet>
        <6ad8eeef-101e-58ba-734d-1725c998a909@gmail.com>
Date:   Fri, 08 Nov 2019 21:12:27 -0500
In-Reply-To: <6ad8eeef-101e-58ba-734d-1725c998a909@gmail.com> (Michael
        Schmitz's message of "Sat, 9 Nov 2019 14:56:46 +1300")
Message-ID: <yq1v9rtvlv8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=874
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911090019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=955 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911090019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael,

>>> [    1.278970] Trying to unpack rootfs image as initramfs...
>>> [    4.011404] Initramfs unpacking failed: broken padding
>>
>> Was this test failure unrelated to commit 9393c8de62?
>
> Seems to be unrelated - a m68k kernel with that commit included, SCSI
> core included but low-level driver built as a module(*)  boots into
> the initramfs just fine.
>
> (*) well-known emulator bug.

I'm scratching my head too. I have tested a variety of systems and all
of them boot and work fine.

-- 
Martin K. Petersen	Oracle Linux Engineering
