Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DD6C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6722441D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D8Ljg4ML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfE3CKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:10:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfE3CKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:10:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U29GDh190060;
        Thu, 30 May 2019 02:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3b4v02kAlRWt1zySxYW3+jwiIhNktI40S7d3ZdICrPU=;
 b=D8Ljg4ML7czwUmdbnPG63RBFcFmkeDIUcjF2m916X78WFSM065nGcx7gAh9LorxWsXem
 +NPXfPlNuKAz9HTndLvAEFuKqGmt4T5jgOGD3ye+CCD8gn1ZgGqnQ234pZCZT+Vqt/DQ
 kUU2DcyxpzGOIYiK8Z34AJlEtFstAPgmcXJI38t01Vej+XjZxEfjoGLFXX1JehpnELlB
 ZzpQfPcxGE8KpOnE3CVEorf5sM9FQN8fo0pSCcokRtV2T06zPXDvJRQLa1emlrOqgJ9Y
 q1zZyrPnhF9W19KEm7NJIl3dQITbHM9hH6mRg1Xt5BtT3lFBfB8eno5RiZZ2xnbGWyZN yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2spxbqd721-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:10:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U29OZp134973;
        Thu, 30 May 2019 02:10:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ss1fnt1sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:10:05 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U2A2Ba021444;
        Thu, 30 May 2019 02:10:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:10:02 -0700
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        Ewan Milne <emilne@redhat.com>, Tomas Henzl <thenzl@redhat.com>
Subject: Re: [PATCH 1/2] scsi: libsas: only clear phy->in_shutdown after shutdown event done
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190514024239.47313-1-yanaijie@huawei.com>
Date:   Wed, 29 May 2019 22:09:58 -0400
In-Reply-To: <20190514024239.47313-1-yanaijie@huawei.com> (Jason Yan's message
        of "Tue, 14 May 2019 10:42:38 +0800")
Message-ID: <yq1r28gy9op.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jason,

> When the event queue is full of phy up and down events and reached the
> threshold, we will queue a shutdown-event, and set phy->in_shutdown so
> that we will not queue a shutdown-event again. But before the
> shutdown-event can be executed, every phy-down event will clear
> phy->in_shutdown and a new shutdown-event will be queued. The queue will
> be full of these shutdown-events.
>
> Fix this by only clear phy->in_shutdown in sas_phye_shutdown(), that is
> after the first shutdown-event has been executed.

Applied 1+2 to 5.2/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
