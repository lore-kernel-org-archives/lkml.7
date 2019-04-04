Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BB7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52690206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="BxwMPbaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfDDSrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:47:17 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:40808 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729456AbfDDSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1554403636; x=1585939636;
  h=from:to:cc:subject:date:message-id;
  bh=/PQm+DDqrmS5rL6kFTCmZOspwUxK06cLTzk1VExmc9I=;
  b=BxwMPbawR/sPUsM8dZpeWgCh6Xu//woJnbZnWB+G7a7JqeE8BQMh+pBa
   eGFzo3VXHcNgahGZ+mKxldaj99yMKdqhBBenwe01Vp8tdBBsaogFLb4Az
   OD+uJ/qLIuyHIZtI870FOb34C9WP4JYX/UfT41y39R6+QwmfQw5yHVW4V
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GFAQDGT6ZchyWd50NlHQEBBQEHBQG?=
 =?us-ascii?q?BZYN8jTClIIFnDgEBhGyFUCI4EgEBAwEBCQEDAgEBAhABAQEVCQgpL4I6KQG?=
 =?us-ascii?q?CahZngXODAIF2ohM9Am+BAYkHAQEBgh6KL4EwhmuESIFXP4ERgmSFGWSFFAO?=
 =?us-ascii?q?KVjGHVpMNBwKCTwSRJwIYggWJcIhanz8CBAIEBQIVgWYggVhwgz2CI45GIQG?=
 =?us-ascii?q?RGgEB?=
X-IPAS-Result: =?us-ascii?q?A2GFAQDGT6ZchyWd50NlHQEBBQEHBQGBZYN8jTClIIFnD?=
 =?us-ascii?q?gEBhGyFUCI4EgEBAwEBCQEDAgEBAhABAQEVCQgpL4I6KQGCahZngXODAIF2o?=
 =?us-ascii?q?hM9Am+BAYkHAQEBgh6KL4EwhmuESIFXP4ERgmSFGWSFFAOKVjGHVpMNBwKCT?=
 =?us-ascii?q?wSRJwIYggWJcIhanz8CBAIEBQIVgWYggVhwgz2CI45GIQGRGgEB?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2019 13:47:15 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34ISMQ4043163;
        Thu, 4 Apr 2019 14:47:15 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2rnn028y88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 14:47:15 -0400
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.60,309,1549951200"; 
   d="scan'208";a="337561724"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     linux-usb@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        sjg@google.com, campello@google.com,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2 0/2] Support runtime changes of vendor mac passthu policy
Date:   Thu,  4 Apr 2019 13:46:51 -0500
Message-Id: <1554403613-5970-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=450 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms ACPI method `\\_SB.AMAC` is dynamic and changes to it can
influence changing the behavior of MAC pass through and what MAC address is used.

When running USB reset, re-read the MAC address to use to support tools that
change the policy.

This is quite similar to using `SIOCSIFHWADDR` except that the actual MAC to use
comes from ASL rather than from userspace.

Changes from v1:
 * Remove an extra unneeded `ether_addr_copy` call
 * Use `dev_set_mac_address` to ensure all notifiers are called
 * Shuffle functions to allow code re-use.

Mario Limonciello (2):
  r8152: remove extra action copying ethernet address
  r8152: Refresh MAC address during USBDEVFS_RESET

 drivers/net/usb/r8152.c | 51 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

-- 
2.7.4

