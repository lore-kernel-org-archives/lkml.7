Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9982AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626402077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPODDorD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfLDUoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:44:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727889AbfLDUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575492284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JalwGvumE/sV/vESkSXmSu1R1FZ9zcdLVGm8RXkwmcM=;
        b=GPODDorDS+DOPaDRey3J8RdE9xmZmZe/8QS7RpOHrrRxjuL/0P29EbY8+vPfO5MUyYQ5FP
        Zd4uTwRt+kAZ2fgV2juFiQnZjMsxmCWxlzuuBsYWXEUSu9z/EHkMAceeTAE8TBesNB5P7a
        oBeOWt8xA+uofU/acg2kwAk5JF6jRnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-A2O5sKfkP7um__t8PatHgw-1; Wed, 04 Dec 2019 15:44:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B75B800D5E;
        Wed,  4 Dec 2019 20:44:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF055691B3;
        Wed,  4 Dec 2019 20:44:33 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com,
        drjones@redhat.com
Subject: [RFC 0/3] KVM/ARM: Misc PMU fixes
Date:   Wed,  4 Dec 2019 21:44:23 +0100
Message-Id: <20191204204426.9628-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: A2O5sKfkP7um__t8PatHgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While writing new PMUv3 event counter KVM unit tests I found 3
things that do not seem to comply with the specification and at
least need to be confirmed.

Two are related to SW_INCR implementation: no check of the
PMCR.E bit, no support of 64b (CHAIN). From the spec,
I do not understand the SW_INCR behaves differently from
other events but I may be wrong.

The last minor thing is about the PMEVTYPER read-only bits.
On Seattle we have an 8.0 implementation which I understand
is supposed to implement only 10-bit evtCount field which is
not enforced.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v5.4-pmu-kut-fixes-v1

Eric Auger (3):
  KVM: arm64: pmu: Don't increment SW_INCR if PMCR.E is unset
  KVM: arm64: pmu: Fix chained SW_INCR counters
  KVM: arm64: pmu: Enforce PMEVTYPER evtCount size

 arch/arm64/include/asm/perf_event.h |  5 ++++-
 arch/arm64/include/asm/sysreg.h     |  5 +++++
 arch/arm64/kernel/perf_event.c      |  2 +-
 arch/arm64/kvm/sys_regs.c           | 14 ++++++++++----
 virt/kvm/arm/pmu.c                  | 19 ++++++++++++++++++-
 5 files changed, 38 insertions(+), 7 deletions(-)

--=20
2.20.1

