Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59327C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1272054F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RZGkqgAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfI3MQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:16:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35430 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3MQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:16:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8tkc186754
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 12:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=Ig+3i6Q7PYAbWFC2Der49rKv9whESe4oFw+kACz7qXA=;
 b=RZGkqgAHK/p+sbFHxFs9+rc87nIvIRTGZXUO1rZqlV1Im7TpQpWVKtmCHb9L3iHgwkF/
 7hf6gWGVChfflBXkcXkYa/hhrWvZIaud+zYaAVvqlbnRdMkYG1kJ6lwAmXDJQJBm9DMq
 XD8CIueNYoNWrXvzdEhKUsjE+6r3EF7xUoWJRhTFa+PvM6qxQ9MDVKhxD7LgZFd3XLb0
 gx0lcCkRnKjLvzBNyNpARjahhqkP+/sbcUUCQchm0JJ120fkxPdKHG+ZbTxGJDdcgmhv
 lqITu6Annwe7soSKOydbt3468aJOe8zlJbtZd4SP7FXM3vehzSialQi2OTyf6cmyvXym 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v9xxuermw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 12:16:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8UC8sh3152654
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 12:16:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vahngjd3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 12:16:26 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8UCGQwp023238
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 12:16:26 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 05:16:25 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH 0/3] Add a unified parameter "nopvspin"
Date:   Sun, 29 Sep 2019 20:21:03 +0800
Message-Id: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=858
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909300130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9395 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=956 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909300130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases folks want to disable spinlock optimization for
debug/test purpose. Xen and hyperv already have parameters "xen_nopvspin"
and "hv_nopvspin" to support that, but kvm doesn't.

The first patch adds that feature to KVM guest with "nopvspin".
I also changed print code in first patch, I'm not sure if I should
pick that part into a separate patch, just let me know if it's
preferred.

For compatibility reason original parameters "xen_nopvspin" and
"hv_nopvspin" are retained and marked obsolete.


Thanks
Zhenzhong
