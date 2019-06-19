Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD81C31E51
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0A2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 03:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M5ChfN6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfFSDfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 23:35:37 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37942 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSDfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 23:35:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J3XpgE005263;
        Wed, 19 Jun 2019 03:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=rzGxGRnDdtvtDqaMMzM73Ib40cXmOjf/MJkXIMZSzXI=;
 b=M5ChfN6sozfcdnH1dSrRq5c1qNPJGMonjkkm3dR/8vp5BhaFg6K9MFYnYuCfyKlbpLfd
 Wyc3HxWYy/pdjcuCCQ2ICl7UMCCM8yJvjfkKpDO5SB//vD5gnC9jylaDkhleWmLlkhSZ
 HYJVj2gjJgKRq592GzEkNU/HRUCe5jZD4yRf9l6UtWyOKD0x2yrqWzLDUQGcvnMA02En
 55KIT9/Urku189vhHV8GBbebINFs5jnKD5XwrnEC92XvXpuodHyNHINUsJqgpwQW76JX
 IKrBEHER1LzAMqVgJeCSF++tUw4OIi4gNhYox6q4Ohn8P4kWNkH6C+gyY6xhbBSfv1by xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t78098tea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:35:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J3ZKfh113445;
        Wed, 19 Jun 2019 03:35:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t77yn38mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 03:35:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J3ZShZ023785;
        Wed, 19 Jun 2019 03:35:29 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 20:35:28 -0700
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] scsi: scsi_sysfs.c: Hide wwid sdev attr if VPD is not supported
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190612020828.8140-1-marcos.souza.org@gmail.com>
Date:   Tue, 18 Jun 2019 23:35:16 -0400
In-Reply-To: <20190612020828.8140-1-marcos.souza.org@gmail.com> (Marcos Paulo
        de Souza's message of "Tue, 11 Jun 2019 23:08:28 -0300")
Message-ID: <yq1muieuu17.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=767
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=819 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marcos,

> WWID composed from VPD data from device, specifically page 0x83. So,
> when a device does not have VPD support, for example USB storage
> devices where VPD is specifically disabled, a read into <blk
> device>/device/wwid file will always return ENXIO. To avoid this,
> change the scsi_sdev_attr_is_visible function to hide wwid sysfs file
> when the devices does not support VPD.

Not a big fan of attribute files that come and go.

Why not just return an empty string? Hannes?

-- 
Martin K. Petersen	Oracle Linux Engineering
