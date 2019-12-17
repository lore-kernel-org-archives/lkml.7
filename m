Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B743FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885AF20663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NGKMIMuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfLQOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:15:38 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:49037 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfLQOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:15:38 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 09:15:37 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576592138;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=6sVUlp5NLpAAtn28yCdoOs3OAGb5AYegKQzCNbECZMs=;
  b=NGKMIMuwjbsndsi+gKnf6KNHbUX5wTuwiCeP84xCj0ZbAgnr1D7vaA9E
   Bwfxuekq+hmotqXiikdRt347RADTbF7JSOK26WOqqlGCuVWCKqYy0+/O4
   pZDM4U0+cuCsH2N3nff+eBa9J7+c/Go8xTGvSF887TI3s0vAhpVQsyKqv
   0=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: Qz+c6mG1vz35ZJwUvyQJelqy2kgveD6KCcxwLp9FNQnAHJ1QazmJmY/dh1yXGSem3ftegBTm4h
 Cnoa+vMuS7jASwz1gwns4+0Ooh/Q4BdRskCgKFwt+mke0Kfk536ajFrYOAQ3wrQ/+TMZYB+swF
 m51kFtVRpixwwoen2tlLImLf8fjkYvCZuV9i+PAXJHKIlqbQZrssD8XfDLDXAuytnAwHcs/pK0
 f7ZgAKFYGsHtJvelXFOx4cqa2Q32g7tKRsSAxDY+Bi13vI1wQjAtg90OkDjradGyUnpdYPXrR+
 DZ8=
X-SBRS: 2.7
X-MesageID: 9817027
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,325,1571716800"; 
   d="scan'208";a="9817027"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [RFC PATCH 0/3] basic KASAN support for Xen PV domains
Date:   Tue, 17 Dec 2019 14:08:01 +0000
Message-ID: <20191217140804.27364-1-sergey.dyasli@citrix.com>
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

Patch 1 is of RFC quality
Patches 2-3 are independent and quite self-contained.

Sergey Dyasli (1):
  x86/xen: add basic KASAN support for PV kernel

Ross Lagerwall (2):
  xen: teach KASAN about grant tables
  xen/netback: Fix grant copy across page boundary with KASAN

 arch/x86/mm/init.c                | 14 ++++++++
 arch/x86/mm/kasan_init_64.c       | 28 ++++++++++++++++
 arch/x86/xen/Makefile             |  7 ++++
 arch/x86/xen/enlighten_pv.c       |  3 ++
 arch/x86/xen/mmu_pv.c             | 13 ++++++--
 arch/x86/xen/multicalls.c         | 10 ++++++
 drivers/net/xen-netback/common.h  |  2 +-
 drivers/net/xen-netback/netback.c | 55 ++++++++++++++++++++++++-------
 drivers/xen/Makefile              |  2 ++
 drivers/xen/grant-table.c         |  5 ++-
 kernel/Makefile                   |  2 ++
 lib/Kconfig.kasan                 |  3 +-
 12 files changed, 128 insertions(+), 16 deletions(-)

-- 
2.17.1

