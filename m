Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34B1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DBA24410
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GCImXz4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfE3CBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:01:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfE3CBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:01:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1rru3172668;
        Thu, 30 May 2019 02:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=B8QTSyLX9eqIs9dUClhnq3SvLDKzFdLYXPMlBG7SlbQ=;
 b=GCImXz4cyR0yB3TyHuuazXlgylu7jBVqdDVf/vHZh1UlMwxhT1usQvB1NuZlJvGHn+Fv
 gA69AQbdQlnsl3y2XU8snLU3/otV1k9AJ7MFbPGYJAVUD7c0+XBgliiLgRundKErxI4o
 xe7E63TVgbroACOH+x9BnsMMmg1TMVkHv3xTih3NwKrYsZSl8hiDaj9xqsFUEfpIPitv
 PiylH0G2L7ixMPyNlymDmWtIgbGP8leqPOS/O5B/4iP6pEaCjSxafOoXOtqjAISCRM1U
 4ju65cFkS2qcEwGsj16bBD5ABGTsAl1fFwVMvj6Ok3uMGDzHCCJITitugctDigpRp/nh 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2spw4tnams-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:00:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U203fs183118;
        Thu, 30 May 2019 02:00:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31vkfd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:00:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U20E8l030781;
        Thu, 30 May 2019 02:00:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:00:14 -0700
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, don.brace@microsemi.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        Thomas.Lendacky@amd.com, dyoung@redhat.com
Subject: Re: [PATCH v2] scsi: smartpqi: properly set both the DMA mask and the coherent DMA mask in pqi_pci_init()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190527005934.1493-1-lijiang@redhat.com>
Date:   Wed, 29 May 2019 22:00:11 -0400
In-Reply-To: <20190527005934.1493-1-lijiang@redhat.com> (Lianbo Jiang's
        message of "Mon, 27 May 2019 08:59:34 +0800")
Message-ID: <yq14l5czopg.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=807 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lianbo,

> When SME is enabled, the smartpqi driver won't work on the HP DL385
> G10 machine, which causes the failure of kernel boot because it fails
> to allocate pqi error buffer. Please refer to the kernel log:

Applied to 5.2/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
