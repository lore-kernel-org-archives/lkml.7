Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C90C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B515820651
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PneBln1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfHNR4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:56:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50340 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfHNR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:56:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHrs7p120496;
        Wed, 14 Aug 2019 17:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=BKxqk+CBk51jtK7v8gTw8n53G62GPRXfoVRO6EcuU6c=;
 b=PneBln1qQwbiRopUdXPAnFRgh/ykeMQFzk+ajFK+2K7qfyCRqVv/90ZjC4FRGP0tDSVA
 vOsG1tFHTsmpzjni7FN0rizE+IDdzWNFNoU00TR8jRklXI34KTcqMxPOZUPII16P0KAR
 57P9O41GCt3M968B3C4xxx1A5Tkq5OAf+yNsIg9xEbZH9G9YTGgXzwEXvxApj8RQgr9U
 kWXCZe7+ULeQG03hTeA04T5QaQqMvKblWwLwnLGtEpAsn6lSEvlmWSdBwwIY/OIYOjfo
 xF7FRjGC86IkERxOLTB8x/MMgobbIgGobojqq+SJ4QJq4gsV/tT+ImV7exw8x4f6/oeh GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u9nvpef61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7EHs2Sh027519;
        Wed, 14 Aug 2019 17:55:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ucgf01g8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 17:55:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7EHtaEH025328;
        Wed, 14 Aug 2019 17:55:36 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 10:55:36 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [PATCH 0/5 v4]Kernel Access to Ftrace instances.
Date:   Wed, 14 Aug 2019 10:55:22 -0700
Message-Id: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=825
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=874 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908140161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to patches introduced by commit f45d1225adb0 "tracing: Kernel
access to Ftrace instances") we also need the following patches to reliably
access ftrace instances from other kernel modules or components.

This version addresses the review comments/suggestions received for v3.

Please review the patches that follow.

Divya Indi (5):
  tracing: Declare newly exported APIs in include/linux/trace.h
  tracing: Verify if trace array exists before destroying it.
  tracing: Adding NULL checks
  tracing: Handle the trace array ref counter in new functions
  tracing: New functions for kernel access to Ftrace instances

 include/linux/trace.h        | 10 +++++
 include/linux/trace_events.h |  3 +-
 kernel/trace/trace.c         | 88 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h         |  4 +-
 kernel/trace/trace_events.c  | 25 ++++++++++++-
 5 files changed, 121 insertions(+), 9 deletions(-)

-- 
1.8.3.1

