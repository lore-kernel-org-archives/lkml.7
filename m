Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D872C10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D85218AF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kPArrzN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDMAIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:08:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38808 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfDMAIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:08:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3D04Nct075328;
        Sat, 13 Apr 2019 00:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=LR7dibRBj2GMgLsi+/+GFDcAeXPi1YPqW5+rKfBgj18=;
 b=kPArrzN8B90gb4PlvdH8UCxwzl3TL9EK8FsYIPLwBa0Pc55V/xJRY+owmdzmQVV/AgO/
 FbIbVgksvFBsr6XYPouU2AoV8UM8c0zIhf7nUdXgU7emGDYizCdJdLDM1C5ic2fk9P1C
 HCSbPX5T0Z08194MY9KwSysUX8P0nys62Iv1MIH8OQkW7hglP0vPep86ULrHvxJqSrrk
 BthDBluKGKFVjWulUc+eeJ3KVttVrCo++6eKq4HrThr09EccWLn7M+DQVg3HIUOuJkEr
 NdE1U4jxc/t6IPVK1DI0d20OiyDbvzjpsJLLg7SF/UeC1AucHVrVVh7l65XZ5pY5TqRi pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rpmrqrw2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Apr 2019 00:08:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3D04boh190156;
        Sat, 13 Apr 2019 00:06:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ru4vrr0uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Apr 2019 00:06:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3D064DU018511;
        Sat, 13 Apr 2019 00:06:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Apr 2019 17:06:04 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Karen Xie <kxie@chelsio.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V3] scsi: cxgbi: remove redundant __kfree_skb call on skb and free cst->atid
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190412083301.25503-1-colin.king@canonical.com>
Date:   Fri, 12 Apr 2019 20:06:01 -0400
In-Reply-To: <20190412083301.25503-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 12 Apr 2019 09:33:01 +0100")
Message-ID: <yq1k1fykbva.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9225 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120158
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9225 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The error return path via label rel_resource checks for a non-null skb
> before free'ing it.  However, skb is always null at this exit path, so
> the null check and the free are redundant and can be removed.
> Removing this allows the original goto's to rel_resource to be cleaned
> up; the first can be replaced by a return of -EINVAL, the second can
> be replaced by a more appropriate -ENOMEM return and fix a memory leak
> by freeing csk->atid.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
