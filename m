Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17D1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9645E206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 00:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MeeUzHKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfG3ADO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 20:03:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36728 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfG3ADO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:03:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNwmWX162427;
        Tue, 30 Jul 2019 00:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=MFPK0VKdAnqdVd7edEXECtqh0kam7Svpl/9gcOtuoUs=;
 b=MeeUzHKjiijBQbiNEuPd6ZWaGO4So2GG6KNiHDM9MRpZZwo+6wTygvxlhO6m3jsZFvde
 ixnszMgXDHM/0WQSAp1+zY9+Rr7ESytHoPqyBjzwoMMYoPZOpADMCiD3V7lYNSdhVGh2
 32bUeHBZfyUnS3iaqUGCoAktnfm80ECNJvd2233yF3G8X9RbFMr3tKmxkyl4Eim8Y2zI
 q2Zetv/J9Pd3VLECsLGTilSXK6jSnrv5y75mZ3EpqZTvVrU6nWe6KAjgVDBPermI8oWp
 QslBuHWT+p+5Gi9DdirRKoFo5AIq+QUOeyk16J2Ryk0aGC6Ga/Gqog/q5ljwOAUeQrGC VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u0f8qtpgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6TNvbBx043252;
        Tue, 30 Jul 2019 00:02:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u0dxqk1ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 00:02:44 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6U02hTA003725;
        Tue, 30 Jul 2019 00:02:43 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 17:02:43 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: [PATCH 0/7[v3]] Kernel access to Ftrace instances.
Date:   Mon, 29 Jul 2019 17:02:27 -0700
Message-Id: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=847
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907290261
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=895 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907290261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to patches introduced by commit f45d1225adb0 "tracing: Kernel
access to Ftrace instances") we also need the following patches to reliably
access ftrace instances from other kernel modules or components.

Please review the patches that follow.

Divya Indi (7):
  tracing: Required changes to use ftrace_set_clr_event.
  tracing: Declare newly exported APIs in include/linux/trace.h
  tracing: Verify if trace array exists before destroying it.
  tracing: Adding NULL checks
  tracing: Handle the trace array ref counter in new functions
  tracing: New functions for kernel access to Ftrace instances
  tracing: Un-export ftrace_set_clr_event

 include/linux/trace.h        | 10 +++++
 include/linux/trace_events.h |  2 +
 kernel/trace/trace.c         | 90 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h         |  4 +-
 kernel/trace/trace_events.c  | 25 +++++++++++-
 5 files changed, 123 insertions(+), 8 deletions(-)

-- 
1.8.3.1

