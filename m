Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BB0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A29206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 00:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ne8s69nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFEAms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 20:42:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35928 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfFEAms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 20:42:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550YVLj169502;
        Wed, 5 Jun 2019 00:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=2jG9iwigPRzzzQOoYAjs0CPAiPKopiiGwTpAa90JsUg=;
 b=Ne8s69nYB1yGka7zesaxSW7bZ+gl+EXxRZS6w3ek5JEoexVSWnk8qcPXhgoacvQfsLwx
 mCaALcKa00+LI4whTL3nAOBAAzM67lu4oXZcPsl8523cZrGhhslDIPDGQEMygSYPTDz3
 6sbRArKHWUFCKcDt1zWH5AS+l2dbMouLmqXnthrXb2ChQQ8LLz3tNkSfM0MUdvO8psKP
 AF10PQDvoM/JEhbFBV3p9BKhJ3diUYUXiYwrE08eZ6hhey5j7ehBsVpQndSZCG5b2PVk
 jKfTd6vpQpkjyd87L7OMIJ8uIqrXE4u29tNC/NJygrNazmoMt+UMZtoTML2Ij0R1bC3B Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2suj0qg13j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x550fqel153338;
        Wed, 5 Jun 2019 00:42:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2swnghn48f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jun 2019 00:42:16 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x550gFkx027460;
        Wed, 5 Jun 2019 00:42:15 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Jun 2019 17:42:14 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Srinivas Eeda <srinivas.eeda@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC] Kernel Access to Ftrace instances. 
Date:   Tue,  4 Jun 2019 17:42:02 -0700
Message-Id: <1559695325-17155-1-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=695
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906050001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9278 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=741 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906050001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
Please Review the patches that follow. These include -

[PATCH 1/3] tracing: Relevant changes for kernel access to Ftrace instances.
[PATCH 2/3] tracing: Adding additional NULL checks.
[PATCH 3/3] tracing: Add 2 new funcs. for kernel access to Ftrace instances.

Let me know if you have any concerns or questions. 

A sample module demonstrating the use of the above functions will follow soon. 

Thanks,
Divya
