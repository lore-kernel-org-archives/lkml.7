Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D337C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C82F21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 01:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PFa7vxlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGDBQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 21:16:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52260 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGDBQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 21:16:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641EI9A034007;
        Thu, 4 Jul 2019 01:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=8R30P8/VE15uPa2Cd5dwobgt5Ubg1NVPlqUdVRzGKOg=;
 b=PFa7vxlW1+CH/aILqZteNTx4bLTRzCCKfxlUc0pO0k9P6N6FzCrBr2ot3WvgURE9f+Ra
 mpXvtK6hbtuAJrn0CepZRt+szQO2DmQpNdFuyHd3POlkpUne1LAe+EsWKQrLhCX/DQo2
 LlsU8znXbYYmx2OMPJvKWob3JSGNoXynzfPFS93Lqx/BOdLQPnpjkgETMyneOYUzbojN
 WEKblRARQYCw9aRAC48uKdNVHzjaXSVFJKCWAMEmHshiNS1AF1rc2fZGLEgI4RKPryIr
 1ysZDf1XeyfedeyiA8VNc6PPHjNnfzG/FG6XuEvhwgxd0+aLyyUNX7T2q/7Bwm/0UvdY Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2te61q46r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:15:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x641CfXm100559;
        Thu, 4 Jul 2019 01:15:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tebbknp7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 01:15:58 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x641FvGL010644;
        Thu, 4 Jul 2019 01:15:57 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jul 2019 18:15:56 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v5 0/4] misc fixes to PV extentions code
Date:   Wed,  3 Jul 2019 09:19:34 +0800
Message-Id: <1562116778-5846-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040014
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

For compatibility reason, "xen_nopv" is keeped and mapped to "nopv",
this way also avoids an issue with xen_nopv when booting PVH guest.

Build test passes with CONFIG_HYPERVISOR_GUEST enable and disabled.
I didn't get env to test with jailhouse and Hyperv, the others work
as expected.

v5:
PATCH2:
update patch description per Boris
add declaration of nopv variable in arch/x86/include/asm/hypervisor.h
which will be used in PATCH3 and PATCH4

PATCH3 update xen_parse_nopv() per Boris
PATCH4 add nopv=false per Boris
Combine PATCH5 into PATCH3


v4:
PATCH5 a new patch to add 'xen_nopv' back per Boris

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
