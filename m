Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE17C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD1822CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="EbjQsYx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfHSREh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:04:37 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:25898 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbfHSREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:04:35 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JGxaS2003739;
        Mon, 19 Aug 2019 13:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=4TUNstILGMYHtvTWSxWfD1G0ak+h3mI3SMQK5Ban9Ww=;
 b=EbjQsYx5otpksauPu4rGrqnavBLEoyvwNGYgoyO6lIir9RO6FFjeDNt9Lh+yWLgCa0ax
 9hXCY/O2B8jEJ1SkkVZf3LZVgJ4CQZnCm21RZ0s0zCbytGAYSj6onqPc1x7uvADh6enw
 PjeeV0TNklOXDmFnd7h2Fm1JDWFbLV0AYnEyCSzBV4QGsYtJFfF8BuRbaRyNCOB7nNqp
 jDbtFw056a5P3iruWJzzugZbZ7flANdBvLjwETBhdbGe8tCczmU1rKbIqa1YmkiZRTls
 E3UpXBdnQXVYUPCdnjMZTH8sk973qkK+3g7+fWJSmuKzklPMcuV+Mx4wVfjZERRfkaQ8 1A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2uecn3ypr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 13:04:33 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JGwAu9087772;
        Mon, 19 Aug 2019 13:04:33 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2ufxkfs94c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 13:04:33 -0400
X-LoopCount0: from 10.173.37.27
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1287237318"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Bastien Nocera <hadess@hadess.net>,
        Christian Kellner <ckellner@redhat.com>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>
Subject: [PATCH] Revert "Bluetooth: btusb: driver to enable the usb-wakeup feature"
Date:   Mon, 19 Aug 2019 12:04:08 -0500
Message-Id: <1566234248-13799-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=720 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190180
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=849 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a0085f2510e8976614ad8f766b209448b385492f.

This commit has caused regressions in notebooks that support suspend
to idle such as the XPS 9360, XPS 9370 and XPS 9380.

These notebooks will wakeup from suspend to idle from an unsolicited
advertising packet from an unpaired BLE device.

In a bug report it was sugggested that this is caused by a generic
lack of LE privacy support.  Revert this commit until that behavior
can be avoided by the kernel.

Fixes: a0085f2510e8 ("Bluetooth: btusb: driver to enable the usb-wakeup feature")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=200039
Link: https://marc.info/?l=linux-bluetooth&m=156441081612627&w=2
Link: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/750073/
CC: Bastien Nocera <hadess@hadess.net>
CC: Christian Kellner <ckellner@redhat.com>
CC: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/bluetooth/btusb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3876fee6..33c3873 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1170,10 +1170,6 @@ static int btusb_open(struct hci_dev *hdev)
 	}
 
 	data->intf->needs_remote_wakeup = 1;
-	/* device specific wakeup source enabled and required for USB
-	 * remote wakeup while host is suspended
-	 */
-	device_wakeup_enable(&data->udev->dev);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
@@ -1238,7 +1234,6 @@ static int btusb_close(struct hci_dev *hdev)
 		goto failed;
 
 	data->intf->needs_remote_wakeup = 0;
-	device_wakeup_disable(&data->udev->dev);
 	usb_autopm_put_interface(data->intf);
 
 failed:
-- 
2.7.4

