Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A01C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2969B205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tCQMMzga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfGHJM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 05:12:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfGHJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 05:12:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6899N1m045622;
        Mon, 8 Jul 2019 09:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=HrLoCLWKaK68rHicJaIU6MsioVbmLOJdaDU92K7D8ok=;
 b=tCQMMzgabehfm7OTcpmRRmZH/CeFRo9huZe6zZBm3ddL+DXYhBX0Q7XEAI8ETyetM8wD
 B7A6dMd/hrPQf6XgJpR8+GxoNoVZKCi1y41ENxqkoKM/nFNBrTEvH5wE5nZMeo5uLDhW
 iVyII8WAHKxzcBETvG85BMPTIx+LEPchtvoIHVY/kxGgvCUSHz1hkLXFBBfJjM20+i22
 MuKlGIQ8byC7Vd4u37Io5eq91055SPgtpicAwD2qVQQBb3+VbCU4P4i2vjmV7G1tvRq1
 vRz8UNCz1KVxgrgh+J6BkjJeSQUWg08qwkrga4St6EpOc867feT4FpGkUF4zTMXpoFq0 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tjkkpd879-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 09:11:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6897uOB111007;
        Mon, 8 Jul 2019 09:11:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tjkf23d87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 09:11:30 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x689BTkI005039;
        Mon, 8 Jul 2019 09:11:29 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 02:11:29 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v6 0/4] misc fixes to PV extensions code
Date:   Sun,  7 Jul 2019 17:15:04 +0800
Message-Id: <1562490908-17882-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080121
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

v6:
PATCH3 add Reviewed-by
PATCH4 remove unnecessory xen_hvm_nopv_guest_late_init() per Boris

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
