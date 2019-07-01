Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C218C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B128206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DXEwpbck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGBCRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:17:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51844 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGBCRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:17:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x622DuCg002640;
        Tue, 2 Jul 2019 02:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=JBk+9q6K3yoqn/77EyVKRhimbO8wdik/7q1ScDaQrDU=;
 b=DXEwpbckhUODFnesaSI6tWfTFGu08oZ2ocmXursuCbHXTxiZ+3A+E9agSgkuq9m+7IRV
 rXeZcwqCT1FkRSrU9IJus+TIHIBzMQzg9uLIwMNFlQ9MaEuFD2azdSM0q2XF/NDFcvhZ
 9d090WU5I211v1jqGbdL7dzT5MEWTRlxYw+Q0phgSn+j4jPFdf8upvGXZUT6r1bWjDyV
 JQOkiu4pxCe8f4T3RcHAjVnboAhnJgJvO/oGygOzcBh/odQdh3Xvl/JNXTKdPta8gGFU
 VVmDKsytQ8vAy9U4BIMLJd2kkQhw+z8ifLp7ai9vyWoCKD4WorSKE6nlVcxqYk4luJU1 mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2te61e0ny4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 02:16:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x622CjP7147236;
        Tue, 2 Jul 2019 02:16:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tebbjg8x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 02:16:52 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x622GoiI011178;
        Tue, 2 Jul 2019 02:16:50 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 19:16:50 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.co,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v3 0/4] misc fixes to PV extentions code
Date:   Mon,  1 Jul 2019 10:20:24 +0800
Message-Id: <1561947628-1147-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In virtualization environment, PV extensions (drivers, interrupts,
timers, etc) are enabled in the majority of use cases which is the
best option.

However, in some cases (kexec not fully working, benchmarking, etc)
we want to disable PV extensions. We have xen_nopv for that purpose
but only for XEN. For a consistent admin experience a common command
line parameter set across all PV guest implementations is a better
choice.

To achieve this introduce a new 'nopv' parameter which is usable by
most of PV guest implementation. Due to the limitation of some PV
guests(XEN PV, XEN PVH and jailhouse), 'nopv' is ignored for XEN PV
, jailhouse and XEN PVH if booting via Xen-PVH boot entry. If booting
via normal boot entry(like grub2), PVH guest has to panic itself
currently.

While analyzing the PV guest code one bug were found and fixed.
(Patches 1). It can be applied independent of the functional
changes, but is kept in the series as the functional changes
depend on them.

As I didn't got further comments from Jgross about remove 'xen_nopv',
so I presume he has no objection to that. In fact, I think no product
environment will use 'xen_nopv' for performance. Jgross, if you changed
mind to preserve it finally, just let me know.

I didn't get env to test with jailhouse and Hyperv, the others work
as expected.

v3:
Remove some unrelated patches from patchset as suggested by Tglx

PATCH1 unchanged
PATCH2 add Reviewed-by
PATCH3 add Reviewed-by
PATCH4 rewrite the patch as Jgross found an issue in old patch,
description is also updated.



v2:
PATCH3 use 'ignore_nopv' for PVH/PV guest as suggested by Jgross.
PATCH5 new added one, specifically for HVM guest

Thanks
Zhenzhong
