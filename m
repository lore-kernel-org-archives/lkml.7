Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB42BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806C8208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="diDR56hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfFYMA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:00:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54716 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFYMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:00:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBwkFp132925;
        Tue, 25 Jun 2019 11:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=JHXcosG7IYGrrYtkyQNPDmN2Ct09zNxM9EczFZRDWZw=;
 b=diDR56hFh42T/cWtZu5ChKWg6e/UmimF4qGq3l+Iv12QW1DzD7bp7l7+5BnVHON/NmZN
 +gpLyPgAUA5C8U0cvKcAiqPMKm1tthbhhfXzfCAlBFUg76rfoXTpS5UBOFRFOMOWthLg
 jcfeSTYfcp7EM9jZEEkdlozcyLFs5bYxtH2deFmuHWoI9oVSTwS/GYUBfXM/qkLc5x2D
 vVgBiu+9VjwooXGW4xPUm8Pugb86q48z+eb59suBjwPfRaoqCkBoUpdrbKxPVNBi3rJK
 ao2C5WCSjvFC0rMzMsA/YHZC4GYcb3u2fNbia6nnvRHQfgjehspqS6YA2hFmIC40QLR0 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pkv5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:59:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBxO2P002132;
        Tue, 25 Jun 2019 11:59:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7c6q71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:59:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5PBxmh4011993;
        Tue, 25 Jun 2019 11:59:48 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 04:59:47 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, peterz@infradead.org,
        srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v2 0/7] misc fixes to PV extentions code
Date:   Mon, 24 Jun 2019 20:02:52 +0800
Message-Id: <1561377779-28036-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH v2 1/7]  x86/xen: Mark xen_hvm_need_lapic() and xen_hvm_need_lapic() as __init
[PATCH v2 2/7]  x86/jailhouse: Mark jailhouse_x2apic_available as __init

Above two patches only add __init annotation to some functions, not
related to other patches. I didn't split the two out as following patches
need them to avoid conflicts.


[PATCH v2 3/7]  x86: Add nopv parameter to disable PV extensions
[PATCH v2 4/7]  Revert "xen: Introduce 'xen_nopv' to disable PV extensions for HVM guests."
[PATCH v2 5/7]  x86/xen: nopv parameter support for HVM guest

Above three patches add an unified nopv prameter used for most of hypervisor
platform except XEN PV/PVH, jailhouse. Those need PV extensions to work.

I revert 'xen_nopv' as it's same effect as nopv on XEN platform, there is also
an issue using 'xen_nopv' with PVH, we should ignore 'xen_nopv' for PVH.

[PATCH v2 6/7]  locking/spinlocks, paravirt, hyperv: Correct the hv_nopvspin case

This is a similar change as Commit e6fd28eb3522
("locking/spinlocks, paravirt, xen: Correct the xen_nopvspin case"), but for
hyperv.

[PATCH v2 7/7]  Revert "x86/paravirt: Set up the virt_spin_lock_key after static keys get initialized"

This revert an old change which is unnecessory now, I think the original change is smarter.


v2:
PATCH3 use 'ignore_nopv' for PVH/PV guest as suggested by Jgross.
PATCH5 new added one, specifically for HVM guest

Thanks
Zhenzhong
