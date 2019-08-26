Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B2C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2D62186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 10:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfHZKPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfHZKPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 06:15:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C84B530832C8;
        Mon, 26 Aug 2019 10:15:49 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3304A608C1;
        Mon, 26 Aug 2019 10:15:49 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] x86/apic: reset LDR in clear_local_APIC
Date:   Mon, 26 Aug 2019 06:15:11 -0400
Message-Id: <20190826101513.5080-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 26 Aug 2019 10:15:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
   1/2: clear out the bogus initialization in bigsmp_init_apic_ldr
   2/2: reword commit message as suggested by Thomas
v1 posted at https://lkml.org/lkml/2019/8/14/1

On a 32 bit RHEL6 guest with greater than 8 cpus, the
kdump kernel hangs when calibrating apic. This happens
because when apic initializes bigsmp, it also initializes LDR
even though it probably wouldn't be used.

When booting into kdump, KVM apic incorrectly reads the stale LDR
values from the guest while building the logical destination map
even for inactive vcpus. While KVM apic can be fixed to ignore apics
that haven't been enabled, a simple guest only change can be to
just clear out the LDR.

Bandan Das (2):
  x86/apic: Do not initialize LDR and DFR for bigsmp
  x86/apic: include the LDR when clearing out apic registers

 arch/x86/kernel/apic/apic.c      |  4 ++++
 arch/x86/kernel/apic/bigsmp_32.c | 24 ++----------------------
 2 files changed, 6 insertions(+), 22 deletions(-)

-- 
2.20.1

