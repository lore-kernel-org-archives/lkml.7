Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CDF20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w082iDgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfCFRyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:54:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44588 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfCFRyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:54:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x26Hnnub014040;
        Wed, 6 Mar 2019 17:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TaCxroCyrJIC4Fcwz0VuHQonGnNxRSzwOIlZkYeytO0=;
 b=w082iDgZBzr/HTZoVzMp0JuFk6lulUul6DNqUlsUXRSE9MhNoXL6EMaLa4uVQ2qIcbeK
 puofwYo3u2zoTnMFRCFM1AhsuX571aRgk8IrFpd8F6UrNE5sS0x/SXDzYUB3JXpB7v2y
 fx6TaaX6TiT2XpbCxnvcn+A5QjPaRm9PlZ85NOGOPtngdBgq8QB6bV73XAngMg4ji7v/
 3VVoDpgFTHejBIij+A8p1rfyFR+k/ckVdw+UkDobbr7YyrElpoNCtsgyOXNPVdzP401Z
 C10IsRpotyqHPdkSwPsk1aguo+r18IEBfmq+oVWhaZaFl/14sTkLxC6O8xxjiCmKEjKj Iw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qyfbedk36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 17:54:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x26Hs4GU003589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 17:54:04 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x26Hs24i032723;
        Wed, 6 Mar 2019 17:54:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 09:54:02 -0800
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <qtran@marvell.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] scsi: qla2xxx: avoid printf format warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190304193917.702601-1-arnd@arndb.de>
        <20190304193917.702601-3-arnd@arndb.de>
Date:   Wed, 06 Mar 2019 12:54:00 -0500
In-Reply-To: <20190304193917.702601-3-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 4 Mar 2019 20:39:10 +0100")
Message-ID: <yq1k1hbyjlz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9187 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=936 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Depending on the target architecture and configuration, both
> phys_addr_t and dma_addr_t may be smaller than 'long long', so we get
> a warning when printing either of them using the %llx format string:

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
