Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CAFC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F1320673
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="S7Y27RpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAHP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:28:23 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:3495 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgAHP2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:28:21 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2020 10:28:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1578497301;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Ao9HMdTBC+XACEJ1rqPy+5n52e0DdI0N2KnnuQhp+To=;
  b=S7Y27RpVRIfekqKW+xmtBIJIJOjAubnoWA2dvEe91yxrfN+BSpCtpThV
   Jc/ImCJ+7G8Gxm/GfM8hYMtBkQwcyT6v/42RvoS8pS6ASzY8MISy4ozee
   /cIDWg1aVGXOkKIU7Y8DkvSq/lClWJoapHY1/hW86T7DSDN1KScv6GgZE
   8=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: aV70Ec38LNGJHPyjmtz3ubeiTnr6mtH+1TOCC+rUdQpsyHfc0ycOuyMkNd8LI/THZ/TU7JqOOv
 J2EMt9YDA3dz5/DokVaJH6CTl/S0dcoWuwQeuBL5EH1lDvJUBxJqjLZyyVNAI0xRXUYaVc5/zQ
 J7xZ4F3n5EcB47TJwb3p9tdkRo8vRuUyZJfApAh7tNh38bQRzOPlTFDSL0Yg3gR6ny8iCS01/a
 4leaynRNcoOnKITm0n+jg6lZkAlEuZPd30A4iqTn7Uns0uulDWrjpKs47Vvht/MLdLQUgcxrLU
 Eaw=
X-SBRS: 2.7
X-MesageID: 11004140
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,410,1571716800"; 
   d="scan'208";a="11004140"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [PATCH v1 0/4] basic KASAN support for Xen PV domains
Date:   Wed, 8 Jan 2020 15:20:56 +0000
Message-ID: <20200108152100.7630-1-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows to boot and run Xen PV kernels (Dom0 and DomU) with
CONFIG_KASAN=y. It has been used internally for some time now with good
results for finding memory corruption issues in Dom0 kernel.

Only Outline instrumentation is supported at the moment.

Sergey Dyasli (2):
  kasan: introduce set_pmd_early_shadow()
  x86/xen: add basic KASAN support for PV kernel

Ross Lagerwall (2):
  xen: teach KASAN about grant tables
  xen/netback: Fix grant copy across page boundary with KASAN

 arch/x86/mm/kasan_init_64.c       | 12 +++++++
 arch/x86/xen/Makefile             |  7 ++++
 arch/x86/xen/enlighten_pv.c       |  3 ++
 arch/x86/xen/mmu_pv.c             | 39 ++++++++++++++++++++
 drivers/net/xen-netback/common.h  |  2 +-
 drivers/net/xen-netback/netback.c | 59 +++++++++++++++++++++++++------
 drivers/xen/Makefile              |  2 ++
 drivers/xen/grant-table.c         |  5 ++-
 include/xen/xen-ops.h             |  4 +++
 kernel/Makefile                   |  2 ++
 lib/Kconfig.kasan                 |  3 +-
 mm/kasan/init.c                   | 25 ++++++++-----
 12 files changed, 141 insertions(+), 22 deletions(-)

-- 
2.17.1

