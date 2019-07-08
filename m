Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE80C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5922084A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfGHIXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:23:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728673AbfGHIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:23:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x688MT0J143001
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 04:23:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm02m4gf6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:23:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 8 Jul 2019 09:23:03 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 09:23:00 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x688MwZU39780634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 08:22:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B595D4C04A;
        Mon,  8 Jul 2019 08:22:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79DB34C044;
        Mon,  8 Jul 2019 08:22:58 +0000 (GMT)
Received: from localhost (unknown [9.152.212.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Jul 2019 08:22:58 +0000 (GMT)
Date:   Mon, 8 Jul 2019 10:22:57 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] s390: ap: constify parameter of match_apqn
References: <your-ad-here.call-01562573328-ext-8139@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01562573328-ext-8139@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
x-cbid: 19070808-0020-0000-0000-000003513853
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070808-0021-0000-0000-000021A4E115
Message-Id: <patch.git-14fdf13eac05.your-ad-here.call-01562573328-ext-8139@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with
class_find_device()") changed the prototype of driver_find_device to
use a const void pointer.

Change match_apqn accordingly.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2c9fb1423a39..7e85ba7c6ef0 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -26,7 +26,7 @@
 
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
 
-static int match_apqn(struct device *dev, void *data)
+static int match_apqn(struct device *dev, const void *data)
 {
 	struct vfio_ap_queue *q = dev_get_drvdata(dev);
 
-- 
2.21.0

