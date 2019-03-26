Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D44B20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wyehcn+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfCZCSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:18:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47874 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbfCZCSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:18:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q2E08Y062966;
        Tue, 26 Mar 2019 02:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xsHwC9oNYJjf/Hw5vkJQiO4kWrvRi0CA7gv9FiiMK00=;
 b=Wyehcn+4qaPLQUKwJgGZvIh10yVRBJhSUT7fipddv6k96UIR6jxucta0A8gE1ZhNXzV5
 uWtCoQT1SPJdlQsMZtAD5JRCKMiIPXauUe5efYNqQcYNYsygvEW3iZSbfqU6w1sNxuRw
 nveJ8CLTU5QnYBqlKC7t5kyJU9nEwk8wSrxcx0v69GyUrEOHD82KP8t7z7WsmqLsHthB
 4TRSVqZew5JFajkipLHbT/982Cs0TXog0EbCsDwuHHQViSVKN3FXUSYoso2RbRxwaH5v
 wg0alHC7BeqpNzO2Xw/bRxhs0laoGZpSUFX/o3WZRlcJOKvcLu0w1krsBCeXjI9SBFLl Fw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g0qkah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:17:57 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2HuPm017792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:17:57 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2HtlM003514;
        Tue, 26 Mar 2019 02:17:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 19:17:54 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: avoid uninitialized variable warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190322142557.929966-1-arnd@arndb.de>
Date:   Mon, 25 Mar 2019 22:17:52 -0400
In-Reply-To: <20190322142557.929966-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 22 Mar 2019 15:25:49 +0100")
Message-ID: <yq1tvfqz8dr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=688 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> clang -Wuninitialized incorrectly sees a variable being used without
> initialization:
>
> drivers/scsi/lpfc/lpfc_nvme.c:2102:37: error: variable 'localport' is uninitialized when used here
>       [-Werror,-Wuninitialized]
>                 lport = (struct lpfc_nvme_lport *)localport->private;
>                                                   ^~~~~~~~~
> drivers/scsi/lpfc/lpfc_nvme.c:2059:38: note: initialize the variable 'localport' to silence this warning
>         struct nvme_fc_local_port *localport;
>                                             ^
>                                              = NULL
> 1 error generated.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
