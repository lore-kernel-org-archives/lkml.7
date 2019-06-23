Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E54CC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D50420665
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 13:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFWN1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 09:27:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33413 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFWN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 09:27:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hf2Wt-0001ix-Qe; Sun, 23 Jun 2019 15:27:35 +0200
Message-Id: <20190623132340.463097504@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 23 Jun 2019 15:23:40 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: [patch 00/29] x86/hpet: Cleanup the channel management
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the HPET NMI watchdog series, I stared into the HPET code
and the proposed changes. The latter try to add yet another layer of duct
tape and ifdeffery to the existing maze. No, thanks.

The following series cleans up the channel management and consolidates all
state storage into a single place instead of 3 different ad hoc allocated
places which carry redundant information and make the code hard to follow.

The reservation of a HPET channel for a NMI watchdog becomes a few lines of
code after that series and just fits naturaly into that scheme without glue
and more extra storage and ifdeffery.

For your conveniance the series is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/hpet

Thanks,

	tglx

8<---------------------
 include/asm/hpet.h |    7 
 kernel/apic/msi.c  |    4 
 kernel/hpet.c      |  937 +++++++++++++++++++++++------------------------------
 3 files changed, 428 insertions(+), 520 deletions(-)



