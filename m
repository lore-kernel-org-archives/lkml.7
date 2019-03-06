Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p0sWcnyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfCFRpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:45:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53628 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCFRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:45:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x26HifvD012750;
        Wed, 6 Mar 2019 17:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=117+7s5aHfHE9VZJXTSzI6HVThmQW4xkPhoUgxH1L1M=;
 b=p0sWcnyCZUtXdrK0+JVamEI691KJMxsmNZPy3VRZDXXGeprvPebBMTYzMiKUxQY30Xzi
 Hlplmje/+VbSC4z/cTJ5+vZu8TaeCU8nnKiKpZWDfKLHzHC29jMnljNgI98leBdIjC6T
 j32fdrpUPdM7XWmc1nZhXqDtwnmAIojBuVC9eFdp7nohw8o+yVK/YF63AhI6eF3O5KQX
 W9RMnvA3wNX56Gw4D0YV9r4LTWbhbISSfYRgm6vf069uxU4wojPqvfx8aKtGm5iWv3PC
 QqG42GjnKzIiwVXU63vY1EUTPJhDzfDTIAAU5Fh3E35XvafdXH4+32UQxyEUQh6EjfZV zA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qyh8udab8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 17:45:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x26HjdAh005994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 17:45:39 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x26HjbWD007596;
        Wed, 6 Mar 2019 17:45:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 09:45:34 -0800
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Wei Li <liwei213@huawei.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] scsi: ufs: hisi: fix ufs_hba_variant_ops passing
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190304193917.702601-1-arnd@arndb.de>
        <20190304193917.702601-4-arnd@arndb.de>
Date:   Wed, 06 Mar 2019 12:45:31 -0500
In-Reply-To: <20190304193917.702601-4-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 4 Mar 2019 20:39:11 +0100")
Message-ID: <yq15zsvzykk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9187 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=859 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Without CONFIG_OF, the of_match_node() helper does not evaluate
> its argument, and the compiler warns about the unused variable:
>
> drivers/scsi/ufs/ufs-hisi.c: In function 'ufs_hisi_probe':
> drivers/scsi/ufs/ufs-hisi.c:673:17: error: unused variable 'dev' [-Werror=unused-variable]

Applied to 5.1/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
