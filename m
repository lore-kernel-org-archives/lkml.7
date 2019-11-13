Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F614C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17955206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mAfM23Hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKMVR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:17:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:17:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADL40nR056673;
        Wed, 13 Nov 2019 21:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=pIR/fCCWbp3TXnn+eHo9zj2GQqY5GlxleqQj0nAeXJs=;
 b=mAfM23HmvKNeVZqPC0qBtwQIE73LIu93H2orzToHLW1jstjahcr+mYIejFI31G21BAFm
 adTWC4/oS8UvVw51wGLuHjo9Ks5MFsauZ45nsgC5AaA0fVCqkJxbNJZ7La45zBfXTuso
 4+4G1c6vTslNpIayUWJJDD0nyAjpZBxYHo+AkQTiKoS+efSEFgWFodzCyRAIXfz80wMs
 d4y3CMSpIAskSdrhgG3BYnb/21oGdbV7bRk25eyuKrLL6GUQTH1UEhwLP8K3mfGMoBuj
 4VCIyBD0ZpomdVKCndqfqPHKcZfhNavwNTk9wFKXdRETgKu1hxbl4rzSU4wZt6rL7N1u MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w5ndqfadd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:16:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADL3weL170475;
        Wed, 13 Nov 2019 21:16:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w8g18768t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:16:57 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xADLGukB015416;
        Wed, 13 Nov 2019 21:16:56 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 13:16:56 -0800
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Joe Jin <joe.jin@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [RFC v4] Kernel access to ftrace instances. 
Date:   Wed, 13 Nov 2019 13:15:57 -0800
Message-Id: <1573679762-7774-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=588
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130175
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=653 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please review the patches that follow -

[PATCH 1/5] tracing: Declare newly exported APIs in include/linux/trace.h
[PATCH 2/5] tracing: Verify if trace array exists before destroying it.
[PATCH 3/5] tracing: Adding NULL checks
[PATCH 4/5] tracing: Adding new functions for kernel access to Ftrace instances.
[PATCH 5/5] tracing: Sample module to demonstrate kernel access to Ftrace instances.

This patchset addresses the feedback recieved for v3.

Changes from v3 include -

1) trace_array_get_by_name() replaces trace_array_lookup and 
with its new implementation we no longer need to export
trace_array_create().

If a trace array with given name exists, this func returns a pointer
to this trace array (Previously, trace_array_lookup()). 
If does not exist, create a new trace array (Previously done by trace_array_create()).

2) A new trace array will always have ref ctr = 1 on creation.
Destroying a trace array will require its ref ctr to be 1.

3) trace_array_set_clr_event(): Uses boolean instead of 0/1 to enable/disable
events to a trace array. 

4) Sample module reflects the above changes. It is now part of the same patch-set.

Thanks,
Divya
