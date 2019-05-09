Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F2CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1E820656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aHPad768"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEIRZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:25:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41670 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfEIRZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:25:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HJMx4162245;
        Thu, 9 May 2019 17:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=d7jsRj1+4ktgEU6gy2u33kGoS54PhxENv0bhYByLvHg=;
 b=aHPad768dCTFxCJgTFzoLiq4Kah+rARe3ddJOH4pC4kk3w4v4vJegt/p5E1xJhps2h0+
 SKg5pGhFS5XWO/tIWQ10ol8p3+EKDZ+yflpd5uBqkRIppZSV/BfgPkzfxc7aIgwR04sw
 xM8Fh7fD2++AGDrN4lmYLd/QA5oGWy33PYywHeJnzqwLLrsVVFQvxYsIxlcoOwI1j9ED
 GI6TEf9TIje8NbamKUtPUe6wlbJ31DDxIDULH08kj10SF8mBQ+hrb80kKBNvmmr0+8N6
 s2A5Gy404dozwjwrTbRRrhEn6WkT7jcAlyNE2UoFf4pQ5XbPSy8fwDfY1q22V2nnC5+V Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2s94b6cey7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49HP6Lf152120;
        Thu, 9 May 2019 17:25:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2schvyy7te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:25:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x49HPVd9031135;
        Thu, 9 May 2019 17:25:31 GMT
Received: from aa1-ca-oracle-com.ca.oracle.com (/10.156.75.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:25:31 -0700
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com, ankur.a.arora@oracle.com
Subject: [RFC PATCH 00/16] xenhost support
Date:   Thu,  9 May 2019 10:25:24 -0700
Message-Id: <20190509172540.12398-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090100
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is an RFC for xenhost support, outlined here by Juergen here:
https://lkml.org/lkml/2019/4/8/67.

The high level idea is to provide an abstraction of the Xen
communication interface, as a xenhost_t.

xenhost_t expose ops for communication between the guest and Xen
(hypercall, cpuid, shared_info/vcpu_info, evtchn, grant-table and on top
of those, xenbus, ballooning), and these can differ based on the kind
of underlying Xen: regular, local, and nested.

(Since this abstraction is largely about guest -- xenhost communication,
no ops are needed for timer, clock, sched, memory (MMU, P2M), VCPU mgmt.
etc.)

Xenhost use-cases:

Regular-Xen: the standard Xen interface presented to a guest,
specifically for comunication between Lx-guest and Lx-Xen.

Local-Xen: a Xen like interface which runs in the same address space as
the guest (dom0). This, can act as the default xenhost.

The major ways it differs from a regular Xen interface is in presenting
a different hypercall interface (call instead of a syscall/vmcall), and
in an inability to do grant-mappings: since local-Xen exists in the same
address space as Xen, there's no way for it to cheaply change the
physical page that a GFN maps to (assuming no P2M tables.)

Nested-Xen: this channel is to Xen, one level removed: from L1-guest to
L0-Xen. The use case is that we want L0-dom0-backends to talk to
L1-dom0-frontend drivers which can then present PV devices which can
in-turn be used by the L1-dom0-backend drivers as raw underlying devices.
The interfaces themselves, broadly remain similar.

Note: L0-Xen, L1-Xen represent Xen running at that nesting level
and L0-guest, L1-guest represent guests that are children of Xen
at that nesting level. Lx, represents any level.

Patches 1-7,
  "x86/xen: add xenhost_t interface"
  "x86/xen: cpuid support in xenhost_t"
  "x86/xen: make hypercall_page generic"
  "x86/xen: hypercall support for xenhost_t"
  "x86/xen: add feature support in xenhost_t"
  "x86/xen: add shared_info support to xenhost_t"
  "x86/xen: make vcpu_info part of xenhost_t"
abstract out interfaces that setup hypercalls/cpuid/shared_info/vcpu_info etc.

Patch 8, "x86/xen: irq/upcall handling with multiple xenhosts"
sets up the upcall and pv_irq ops based on vcpu_info.

Patch 9, "xen/evtchn: support evtchn in xenhost_t" adds xenhost based
evtchn support for evtchn_2l.

Patches 10 and 16, "xen/balloon: support ballooning in xenhost_t" and
"xen/grant-table: host_addr fixup in mapping on xenhost_r0"
implement support from GNTTABOP_map_grant_ref for xenhosts of type
xenhost_r0 (xenhost local.)

Patch 12, "xen/xenbus: support xenbus frontend/backend with xenhost_t"
makes xenbus so that both its frontend and backend can be bootstrapped
separately via separate xenhosts.

Remaining patches, 11, 13, 14, 15:
  "xen/grant-table: make grant-table xenhost aware"
  "drivers/xen: gnttab, evtchn, xenbus API changes"
  "xen/blk: gnttab, evtchn, xenbus API changes"
  "xen/net: gnttab, evtchn, xenbus API changes"
are mostly mechanical changes for APIs that now take xenhost_t *
as parameter.

The code itself is RFC quality, and is mostly meant to get feedback before
proceeding further. Also note that the FIFO logic and some Xen drivers
(input, pciback, scsi etc) are mostly unchanged, so will not build.


Please take a look.

Thanks
Ankur


Ankur Arora (16):

  x86/xen: add xenhost_t interface
  x86/xen: cpuid support in xenhost_t
  x86/xen: make hypercall_page generic
  x86/xen: hypercall support for xenhost_t
  x86/xen: add feature support in xenhost_t
  x86/xen: add shared_info support to xenhost_t
  x86/xen: make vcpu_info part of xenhost_t
  x86/xen: irq/upcall handling with multiple xenhosts
  xen/evtchn: support evtchn in xenhost_t
  xen/balloon: support ballooning in xenhost_t
  xen/grant-table: make grant-table xenhost aware
  xen/xenbus: support xenbus frontend/backend with xenhost_t
  drivers/xen: gnttab, evtchn, xenbus API changes
  xen/blk: gnttab, evtchn, xenbus API changes
  xen/net: gnttab, evtchn, xenbus API changes
  xen/grant-table: host_addr fixup in mapping on xenhost_r0

 arch/x86/include/asm/xen/hypercall.h       | 239 +++++---
 arch/x86/include/asm/xen/hypervisor.h      |   3 +-
 arch/x86/pci/xen.c                         |  18 +-
 arch/x86/xen/Makefile                      |   3 +-
 arch/x86/xen/enlighten.c                   | 101 ++--
 arch/x86/xen/enlighten_hvm.c               | 185 ++++--
 arch/x86/xen/enlighten_pv.c                | 144 ++++-
 arch/x86/xen/enlighten_pvh.c               |  25 +-
 arch/x86/xen/grant-table.c                 |  71 ++-
 arch/x86/xen/irq.c                         |  75 ++-
 arch/x86/xen/mmu_pv.c                      |   6 +-
 arch/x86/xen/p2m.c                         |  24 +-
 arch/x86/xen/pci-swiotlb-xen.c             |   1 +
 arch/x86/xen/setup.c                       |   1 +
 arch/x86/xen/smp.c                         |  25 +-
 arch/x86/xen/smp_hvm.c                     |  17 +-
 arch/x86/xen/smp_pv.c                      |  27 +-
 arch/x86/xen/suspend_hvm.c                 |   6 +-
 arch/x86/xen/suspend_pv.c                  |  14 +-
 arch/x86/xen/time.c                        |  32 +-
 arch/x86/xen/xen-asm_32.S                  |   2 +-
 arch/x86/xen/xen-asm_64.S                  |   2 +-
 arch/x86/xen/xen-head.S                    |  11 +-
 arch/x86/xen/xen-ops.h                     |   8 +-
 arch/x86/xen/xenhost.c                     | 102 ++++
 drivers/block/xen-blkback/blkback.c        |  56 +-
 drivers/block/xen-blkback/common.h         |   2 +-
 drivers/block/xen-blkback/xenbus.c         |  65 +--
 drivers/block/xen-blkfront.c               | 105 ++--
 drivers/input/misc/xen-kbdfront.c          |   2 +-
 drivers/net/xen-netback/hash.c             |   7 +-
 drivers/net/xen-netback/interface.c        |  15 +-
 drivers/net/xen-netback/netback.c          |  11 +-
 drivers/net/xen-netback/rx.c               |   3 +-
 drivers/net/xen-netback/xenbus.c           |  81 +--
 drivers/net/xen-netfront.c                 | 122 ++--
 drivers/pci/xen-pcifront.c                 |   6 +-
 drivers/tty/hvc/hvc_xen.c                  |   2 +-
 drivers/xen/acpi.c                         |   2 +
 drivers/xen/balloon.c                      |  21 +-
 drivers/xen/cpu_hotplug.c                  |  16 +-
 drivers/xen/events/Makefile                |   1 -
 drivers/xen/events/events_2l.c             | 198 +++----
 drivers/xen/events/events_base.c           | 381 +++++++------
 drivers/xen/events/events_fifo.c           |   4 +-
 drivers/xen/events/events_internal.h       |  78 +--
 drivers/xen/evtchn.c                       |  24 +-
 drivers/xen/fallback.c                     |   9 +-
 drivers/xen/features.c                     |  33 +-
 drivers/xen/gntalloc.c                     |  21 +-
 drivers/xen/gntdev.c                       |  26 +-
 drivers/xen/grant-table.c                  | 632 ++++++++++++---------
 drivers/xen/manage.c                       |  37 +-
 drivers/xen/mcelog.c                       |   2 +-
 drivers/xen/pcpu.c                         |   2 +-
 drivers/xen/platform-pci.c                 |  12 +-
 drivers/xen/preempt.c                      |   1 +
 drivers/xen/privcmd.c                      |   5 +-
 drivers/xen/sys-hypervisor.c               |  14 +-
 drivers/xen/time.c                         |   4 +-
 drivers/xen/xen-balloon.c                  |  16 +-
 drivers/xen/xen-pciback/xenbus.c           |   2 +-
 drivers/xen/xen-scsiback.c                 |   5 +-
 drivers/xen/xen-selfballoon.c              |   2 +
 drivers/xen/xenbus/xenbus.h                |  45 +-
 drivers/xen/xenbus/xenbus_client.c         |  40 +-
 drivers/xen/xenbus/xenbus_comms.c          | 121 ++--
 drivers/xen/xenbus/xenbus_dev_backend.c    |  30 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c   |  22 +-
 drivers/xen/xenbus/xenbus_probe.c          | 247 +++++---
 drivers/xen/xenbus/xenbus_probe_backend.c  |  20 +-
 drivers/xen/xenbus/xenbus_probe_frontend.c |  66 ++-
 drivers/xen/xenbus/xenbus_xs.c             | 192 ++++---
 drivers/xen/xenfs/xenstored.c              |   7 +-
 drivers/xen/xlate_mmu.c                    |   4 +-
 include/xen/balloon.h                      |   4 +-
 include/xen/events.h                       |  45 +-
 include/xen/features.h                     |  17 +-
 include/xen/grant_table.h                  |  83 +--
 include/xen/xen-ops.h                      |  10 +-
 include/xen/xen.h                          |   3 +
 include/xen/xenbus.h                       |  54 +-
 include/xen/xenhost.h                      | 302 ++++++++++
 83 files changed, 2826 insertions(+), 1653 deletions(-)
 create mode 100644 arch/x86/xen/xenhost.c
 create mode 100644 include/xen/xenhost.h

-- 
2.20.1

