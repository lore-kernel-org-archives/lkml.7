Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A62C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7E92339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567013560;
	bh=g4OCrTwVa9bGHj9tnxdp3jF6CcqJ8f1XiF9bSopoU3g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cL6NdGHv8yZnI/8mzM4fohverEbZfjZbkqmtTKsh1OVtqR6O7fLr4ifw8Xfug0QGh
	 zAauujBSi4jGHcmGn0HTVO2eib9Ird5ZdEMJTqqKFcDxHTD6mP2s/RWeZ6aQGZ5hUG
	 i8vcYY0cWP8Z6IAIVDH3vlIa1J1FZ+gaYZat9oIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH1Rcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1Rcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:32:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F3222CF8;
        Wed, 28 Aug 2019 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567013558;
        bh=g4OCrTwVa9bGHj9tnxdp3jF6CcqJ8f1XiF9bSopoU3g=;
        h=Date:From:To:Cc:Subject:From;
        b=a3rf4aOlbouRot3H7YWNOPjdMdjcSi4kuaOwn9XEDNdNwloLChRW0NRPbuHXR9PXS
         C6MgP0i2QWJTMl2Pk08Rc1N/ScAAM4oPGmcweVwXtZ/63yqisTC31BDdQGAwJFmL4V
         GPPOqjrUiOAnRHK07SzjdAwi+63PljkdrwKkNN/A=
Date:   Wed, 28 Aug 2019 18:32:33 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, marc.zyngier@arm.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: [GIT PULL] arm64: Fixes for -rc7
Message-ID: <20190828173233.zqwm5nd4p5xa4jxi@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Hot on the heels of our last set of fixes are a few more for -rc7. Two
of them are fixing issues with our virtual interrupt controller
implementation in KVM/arm, while the other is a longstanding but
straightforward kallsyms fix which was been acked by Masami and resolves
an initialisation failure in kprobes observed on arm64.

Please pull, thanks.

Will

--->8

The following changes since commit b6143d10d23ebb4a77af311e8b8b7f019d0163e6:

  arm64: ftrace: Ensure module ftrace trampoline is coherent with I-side (2019-08-16 17:40:03 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 82e40f558de566fdee214bec68096bbd5e64a6a4:

  KVM: arm/arm64: vgic-v2: Handle SGI bits in GICD_I{S,C}PENDR0 as WI (2019-08-28 11:21:42 +0100)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix GICv2 emulation bug (KVM)

- Fix deadlock in virtual GIC interrupt injection code (KVM)

- Fix kprobes blacklist init failure due to broken kallsyms lookup

----------------------------------------------------------------
Heyi Guo (1):
      KVM: arm/arm64: vgic: Fix potential deadlock when ap_list is long

Marc Zyngier (2):
      kallsyms: Don't let kallsyms_lookup_size_offset() fail on retrieving the first symbol
      KVM: arm/arm64: vgic-v2: Handle SGI bits in GICD_I{S,C}PENDR0 as WI

 kernel/kallsyms.c             |  6 ++++--
 virt/kvm/arm/vgic/vgic-mmio.c | 18 ++++++++++++++++++
 virt/kvm/arm/vgic/vgic-v2.c   |  5 ++++-
 virt/kvm/arm/vgic/vgic-v3.c   |  5 ++++-
 virt/kvm/arm/vgic/vgic.c      |  7 +++++++
 5 files changed, 37 insertions(+), 4 deletions(-)
