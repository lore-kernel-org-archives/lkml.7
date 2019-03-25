Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A007B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Y19f+xEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfCYOM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:12:58 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:24156 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbfCYOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1553523177; x=1585059177;
  h=cc:from:to:subject:date:message-id;
  bh=Igp6GPMRxzdz4EcLu4mmrctowFRXI8UkHE9HuizoM2s=;
  b=Y19f+xEaP5AUuAKwQ5GZUJXNa5zSCCILdI8PS8ySjuUixTf9mgh/Hg+h
   m8bPzQpq4M7VlmFqtJ4ZqkapZ9lje/bwKCnrLyw6o6E9pp+2s+dQra75L
   Sv0w42r80SSeDexmprTwNZs+muPZvUB/pTZUE9sZ4Zq+mxedf8rC30d+d
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FwAACv4ZhchyeV50NkHgEGBwaBVAY?=
 =?us-ascii?q?LAYFmghUnjQmlHoFnDQEBhGyFFSI3Bg0BAQMBAQkBAwIBAQIQAQEBCgsJCCk?=
 =?us-ascii?q?vgjopAYJqFhVST4ECIoMAgXahfz0Cb4EBiQcBAQGBazOFRoRigS8BhmmESIF?=
 =?us-ascii?q?XP4RhhC1khRQDkjWSYQcCgkcEkG4CF5N9AS2eGQIEAgQFAhWBY4F5cIM8giS?=
 =?us-ascii?q?BCQECjTkiATGQJgEB?=
X-IPAS-Result: =?us-ascii?q?A2FwAACv4ZhchyeV50NkHgEGBwaBVAYLAYFmghUnjQmlH?=
 =?us-ascii?q?oFnDQEBhGyFFSI3Bg0BAQMBAQkBAwIBAQIQAQEBCgsJCCkvgjopAYJqFhVST?=
 =?us-ascii?q?4ECIoMAgXahfz0Cb4EBiQcBAQGBazOFRoRigS8BhmmESIFXP4RhhC1khRQDk?=
 =?us-ascii?q?jWSYQcCgkcEkG4CF5N9AS2eGQIEAgQFAhWBY4F5cIM8giSBCQECjTkiATGQJ?=
 =?us-ascii?q?gEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Mar 2019 09:12:43 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PE8Xrg079378;
        Mon, 25 Mar 2019 10:12:43 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0b-00154901.pphosted.com with ESMTP id 2rewgq9953-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 10:12:42 -0400
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        sjg@google.com, campello@google.com,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Mar 2019 20:11:51 +0600
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.60,269,1549951200"; 
   d="scan'208";a="1215647042"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     linux-usb@vger.kernel.org
Subject: [PATCH] r8152: Refresh MAC address during USBDEVFS_RESET
Date:   Mon, 25 Mar 2019 09:12:23 -0500
Message-Id: <1553523143-23072-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=807 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms it is possible to dynamically change the policy
of what MAC address is selected from the ASL at runtime.

These tools will reset the USB device and expect the change to be
made immediately.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 86c8c64..eb5351b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4268,6 +4268,9 @@ static int rtl8152_post_reset(struct usb_interface *intf)
 	if (!tp)
 		return 0;
 
+	/* reset the MAC adddress in case of policy change */
+	set_ethernet_addr(tp);
+
 	netdev = tp->netdev;
 	if (!netif_running(netdev))
 		return 0;
-- 
2.7.4

