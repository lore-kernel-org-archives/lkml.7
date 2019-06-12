Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09134C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D097021019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MwvmsZ+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502146AbfFLQfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:35:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438224AbfFLQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:35:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CGY2Ki172589;
        Wed, 12 Jun 2019 16:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=WKZBn5hrqUBN0vdTdkfQRnrpZW0zRXfCHW2XB/WALnc=;
 b=MwvmsZ+GhfUdX1QyVxwkuyCXY5gaKoNTO9c+wGBg/NtFkeOf3UcXNYGtJfI2t+SFQtyL
 nAW3B4L0RVf4tN+HAiBN5SGlSs7I1YCqLEwHBqkWa8tsoMCv1Fj08cilXn3EhrMnilHL
 Lsn20c2JEnUkTT8wC5+ltllWttz+thXgQbcsLcgTZV8nVT+5keSQiH/9bIe6VdpPcd5H
 0TnNsmrdbIq1qKLULfUr1Sapmka6sPHvoz1t3VGiPgmQoKdUu2Rz7xrPw4JgRy3wplru
 m6mKEjC6YVt0SXC7kALrzgxKX/Sr/aNvZPsGTSdP6cNTqOiyaSXdkQbYvb0U6aSBnwBL Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t04etvrr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 16:34:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CGXJiC113235;
        Wed, 12 Jun 2019 16:34:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t024v2uq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 16:34:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5CGYpld006402;
        Wed, 12 Jun 2019 16:34:51 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 09:34:51 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Divya Indi <divya.indi@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: [RFC][v2] Kernel Access to Ftrace Instances.
Date:   Wed, 12 Jun 2019 09:34:16 -0700
Message-Id: <1560357259-3497-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=795
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=858 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please review the patches that follow -

[PATCH 1/3] tracing: Relevant changes for kernel access to Ftrace instances.
[PATCH 2/3] tracing: Adding additional NULL checks.
[PATCH 3/3] tracing: Add 2 new funcs. for kernel access to Ftrace instances.

This is v2 for the series with changes made to Patch 3/3 to address review comments. 

The new changes ensure that a trace array created by trace_array_create or
accessed via trace_array_lookup cannot be freed if still in use.

Let me know if you have any questions/concerns/suggestions. 

Thanks,
Divya 

